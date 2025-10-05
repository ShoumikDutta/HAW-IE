public class RBST
{
    private Node root;
    private int count;

    private Node rotL(Node h)
    {
        Node v = h.right;
        h.right = v.left;
        v.left = h;
        return v;
    }

    private Node rotR(Node h)
    {
        Node u = h.left;
        h.left = u.right;
        u.right = h;
        return u;
    }

    private Node putRoot(Node x, String key, int val)
    {
        if (x == null) return new Node(key, val);
        int cmp = key.compareTo(x.key);
        if (cmp == 0) x.val = val;
        else if (cmp < 0)
        { x.left = putRoot(x.left, key, val); x = rotR(x); }
        else if (cmp > 0)
        { x.right = putRoot(x.right, key, val); x = rotL(x); }
        return x;
    }

    public void put(String key, int val)
    {
        ++count;
        root = put(root, key, val);
    }

    private Node put(Node x, String key, int val)
    {
        if (x == null) return new Node(key, val);
        int cmp = key.compareTo(x.key);
        if (cmp == 0) { x.val = val; return x; }
        if (StdRandom.bernoulli(1.0 / (x.N + 1.0)))
            return putRoot(x, key, val);  //changed h to x
        if (cmp < 0) x.left = put(x.left, key, val);
        else if (cmp > 0) x.right = put(x.right, key, val);
        x.N++;
        return x;
    }

    //put for simple BST to test depth function
//    private Node put(Node parentNode, String key, int val)
//    {
//        if (parentNode == null)
//        {
//            return new Node(key, val);
//        }
//        int cmp = key.compareTo(parentNode.key);
//        //case when this word was found again - just update value
//        if (cmp == 0)
//        {
//            parentNode.val = val;
//        }
//        else if (cmp < 0)
//        {
//            parentNode.left = put(parentNode.left, key, val);
//        }
//        else if (cmp > 0)
//        {
//            parentNode.right = put(parentNode.right, key, val);
//        }
//        return parentNode;
//    }

    public int depth()
    {
        return depth(root, 0);
    }

    private int depth(Node node, int curDepth)
    {
        if (node == null)
            return curDepth;
        int leftDepth = depth(node.left, curDepth + 1);
        int rightDepth = depth(node.right, curDepth + 1);
        if (leftDepth > rightDepth)
            return leftDepth;
        return rightDepth;
    }

    public int getCount()
    {
        return count;
    }
}

