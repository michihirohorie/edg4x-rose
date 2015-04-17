class Closure5 {
    val n = 9;

    class SomeClass {
        val h = 0;
    }

    def f(p : SomeClass) {
        val h = ()=>{ p.h + n };
    }
}

