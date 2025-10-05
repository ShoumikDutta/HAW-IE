import java.util.Stack;
import java.util.StringTokenizer;

public class ArithmeticTerm
{
    private String usualString_; // usualString_ - the Infix expression

    public ArithmeticTerm(String usualString)
    {
        usualString_ = usualString;
    }

    public String toString()
    {
        return usualString_;
    }

    //this part is what's different from problem 1, here we get Postfix from Infix Expressions
    public String convert()
    {
        String outputString = "";
        Stack<String> tempStack = new Stack<>();
        StringTokenizer st = new StringTokenizer(usualString_, " \t\n\r");
        while (st.hasMoreTokens())
        {
            String element = st.nextToken();
            try
            {
                double value = Double.parseDouble(element);
                outputString += element + " ";
            } catch (Exception ex)
            {
                if (element.equals("+") || element.equals("-") || element.equals("*")
                        || element.equals("/") || element.equals("^"))
                {
                    tempStack.push(element);
                } else if (element.equals(")"))
                {
                    outputString += tempStack.pop() + " ";
                }
            }
        }
        while (tempStack.size() > 0)
            outputString += tempStack.pop() + " ";
        return outputString;
    }

    public void reverse()
    {
        Stack<String> tempStack = new Stack<>();
        StringTokenizer st = new StringTokenizer(usualString_, " \t\n\r");
        while (st.hasMoreTokens())
        {
            tempStack.push(st.nextToken());
        }

        usualString_ = tempStack.pop();

        while (tempStack.size() > 0)
        {
            usualString_ = usualString_ + " " + tempStack.pop();
        }
    }

    public Double evaluate()
    {
        String polishString = convert();
        //String polishString = sc.nextLine();
        StringTokenizer st = new StringTokenizer(polishString, " \t\n\r");

        Stack<Double> algorithmStack = new Stack<>();
        while (st.hasMoreTokens())
        {
            String element = st.nextToken();
            try
            {
                double value = Double.parseDouble(element);
                algorithmStack.push(value);
            } catch (Exception ex)
            {
                if (algorithmStack.size() < 2)
                {
                    System.out.println("Error");
                    return 0.0;
                }
                if (element.equals("+"))
                {
                    double b = algorithmStack.pop();
                    double a = algorithmStack.pop();
                    double res = a + b;
                    algorithmStack.push(res);
                } else if (element.equals("-"))
                {
                    double b = algorithmStack.pop();
                    double a = algorithmStack.pop();
                    double res = a - b;
                    algorithmStack.push(res);
                } else if (element.equals("*"))
                {
                    double b = algorithmStack.pop();
                    double a = algorithmStack.pop();
                    double res = a * b;
                    algorithmStack.push(res);
                } else if (element.equals("/"))
                {
                    double b = algorithmStack.pop();
                    double a = algorithmStack.pop();
                    double res = a / b;
                    algorithmStack.push(res);
                } else if (element.equals("^"))
                {
                    double b = algorithmStack.pop();
                    double a = algorithmStack.pop();
                    double res = Math.pow(a, b);
                    algorithmStack.push(res);
                } else
                {
                    System.out.println("Error");
                    break;
                }
            }
        }
        if (algorithmStack.size() != 1)
        {
            System.out.print("Error");
            return 0.0;
        }
        return algorithmStack.pop();
    }
}