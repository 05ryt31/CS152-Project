package harness.smoke_io;

import java.util.Scanner;

public class SmokeIO {
    public static void main(String[] args) {
        Scanner scnr = new Scanner(System.in);
        String input = scnr.nextLine();
        System.out.println("Hello, " + input);
        scnr.close();
    }
}
