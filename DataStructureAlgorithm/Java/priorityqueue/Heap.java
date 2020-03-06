package datastructure.priorityqueue;

public class Heap {
	public int[] array;
	public int count;	// ����Ԫ�ظ���
	private int capacity;	// �Ѵ�С
	@SuppressWarnings("unused")
	private boolean heap_type;	// ������ true ��ʾ��С��
		
	public Heap(int capacity, Boolean heap_type) {
		// TODO Auto-generated constructor stub
		this.heap_type = heap_type;
		this.count = 0;
		this.capacity = capacity;
		this.array = new int[capacity];
	}
//	˫�׽��
	public int Parent(int i) {
		if (i <= 0 || i >= this.count)
			return -1;
		return (i - 1) / 2;
	}
//	���ӽ��
	public int LeftChild(int i) {
		int left = 2 * i + 1;
		if (left >= this.count)
			return -1;
		return left;
	}
	public int RightChild(int i) {
		int right = 2 * i + 2;
		if (right >= this.count)
			return -1;
		return right;
	}
//	��ȡ���Ԫ�� ����������
	public int getMaximum() {
		if (this.count == 0)
			return -1;
		return array[0];
	}
//	�ѻ�Ԫ�� ������͸
	public void PercolateDown(int i) {
		int l, r, max, temp;
		l = LeftChild(i);
		r = RightChild(i);
		if (l != -1 && this.array[l] > this.array[i])
			max = l;
		else
			max = i;
		if (r != -1 && this.array[r] > this.array[max])
			max = r;
		if (max != i) {	// ��ǰ��㲻������������
			temp = this.array[i];
			this.array[i] = this.array[max];
			this.array[max] = temp;
			PercolateDown(max);
		}
	}
//	ɾ��Ԫ�� ֻ��ɾ�������
	int DeleteMax() {
		if (this.count == 0)
			return -1;
		int data = this.array[0];
		this.array[0] = this.array[this.count-1];
		// ��ĩβԪ�طŵ����ڵ� ��Ҫ���жѻ�
		this.count--;
		PercolateDown(0);
		return data;
	}
//	����Ԫ�� ��ĩβ���� ��������͸
	void Insert(int data) {
		if (this.count == capacity)
			ResizeHeap();
		this.count++;
		int i = this.count-1;
		while (i >= 0 && data > this.array[(i-1)/2]) {
			this.array[i] = this.array[(i-1)/2];
			i = (i - 1) / 2;
		}
		this.array[i] = data;
	}
//	�����ѵĴ�С
	void ResizeHeap() {
		int[] array_old = new int[this.capacity];
		System.arraycopy(this.array, 0, array_old, 0, this.count-1);
		this.array = new int[this.capacity * 2];
		if (this.array == null) {
			System.out.println("Memory Error");
			return;
		}
		for (int i = 0; i < this.count; i++)
			this.array[i] = array_old[i];
		this.capacity *= 2;
		array_old = null;
	}
//	��ն�
	public void DestroyHeap() {
		this.count = 0;
		this.array = null;
	}
//	���齨��
	public static void BuildHeap(Heap H, int A[], int n) {
		if (H == null) return;
		while (n > H.capacity)
			H.ResizeHeap();
		for (int i = 0; i < n; i++)
			H.array[i] = A[i];
		H.count = n;
		for (int i = (n-1)/2; i >= 0; i--)
			H.PercolateDown(i);
	}
//	������
	@SuppressWarnings("unused")
	public static void HeapSort(int[] A, int n) {
		Heap h = new Heap(n, false);
		int old_size;
		BuildHeap(h, A, n);
		old_size = h.count;
		for (int i = n-1; i >= 0; i--) {	// ���� array[0] �������ֵ
			A[n-1-i] = h.array[0];
			h.array[0] = h.array[h.count-1];
			h.count--;
			h.PercolateDown(0);
		}
		h.DestroyHeap();
	}
	//	��ӡ
	@Override
	public String toString() {
		// TODO Auto-generated method stub
		String s = new String();
		int i = 0;
		while (i < this.count)
			s = s + this.array[i++] + " ";
		return s;
	}
}









