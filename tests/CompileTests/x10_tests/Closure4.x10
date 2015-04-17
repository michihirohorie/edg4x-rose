class Closure4 {
    class SomeClass {
        val h = 0;
    }

    def f(p : SomeClass) {
        val h = ()=>{ p.h };
    }
}

