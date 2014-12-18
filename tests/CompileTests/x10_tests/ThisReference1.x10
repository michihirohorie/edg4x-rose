class ThisReference1 {
    val a : Long = 0;
    class Nested {
        def func(var b : Long) {
            b += a;
        }
    }
}
