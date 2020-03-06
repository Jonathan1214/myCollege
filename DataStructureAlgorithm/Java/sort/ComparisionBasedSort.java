package datastructure.sort;

import datastructure.priorityqueue.Heap;

public class ComparisionBasedSort {
	private static void swap(int A[], int i, int j) {
		int temp = A[i];
		A[i] = A[j];
		A[j] = temp;
	}
	
	public static void BubbleSort(int A[], int length) {
		int comparisonTimes = 0;
		int swapTimes = 0;
		for (int pass = length-1; pass > 0; pass--) {
			for (int index = 0; index < pass; index++) {
				if (A[index] > A[index+1]) {
					swap(A, index, index+1);
					swapTimes++;
				}
				comparisonTimes++;
			}
		}
		System.out.println("BubbleSort:\n\tcomparison times: " +
				comparisonTimes + "\n\tswap times: " + swapTimes);
	}
	
	public static void BubbleSortImproved(int A[], int length) {
		int comparisonTimes = 0;
		int swapTimes = 0;
		int swapped = 1;
		for (int pass = length-1; pass > 0 && swapped != 0; pass--) {
			swapped = 0;
			for (int index = 0; index < pass; index++) {
				if (A[index] > A[index+1]) {
					swap(A, index, index+1);
					swapTimes++;
					swapped = 1;
				}
				comparisonTimes++;
			}
		}
		System.out.println("BubbleSortImproved:\n\tcomparison times: " +
				comparisonTimes + "\n\tswap times: " + swapTimes);
	}
	
	public static void SelectionSort(int[] A, int length) {
		int i, j, min;
		int comparisonTimes = 0;
		int swapTimes = 0;
		for (i = 0; i < length-1; i++) {
			min = i;
			for (j = i+1; j < length; j++) {
				if (A[j] < A[min])
					min = j;
				comparisonTimes++;
			}
			swap(A, min, i);
			swapTimes++;
		}
		System.out.println("SelectionSort:\n\tcomparison times: " +
				comparisonTimes + "\n\tswap times: " + swapTimes);
	}
	
	public static void InsertionSort(int[] A, int length) {
		int i, j, v;
		for (i = 1; i < length; i++) {
			v = A[i];
			j = i;
			while (j > 0 && A[j-1] > v) {
				A[j] = A[j-1];
				j--;
			}
			A[j] = v;
		}
	}
	
	public static void ShellSort(int[] A, int length) {
		int i, j, h, v;
		for (h = 1; h < length/9; h = 3*h+1);
		for (; h > 0; h /= 3) {
			for (i = h-1; i < length; i++) {
				v = A[i];
				j = i;
				while (j >= h && A[j-h] > v) {
					A[j] = A[j-h];
					j -= h;
				}
				A[j] = v;
			}
		}
	}
	
	public static void MergeSort(int[] A, int length) {
		/*
		 * 分治
		*/
		MergeSort_c(A, 0, length-1);
	}
	
	private static void MergeSort_c(int[] A, int left, int right) {
		if (right <= left) return;
		
		int mid = left + (right-left)/2;
		MergeSort_c(A, left, mid);
		MergeSort_c(A, mid+1, right);
		Merge(A, left, mid, right);
	}
	
	private static void Merge(int[] A, int left, int mid, int right) {
		int[] tmp = new int[right-left+1];
		int i = left, j = mid+1, k = 0;
		while (i <= mid && j <= right) {
			if (A[i] < A[j]) tmp[k++] = A[i++];
			else tmp[k++] = A[j++];
		}
//		将剩余的数插入进去
		while (i <= mid)
			tmp[k++] = A[i++];
		while (j <= right)
			tmp[k++] = A[j++];
//		复制到原来的数组中
		for (k = 0, i = left; k < right-left+1; k++)
			A[i+k] = tmp[k];
	}
	
	public static void HeapSort(int[] A, int length) {
//		建立一个最大堆 依次从堆中删除堆顶元素
		Heap h = new Heap(length, false);
		Heap.BuildHeap(h, A, length);
		for (int i = length-1; i >= 0; i--) {	// 最大堆 array[0] 保存最大值
			A[i] = h.array[0];
			h.array[0] = h.array[h.count-1];
			h.count--;
			h.PercolateDown(0);
		}
		h.DestroyHeap();
	}
	
	public static void QuickSort(int[] A, int length) {
		/*
		 * 分区
		*/
		QuickSortC(A, 0, length-1);
	}

	private static void QuickSortC(int[] A, int low, int high) {
		if (high <= low) return;
		int pivot = Partion(A, low, high);
		QuickSortC(A, low, pivot-1);
		QuickSortC(A, pivot+1, high);
	}

	private static int Partion(int[] A, int low, int high) {
		int pivot = A[high], i = low;
		for (int j = low; j < high; j++) {
			if (A[j] < pivot) {
				swap(A, i, j);
				i++;
			}
		}
		swap(A, i, high);
		return i;
	}
	
	public static void TreeSort() {
		
	}

}









