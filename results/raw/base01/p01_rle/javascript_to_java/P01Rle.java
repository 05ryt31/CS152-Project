package results.raw.base01.p01_rle.javascript_to_java;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.IOException;

public class P01Rle {
    public static void main(String[] args) {
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(System.in))) {
            String line = reader.readLine();
            if (line != null) {
                StringBuilder result = new StringBuilder();
                int i = 0;
                while (i < line.length()) {
                    int j = i;
                    while (j < line.length() && line.charAt(j) == line.charAt(i)) j++;
                    result.append(line.charAt(i)).append(j - i);
                    i = j;
                }
                System.out.println(result.toString());
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
