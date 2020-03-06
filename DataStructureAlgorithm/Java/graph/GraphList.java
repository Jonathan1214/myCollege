package datastructure.graph;

import java.util.ArrayList;

import datastructure.linkedlist.LLNode;

public class GraphList {
	private ArrayList<Integer> vertices;
	private ArrayList<LLNode<Integer>> edges;
	@SuppressWarnings("unused")
	private int vertexCount;
	public GraphList(int vertexCount) {
		// TODO Auto-generated constructor stub
		this.vertexCount = vertexCount;
		vertices = new ArrayList<Integer>();
		edges = new ArrayList<LLNode<Integer>>();
		for (int i = 0; i < vertexCount; i++) {
			vertices.add(i);
			edges.add(new LLNode<Integer>(i));
		}
	}
	public void addEdge(int source, int destination) {
		int i = vertices.indexOf(source);
		int j = vertices.indexOf(destination);
		if (i != -1 || j != -1) {
//			从头插入 再后面插入也应该可以
			edges.get(i).InsertAtBegining(new LLNode<Integer>(destination));
			edges.get(j).InsertAtBegining(new LLNode<Integer>(source));
		}
	}
	@Override
	public String toString() {
		// TODO Auto-generated method stub
		String s = new String();
		for (int vertex : vertices) {
			int index = vertices.indexOf(vertex);
//			s = s + index + ": ";
			LLNode<Integer> temp = edges.get(index); //.getNext();
			s = s + temp.getData() + ": ";
			temp = temp.getNext();
			while (temp != null) {
				s += temp.getData() + " ";
				temp = temp.getNext();
			}
			s += "\n";
		}
		return s;
	}
	
}
