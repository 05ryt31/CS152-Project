package benchmark.p15_permutations;

import java.io.*;
import java.util.*;

public class P15Permutations {
    static void generate(char[] letters, boolean[] used, StringBuilder current) {
        if (current.length() == letters.length) { 
            System.out.println(current); 
            return; 
        }

        for (int i = 0; i < letters.length; i++) {
            if (!used[i]) {
                used[i] = true; 
                current.append(letters[i]);
                generate(letters, used, current);
                current.deleteCharAt(current.length() - 1); 
                used[i] = false;
            }
        }
    }

    public static void main(String[] args) throws Exception {
        char[] letters = new BufferedReader(new InputStreamReader(System.in)).readLine().toCharArray();
        Arrays.sort(letters);
        generate(letters, new boolean[letters.length], new StringBuilder());
    }
}
