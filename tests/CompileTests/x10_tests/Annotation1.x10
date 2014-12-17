import x10.compiler.NonEscaping;

public class Annotation1 {
    @NonEscaping private def func() {
        Console.OUT.println("annotation1");
    }
}
