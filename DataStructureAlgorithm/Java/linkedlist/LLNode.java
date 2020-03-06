package datastructure.linkedlist;

public class LLNode<T> {
	private T data;
	private LLNode<T> next;
	public LLNode(T data) {
		this.data = data;
	}

	public void setNext(LLNode<T> newNode) {
		// TODO Auto-generated method stub
		this.next = newNode;
	}
	
	public LLNode<T> getNext() {
		return next;
	}
	
	public void setData(T data) {
		this.data = data;
	}
	public T getData() {
		// TODO Auto-generated method stub
		return this.data;
	}
	public void InsertAtBegining(LLNode<T> newNode) {
		newNode.setNext(this.next);
		this.next = newNode;
	}

}
