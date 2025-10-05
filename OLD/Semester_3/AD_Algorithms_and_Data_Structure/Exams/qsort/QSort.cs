using System;

namespace qsort
{
    public class QSort<T> where T:IComparable<T>
    {
        public static void Sort(T[] arr)
        {
            Console.Write("Initial array: ");
            for (var i = 0; i < arr.Length; ++i)
                Console.Write("{0}, ", arr[i]);
            Console.WriteLine();

            Sort(arr, 0, arr.Length - 1);
        }

        private static void Sort(T[] arr, int l, int r)
        {
            if (l < r)
            {
                int q = Partition(arr, l, r);
                if (q != r)
                    Sort(arr, l, q);
                if (q + 1 != l)
                    Sort(arr, q + 1, r);
            }
        }

        private static int Partition(T[] arr, int b, int e)
        {
            Console.WriteLine("Partition {0}, {1}", b, e);
            var pivot = arr[(b + e)/2];
            int l = b;
            int r = e;
            while (l <= r)
            {
                while (arr[l].CompareTo(pivot) < 0)
                    l++;
                while (arr[r].CompareTo(pivot) > 0)
                    r--;
                if (l <= r)
                {
                    var t = arr[l];
                    arr[l] = arr[r];
                    arr[r] = t;
                    ++l;
                    --r;
                }
            }

            for(var i = 0; i < arr.Length; ++i)
                Console.Write("{0}, ", arr[i]);
            Console.WriteLine();
            return r;
        }
    }
}