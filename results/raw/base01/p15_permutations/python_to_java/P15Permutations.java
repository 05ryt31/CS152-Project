package results.raw.base01.p15_permutations.python_to_java;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class P15Permutations {
    public static void main(String[] args) throws Exception {
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        String line = reader.readLine();
        List<String> letters = Arrays.asList(line.split(""));
        Collections.sort(letters);
        List<String> results = new ArrayList<>();
        boolean[] used = new boolean[letters.size()];
        generate(letters, used, new ArrayList<>(), results);
        for (String word : results) {
            System.out.println(word);
        }
    }

    private static void generate(List<String> letters, boolean[] used, List<String> current, List<String> out) {
        if (current.size() == letters.size()) {
            out.add(String.join("", current));
            return;
        }
        for (int i = 0; i < letters.size(); i++) {
            if (!used[i]) {
                used[i] = true;
                current.add(letters.get(i));
                generate(letters, used, current, out);
                current.remove(current.size() - 1);
                used[i] = false;
            }
        }
    }
}
