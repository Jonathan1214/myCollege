package datastructure.fresh;

public class BasicRecursive {
//	��ŵ������
	public static void TowersOfHanoi(int n, String frompeg, String topeg, String auxpeg) {
		if (n == 1) {
			System.out.println("Move 1 disk from peg " + frompeg + " to peg " + topeg);
			return;
		}
		// �ֽ����� �������  n �����Ƶ�������
		TowersOfHanoi(n-1, frompeg, auxpeg, topeg);
		// ��ʣ�µ�һ�������Ƶ�Ŀ����
		System.out.println("Move 1 disk from peg " + frompeg + " to peg " + topeg);
		// ���������ϵ�  n-1 �������Ƶ�Ŀ������
		TowersOfHanoi(n-1, auxpeg, topeg, frompeg);
	}
	
//	�����Ƿ�����
//	public static boolean isArraySortedOrder(int[] a, int index) {
//		if (a.length == 1) return true;
//		return (a[index -1] <= a[index - 2])
//	}

//	�����ƴ�
	public static void Binary(int n, int[] A) {
		if (n < 1) {
			for (int a : A)
				System.out.print(a + " ");
			System.out.println();
		} else {
			A[n-1] = 0;
			Binary(n-1, A);
			A[n-1] = 1;
			Binary(n-1, A);
		}
	}

//	k���ƴ� ͬ��
	public static void k_string(int n, int k, int[] A) {
		if (n < 1) {
			for (int a : A)
				System.out.print(a + " ");
			System.out.println();
		} else {
			for (int j = 0; j < k; j++) {
				A[n-1] = j;
				k_string(n-1, k, A);
			}
		}
	}
	
	public static void main(String[] args) {
//		BasicRecursive.TowersOfHanoi(3, "A", "B", "C");
		int[] A = new int[3];
//		BasicRecursive.Binary(A.length, A);
		BasicRecursive.k_string(A.length, 3, A);
	}
}
