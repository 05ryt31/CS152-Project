package results.raw.base01.p15_permutations.javascript_to_java;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class P15Permutations {
    public static void main(String[] args) throws Exception {
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        String input = reader.readLine();
        List<Character> letters = new ArrayList<>();
        for (char c : input.toCharArray()) {
            letters.add(c);
        }
        Collections.sort(letters);

        List<String> output = new ArrayList<>();
        generate("", letters, output);

        for (String perm : output) {
            System.out.println(perm);
        }
    }

    private static void generate(String prefix, List<Character> remaining, List<String> output) {
        if (remaining.isEmpty()) {
            output.add(prefix);
        } else {
            for (int i = 0; i < remaining.size(); i++) {
                char current = remaining.get(i);
                List<Character> nextRemaining = new ArrayList<>(remaining);
                nextRemaining.remove(i);
                generate(prefix + current, nextRemaining, output);
            }
        }
    }
}
