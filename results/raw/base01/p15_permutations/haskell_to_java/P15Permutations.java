package results.raw.base01.p15_permutations.haskell_to_java;

import java.util.*;

public class P15Permutations {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        String line = scanner.nextLine();
        List<String> permutations = permutations(line);
        Collections.sort(permutations);
        for (String permutation : permutations) {
            System.out.println(permutation);
        }
    }

    private static List<String> permutations(String str) {
        if (str.isEmpty()) {
            return Collections.singletonList("");
        }
        List<String> perms = new ArrayList<>();
        for (int i = 0; i < str.length(); i++) {
            char ch = str.charAt(i);
            String remaining = str.substring(0, i) + str.substring(i + 1);
            for (String perm : permutations(remaining)) {
                perms.add(ch + perm);
            }
        }
        return perms;
    }
}
