class Closure8 {
    def make(cl : ()=>Closure8) {}

    def f() {
          make(() => new Closure8());
    }

}
