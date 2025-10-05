import java.util.HashMap;

public class PrefixFreeDecoder {
    private Node root;
    private HashMap<Character, String> table = new HashMap<Character, String>();

    public PrefixFreeDecoder(String sequence)
    {
        root = new Node(sequence, table, "", new IntHolder(0));
    }

    private class Node
    {
        char ch;
        Node left, right;
        Node(String sequence, HashMap<Character, String> table, String path, IntHolder counter)
        {
            if (counter.getValue() == sequence.length())
                return;
            ch = sequence.charAt(counter.inc());
            if (ch == '*')
            {
                left = new Node(sequence, table, path + '0', counter);
                right = new Node(sequence, table, path + '1', counter);
            }
            else
                table.put(ch, path);
        }
        boolean isInternal() {
            return ch == '*';
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
