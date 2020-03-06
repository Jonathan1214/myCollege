package datastructure.fresh;

public class BasicTest {
	
	public static int Print(int n) {
		if (n == 0 )	// 基线条件
			return 0;
		else {
			System.out.println(n);
			return Print(n -1);
		}
	}
	
	public static void main(String[] args) {
		System.out.println(BasicTest.Print(4));
	}
}
