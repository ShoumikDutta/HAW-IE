import java.util.Random;

public class Main {

    public static void main(String[] args)
    {
        final int RANDOM_ELEMENTS_COUNT = 100;
        //count of additional numbers more then RANDOM_ELEMENTS_COUNT to test heap overflowing
        //final int EXTRA_COUNT = (int)1e8;
        //if 1e8 takes too much time during "removing items in array" - try 1e5 in the comment below
        final int EXTRA_COUNT = (int)1e2;
        final int ERROR_VALUE = -1;
        PQmin queue = new PQmin(RANDOM_ELEMENTS_COUNT);
        Random random = new Random();

        for(int i=0; i< RANDOM_ELEMENTS_COUNT + EXTRA_COUNT; ++i)
        {
            int valueToAdd = random.nextInt(99) + 1;

            queue.insert(valueToAdd);
        }
        System.out.printf("All items are added. Heap contains %d element now. Max count is %d\n", queue.getCurSize(), queue.getMaxSize());

        //since array (a heap) is HUGE, it won't show instantly in the output in most PC, but its work can be seen in "debug mode" or just wait a few minutes
        //also, searching for minimal element in such huge array takes too much time if array is not sorted
        for(int i=0; i< RANDOM_ELEMENTS_COUNT + EXTRA_COUNT; ++i)
        {
            System.out.printf("%d\n",queue.delMin(ERROR_VALUE));
        }

        System.out.printf("All items are removed. Heap contains %d element now. Max count is %d\n", queue.getCurSize(), queue.getMaxSize());

        System.out.println();
    }
}
