package datastructure.linkedlist;

public class FloydLoopDetect {
//	Floyd �㷨
//		����������Ƿ���ڻ�
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

//	�ҵ�������� ���Ժ�������ɾ��
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
//	ȷ�����ĳ���
	int FindLoopLength(MyListNode head) {
		if (head == null) return 0;
		MyListNode slowPtr = head, fastPtr = head;
		int count = 0;
		boolean loopExists = false;
//		ȷ�����Ƿ����
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






