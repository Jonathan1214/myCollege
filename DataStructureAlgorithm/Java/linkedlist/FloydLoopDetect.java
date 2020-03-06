package datastructure.linkedlist;

public class FloydLoopDetect {
//	Floyd 算法
//		检测链表中是否存在环
	boolean DoesLinkedListContainsLoop(MyListNode head) {
		if (head == null) return false;
		MyListNode slowPtr = head, fastPtr = head;
		while (fastPtr.getNext() != null && fastPtr.getNext().getNext() != null) {
			slowPtr = slowPtr.getNext();
			fastPtr = fastPtr.getNext().getNext();
			if (slowPtr == fastPtr) return true;
		}
		return false;
	}

//	找到环的起点 可以后续进行删除
	MyListNode findBeginOfLoop(MyListNode head) {
		MyListNode slowPtr = head, fastPtr = head;
		boolean loopExists = false;
		if (head == null) return null;
		while (fastPtr.getNext() != null && fastPtr.getNext().getNext() != null) {
			slowPtr = slowPtr.getNext();
			fastPtr = fastPtr.getNext().getNext();
			if (slowPtr == fastPtr) {
				loopExists = true;
				break;
			}
		}
		if (loopExists) {
			slowPtr = head;
			while (slowPtr != fastPtr) {
				fastPtr = fastPtr.getNext();
				slowPtr = slowPtr.getNext();
			}
			return slowPtr;
		}
		return null;
	}
//	确定环的长度
	int FindLoopLength(MyListNode head) {
		if (head == null) return 0;
		MyListNode slowPtr = head, fastPtr = head;
		int count = 0;
		boolean loopExists = false;
//		确定环是否存在
		while (fastPtr.getNext() != null && fastPtr.getNext().getNext() != null) {
			slowPtr = slowPtr.getNext();
			fastPtr = fastPtr.getNext().getNext();
			if (slowPtr == fastPtr) {
				loopExists = true;
				break;
			}
		}
		if (loopExists) {
			fastPtr = fastPtr.getNext();
			count++;
			while (slowPtr != fastPtr) {
				fastPtr = fastPtr.getNext();
				count++;
			}
			return count;
		}
		return 0;
	}
}






