class Closure3 {
    def f(clo : (Long, Long)=>Long) {
        val a = 3;
        val b = 4;
        val v = clo(a, b);
    }
}
