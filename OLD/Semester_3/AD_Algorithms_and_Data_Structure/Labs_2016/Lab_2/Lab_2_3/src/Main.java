import java.util.Scanner;

public class Main {

    public static void main(String[] args)
    {

        Scanner sc = new Scanner(System.in);

        //first four (n1-n4) are "leaves"
        //here we also create a tree, but node after a node
        BiNode n1 = new BiNode("3");
        BiNode n2 = new BiNode("5");
        BiNode n3 = new BiNode("3");
        BiNode n4 = new BiNode("1");

        BiNode n5 = new BiNode("+", n1, n2);
        BiNode n6 = new BiNode("/", n3, n4);
        BiNode n7 = new BiNode("*", n5, n6);


        BiNode n8 = new BiNode("3.2");
        BiNode n9 = new BiNode("5.2");
        BiNode n10 = new BiNode("3.2");
        BiNode n11 = new BiNode("1.0");

        BiNode n12 = new BiNode("+", n8, n9);
        BiNode n13 = new BiNode("/", n10, n11);
        BiNode n14 = new BiNode("*", n12, n13);


        BiNode n15 = new BiNode("3.2");
        BiNode n16 = new BiNode("2");
        BiNode n17 = new BiNode("3");
        BiNode n18 = new BiNode("1");

        BiNode n19 = new BiNode("^", n15, n16);
        BiNode n20 = new BiNode("^", n17, n18);
        BiNode n21 = new BiNode("^", n19, n20);


        BiNode n22 = new BiNode("-3.2");
        BiNode n23 = new BiNode("2.5");
        BiNode n24 = new BiNode("3.8");
        BiNode n25 = new BiNode("1.5");
        BiNode n26 = new BiNode("3.1");
        BiNode n27 = new BiNode("1.9");
        BiNode n28 = new BiNode("-3.0");
        BiNode n29 = new BiNode("2");

        BiNode n30 = new BiNode("+", n22, n23);
        BiNode n31 = new BiNode("-", n24, n25);
        BiNode n32 = new BiNode("*", n26, n27);
        BiNode n33 = new BiNode("^", n28, n29);
        BiNode n34 = new BiNode("/", n30, n31);
        BiNode n35 = new BiNode("-", n32, n33);
        BiNode n36 = new BiNode("+", n34, n35);
        BiNode n37 = new BiNode("sin", n36, null);


        BiNode n38 = new BiNode("-1");
        BiNode n39 = new BiNode("sin", n38, null);

        Tree simpleTree = new Tree(n7);
        Tree simpleTree2 = new Tree(n14);
        Tree simpleTree3 = new Tree(n21);
        Tree simpleTree4 = new Tree(n37);
        Tree simpleTree5 = new Tree(n39);


        //Call the postorderTraversal method for the tree constructed in the main program of step 2.
        System.out.println("Test tree created by hands (n7, n14 and so on):");
        simpleTree.postorderTraversal();
        simpleTree2.postorderTraversal();
        simpleTree3.postorderTraversal();
        simpleTree4.postorderTraversal();
        simpleTree5.postorderTraversal();

        //another way to make things way simpler
        System.out.println("Test tree created by special constructor: ");
        Tree autoTree = new Tree("3 5 + 3 1 / *");
        //it might look strange that we enter postfix and get the same thing that's actually a postorder tree

        autoTree.postorderTraversal();

        //just for fun with typing in the console
        for(int i = 0; i < 5; ++i)
        {
            System.out.println("Type a postfix expression (don't forget about the space!!!):");
            String postfixString = sc.nextLine();
            autoTree = new Tree(postfixString);

            System.out.println("A tree created: ");
            autoTree.postorderTraversal();
        }
    }

}
