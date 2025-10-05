//class in which we save two values:
//1 - count of certain words
//2 - depth of certain word
public class SearchResult
{
    private int countOfWords;
    private int wordDepth;

    public SearchResult (int _countOfWords, int _wordDepth)
    {
        countOfWords = _countOfWords;
        wordDepth = _wordDepth;
    }

    public int getCountOfWords()
    {
        return countOfWords;
    }

    public int getWordDepth()
    {
        return wordDepth;
    }
}
