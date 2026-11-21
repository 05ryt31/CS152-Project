package results.raw.base01.p01_rle.prolog_to_java;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;

public class P01Rle {
    public static void main(String[] args) {
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(System.in))) {
            String line = reader.readLine();
            List<Character> chars = new ArrayList<>();
            for (char c : line.toCharArray()) {
                chars.add(c);
            }
            List<Object> out = encode(chars);
            System.out.println(out.stream().map(Object::toString).collect(Collectors.joining()));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private static List<Object> encode(List<Character> chars) {
        if (chars.isEmpty()) {
            return new ArrayList<>();
        }
        char current = chars.get(0);
        int count = 1;
        List<Object> rest = new ArrayList<>(chars.subList(1, chars.size()));
        while (!rest.isEmpty() && rest.get(0) == current) {
            rest.remove(0);
            count++;
        }
        List<Object> encodedRest = encode(rest);
        List<Object> result = new ArrayList<>();
        result.add(current);
        result.addAll(Integer.toString(count).chars().mapToObj(i -> (char) i));
        result.addAll(encodedRest);
        return result;
    }
}
