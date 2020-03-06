package datastructure.tree;

public class TreeNode {
//	使用二叉树就可以实现
	private int data;
	private TreeNode firstChild;
	private TreeNode nextSibling;
	
	public int getData() {
		return this.data;
	}
	
	public TreeNode setData(int data) {
		this.data = data;
		return this;
	}
	
	public TreeNode getFirstChild() {
		return this.firstChild;
	}
	
	public TreeNode setFirstChild(TreeNode firstChild) {
		this.firstChild = firstChild;
		return this;
	}
	
	public TreeNode setNextSibling(TreeNode nextSibling) {
		this.nextSibling = nextSibling;
		return this;
	}
	
	public TreeNode getNextSibling() {
		return this.nextSibling;
	}
}
