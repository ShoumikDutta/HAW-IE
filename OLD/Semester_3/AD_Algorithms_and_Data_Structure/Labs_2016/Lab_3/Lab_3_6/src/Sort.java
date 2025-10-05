
public class Sort
{
    static int comparisonCount;
    static int exchangesCount;

    //this "merge" function was found in one of Sedgewick lectures
    //changed from "aux" to "b"
    // aux => auxiliary
    private static void merge(String[] a, String[] b, int l, int m, int r)
    {
        for (int i = l; i < m; i++)
        {
            b[i] = a[i];
            ++exchangesCount;
        }
        for (int j = m; j < r; j++)
        {
            b[j] = a[m + r - j - 1];
            ++exchangesCount;
        }

        int i = l, j = r - 1;

        for (int k = l; k < r; k++)
        {
            ++comparisonCount;
            ++exchangesCount;
            if (b[j].compareTo(b[i]) < 0)
                a[k] = b[j--];
            else
                a[k] = b[i++];
        }
    }

    //this function sorts the array, but doesn't return the result
    //it transposes elements in the same array "a" that came into this function
    public static void SortMerge(String[] a)
    {
//        //**********
//        String[] sortedResult = new String[count]; //вставили count, вместо data.length
//        for (int i = 0; i < count; ++i)
//        {
//            sortedResult[i] = a[i];
//        }
//        //**********

        exchangesCount = 0;
        comparisonCount = 0;
        int N = a.length;
        String[] aux = new String[N];
        for (int m = 1; m < N; m *= 2)
            for (int i = 0; i < N-m; i += m+m)
                merge(a, aux, i, i+m, Math.min(i+m+m, N));
        System.out.printf("Merge Sorting request %d exchange operations and %d comparison operations\n", exchangesCount/3,
                comparisonCount);
    }


    public static String[] SortSelection(String[] data, int count)
    {
        String[] sortedResult = new String[count]; //вставили count, вместо data.length
        for (int i = 0; i < count; ++i)
        {
            sortedResult[i] = data[i];
        }

        exchangesCount = 0;
        comparisonCount = 0;
        for (int i = 0; i < sortedResult.length; ++i)
        {
            int minimalElementPos = GetMinimalString(sortedResult, i);
            if (i != minimalElementPos)
            {
                exchangesCount++;
                String tmpString = sortedResult[i];
                sortedResult[i] = sortedResult[minimalElementPos];
                sortedResult[minimalElementPos] = tmpString;
            }
        }
        System.out.printf("Selection Sorting request %d exchange operations and %d compariosion operations\n", exchangesCount,
                comparisonCount);

        return sortedResult;
    }

    private static int GetMinimalString(String[] data, int startPos)
    {
        int minSPos = startPos;
        for (int i = startPos + 1; i < data.length; ++i)
        {
            ++comparisonCount;
            if (data[i].compareTo(data[minSPos]) < 0)
                minSPos = i;
        }
        return minSPos;
    }
}