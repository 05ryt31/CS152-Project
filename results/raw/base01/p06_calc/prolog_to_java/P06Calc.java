package results.raw.base01.p06_calc.prolog_to_java;

import java.util.Scanner;
import java.io.PrintWriter;

public class P06Calc {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        PrintWriter writer = new PrintWriter(System.out);

        String line = scanner.nextLine();
        int value = evaluateExpression(line);
        writer.println(value);
        writer.flush();

        System.exit(0);
    }

    private static int evaluateExpression(String expression) {
        return Integer.parseInt(expression);
    }
}
