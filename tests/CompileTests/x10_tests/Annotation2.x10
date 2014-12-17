import x10.compiler.StackAllocate;

public class Annotation2 {
    private def func() {
       @StackAllocate val hxx = @StackAllocate new Rail[double](4L);
    }
}
