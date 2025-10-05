import java.util.Scanner;

public class Main {

    public static void main(String[] args)
    {

        Scanner input = new Scanner(System.in);

        for(int i = 0; i < 5; ++i)
        {
            System.out.println("Type in an expression like ( 1 + 2 ) * ( 3 + 4 ) / ( 12 - 5 ) (don't forget spaces!!!):");

            String usualString = input.nextLine();

            ArithmeticTerm term = new ArithmeticTerm(usualString);

            System.out.println("Testing term.toString (the expression in infix form):\n" + term);

            term.reverse();
            System.out.println("Reverse string for your input:\n" + term);

            term.reverse();

            System.out.println("Testing polish notation:\n" + term.convert());

            System.out.println("Answer: " + term.evaluate());
        }
    }
}
