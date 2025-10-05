public class BiNode
{
    //let's imagine a family tree
    public String item; //content
    public BiNode left; //left child
    public BiNode right; //right child

    BiNode(String item) // Leaf constructor
    {
        this(item, null, null);
    }

    BiNode(String item, BiNode left, BiNode right) // inner node
    {
//        item = item_;
//        right = right_;
//        left = left_;
        this.item = item;
        this.right = right;
        this.left = left;
    }
}