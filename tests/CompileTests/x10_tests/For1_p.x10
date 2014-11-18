package x10test;

public class For1_p {
	public def loop() {
		for(var i:Long = 0, j:Long = 10; i < 10;) {
		}

		for(var i:Long = 0; i < 10;)
			i=11;
	}
}
