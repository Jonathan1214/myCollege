package datastructure.dll;

public class UseDLL {
	int getDLLLength(DLLNode headNode) {
		int count = 1;
		while (headNode.getNext() != null) {
			count++;
			headNode = headNode.getNext();
		}
		return count;
	}
//	插入节点
	DLLNode DLLInsert(DLLNode headNode, DLLNode nodeToInsert, int position) {
		if (headNode == null) return nodeToInsert;
		int size = getDLLLength(headNode);
		if (position < 1 || position > size+1) {
			System.out.println("invalid position! It should be 1 to" + (size+1));
			return headNode;
		} 
		if (position == 1) {	// 表头插入
			nodeToInsert.setNext(headNode);
			headNode.setPre(nodeToInsert);
			return nodeToInsert;
		} else {
			DLLNode preNode = headNode;
			int count = 1;
			while (count < position-1) {
				preNode = preNode.getNext();
				count++;
			}
			DLLNode nextNode = preNode.getNext();
			preNode.setNext(nodeToInsert);
			nodeToInsert.setPre(preNode);
			if (nextNode != null) {
				nodeToInsert.setNext(nextNode);
				nextNode.setPre(nodeToInsert);
			}
		}
		return headNode;
	}
	
	DLLNode DLLDelete(DLLNode headNode, int position) {
		int size = getDLLLength(headNode);
		if (position < 1 || position > size) {
			System.out.println("invalid position! It should be 1 to " + size);
			return headNode;
		}
		if (position == 1) {
			if (size == 1) {	// 为何添加一个判断
				headNode = null;
				return null;
			} else {
				DLLNode newHead= headNode.getNext();
				newHead.setPre(null);
				headNode = null;
				return newHead;
			}
		} else {
			DLLNode preNode = headNode;
			int count = 1;
			while (count < position-1) {
				preNode = preNode.getNext();
				count++;
			}
			DLLNode curNode = preNode.getNext();
			DLLNode nextNode = curNode.getNext();
			preNode.setNext(nextNode);
			if (nextNode != null) nextNode.setPre(preNode);
			curNode = null;
		}
		return headNode;
	}
	
	
}
