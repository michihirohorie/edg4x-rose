public class Assert3 {
    public static def test():Boolean {
        return false;
    }
    
    public static def fct() {
        var i:Long = 3;
        // can give any expression on the right hand side
        assert test() : (i==3);
    }

	public static def main(args:Rail[String]) {
	    fct();
	}
}
