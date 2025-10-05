//idea to use an abstract class Sort with getters and setters taken from classmate Johannah Rosenblum. Implementation was done by the author (Antony Sotirov).
public abstract class Sort {

	/*Count variables are:
	 * private - not directly accessible to the user to get/set
	 * static - so that can be used by static methods that don't need initialization!
	 */
	private static int comparisonCount;
	private static int exchangeCount;
	
	
	public static int getCompareCount()
	{
		return comparisonCount;
	}
	
	public static int getExchangeCount()
	{
		return exchangeCount;
	}
	
	//need to use protected to ensure subclasses that extend Sort can use the methods
	protected static void resetCounters() //akin to a setter method
	{
		comparisonCount = 0;
		exchangeCount = 0;
	}
	
	protected static boolean isLess(String v, String z)
	{
		comparisonCount++;
		return (v.compareTo(z) < 0); //returns true or false
		/*Built in Comparable types in Java: String, Double, Integer, Date, File
		 * Comparable interface A.compareTo(B)
		 * returns -1 if A < B = A-1 (we want to trigger an exchange in this case): sorting in ascending order (smaller to bigger)
		 * returns +1 if A > B = A-1
		 * returns 0  if A = B = A-1 */
	}
	
	protected static boolean isLessDesc(String v, String z)
	{
		comparisonCount++;
		return (v.compareTo(z) > 0); //returns true or false
		/*Built in Comparable types in Java: String, Double, Integer, Date, File
		 * Comparable interface A.compareTo(B)
		 * returns -1 if A < B = A-1 (we want to trigger an exchange in this case): sorting in ascending order (smaller to bigger)
		 * returns +1 if A > B = A-1
		 * returns 0  if A = B = A-1 */
	}
	
	
	protected static void exch(String[] a, int i, int j) //order: first i, then j
	{ 
		String temp = a[i]; //store first element
		a[i] = a[j]; //assign second element to first element's position
		a[j] = temp; //assigned stored first element to the next position
		exchangeCount++;
	}
	
}
