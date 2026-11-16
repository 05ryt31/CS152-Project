package results.raw.base01.p15_permutations.prolog_to_java;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.*;

public class P15Permutations {
    public static void main(String[] args) {
        try (Scanner scanner = new Scanner(new BufferedReader(new InputStreamReader(System.in)))) {
            String input = scanner.nextLine();
            permutations(input);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private static void permutations(String str) {
        List<String> chars = new ArrayList<>();
        for (char c : str.toCharArray()) {
            chars.add(String.valueOf(c));
        }
        Collections.sort(chars);

        Set<List<String>> orderedPerms = new TreeSet<>(new Comparator<List<String>>() {
            @Override
            public int compare(List<String> o1, List<String> o2) {
                return o1.toString().compareTo(o2.toString());
            }
        });

        permute(chars, new ArrayList<>(), orderedPerms);

        for (List<String> perm : orderedPerms) {
            System.out.println(String.join("", perm));
        }
    }

    private static void permute(List<String> chars, List<String> current, Set<List<String>> orderedPerms) {
        if (chars.isEmpty()) {
            orderedPerms.add(new ArrayList<>(current));
        } else {
            for (int i = 0; i < chars.size(); i++) {
                List<String> remaining = new ArrayList<>(chars);
                remaining.remove(i);
                current.add(chars.get(i));
                permute(remaining, current, orderedPerms);
                current.remove(current.size() - 1);
            }
        }
    }
}
