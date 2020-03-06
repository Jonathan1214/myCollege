package datastructure.queue;

import java.util.EmptyStackException;

import datastructure.linkedlist.LLNode;

public class LLQueue<T> {
	private LLNode<T> frontNode;
	private LLNode<T> rearNode;

	public LLQueue() {
		this.frontNode = null;
		this.rearNode = null;
	}

	public boolean isEmpty() {
		return (frontNode == null);
	}

	public LLQueue<T> enQueue(T data) {
		LLNode<T> newNode = new LLNode<T>(data);
		if (rearNode != null)
			rearNode.setNext(newNode);
		rearNode = newNode;
		if (frontNode == null)
			frontNode = rearNode;
		return this;
	}

	public T deQueue() {
		T data = null;
		if (isEmpty())
			throw new EmptyStackException();
		else {
			data = frontNode.getData();
			frontNode = frontNode.getNext();
		}
		return data;
	}
	
	public void deleteQueue() {
		frontNode = null;
		rearNode = null;
	}
}
