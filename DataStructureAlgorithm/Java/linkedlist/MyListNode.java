package datastructure.linkedlist;

public class MyListNode {
	private int data;
	private MyListNode next;
	
	// 构造函数
	public MyListNode(int data) {
		this.data = data;
	}
	
	public void setData(int data) {
		this.data = data;
	}
	
	public int getData() {
		return data;
	}
	
	public void setNext(MyListNode next) {
		this.next = next;
	}

	public MyListNode getNext() { // 获取下一个节点
		return this.next;
	}
	
	@Override
	public String toString() {
		// TODO Auto-generated method stub
		MyListNode anext = next;
		String rtString = new String("");
		rtString += data;
		while (anext != null) {
			rtString = rtString + "->" + anext.getData();
			anext = anext.getNext();
		}
		return rtString;
	}
}
