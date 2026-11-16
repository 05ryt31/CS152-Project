package results.raw.base01.p03_dedupe.prolog_to_java;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class P03Dedupe {
    public static void main(String[] args) {
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(System.in))) {
            String line = reader.readLine();
            List<Integer> nums = nums(line);
            List<Integer> uniqueNums = new ArrayList<>();
            Set<Integer> seen = new HashSet<>();
            for (Integer num : nums) {
                if (!seen.contains(num)) {
                    uniqueNums.add(num);
                    seen.add(num);
                }
            }
            printNums(uniqueNums);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private static List<Integer> nums(String line) {
        List<Integer> result = new ArrayList<>();
        if (line == null || line.isEmpty()) {
            return result;
        }
        String[] parts = line.split(" ");
        for (String part : parts) {
            if (!part.trim().isEmpty()) {
                result.add(Integer.parseInt(part));
            }
        }
        return result;
    }

    private static void printNums(List<Integer> nums) {
        System.out.println(nums.stream()
                               .map(String::valueOf)
                               .collect(Collectors.joining(" ")));
    }
}
