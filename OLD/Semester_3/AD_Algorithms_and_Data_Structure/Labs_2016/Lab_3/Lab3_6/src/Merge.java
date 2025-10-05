//implementation idea and code from lecture notes, Sedgewick 
public class Merge {

    private static int Swaps = 0;
    private static int Comp = 0;
    private static String[] aux;

    private static void merge(String[] a, String[] aux, int lo, int mid, int hi)
    {
        for (int k = lo; k <= hi; k++)
        {
            aux[k] = a[k]; //copy original array to auxiliary array
        }
        int i = lo, j = mid+1;

        for (int k = lo; k <= hi; k++)
        {
            Swaps++;
            if (i > mid)  //these are not compares, they are indexes
            {
                a[k] = aux[j++];
            }
            else if (j > hi)
            {
                a[k] = aux[i++];
            }
            else if (isLess(aux[j], aux[i]))
            {
                a[k] = aux[j++];
            }
            else
            {
                a[k] = aux[i++];
            }
        }
    }

    private static void sort(String[] a, String[] aux, int lo, int hi) //recursive splitting of original array
    {
        if (hi <= lo) return;
        int mid = lo + (hi - lo) / 2;
        sort(a, aux, lo, mid);
        sort(a, aux, mid+1, hi);
        merge(a, aux, lo, mid, hi); //finally send to merge and go up the recursion
    }

    public static void sort(String[] a) //public method for accessing the sort
    {
        Swaps = 0;
        Comp = 0;
        aux = new String[a.length];
        sort(a, aux, 0, a.length - 1);
    }

    public static int getSwaps()
    {
        return Swaps;
    }
    public static int getCompare()
    {
        return Comp;
    }

    protected static boolean isLess(String v, String z)
    {
        Comp++;
        return (v.compareTo(z) < 0); //returns true or false

    }

}
