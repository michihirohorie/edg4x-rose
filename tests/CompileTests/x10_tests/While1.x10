public class While1 {
	public def loop() {
		var i:Long = 0;
		var k:Long = 0;
		while (i < 10)
			i = 11;
		while (k < 10)
			k++;
		while (k < 10) {
			k++;
		}
	}
}
