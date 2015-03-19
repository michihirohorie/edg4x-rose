class Closure2 {
    def f(clo : (Long, Long)=>Long) {
        val v = clo(3, 4);
    }
}
