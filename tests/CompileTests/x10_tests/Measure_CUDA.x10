import x10.io.Console;
import x10.util.CUDAUtilities;
import x10.util.Random;
import x10.compiler.CUDA;
import x10.compiler.CUDADirectParams;
import x10.compiler.Native;

public class Measure_CUDA {

  def init_zero (p:Place, a:GlobalRail[Double], blocks:Int, threads:Int) {
    finish async at (p) @CUDA @CUDADirectParams {
      //      val blocks = CUDAUtilities.autoBlocks();
      //      val threads = CUDAUtilities.autoThreads();
      finish for (bid in 0n..(blocks-1n)) async {
        clocked finish for (tid in 0n..(threads-1n)) clocked async {
          val gid = bid * threads + tid;
          a(gid) = 0;
        }
      }
    }
  }

  def init_100 (p:Place, a:GlobalRail[Double], blocks:Int, threads:Int) {
    finish async at (p) @CUDA @CUDADirectParams {
      //      val blocks = CUDAUtilities.autoBlocks();
      //      val threads = CUDAUtilities.autoThreads();
      finish for (bid in 0n..(blocks-1n)) async {
        clocked finish for (tid in 0n..(threads-1n)) clocked async {
          val gid = bid * threads + tid;
          a(gid) = 100;
        }
      }
    }
  }

  def add (p:Place, a:GlobalRail[Double], b:GlobalRail[Double], blocks:Int, threads:Int) {
    finish async at (p) @CUDA @CUDADirectParams {
      //      val blocks = CUDAUtilities.autoBlocks();
      //      val threads = CUDAUtilities.autoThreads();
      finish for (bid in 0n..(blocks-1n)) async {
        clocked finish for (tid in 0n..(threads-1n)) clocked async {
          val gid = bid * threads + tid;
          a(gid) = a(gid) + b(gid);
//          if (gid < 1) {
//          @Native("cuda", "printf(\"blocks: %d, threads: %d\\n\", __env.blocks, __env.threads);"){}
//          }
        }
      }
    }
//    @Native("c++","::x10aux::device_sync(p->id());"){}
  }

  def add4 (p: Place, a:GlobalRail[Double], b:GlobalRail[Double], c:GlobalRail[Double], d:GlobalRail[Double], e:GlobalRail[Double], f:GlobalRail[Double], g:GlobalRail[Double], h:GlobalRail[Double], blocks:Int, threads:Int) {
    finish async at (p) @CUDA @CUDADirectParams {
      finish for (bid in 0n..(blocks-1n)) async {
        clocked finish for (tid in 0n..(threads-1n)) clocked async {
          val gid = bid * threads + tid;
          a(gid) = a(gid) + b(gid);
          c(gid) = c(gid) + d(gid);
          e(gid) = e(gid) + f(gid);
          g(gid) = g(gid) + h(gid);
        }
      }
    }
  }

  def sub (p:Place, a:GlobalRail[Double], b:GlobalRail[Double], blocks:Int, threads:Int) {
    finish async at (p) @CUDA @CUDADirectParams {
      //      val blocks = CUDAUtilities.autoBlocks();
      //      val threads = CUDAUtilities.autoThreads();
      finish for (bid in 0n..(blocks-1n)) async {
        clocked finish for (tid in 0n..(threads-1n)) clocked async {
          val gid = bid * threads + tid;
          a(gid) = a(gid) - b(gid);
        }
      }
    }
  }

  def mult (p:Place, a:GlobalRail[Double], b:GlobalRail[Double], blocks:Int, threads:Int) {
    finish async at (p) @CUDA @CUDADirectParams {
      //      val blocks = CUDAUtilities.autoBlocks();
      //      val threads = CUDAUtilities.autoThreads();
      finish for (bid in 0n..(blocks-1n)) async {
        clocked finish for (tid in 0n..(threads-1n)) clocked async {
          val gid = bid * threads + tid;
          a(gid) = a(gid) * b(gid);
        }
      }
    }
  }

  def div (p:Place, a:GlobalRail[Double], b:GlobalRail[Double], blocks:Int, threads:Int) {
    finish async at (p) @CUDA @CUDADirectParams {
      //      val blocks = CUDAUtilities.autoBlocks();
      //      val threads = CUDAUtilities.autoThreads();
      finish for (bid in 0n..(blocks-1n)) async {
        clocked finish for (tid in 0n..(threads-1n)) clocked async {
          val gid = bid * threads + tid;
          a(gid) = a(gid) / b(gid);
        }
      }
    }
  }

  def addSubMultDiv (p:Place, a:GlobalRail[Double], b:GlobalRail[Double], blocks:Int, threads:Int) {
    finish async at (p) @CUDA @CUDADirectParams {
      //      val blocks = CUDAUtilities.autoBlocks();
      //      val threads = CUDAUtilities.autoThreads();
      finish for (bid in 0n..(blocks-1n)) async {
        clocked finish for (tid in 0n..(threads-1n)) clocked async {
          val gid = bid * threads + tid;
          a(gid) = a(gid) + b(gid);
          a(gid) = a(gid) - b(gid);
          a(gid) = a(gid) * b(gid);
          a(gid) = a(gid) / b(gid);
        }
      }
    }
  }

  def addSubMultDiv_4kernels (p:Place, a:GlobalRail[Double], b:GlobalRail[Double], blocks:Int, threads:Int) {
    finish async at (p) @CUDA @CUDADirectParams {
      finish for (bid in 0n..(blocks-1n)) async {
        clocked finish for (tid in 0n..(threads-1n)) clocked async {
          val gid = bid * threads + tid;
          a(gid) = a(gid) + b(gid);
        }
      }
    }
    finish async at (p) @CUDA @CUDADirectParams {
      finish for (bid in 0n..(blocks-1n)) async {
        clocked finish for (tid in 0n..(threads-1n)) clocked async {
          val gid = bid * threads + tid;
          a(gid) = a(gid) - b(gid);
        }
      }
    }
    finish async at (p) @CUDA @CUDADirectParams {
      finish for (bid in 0n..(blocks-1n)) async {
        clocked finish for (tid in 0n..(threads-1n)) clocked async {
          val gid = bid * threads + tid;
          a(gid) = a(gid) * b(gid);
        }
      }
    }
    finish async at (p) @CUDA @CUDADirectParams {
      finish for (bid in 0n..(blocks-1n)) async {
        clocked finish for (tid in 0n..(threads-1n)) clocked async {
          val gid = bid * threads + tid;
          a(gid) = a(gid) / b(gid);
        }
      }
    }
  }

  def run () {
    val topo = PlaceTopology.getTopology();
    val gpu = topo.getChild(here, 0);

    val blocks = 64n;
    val threads = 128n;
    //        val len = 100;
    val len = blocks*threads;
    val a = CUDAUtilities.makeGlobalRail[Double](gpu, len);
    val b = CUDAUtilities.makeGlobalRail[Double](gpu, len);
    val c = CUDAUtilities.makeGlobalRail[Double](gpu, len);
    val d = CUDAUtilities.makeGlobalRail[Double](gpu, len);
    val e = CUDAUtilities.makeGlobalRail[Double](gpu, len);
    val f = CUDAUtilities.makeGlobalRail[Double](gpu, len);
    val g = CUDAUtilities.makeGlobalRail[Double](gpu, len);
    val h = CUDAUtilities.makeGlobalRail[Double](gpu, len);
//    val b = new Rail[Double](len, (i:Long)=>i as Double);

    init_zero(gpu, a, blocks, threads);
    init_100(gpu, b, blocks, threads);
    init_zero(gpu, c, blocks, threads);
    init_100(gpu, d, blocks, threads);
    init_zero(gpu, e, blocks, threads);
    init_100(gpu, f, blocks, threads);
    init_zero(gpu, g, blocks, threads);
    init_100(gpu, h, blocks, threads);
    add(gpu, a, b, blocks, threads);
    add(gpu, c, d, blocks, threads);
    add(gpu, e, f, blocks, threads);
    add(gpu, g, h, blocks, threads);
    add4(gpu, a, b, e, d, e, f, g, h, blocks, threads);
//    sub(gpu, a, b, blocks, threads);
//    mult(gpu, a, b, blocks, threads);
//    div(gpu, a, b, blocks, threads);
//    addSubMultDiv(gpu, a, b, blocks, threads);
//    addSubMultDiv_4kernels(gpu, a, b, blocks, threads);
    init_zero(gpu, a, blocks, threads);
    init_100(gpu, b, blocks, threads);
    init_zero(gpu, c, blocks, threads);
    init_100(gpu, d, blocks, threads);
    init_zero(gpu, e, blocks, threads);
    init_100(gpu, f, blocks, threads);
    init_zero(gpu, g, blocks, threads);
    init_100(gpu, h, blocks, threads);

    Console.OUT.println("Start");

    var time:Long = System.nanoTime();

    add4(gpu, a, b, e, d, e, f, g, h, blocks, threads);

    Console.OUT.println("time: " + (System.nanoTime() - time));
    init_zero(gpu, a, blocks, threads);
    init_100(gpu, b, blocks, threads);
    init_zero(gpu, c, blocks, threads);
    init_100(gpu, d, blocks, threads);
    init_zero(gpu, e, blocks, threads);
    init_100(gpu, f, blocks, threads);
    init_zero(gpu, g, blocks, threads);
    init_100(gpu, h, blocks, threads);
    time= System.nanoTime();

    add(gpu, a, b, blocks, threads);
    add(gpu, c, d, blocks, threads);
    add(gpu, e, f, blocks, threads);
    add(gpu, g, h, blocks, threads);

    Console.OUT.println("time: " + (System.nanoTime() - time));

    Console.OUT.println("End");

    CUDAUtilities.deleteGlobalRail(a);
    CUDAUtilities.deleteGlobalRail(b);
    CUDAUtilities.deleteGlobalRail(c);
    CUDAUtilities.deleteGlobalRail(d);
    CUDAUtilities.deleteGlobalRail(e);
    CUDAUtilities.deleteGlobalRail(f);
    CUDAUtilities.deleteGlobalRail(g);
    CUDAUtilities.deleteGlobalRail(h);
  }

  public static def main(args:Rail[String]) {
    val measure = new Measure_CUDA();
    measure.run();
  }
}
