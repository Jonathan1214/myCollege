package datastructure.tree;

public class BinaryTreeNode {
	private int data;
	private BinaryTreeNode left;
	private BinaryTreeNode right;
	
	public BinaryTreeNode(int data) {
		this.data = data;
	}
	public int getData() {
		return data;
	}
	public void setData(int data) {
		this.data = data;
	}
	public BinaryTreeNode getLeft() {
		return left;
	}
	public BinaryTreeNode setLeft(BinaryTreeNode left) {
		this.left = left;
		return this;
	}
	public BinaryTreeNode getRight() {
		return right;
	}
	public BinaryTreeNode setRight(BinaryTreeNode right) {
		this.right = right;
		return this;
	}
}
