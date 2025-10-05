public class IntHolder {
    private int value;

    public int getValue()
    {
        return value;
    }

    public int inc()
    {
        return value++;
    }

    public IntHolder(int startValue)
    {
        value = startValue;
    }
}
