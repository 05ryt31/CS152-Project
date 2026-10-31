package benchmark.p01_rle;

import java.io.*;

public class P01Rle {
    public static void main(String[] args) throws Exception {
        String text = new BufferedReader(new InputStreamReader(System.in)).readLine();
        StringBuilder result = new StringBuilder();
        int i = 0;

        while (i < text.length()) {
            int j = i;
            while (j < text.length() && text.charAt(j) == text.charAt(i)) j++;
            result.append(text.charAt(i)).append(j - i);
            i = j;
        }
        
        System.out.println(result);
    }
}
