import java.util.Stack;
import java.util.StringTokenizer;

public class Tree
{
    private BiNode root;

    public Tree(BiNode root) //by argument they meant "BiNode root"
    {
        //root = root_
        this.root = root;
    }

    //reference:
    //https://en.wikipedia.org/wiki/Tree_traversal
    private void inorderTraversal(BiNode node)
    {
        if (node == null)
            return;
        inorderTraversal(node.left);
        System.out.printf("%s ", node.item);
        inorderTraversal(node.right);
    }


    public void inorderTraversal()
    {
        if (root == null)
        {
            System.out.println("Invalid expression");
            return;
        }
        inorderTraversal(root);
        //мы выводим все дерево в одну строку, потому в конце нужно курсор перевести на новую
        System.out.println(); //same as \n
    }

    //warning, recursive algorithm (dangerous for your brain!)
    //reference:
    //http://javaingrab.blogspot.de/2014/07/postfix-to-infix-conversion-using-stack.html
    private String infixGenerator(BiNode node)
    {
        String result = "";
        if (node == null)
            return "";

        //node.item == element
        if (node.item.equals("*") || node.item.equals("/") || node.item.equals("+") || node.item.equals("-") || node.item.equals("^") )
        {
            return "(" + infixGenerator(node.left) + " " + node.item + " " + infixGenerator(node.right) + ")";
        }
        if (node.item.equals("sin") || node.item.equals("cos") || node.item.equals("exp") || node.item.equals("!"))
            return node.item + "(" + infixGenerator(node.left) + ")";
        return node.item;
        // (3 + 5)
        //return infixGenerator(node.left) + " " + node.item + " " + infixGenerator(node.right);
    }

    public String infixGenerator()
    {
        if (root == null)
        {
            return "Invalid expression";
        }
        return infixGenerator(root);
    }

    private BiNode construct(String polishString)
    {
        Stack<BiNode> tempStack = new Stack<>();
        StringTokenizer st = new StringTokenizer(polishString, " \t\n\r");
        while (st.hasMoreTokens())
        {
            String element = st.nextToken();
            try
            {
                double value = Double.parseDouble(element);
                tempStack.push(new BiNode(element));
            } catch (Exception ex)
            {
                if (tempStack.size() < 1)
                    return null;

                if (element.equals("exp") || element.equals("sin") || element.equals("cos") ||
                        element.equals("!"))
                {
                    tempStack.push(new BiNode(element, tempStack.pop(), null));
                    continue;
                }

                if (tempStack.size() < 2)
                    return null;
                if (element.equals("+") || element.equals("-") || element.equals("*")
                        || element.equals("/") || element.equals("^"))
                {
                    BiNode right = tempStack.pop();
                    tempStack.push(new BiNode(element, tempStack.pop(), right));
                }


            }
        }
        return tempStack.pop();// returns the result
    }

    public Tree(String infixString)
    {
        root = construct(infixString);
    }
}
