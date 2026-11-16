package results.raw.base01.p15_permutations.scheme_to_java;

import java.util.*;

public class P15Permutations {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        String input = scanner.nextLine();
        List<Character> letters = Arrays.stream(input.toCharArray())
                                        .sorted()
                                        .collect(Collectors.toList());
        generate(new ArrayList<>(), letters);
    }

    private static void generate(List<Character> prefix, List<Character> remaining) {
        if (remaining.isEmpty()) {
            System.out.println(new String(prefix));
        } else {
            for (int i = 0; i < remaining.size(); i++) {
                List<Character> newPrefix = new ArrayList<>(prefix);
                newPrefix.add(remaining.get(i));
                List<Character> newRemaining = new ArrayList<>(remaining);
                newRemaining.remove(i);
                generate(newPrefix, newRemaining);
            }
        }
    }
}
