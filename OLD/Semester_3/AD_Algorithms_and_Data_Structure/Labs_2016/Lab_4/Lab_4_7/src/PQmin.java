
public class PQmin
{
    //strictly speaking the best way to make program faster is using ArrayList<Integer> instead of simple array
    //but since we have a task specifically requiring an array, so be it =)
    private int[] pq; // pq[i] = ith element on PQ
    private int N; // number of elements on PQ

    public int getCurSize() {return N;}
    public int getMaxSize() {return pq.length;}

    public PQmin(int queueMaxSize)
    {
        N = 0;
        pq = new int[queueMaxSize];
    }

    public void insert(int x)
    {
        //in Lecture 2 "StackQueue" the Resize method is for Strings, so here we have a method for integers
        if (N == pq.length)
        {
            //heap is full - we need to create new array with size bigger then before to give possibility to add new number
            //lets set new size to value 2 times more then before
            int[] newHeap = new int[pq.length*2];
            //copy old values to new heap
            for(int i = 0; i < pq.length; ++i)
                newHeap[i] = pq[i];
            //set reference to the new heap
            pq = newHeap;
        }
        //unlike removing operation, adding random numbers into arrays happens with lightning speed
        pq[N++] = x;
    }

    public int delMin(int errorValue)
    {
        if (N == 0)
        {
            System.out.printf("\nError - you are trying to delete item from empty heap\n");
            return errorValue;
        }

        int minElementPosition = 0;
        for (int i = 1; i < N; i++)
            if (pq[i] < pq[minElementPosition])
            {
                minElementPosition = i;
            }

        int minValue = pq[minElementPosition];
        pq[minElementPosition] = pq[N-1];
        N--;
        return minValue;
    }
}

