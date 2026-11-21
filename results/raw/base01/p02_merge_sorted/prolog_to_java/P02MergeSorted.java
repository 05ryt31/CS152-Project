package results.raw.base01.p02_merge_sorted.prolog_to_java;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

public class P02MergeSorted {
    public static void main(String[] args) {
        try (Scanner scanner = new Scanner(new BufferedReader(new InputStreamReader(System.in)))) {
            String ALine = scanner.nextLine();
            String BLine = scanner.nextLine();
            List<Integer> A = nums(ALine);
            List<Integer> B = nums(BLine);
            List<Integer> Result = merge(A, B);
            printNums(Result);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private static List<Integer> nums(String Line) {
        if ("end_of_file".equals(Line)) return new ArrayList<>();
        if ("".equals(Line)) return new ArrayList<>();
        String[] Parts = Line.split(" ");
        if (Parts.length == 0) return new ArrayList<>();
        List<Integer> Ns = new ArrayList<>();
        for (String Part : Parts) {
            Ns.add(Integer.parseInt(Part));
        }
        return Ns;
    }

    private static List<Integer> merge(List<Integer> Xs, List<Integer> Ys) {
        if (Xs.isEmpty()) return Ys;
        if (Ys.isEmpty()) return Xs;
        if (Xs.get(0) <= Ys.get(0)) {
            List<Integer> Rest = merge(Xs.subList(1, Xs.size()), Ys);
            Rest.add(0, Xs.get(0));
            return Rest;
        } else {
            List<Integer> Rest = merge(Xs, Ys.subList(1, Ys.size()));
            Rest.add(0, Ys.get(0));
            return Rest;
        }
    }

    private static void printNums(List<Integer> Ns) {
        System.out.println(String.join(" ", Ns.stream().map(String::valueOf).toArray(String[]::new)));
    }
}
