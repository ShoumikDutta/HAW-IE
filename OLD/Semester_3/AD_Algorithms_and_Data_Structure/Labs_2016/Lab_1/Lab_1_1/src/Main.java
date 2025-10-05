import java.util.Scanner;
import java.util.Stack;

public class Main {

    public static void main(String[] args)
    {

        Scanner sc = new Scanner(System.in);
        //after this we will realize the pseudocode algoritm

        for(int i = 0; i < 5; ++i)
        {
            System.out.println("Enter your expression in polish notation please (don't forget spaces!!!):");
            //first we need to give user the opportunity to type a string in polish notation
            String polishString = sc.nextLine();
            //for the rest look in class ArithmeticTerm (starting from Double evaluate())

            //first we need to create a new class
            ArithmeticTerm term = new ArithmeticTerm(polishString);

            System.out.println("Testing term.toString:\n" + term);

            term.reverse();
            System.out.println("Testing reverse:\n" + term);

            term.reverse();
            System.out.println("Testing one more reverse:\n" + term);

            System.out.println("Answer: " + term.evaluate());
        }
    }
}
