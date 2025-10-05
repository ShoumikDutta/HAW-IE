import java.util.HashMap;

public class HuffmanDecoder
{
    private Node root;
    private HashMap<Character, String> table = new HashMap<Character, String>();

    public HuffmanDecoder(String message)  //input -> sequence
    {
        int[] freq = new int[128];
        for (int i = 0; i < message.length(); i++)
        {
            freq[message.charAt(i)]++;
        }
        PQmin<Node> pq = new PQmin<Node>();
        for (int i = 0; i < 128; i++)
            if (freq[i] > 0)
                pq.insert(new Node((char) i, freq[i], null, null));
        while (pq.getCurSize() > 1)
        {
            Node x = pq.delMin();
            Node y = pq.delMin();
            Node parent = new Node('*', x.getFrequency() + y.getFrequency(), x, y);
            pq.insert(parent);
        }
        root = pq.delMin();
        fillCharEncodingTable(root, "");
    }

    public void printTreePreorder()
    {
        System.out.printf("\nHuffman tree pre-order path: ");
        printTreePreorder(root);
        System.out.println();
    }

    private void printTreePreorder(Node node)
    {
        if (node != null)
        {
            System.out.print(node.ch);

            printTreePreorder(node.left);
            printTreePreorder(node.right);
        }
    }

    private void fillCharEncodingTable(Node node, String curPath)
    {
        if (node == null)
            return;
        if (!node.isInternal())
            table.put(node.ch, curPath);
        if (node.left != null)
            fillCharEncodingTable(node.left, curPath + "0");
        if (node.right != null)
            fillCharEncodingTable(node.right, curPath + "1");
    }

    private class Node implements Comparable<Node>
    {
        char ch;
        Integer frequency;
        public int getFrequency()
        {
            return frequency;
        }
        Node left, right;

        public Node(char _ch, int _frequency, Node _left, Node _right)
        {
            ch = _ch;
            frequency = _frequency;
            left = _left;
            right = _right;
        }
        boolean isInternal() {
            return ch == '*';
        }

        @Override
        public int compareTo(Node o)
        {
            return frequency.compareTo(o.frequency);
        }
    }

    public String encode(String message)
    {
        String encodedMessage = "";
        for(int i = 0; i < message.length(); ++i)
            encodedMessage += table.get(message.charAt(i));
        return encodedMessage;
    }

    public void decode(String encodedMessage)
    {
        int pos = 0;
        while(pos < encodedMessage.length())
        {
            Node x = root;
            while (x.isInternal())
            {
                char bit = encodedMessage.charAt(pos++);
                if (bit == '0') x = x.left;
                else if (bit == '1') x = x.right;
            }
            System.out.print(x.ch);
        }
    }
}
