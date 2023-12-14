public class Main {
    public static void main(String[] args) {

        AugmentedBST<Integer> bst = new AugmentedBST<Integer>();
        int xs[] = new int[] {20,10,30,5,15,25,35};

        for (int x : xs) {
            bst.insert(x);
        }
        System.out.println(bst);
        System.out.println("select 0 --> " + bst.select(0) + "\n");
        System.out.println("select 1 --> " + bst.select(1)+ "\n");
        System.out.println("select 6 --> " + bst.select(6)+ "\n");
        System.out.println("floor 10 --> " + bst.floor(10)+ "\n");
        System.out.println("ceiling 27--> " + bst.ceiling(27)+ "\n");
        System.out.println("rank 27--> " + bst.rank(27)+ "\n");


    }
}