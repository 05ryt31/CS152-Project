package results.raw.base01.p01_rle.scheme_to_java;

import java.util.Scanner;
import java.io.PrintWriter;

public class P01Rle {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        PrintWriter writer = new PrintWriter(System.out);

        String line = scanner.nextLine();
        String encodedLine = encode(line.toCharArray());
        writer.println(encodedLine);
        writer.flush();

        scanner.close();
        writer.close();
    }

    private static String encode(char[] chars) {
        if (chars.length == 0) return "";

        StringBuilder out = new StringBuilder();
        int count = 1;
        char current = chars[0];

        for (int i = 1; i < chars.length; i++) {
            if (chars[i] == current) {
                count++;
            } else {
                out.append(current).append(count);
                current = chars[i];
                count = 1;
            }
        }
        out.append(current).append(count);

        return out.toString();
    }
}
