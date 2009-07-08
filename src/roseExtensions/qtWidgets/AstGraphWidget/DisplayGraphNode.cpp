#include "rose.h"
#include "DisplayGraphNode.h"
#include "DisplayEdge.h"

#include <QGraphicsScene>

#include <QDebug>


using namespace std;

// ---------------------- DisplayGraphNode -------------------------------

DisplayGraphNode::DisplayGraphNode(QGraphicsScene * sc)
    : DisplayNode(sc)
{
}

DisplayGraphNode::DisplayGraphNode(const QString & caption,QGraphicsScene * sc)
    : DisplayNode(caption,sc)
{
}



DisplayGraphNode::~DisplayGraphNode()
{
    // every node deletes its outgoing edges
    qDeleteAll(outEdges);
}

void DisplayGraphNode::addOutEdge(DisplayNode * to)
{
    outEdges.push_back(new DisplayEdge(this,to));

    if(scene)
        scene->addItem(outEdges.back());
}

void DisplayGraphNode::addInEdge(DisplayNode * from)
{
    inEdges.push_back(new DisplayEdge(from,this));

    if(scene)
        scene->addItem(outEdges.back());
}

void DisplayGraphNode::addEdge(DisplayEdge * edge)
{
    DisplayGraphNode * from = dynamic_cast<DisplayGraphNode*> (edge->sourceNode());
    DisplayGraphNode * to   = dynamic_cast<DisplayGraphNode*> (edge->destNode());

    Q_ASSERT(from && to); // there should only be GraphNodes in this Graph

    from->outEdges.push_back(edge);
    to  ->inEdges.push_back(edge);

    Q_ASSERT(from->scene == to->scene);

    if(from->scene)
        from->scene->addItem(edge);
}


QVariant DisplayGraphNode::itemChange(GraphicsItemChange change, const QVariant &value)
{
    if(change == ItemPositionHasChanged)
    {
        foreach(DisplayEdge * edge, inEdges)
            edge->adjust();

        foreach(DisplayEdge * edge,outEdges)
            edge->adjust();
    }
    return DisplayNode::itemChange(change, value);
}

void DisplayGraphNode::setScene(QGraphicsScene * sc)
{
    if(!sc && scene)
    {
        foreach(QGraphicsItem * i, inEdges)
            scene->removeItem(i);

        foreach(QGraphicsItem * i, outEdges)
            scene->removeItem(i);
    }

    if(sc)
    {
        foreach(QGraphicsItem * i, inEdges)
            sc->addItem(i);

        foreach(QGraphicsItem * i, outEdges)
            sc->addItem(i) ;
    }

    DisplayNode::setScene(sc);
}

bool DisplayGraphNode::isAdjacentTo(DisplayGraphNode * o) const
{
    foreach(DisplayEdge * e, inEdges)
        if(e->sourceNode() == o)
            return true;

    foreach(DisplayEdge * e, outEdges)
        if(e->destNode() == o)
            return true;

    return false;
}




// ---------------------- DisplayGraph -------------------------------

#include "ui_LayoutControl.h"
#include <QTimer>

DisplayGraph::DisplayGraph(QGraphicsScene * sc, QObject * par)
    : QObject(par),
      scene(sc),
      curIteration(0),
      uiWidget(new QWidget()),
      ui(new Ui::LayoutControl()),
      timer(new QTimer(this))
{
    ui->setupUi(uiWidget);

    curDelta = ui->spnDelta->value() * 10e-4;
    optimalDistance = ui->spnOptimalDistance->value();
    updateWidget();

    connect(ui->cmdStartTimer,SIGNAL(clicked()), SLOT(on_cmdStartTimer_clicked()));
    connect(ui->cmdStopTimer,SIGNAL(clicked()),timer, SLOT(stop()));
    connect(ui->cmdSingleStep,SIGNAL(clicked()), SLOT(on_timerEvent()));
    connect(ui->cmdReset,SIGNAL(clicked()), SLOT(on_cmdReset_clicked()));

    connect(timer,SIGNAL(timeout()),SLOT(on_timerEvent()));
}


DisplayGraph::~DisplayGraph()
{
    delete uiWidget;
    delete ui;

    qDeleteAll(n);
}

void DisplayGraph::updateWidget()
{
    ui->lblCurIteration->setText(QString("%1").arg(curIteration));
    ui->lblCurrentDelta->setText(QString("%1").arg(curDelta));
}


void DisplayGraph::on_cmdStartTimer_clicked()
{
    on_cmdReset_clicked();
    timer->start(ui->spnTimerInterval->value());
}



void DisplayGraph::on_cmdReset_clicked()
{
    curIteration=0;
    curDelta = ui->spnDelta->value() *1e-4;
    updateWidget();
}



void DisplayGraph::addEdge(DisplayGraphNode * n1, DisplayGraphNode * n2, const QString & label)
{
    int i1 = n.indexOf(n1);
    int i2 = n.indexOf(n2);
    Q_ASSERT(i1 >=0 && i2 >=0); // nodes have to be added before edges are added
    addEdge(i1,i2,label);

}

void DisplayGraph::addEdge ( int i1, int i2, const QString & label)
{
    // create visible part
    DisplayEdge * e = new DisplayEdge(n[i1],n[i2]);
    e->setEdgeLabel(label);
    e->setPaintMode(DisplayEdge::STRAIGHT);
    DisplayGraphNode::addEdge(e);
    // ..and invisible part
    addInvisibleEdge(i1,i2);
}

void DisplayGraph::addInvisibleEdge(int i1, int i2)
{
    edgeInfo.insert(i1,i2);
    edgeInfo.insert(i2,i1);
}

int DisplayGraph::addNode(DisplayGraphNode * node)
{
    node->setScene(scene);
    n.push_back(node);
    return n.size()-1;
}

int DisplayGraph::addGravityNode()
{
    DisplayGraphNode * node = new DisplayGraphNode("x",scene);
    node->setBgColor(QColor(Qt::red).lighter(150));
    n.push_back(node);
    return n.size()-1;
}

void DisplayGraph::on_timerEvent()
{
    if(curIteration >= ui->spnMaxIterations->value() ||
         curDelta <= 0)
    {
        timer->stop();
        return;
    }

    optimalDistance= ui->spnOptimalDistance->value();

    springBasedLayoutIteration(curDelta);

    curDelta -= ui->spnDeltaDecrement->value() * 1e-6;
    curIteration++;
    updateWidget();
}


void DisplayGraph::springBasedLayoutIteration(qreal delta)
{
    forces.fill(QPointF(0,0),n.size());

    /*
    qDebug() << "Edge Info:";
    QMultiMap<int, int>::iterator i = edgeInfo.begin();
    while (i != edgeInfo.end() ) {
        qDebug() << i.value() ;
        ++i;
    }*/

    for(int i=0; i < n.size(); i++)
    {
        QPointF randComp =  QPointF(qrand()/(double)RAND_MAX,qrand()/(double)RAND_MAX) -QPointF(0.5,0.5);
        n[i]->setPos(n[i]->pos() + ui->spnRandomFactor->value() * randComp );

        for(int j=0; j < i; j++)
        {
            qreal dist= optimalDistance + n[i]->boundingRect().width()/2;
            if( edgeInfo.contains(i,j))
            {
                QPointF attrForce( attractiveForce(n[i]->pos(),n[j]->pos(),dist) );
                forces[i] += attrForce;
                forces[j] -= attrForce;
            }

            QPointF repForce(repulsiveForce(n[i]->pos(),n[j]->pos(),dist));
            forces[i] += repForce;
            forces[j] -= repForce;
        }
    }

    for(int i=0; i<n.size(); i++)
    {
        if(n[i]->isMouseHold())
            continue;

        qreal dx = forces[i].x() * delta;
        qreal dy = forces[i].y() * delta;

        dx = qBound(-optimalDistance,dx,optimalDistance);
        dy = qBound(-optimalDistance,dy,optimalDistance);
        n[i]->moveBy(dx,dy);
    }

}

QPointF DisplayGraph::repulsiveForce (const QPointF & n1, const QPointF & n2, qreal optDist)
{
    if(n1 == n2)
    {
        qDebug() << "GraphLayout RepForce Warning";
        return QPointF(0,0);
    }


    QLineF l (n1,n2);
    QPointF v (n1-n2);
    QPointF res =( optDist *optDist / l.length() ) * v;
    return  res;
}

QPointF DisplayGraph::attractiveForce(const QPointF & n1, const QPointF & n2, qreal optDist)
{
    if(n1 == n2)
    {
        qDebug() << "GraphLayout AttrForce Warning";
        return QPointF(0,0);
    }

    QPointF v( n2-n1);
    QPointF res =( (v.x()*v.x() + v.y() * v.y())  / optDist) * v;
    return res;
}



DisplayGraph * DisplayGraph::generateCallGraph(QGraphicsScene * sc,
                                               SgIncidenceDirectedGraph * cg,
                                               QObject * par)
{
    DisplayGraph * g = new DisplayGraph(sc,par);

    typedef rose_graph_integer_node_hash_map      NodeMap;
    typedef rose_graph_integer_edge_hash_multimap EdgeMap;

    NodeMap & nodes = cg->get_node_index_to_node_map ();


    for( NodeMap::iterator it = nodes.begin();  it != nodes.end(); ++it )
    {
        QString name  ( it->second->get_name ().c_str() );
        DisplayGraphNode * n = new DisplayGraphNode(name,sc );

        g->addNode(n);
    }

    EdgeMap & edges =  cg->get_node_index_to_edge_multimap_edgesOut ();
    for( EdgeMap::iterator it= edges.begin(); it != edges.end(); ++it )
    {
        SgDirectedGraphEdge * edge = isSgDirectedGraphEdge(it->second);
        Q_ASSERT(edge);
        QString edgeLabel( edge->get_name().c_str());
        g->addEdge(edge->get_from()->get_index(),edge->get_to()->get_index(),edgeLabel);
    }

    return g;
}


DisplayGraph * DisplayGraph::generateTestGraph(QGraphicsScene * sc,QObject * par)
{
    DisplayGraph * g = new DisplayGraph(sc,par);

    // add some nodes
    for(int i=0; i < 6; i++)
    {
        DisplayGraphNode * n = new DisplayGraphNode( QString("%1").arg(i),sc );
        //n->setPos(i,0);
        g->addNode(n);
    }


    // ..and edges
    g->addEdge(0,1);
    g->addEdge(1,0);
    g->addEdge(0,2);

    g->addEdge(1,3);

    g->addEdge(3,4);
    g->addEdge(4,5);
    g->addEdge(3,5);
    g->addEdge(2,4);


    int n1=g->addNode( new DisplayGraphNode("Node1",sc) ) ;
    int n2=g->addNode( new DisplayGraphNode("LongNode2",sc));
    int n3=g->addNode( new DisplayGraphNode("LongLongNode3",sc));

    int gn=g->addGravityNode();

    g->addEdge(n1,n2);
    g->addEdge(0,n1);
    g->addEdge(2,n2);
    g->addInvisibleEdge(gn,n1);
    g->addInvisibleEdge(gn,n2);
    g->addInvisibleEdge(gn,n3);


    return g;
}



