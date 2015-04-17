class Closure6 {
    val n = 9;

    class SomeClass {
        val h = 0;
    }

    def f(p : SomeClass) {
        val h = (a:Long)=>{ p.h + n + a };
    }
}

