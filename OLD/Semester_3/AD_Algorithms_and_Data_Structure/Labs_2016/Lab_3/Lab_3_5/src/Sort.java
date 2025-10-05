//since we need to make to different sorts, then we'll use one class for both of them
//we'll do this way since sorting is usually a one-time process
//provided the data - got the sorted data, there's no need to sort what had already been sorted
public class Sort
{
    //since we have static functions, then for simplicity we'll create static variables which will be used in some functions
    static int comparisonCount;
    static int exchangesCount;

    public static String[] SortSelection(String[] data)
    {
        //here we get the array "data" which haven't been sorted yet
        String[] sortedResult = new String[data.length];

        //then we copy the initial array into the one that will be sorted
        //the process will repeat as long as i< data.length
        for(int i = 0; i < data.length; ++i)
        {
            sortedResult[i] = data[i];
        }

        exchangesCount = 0;
        comparisonCount = 0;
        for(int i = 0; i < sortedResult.length; ++i)
        {
            //the bigger will be number i, the less elements will there be on the right side
            //when i = 90, then min element will be searched only among positions from 90 to 99
            //for i = 99, ony one position will be left and that's 99
            int minimalElementPos = GetMinimalString(sortedResult, i);
            //the code below changes positions of the current string (with i)
            //with the lowest string
            //we don't need to change positions when minimalElementPos == i
            if (i != minimalElementPos)
            {
                exch(sortedResult, i, minimalElementPos);
//
//                exchangesCount++;
//                String tmpString = sortedResult[i];
//                sortedResult[i] = sortedResult[minimalElementPos];
//                sortedResult[minimalElementPos] = tmpString;
            }
        }
        System.out.printf("Selection Sorting request %d exchange operations and %d comparison operations\n", exchangesCount,
                comparisonCount);

        return sortedResult;
    }


    //we'll do in such way that function GetMinimalString returned the position of lowest element
    //this way it'll be easier to perform deletion
    //data - our array, à startPos - element's position from which we start looking for the lowest element
    //at first it will be 0, then 1, 2 and so on
    private static int GetMinimalString(String[] data, int startPos)
    {
        //here's the same principle as how we were looking for the lowest number in an array
        //first we say that lowest number - first in the list, then we compare further
        int minSPos = startPos;
        for (int i = startPos + 1; i < data.length; ++i)
        {
            ++comparisonCount;
            //compareTo compares the string on the left from the string data[minSPos] with... right, with data[minSPos]
            if (data[i].compareTo(data[minSPos]) < 0)
                minSPos = i;
        }
        return minSPos;
    }

    public static String[] SortInsertion(String[] data)
    {
        exchangesCount = 0;
        comparisonCount = 0;
        //data
        //5 4 1 3 2 was

        //sortedResult
        //5 <= sortedResult[0] = data[0];

        //        sortedResult[1] < sortedResult[0]
        //5 4 =>  sortedResult[0] = data[1] => 4 5
        // 4 5 1 => sortedResult[1] = data[2] => 4 1 5 => sortedResult[0] = data[1] => 1 4 5
        // 1 4 5 3 => sortedResult[2] = data[3] => 1 4 3 5 => sortedResult[1] = data[2] => 1 3 4 5
        //1 3 4 5 2 => sortedResult[3] = data[4] => 1 3 4 2 5 .... => sortedResult[0] = data[1] => 1 2 3 4 5
        String[] sortedResult = new String[data.length];
        //we won't sort the whole array, only the first element, then we take the rest in orderly fashion
        //and for each of elements we have to find a place to insert into, so that the sequence has to be sorted
        sortedResult[0] = data[0];
        for ( int i = 1; i < data.length; ++i)
        {
            //starts form the end
            sortedResult[i] = data[i];
            for( int j = i; j > 0; --j)
            {
                //compareTo compares the string on the left from the string sortedResult[j - 1] with... right, with sortedResult[j - 1]
                //returns the number less than 0, if a string on the left is bigger than sortedResult[j - 1]
                //returns 0 if both strings are ==
                //returns number bigger than 0 if string on the left is bigger than sortedResult[j - 1]
                //the feature here is that the exchangeCount is almost same (or close) as comparisonCount
                ++comparisonCount;
                if (sortedResult[j].compareTo(sortedResult[j - 1]) < 0)//here we check if string j is less than j-1
                //also can be done this way (j-1 is more than j)
                //if (sortedResult[j - 1].compareTo(sortedResult[j]) > 0)
                {
                    //here we exchange strings
                    exch(sortedResult, j, j - 1);
                }
                else
                    //once we find the string less than current string (which will be placed from right to left),
                    //then there's no more need for compares and exchanges
                    break;
            }
        }
        System.out.printf("Insertion Sorting request %d exchange operations and %d comparision operations\n", exchangesCount,
                comparisonCount);

        return sortedResult;
    }

    private static void exch(String[] data, int i, int j)
    {
        exchangesCount++;
        String tmpString = data[i];
        data[i] = data[j];
        data[j] = tmpString;
    }
}