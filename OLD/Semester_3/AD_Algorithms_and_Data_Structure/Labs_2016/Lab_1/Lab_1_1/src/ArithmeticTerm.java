import java.util.Stack;
import java.util.StringTokenizer;

public class ArithmeticTerm
{
    private String polishString_;  //ÌÂ "ÏÂÚÓ‰", ‡ "ÔÓÎÂ"

    public ArithmeticTerm(String polishString)
    {
        polishString_ = polishString;
    }

    public String toString()
    {
        return polishString_;
    }

    public void reverse()
    {
        //we were asked to use class Stack for solving the problem
        Stack<String> tempStack = new Stack<>();
        StringTokenizer st = new StringTokenizer(polishString_, " \t\n\r");
        while (st.hasMoreTokens())
        {
            //now we have a tokenizer that allows to "break" a big string into substrings
            //these substrings are added into a stack in a direct order
            //but!!! When we will take substrings, they will be taken in the inverse order
            tempStack.push(st.nextToken());
        }

        //then a ì-ì will be inserted first into polishString_ - yes, it's recorded in inverse order
        polishString_ = tempStack.pop();

        //now, as understood previously, we donít have to worry about how to get
        //the elements from stack in the inverse order
        while (tempStack.size() > 0)
        {
            //here we add all elements to an existing string in inverse order
            polishString_ = polishString_ + " " + tempStack.pop();
        }
    }

    public Double evaluate()
    {
        // fisrt we need to give user the opportunity of typing the string in a Polish Notation
        //String polishString = sc.nextLine();
        //now we have to make it into separate symbols
        StringTokenizer st = new StringTokenizer(polishString_, " \t\n\r");

        //this way creates an object known as a stack
        Stack<Double> algorithmStack = new Stack<>();
        // now we sort out all the symbols of a string one after another
        while (st.hasMoreTokens())
        {
            String element = st.nextToken();
            //function Double.parseDouble(element) will try to read a string as a number
            //if it won't be possible, then it will create an exceptional situation in ìcatch (Exception ex)î
            try
            {
                //hereís the case if turning into a number is possible 
                double value = Double.parseDouble(element);
                algorithmStack.push(value);
            }
            //if we get into ìcatch (Exception ex)î ñ it means the substring was an operand or something else, or even error, but not a number
            catch (Exception ex)
            {
                if (algorithmStack.size() < 2)
                {
                    System.out.println("Error");
                    return 0.0;
                }

                if (element.equals("+"))
                {
                    //we add substrings in a direct order into a substring, but read them in an inverse(!!!!) order
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
        //this code solves a problem when thereís not enough of operations
        //for example 2 2 2 2 +, when actually there should be something like 2 2 2 2 + - *
        if (algorithmStack.size() != 1)
        {
            System.out.print("Error");
            return 0.0;
        }
        return algorithmStack.pop();
    }
}
