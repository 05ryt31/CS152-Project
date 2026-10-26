package benchmark.p09_stack_vm;

import java.io.*;
import java.util.*;

public class P09StackVm {
    public static void main(String[] args) throws Exception {
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        int n = Integer.parseInt(reader.readLine());
        Deque<Integer> stack = new ArrayDeque<>();

        for (int i = 0; i < n; i++) {
            String[] parts = reader.readLine().split("\\s+");
            String op = parts[0];

            if (op.equals("push")) stack.push(Integer.parseInt(parts[1]));
            else if (op.equals("pop")) { 
                if (stack.isEmpty()) System.out.println("error");
                else stack.pop(); 
            } else if (op.equals("add") || op.equals("mul")) {
                if (stack.size() < 2) System.out.println("error");
                else { 
                    int b = stack.pop();
                    int a = stack.pop(); 
                    stack.push(op.equals("add") ? a + b : a * b); 
                }
            } else if (op.equals("dup")) {
                if (stack.isEmpty()) System.out.println("error");
                else stack.push(stack.peek());
            } else if (op.equals("swap")) {
                if (stack.size() < 2) System.out.println("error");
                else { 
                    int a = stack.pop();
                    int b = stack.pop(); 
                    stack.push(a); 
                    stack.push(b); 
                }
            } else if (op.equals("print")) { 
                if (stack.isEmpty()) System.out.println("error");
                else System.out.println(stack.peek());
            }
        }
    }
}
