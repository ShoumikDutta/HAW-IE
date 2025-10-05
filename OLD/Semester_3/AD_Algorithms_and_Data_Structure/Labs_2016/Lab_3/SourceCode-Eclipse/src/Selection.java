//implementation idea from lecture notes, Sedgewick 
public class Selection extends Sort { 
	
	//public static method: can be used without initialization!
	public static String[] sort(String[] str)
	{
		//reset both counts for each call of the static method
		resetCounters();
		
		int N = str.length;
		for (int i = 0; i < N; i++)
		{
			int min = i; //set initial minimum index
			for (int j = i+1; j < N; j++) //search the successive elements for the smallest element among them
			{
				if ( isLess(str[j], str[min]) )//compare the j-th element with the min element
					min = j; //set the new min index if comparison returns positive
			}//end inner for loop
			exch(str, i, min);
		}//end outer for loop
		
		return str;
	}//end sort method
	
	public static String[] sortDesc(String[] str)
	//why can't we use "Comparable[]" ???
	{
		//reset both counts for each call of the static method
		resetCounters();
		
		int N = str.length;
		for (int i = 0; i < N; i++)
		{
			int min = i; //set initial minimum index
			for (int j = i+1; j < N; j++) //search the successive elements for the smallest element among them
			{
				if ( isLessDesc(str[j], str[min]) )//compare the j-th element with the min element
					min = j; //set the new min index if comparison returns positive
			}//end inner for loop
			exch(str, i, min);
		}//end outer for loop
		
		return str;
	}//end sort method
	
}//end class Selection
