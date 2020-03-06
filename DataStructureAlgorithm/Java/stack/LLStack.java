package datastructure.stack;

import datastructure.linkedlist.LLNode;

public class LLStack<T> {
	private LLNode<T> headNode;
	public LLStack() {
		// TODO Auto-generated constructor stub
		this.headNode = new LLNode<T>(null);
	}
	
	public void push(T data) {
		if (headNode == null)
			headNode = new LLNode<T>(data);
		else if (headNode.getData() == null)
			headNode.setData(data);
		else {
			LLNode<T> temp = new LLNode<T>(data);
			temp.setNext(headNode);
			headNode = temp;
		}
	}
	
	public T pop() {
		if (headNode == null)
			return null;
		else {
			T data = headNode.getData();
			headNode = headNode.getNext();
			return data;
		}
	}
	
	public boolean isEmpty() {
		if (headNode == null) return true;
		return false;
	}
	
	public void deleteLLStack() {
		headNode = null;
	}
}
