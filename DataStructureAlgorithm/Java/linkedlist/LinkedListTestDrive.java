package datastructure.linkedlist;

public class LinkedListTestDrive {
	public static void main(String[] args) {
		MyListNode list = new MyListNode(1);
		UseMyLinkedList uses = new UseMyLinkedList();
		System.out.println(list);
		for (int index = 2; index <= 10; index++)
			uses.InsertLinkedList(list, new MyListNode(index), index);
		System.out.println(list);
		uses.DeleteNodeFromLinkedList(list, 5);
		System.out.println(list);
	}
}
