
public class BST
{
    private Node root;

    private class Node
    {
        //instead of (Key key) and (Value value):
        String key;//words
        Integer value;//number of word-comparisons needed to store the word in the tree

        Node left, right;

        public Node (String _key, Integer _value)
        {
            key = _key;
            value = _value;
        }
    }

    public void put(String key)
    {
        root = put(root, key);
    }


    private Node put(Node parentNode, String key)
    {
        //case when the word was found for the first time - then in "found" we write 1
        if (parentNode == null)
        {
            return new Node(key, 1);
        }
        int cmp = key.compareTo(parentNode.key);
        //case when this word was found again - just update value
        if (cmp == 0)
        {
            ++parentNode.value;
        }
        else if (cmp < 0)
        {
            parentNode.left = put(parentNode.left, key);
        }
        else if (cmp > 0)
        {
            parentNode.right = put(parentNode.right, key);
        }
        return parentNode;
    }

    //modified a bit since we need to return two values (x.value and curDepth)
    public SearchResult get(String key)
    {

        Node x = root;
        int curDepth = 0;
        while (x != null)
        {
            int cmp = key.compareTo(x.key);
            if (cmp == 0)
            {
                SearchResult result = new SearchResult(x.value, curDepth);
                return result;
                // also possible:
                // return new SearchResult(x.value, curDepth);
            }
            else if (cmp <= 0)
                x = x.left;
            else if (cmp > 0)
                x = x.right;
            ++curDepth;
        }
        return null;
    }
}
