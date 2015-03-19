class Closure1 {
    def f() : (Long)=>Long {
        val clo = (i:Long)=>3*i;
        return clo;
    }
}
