import java.util.*;
 
public class RLE {
    public static String encode(String s) {
        if (s.length() == 0) return "";
        char c = s.charAt(0);
        int count = 0;
        StringBuilder encoded = new StringBuilder();
        for (int i = 0; i < s.length(); i++) {
            if (c != s.charAt(i)) {
                encoded.append(count).append(c);
                c = s.charAt(i);
                count = 0;
            }
            count++;
        }
        encoded.append(count).append(c);
        return encoded.toString();
    }
 
    public static String decode(String s) {
        if (s.length() == 0) return "";
        StringBuilder decoded = new StringBuilder();
        for (int i = 0; i < s.length(); i += 2) {
            int count = Integer.parseInt(s.substring(i, i+1));
            char c = s.charAt(i+1);
            for (int j = 0; j < count; j++)
                decoded.append(c);
        }
        return decoded.toString();
    }
 
    public static void main(String[] args) {
        System.out.println("Encoding:");
        for (String s : Arrays.asList("", "a", "aa", "aabbbcccc")) {
            System.out.printf("%s -> %s%n", s, encode(s));
        }
        System.out.println("\nDecoding:");
        for (String s : Arrays.asList("", "1a", "2a3b4c", "1a2b3c4d5e6f7g8h9i0j")) {
            System.out.printf("%s -> %s%n", s, decode(s));
        }
    }
}
