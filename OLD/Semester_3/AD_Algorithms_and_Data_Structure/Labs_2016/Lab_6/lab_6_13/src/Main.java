public class Main {
    public static void main(String[] args)
    {
        PrefixFreeDecoder coder = new PrefixFreeDecoder("****kbl_***cta*of");
        String msg = "a_flock_of_bat_of_a_block_of_flat_of_lot_of_a_cat_flab_a_flat_cab";
        String encodedMessage = coder.encode(msg);

        System.out.printf("message <%s> was encoded with %d bits as \n%s\n", msg, encodedMessage.length(), encodedMessage);
        coder.decode(encodedMessage);

        System.out.println();
        System.out.println();

        PrefixFreeDecoder coder1 = new PrefixFreeDecoder("********sam'_hop****tdck*re"); //anything to do with capital letters?
        String msg1 = "sam's_shop_stocks_short_spotted_socks";
        String encodedMessage1 = coder1.encode(msg1);
        System.out.printf("message <%s> was encoded with %d bits as\n%s\n", msg1, encodedMessage1.length(), encodedMessage1);
        coder1.decode(encodedMessage1);

        System.out.println();
        System.out.println();

        String msg2 = "a_flock_of_bat_of_a_block_of_flat_of_lot_of_a_cat_flab_a_flat_cab";
        HuffmanDecoder hDecoder = new HuffmanDecoder(msg2);
        String hEncodedMessage = hDecoder.encode(msg2);
        System.out.printf("message <%s> was encoded with %d bits as\n%s\n", msg2, hEncodedMessage.length(), hEncodedMessage);
        hDecoder.decode(hEncodedMessage);
        hDecoder.printTreePreorder();

        System.out.println();
        System.out.println();

        String msg3 = "sam's_shop_stocks_short_spotted_socks";
        HuffmanDecoder hDecoder1 = new HuffmanDecoder(msg3);
        String hEncodedMessage1 = hDecoder1.encode(msg3);
        System.out.printf("message <%s> was encoded with %d bits as\n%s\n", msg3, hEncodedMessage1.length(), hEncodedMessage1);
        hDecoder1.decode(hEncodedMessage1);
        hDecoder1.printTreePreorder();

//        PrefixFreeDecoder coder = new PrefixFreeDecoder("*a**d*c!*rb");
//        String msg = "abracadabra!";
//        String encodedMessage = coder.encode(msg);
//        System.out.printf("message <%s> was encoded as %s\n", msg, encodedMessage);
//        coder.decode("0111110010100100011111001011");
    }
}
