import java.util.*;
 
public class RLE {
    public static String encode(String s) {
        if (s == null || s.length() == 0) return "";
        StringBuilder encoded = new StringBuilder();
        char c = s.charAt(0);
        int count = 1;
        for (int i = 1; i < s.length(); i++) {
            if (c != s.charAt(i)) {
                encoded.append(c).append(count);
                c = s.charAt(i);
                count = 1;
            } else {
                count++;
            }
        }
        encoded.append(c).append(count);
        return encoded.toString();
    }
 
    public static void main(String[] args) {
        System.out.println("Encoded: " + encode("WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWB"));
    }
}
