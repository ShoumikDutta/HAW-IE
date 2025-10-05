import java.util.ArrayList;

public class PQmin<T extends Comparable>
{
    private ArrayList<T> pq; // pq[i] = ith element on PQ

    public int getCurSize() {return pq.size();}

    public PQmin()
    {
        pq = new ArrayList<T>();
    }

    public void insert(T x)
    {
        pq.add(x);
    }

    public T delMin()
    {
        int minElementPosition = 0;

        for (int i = 1; i < getCurSize(); i++)
            if (pq.get(i).compareTo(pq.get(minElementPosition)) < 0)
            {
                minElementPosition = i;
            }

        T minValue = pq.get(minElementPosition);
        pq.set(minElementPosition, pq.get(getCurSize() - 1));
        pq.remove(getCurSize() - 1);
        return minValue;
    }
}

