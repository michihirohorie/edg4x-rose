public class Assert2 {
    public static def test():Boolean {
        return true;
    }
    
    public static def fct() {
        assert test() : "Assertion triggered";
    }

	public static def main(args:Rail[String]) {
	    fct();
	}
}
