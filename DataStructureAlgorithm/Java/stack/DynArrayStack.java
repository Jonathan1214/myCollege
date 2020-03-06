package datastructure.stack;

public class DynArrayStack {
	private int top;
	private int capacity;
	private int[] array;
	public DynArrayStack() {
		capacity = 1;
		array = new int[capacity];
		top = -1;
	}
	public boolean isEmpty() {
		return (top == -1);
	}
	public boolean isStackFull() {
		return (top == capacity-1);
	}
	public void push(int data) {
		if (isStackFull()) doubleStack();
		array[++top] = data;
	}
	private void doubleStack() {
		// TODO Auto-generated method stub
		int newArray[] = new int[capacity*2];
		System.arraycopy(array, 0, newArray, 0, capacity);
		capacity *= 2;
		array = newArray;
	}
	public int pop() {
		if (isEmpty()) {
			System.out.println("Stack overflow");
			return 0;
		}
		else return array[top--];
	}
	public void deleteStack() {
		top = -1;
	}
}
