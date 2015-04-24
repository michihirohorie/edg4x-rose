class Closure9 {
    def make(a : Long, cl : ()=>Closure9) {}

    def f() {
          make(0, () => new Closure9());
    }
}
