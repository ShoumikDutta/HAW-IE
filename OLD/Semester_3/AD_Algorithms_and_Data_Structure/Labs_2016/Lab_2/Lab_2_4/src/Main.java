import java.util.Scanner;

public class Main {

    public static void main(String[] args)
    {
        Scanner sc = new Scanner(System.in);

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


        BiNode n22 = new BiNode("-");
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


        System.out.println("FPAE created from n7:\n" + simpleTree.infixGenerator());
        System.out.println("FPAE created from n14:\n" + simpleTree2.infixGenerator());
        System.out.println("FPAE created from n28:\n" + simpleTree3.infixGenerator());
        System.out.println("FPAE created from n37:\n" + simpleTree4.infixGenerator());
        System.out.println("FPAE created from n39:\n" + simpleTree5.infixGenerator());

        for(int i = 0; i < 5; ++i)
        {
            System.out.println("Type a postfix expression (don't forget about the space!!!):");
            String infixString = sc.nextLine();
            simpleTree = new Tree(infixString);

            System.out.println("FPAE created: ");
            System.out.println(simpleTree.infixGenerator());
        }
    }
}
