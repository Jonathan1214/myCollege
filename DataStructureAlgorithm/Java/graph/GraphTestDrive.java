package datastructure.graph;

//import java.util.ArrayList;

public class GraphTestDrive {
	public static void main(String[] args) {
//		ArrayList<Integer> iList = new ArrayList<Integer>();
//		System.out.println(iList);
//		iList.add(0);
//		System.out.println(iList);
		GraphList gL = new GraphList(7);
		gL.addEdge(0, 2);
		gL.addEdge(0, 3);
		gL.addEdge(1, 2);
		gL.addEdge(2, 4);
		gL.addEdge(3, 6);
		gL.addEdge(5, 6);
		System.out.println(gL);
	}
}
