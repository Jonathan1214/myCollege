package datastructure.graph;

public class GraphMatrix {
//	ÎÞÏòÍ¼
	private boolean adjMatrix[][];
	private int vertexCount;
	public GraphMatrix(int vertexCount) {
		// TODO Auto-generated constructor stub
		this.vertexCount = vertexCount;
		adjMatrix = new boolean[vertexCount][vertexCount];
	}
	public void addEdge(int i, int j) {
		if (i >=0 && i < vertexCount-1 && j >= 0 && j < vertexCount) {
			adjMatrix[i][j] = true;
			adjMatrix[j][i] = true;
		}
	}
	public void removeEdge(int i, int j) {
		if (i >=0 && i < vertexCount-1 && j >= 0 && j < vertexCount) {
			adjMatrix[i][j] = false;
			adjMatrix[j][i] = false;
		}
	}
	public boolean isEdge(int i, int j) {
		if (i >=0 && i < vertexCount-1 && j >= 0 && j < vertexCount)
			return adjMatrix[i][j];
		else return false;
	}
	
}
