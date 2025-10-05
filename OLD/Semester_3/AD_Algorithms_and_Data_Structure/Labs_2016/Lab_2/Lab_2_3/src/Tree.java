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
    private void postorderTraversal(BiNode node)
    {
        if (node == null)
            return; //since we have a void, then here as if nothing is being returned
        //but in reality such functions "return" their results on a screen
        postorderTraversal(node.left);
        postorderTraversal(node.right);
        System.out.printf("%s ", node.item);
    }


    //here we have two methods: first is public and second is private
    //first is for start (always starts from root node)
    //second is for tree traversal
    public void postorderTraversal()
    {
        if (root == null)
        {
            System.out.println("Invalid expression");
            return;
        }
        postorderTraversal(root);
        System.out.println(); //same as \n
    }

    private BiNode construct(String polishString)
    {
        Stack<BiNode> tempStack = new Stack<>();
        StringTokenizer st = new StringTokenizer(polishString, " \t\n\r");
        while (st.hasMoreTokens())
        {
            String element = st.nextToken();
            //function Double.parseDouble(element) tries to read a string as a number
            //if impossible - will create an exception
            try
            {
                double value = Double.parseDouble(element);
                tempStack.push(new BiNode(element));
            } catch (Exception ex)
            {
                //unary expressions has to be added before
                // if (tempStack.size() < 2)
                //because they can work with just one value
                if (tempStack.size() < 1)
                    return null;

                if (element.equals("exp") || element.equals("sin") || element.equals("cos") ||
                        element.equals("!"))
                {
                    //these expressions can be on the left and right, so instead of left/right we have null
                    //a hint:
                    // left -> tempStack.pop(),
                    // right -> null
                    tempStack.push(new BiNode(element, tempStack.pop(), null));
                    continue;
                }

                //we have two containers
                //first - polish string, divided into substrings
                //second - stack where we write the nodes
                if (tempStack.size() < 2)
                    return null;
                if (element.equals("+") || element.equals("-") || element.equals("*")
                        || element.equals("/") || element.equals("^"))
                {
                    //4 5 10
                    //pop()  returns 10, then in stack we have 4 5
                    //pop()  returns 5, then in stack we have 4
                    BiNode right = tempStack.pop();
                    tempStack.push(new BiNode(element, tempStack.pop(), right));
                }


            }
        }
        return tempStack.pop();// returns the result
    }

    public Tree(String postfix)
    {
        root = construct(postfix);
    }
}
