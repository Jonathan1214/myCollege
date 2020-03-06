package datastructure.priorityqueue;

public class HeapTestDrive {
	static String arrayToString(int[] A, int n) {
		String s = new String();
		int i = 0;
		while (i < n)
			s = s + A[i++] + " ";
		return s;
	}
	public static void main(String[] args) {
		int[] A = {1, 2, 3, 4, 5, 6, 7};
		System.out.println(arrayToString(A, A.length));
		Heap H = new Heap(10, false);
		Heap.BuildHeap(H, A, A.length);
		System.out.println(H);
		System.out.println(arrayToString(A, A.length));
		Heap.HeapSort(A, A.length);
		System.out.println(arrayToString(A, A.length));
	}
}
