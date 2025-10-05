//implementation idea from lecture notes, Sedgewick 
public class Insertion extends Sort {
	
	//public static method: can be used without initialization!
	public static String[] sort(String[] str)
	{
		//reset both counts for each call of the static method
		resetCounters();
		
		int N = str.length;
		for (int i = 0; i < N; i++)
		{
			for (int j = i; j > 0; j--) //when i=0: the for loop will be skipped :)
			{
				if ( isLess(str[j], str[j-1]) ) //compare an element with the previous one, if true - run an exchange:
					exch(str, j, j-1);
				else break; //once the a[j] string is bigger than a[j-1] no need for further comparisons and swaps
			}//end inner for-loop
		}//end outer for-loop
		
		return str;
	}//end sort method
	
}//end class Insertion
