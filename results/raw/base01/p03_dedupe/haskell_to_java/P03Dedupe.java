package results.raw.base01.p03_dedupe.haskell_to_java;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.HashSet;
import java.util.Set;

public class P03Dedupe {
    public static void main(String[] args) {
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(System.in))) {
            String line;
            while ((line = reader.readLine()) != null) {
                int[] nums = readNums(line);
                int[] result = unique(nums);
                if (result.length > 0) {
                    printResult(result);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private static int[] readNums(String s) {
        return Arrays.stream(s.split("\\s+")).mapToInt(Integer::parseInt).toArray();
    }

    private static int[] unique(int[] nums) {
        Set<Integer> seen = new HashSet<>();
        int[] result = new int[nums.length];
        int index = 0;
        for (int num : nums) {
            if (!seen.contains(num)) {
                seen.add(num);
                result[index++] = num;
            }
        }
        return Arrays.copyOfRange(result, 0, index);
    }

    private static void printResult(int[] result) {
        for (int i = 0; i < result.length; i++) {
            if (i > 0) System.out.print(" ");
            System.out.print(result[i]);
        }
        System.out.println();
    }
}
