using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace qsort
{
    class Program
    {
        static void Main(string[] args)
        {
            int[] data = {3, 5, 8, 1, 4, 9, 2, 6, 7};
            QSort<int>.Sort(data);
            //char[] data2 = {'Q', 'E', 'T', 'U', 'O', 'A', 'N', 'G', 'J', 'L', 'X', 'V', 'D'};
            //QSort<char>.Sort(data2);
            //for(var i = 0; i < data.Length; ++i)D:\1Univ\AD_Algorithms_and_Data_Structure\1_AD_16\Exams\qsort\Program.cs
            //    Console.Write("{0}, ", data[i]);
            Console.ReadKey();
        }
    }
}

