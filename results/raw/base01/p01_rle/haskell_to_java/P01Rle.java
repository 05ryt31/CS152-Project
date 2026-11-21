package results.raw.base01.p01_rle.haskell_to_java;

import java.util.Scanner;
import java.util.Arrays;

public class P01Rle {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        String line = scanner.nextLine();
        scanner.close();

        StringBuilder result = new StringBuilder();
        char[] chars = line.toCharArray();
        int count = 1;

        for (int i = 1; i < chars.length; i++) {
            if (chars[i] == chars[i - 1]) {
                count++;
            } else {
                result.append(chars[i - 1]).append(count);
                count = 1;
            }
        }
        result.append(chars[chars.length - 1]).append(count);

        System.out.println(result.toString());
    }
}
