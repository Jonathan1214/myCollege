package datastructure.tree;

import datastructure.queue.LLQueue;
import datastructure.stack.LLStack;

public class BinarTreeRelatedProblems {
//	�������Ԫ�� recursive
	int findMax(BinaryTreeNode root) {
		int root_val, left, right, max = 0;
		if (root != null) {
			root_val = root.getData();
			left = findMax(root.getLeft());
			right = findMax(root.getRight());
			if (left > right)
				max = left;
			else
				max = right;
			if (max < root_val)
				max = root_val;
		}
		return max;
	}
//	ɾ����
	void deleteBinaryTree(BinaryTreeNode root) {
		if (root == null)
			return;
		deleteBinaryTree(root.getLeft());
		deleteBinaryTree(root.getRight());
		root = null;
	}
//	������������
	void LevelOrderTraversalInReverse(BinaryTreeNode root) {
//		�����������ջ�Ͷ��н�����������
		if (root == null) return;
		LLQueue<BinaryTreeNode> Q = new LLQueue<BinaryTreeNode>();
		LLStack<BinaryTreeNode> S = new LLStack<BinaryTreeNode>();
		BinaryTreeNode temp;
		Q.enQueue(root);
		while (!Q.isEmpty()) {
			temp = Q.deQueue();
			if (temp.getRight() != null)
				Q.enQueue(temp.getRight());
			if (temp.getLeft() != null)
				Q.enQueue(temp.getLeft());
			S.push(temp);
		}
		while (!S.isEmpty())
			System.out.println(S.pop().getData());
	}
//	���ĸ߶�
	int heightOfBinaryTree(BinaryTreeNode root) {
		if (root == null) return 0;
		int leftheight, rightheight;
		leftheight = heightOfBinaryTree(root.getLeft());
		rightheight = heightOfBinaryTree(root.getRight());
		if (leftheight > rightheight)
			return leftheight + 1;
		else return rightheight + 1;
	}
	int heightOfBinaryTreeNonRecursive(BinaryTreeNode root) {
		int level = 1;
		if (root == null) return 0;
		LLQueue<BinaryTreeNode> Q = new LLQueue<BinaryTreeNode>();
		Q.enQueue(root).enQueue(null);
		while (!Q.isEmpty()) {
			root = Q.deQueue();
			if (root == null) {
				if (!Q.isEmpty())
					Q.enQueue(null);
				level++;
			} else {
				if (root.getLeft() != null)
					Q.enQueue(root.getLeft());
				if (root.getRight() != null)
					Q.enQueue(root.getRight());
			}
		}
		return level;
	}
//	Ѱ������Ľ��
	BinaryTreeNode DeepestNodeInBinaryTree(BinaryTreeNode root) {
		if (root == null) return null;
		BinaryTreeNode temp = null;
		LLQueue<BinaryTreeNode> Q = new LLQueue<BinaryTreeNode>();
		Q.enQueue(root);
		while (!Q.isEmpty()) {
			temp = Q.deQueue();
			if (temp.getLeft() != null)
				Q.enQueue(temp.getLeft());
			if (temp.getRight() != null)
				Q.enQueue(temp.getRight());
		}
		Q.deleteQueue();
		return temp;
	}
//	��ȡҶ�ӽ��ĸ���
	int NumberOfLeavesInBTUsingLevelOrder(BinaryTreeNode root) {
		if (root == null)
			return 0;
		BinaryTreeNode temp = null;
		LLQueue<BinaryTreeNode> Q = new LLQueue<BinaryTreeNode>();
		Q.enQueue(root);
		int count = 1;
		while (!Q.isEmpty()) {
			temp = Q.deQueue();
			if (temp.getLeft() == null && temp.getRight() == null)
				count++;
			else {
				if (temp.getLeft() != null)
					Q.enQueue(temp.getLeft());
				if (temp.getRight() != null)
					Q.enQueue(temp.getRight());
			}
		}
		return count;
	}
//	�����ĸ��� Non recursive
	int NumberOfFullNodesInBTUsingLevelOrder(BinaryTreeNode root) {
		if (root == null)
			return 0;
		BinaryTreeNode temp = null;
		LLQueue<BinaryTreeNode> Q = new LLQueue<BinaryTreeNode>();
		Q.enQueue(root);
		int count = 0;
		while (!Q.isEmpty()) {
			temp = Q.deQueue();
			if (temp.getLeft() != null && temp.getRight() != null)
				count++;
			if (temp.getLeft() != null)
				Q.enQueue(temp.getLeft());
			if (temp.getRight() != null)
				Q.enQueue(temp.getRight());
		}
		return count;
	}
//	���������������������
	BinaryTreeNode LCA(BinaryTreeNode root, BinaryTreeNode a, BinaryTreeNode b) {
		BinaryTreeNode left, right;
		if (root == null)
			return root;
		if (a == root || b == root)
			return root;
		left = LCA(root.getLeft(), a, b);
		right = LCA(root.getRight(), a, b);
		if (right != null && left != null)
			return root;
		else return (left!=null)?left:right;
	}
}






