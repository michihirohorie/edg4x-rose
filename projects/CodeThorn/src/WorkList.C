// We want to avoid calling critical sections from critical sections:
// therefore all worklist functions do not use each other.

#include <list>
#include <algorithm>
#include "WorkListSeq.h"

using namespace std;
using namespace CodeThorn;

template<typename Element>
bool WorkListSeq<Element>::isEmpty() { 
  bool res;
  #pragma omp critical
  {
    res=(workList.size()==0);
  }
  return res;
}

template<typename Element>
bool WorkListSeq<Element>::exists(Element elem) {
  typename list<Element>::iterator findIter;
#pragma omp critical
  {
    findIter=std::find(workList.begin(), workList.end(), elem);
  }
  return findIter==workList.end();
}

template<typename Element>
void WorkListSeq<Element>::add(Element elem) { 
#pragma omp critical
  {
    workList.push_back(elem); 
  }
}

template<typename Element>
void WorkListSeq<Element>::add(std::set<Element>& elemSet) { 
#pragma omp critical
  {
    for(typename std::set<Element>::iterator i=elemSet.begin();i!=elemSet.end();++i) {
        workList.push_back(*i);
    }
  }
}

template<typename Element>
Element WorkListSeq<Element>::take() {
  if(workList.size()==0) {
    throw "Error: attempted to take element from empty work list.";

  }  else {
    Element co;
#pragma omp critical
    {
      co=*workList.begin();
      workList.pop_front();
    }
    return co;
  }
}

template<typename Element>
Element WorkListSeq<Element>::examine() {
  if(workList.size()==0)
    throw "Error: attempted to examine next element in empty work list.";
  Element elem;
#pragma omp critical
  {
    if(workList.size()>0)
      elem=*workList.begin();
  }
  return elem;
}

