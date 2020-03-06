package datastructure.sort;

import java.util.Random;

public class SortTestDrive {
	static int[] generateRandomArray(int len, int max) {
		int[] arr = new int[len];
		for (int i = 0; i < len; i++)
			arr[i] = (int)(Math.random()*max);
		return arr;
	}
	static int[] generateRandomArray(int len) {
		Random rand = new Random();
		int[] arr = new int[len];
		for (int i = 0; i < len; i++)
			arr[i] = rand.nextInt(1000) + 1;
		return arr;
	}
	static String ArrayToString(int[] array) {
		String s = new String();
		int index = 0;
		while (index < array.length)
			s = s + array[index++] + " ";
		return s;
	}
	public static void main(String[] args) {
		int[] A = generateRandomArray(100);
//		System.out.println(ArrayToString(A));
		ComparisionBasedSort.BubbleSort(generateRandomArray(100), 100);
//		System.out.println(ArrayToString(A));
		ComparisionBasedSort.BubbleSortImproved(generateRandomArray(100), 100);
//		System.out.println(ArrayToString(A));
		ComparisionBasedSort.SelectionSort(generateRandomArray(100), 100);
		long startTime = System.nanoTime();
		ComparisionBasedSort.InsertionSort(generateRandomArray(100), 100);
		long endTime = System.nanoTime();
		System.out.println("InsertionSort Times used: " + (endTime-startTime)+ " ns");
		ComparisionBasedSort.ShellSort(generateRandomArray(100), 100);
		ComparisionBasedSort.MergeSort(generateRandomArray(100), 100);
		ComparisionBasedSort.HeapSort(generateRandomArray(100), 100);
		System.out.println(ArrayToString(A));
		ComparisionBasedSort.QuickSort(A, A.length);
		System.out.println(ArrayToString(A));

	}
}
