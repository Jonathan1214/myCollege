package datastructure.tree;

public class BinaryTreeTraverseTestDrive {
	static BinaryTreeNode createBinaryTree() {
		BinaryTreeNode root = new BinaryTreeNode(1);
		root.setLeft(new BinaryTreeNode(2)).setRight(new BinaryTreeNode(3));
		root.getLeft().setLeft(new BinaryTreeNode(4)).setRight(new BinaryTreeNode(5));
		root.getRight().setLeft(new BinaryTreeNode(6)).setRight(new BinaryTreeNode(7));
		return root;
	}
	public static void main(String[] args) {
		BinaryTreeNode tree = createBinaryTree();
		TraverseBinaryTree traverser = new TraverseBinaryTree();
		traverser.PreOrder(tree);
		System.out.println();
		traverser.PreOrderNonRecursive(tree);
		System.out.println("\n");
		
		traverser.InOrder(tree);
		System.out.println();
		traverser.InOrderNonRecursive(tree);
		System.out.println("\n");
		
		traverser.PostOrder(tree);
		System.out.println();
//		test no good
//		traverser.PostOrderNonRecursive(tree);
		traverser.LevelOrder(tree);
	}
}
