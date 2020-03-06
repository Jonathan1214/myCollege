package datastructure.linkedlist;

public class UseMyLinkedList {
//	返回链表长度
	public int getListLength(MyListNode headNode) {
		int length = 0;
		MyListNode currentNode = headNode;
		while (currentNode != null) {
			length++;
			currentNode = currentNode.getNext();
		}
		return length;
	}
//	插入
	public MyListNode InsertLinkedList(MyListNode headNode, MyListNode NodeToInsert, int position) {
		if (headNode == null) return NodeToInsert;
		int size = getListLength(headNode);
		if (position > size+1 || position < 1) {
			System.out.println("invalid positon! It should be 1 to " + (size+1));
			return headNode;
		}
		if (position == 1) { // 在表头插入
			NodeToInsert.setNext(headNode);
			headNode = NodeToInsert;
		} else {
			MyListNode preNode = headNode;
			int count = 1;
			while (count < position-1) {
				preNode = preNode.getNext();
				count++;
			}
			MyListNode nextNode = preNode.getNext();
			preNode.setNext(NodeToInsert);
			NodeToInsert.setNext(nextNode);
		}
		return headNode;
	}
//	删除
	public MyListNode DeleteNodeFromLinkedList(MyListNode headNode, int position) {
		int size = getListLength(headNode);
		if (position < 1 || position > size) {
			System.out.println("invalid positon! It should be 1 to " + size);
			return headNode;
		}
		if (position == 1) {
			MyListNode newHead = headNode.getNext();
			headNode = null;
			return newHead;
		} else {
			MyListNode preNode = headNode;
			int count = 1;
			while (count < position-1) {
				preNode = preNode.getNext();
				count++;
			}
			MyListNode curNode = preNode.getNext();
			preNode.setNext(curNode.getNext());
			curNode = null;
		}
		return headNode;
	}
//	删除链表
	public void DeleteLinkedList(MyListNode headNode) {
		MyListNode auxiliaryNode, iterator = headNode;
		while (iterator != null) {
			auxiliaryNode = iterator.getNext();
			iterator = null;	// GC 自动回收
			iterator = auxiliaryNode;
		}
	}
}
