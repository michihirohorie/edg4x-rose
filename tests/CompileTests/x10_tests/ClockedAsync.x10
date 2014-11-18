class ClockedAsync {
	def test() {
		clocked finish {
		   clocked async {}
		}
	}
}
