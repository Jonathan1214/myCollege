package datastructure.tree;

import java.util.Stack;

import datastructure.queue.LLQueue;

public class TraverseBinaryTree {
//	前续遍历 DLR
	void PreOrder(BinaryTreeNode root) {
		// 递归解决
		if (root != null) {
			System.out.print(root.getData() + " ");
			PreOrder(root.getLeft());
			PreOrder(root.getRight());
		}
	}

	void PreOrderNonRecursive(BinaryTreeNode root) {
		if (root == null)
			return;
		Stack<BinaryTreeNode> S = new Stack<BinaryTreeNode>();
		while (true) {
			while (root != null) {
				System.out.print(root.getData() + " ");
				S.push(root);
				root = root.getLeft();
			}
			if (S.isEmpty())
				break;
			root = S.pop().getRight();
		}
	}

//	中序遍历 LDR
	void InOrder(BinaryTreeNode root) {
		if (root != null) {
			InOrder(root.getLeft());
			System.out.print(root.getData() + " ");
			InOrder(root.getRight());
		}
	}

	void InOrderNonRecursive(BinaryTreeNode root) {
		if (root == null)
			return;
		Stack<BinaryTreeNode> S = new Stack<BinaryTreeNode>();
		while (true) {
			while (root != null) {
				S.push(root);
				root = root.getLeft();
			}
			if (S.isEmpty())
				break;
			root = S.pop();
			System.out.print(root.getData() + " ");
			root = root.getRight();
		}
	}

//	后序遍历 LRD
	void PostOrder(BinaryTreeNode root) {
		if (root != null) {
			PostOrder(root.getLeft());
			PostOrder(root.getRight());
			System.out.print(root.getData() + " ");
		}
	}

	void PostOrderNonRecursive(BinaryTreeNode root) {
		if (root == null)
			return;
		Stack<BinaryTreeNode> S = new Stack<BinaryTreeNode>();
		while (true) {
			if (root != null) {
				S.push(root);
				root = root.getLeft();
			} else {
				if (S.isEmpty()) {
					System.out.println("Stack is Empty");
					return;
				} else {
					if (S.peek().getRight() == null) {
						root = S.pop();
						System.out.print(root.getData() + " ");
						if (root == S.peek().getRight())
							System.out.print(S.pop().getData() + " ");
					}
					if (!S.isEmpty())
						root = S.peek().getRight();
					else
						root = null;
				}
			}
		}
	}

//	层次遍历
	void LevelOrder(BinaryTreeNode root) {
		BinaryTreeNode temp;
		LLQueue<BinaryTreeNode> Q = new LLQueue<BinaryTreeNode>();
		if (root == null) return;
		Q.enQueue(root);
		while (!Q.isEmpty()) {
			temp = Q.deQueue();
			System.out.print(temp.getData() + " ");
			if (temp.getLeft() != null) Q.enQueue(temp.getLeft());
			if (temp.getRight() != null) Q.enQueue(temp.getRight());
		}
		Q.deleteQueue();
	}

}
