package datastructure.dll;

public class DLLNode {
	private int data;
	private DLLNode next;
	private DLLNode pre;
	
	public DLLNode(int data) {
		this.data = data;
	}
	
	public DLLNode setData(int data) {
		this.data = data;
		return this;
	}
	
	public int getData() {
		return data;
	}
	
	public DLLNode setNext(DLLNode next) {
		this.next = next;
		return this;
	}
	
	public DLLNode getNext() {
		return next;
	}
	
	public DLLNode setPre(DLLNode pre) {
		this.pre = pre;
		return this;
	}
	
	public DLLNode getPre() {
		return pre;
	}
}





