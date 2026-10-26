package benchmark.p11_pipeline;

import java.io.*;
import java.util.*;

public class P11Pipeline {
    public static void main(String[] args) throws Exception {
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        List<Integer> values = new ArrayList<>();
        for (String token : reader.readLine().split("\\s+")) {
            if (!token.isEmpty()) values.add(Integer.parseInt(token));
        }

        int k = Integer.parseInt(reader.readLine());
        Object result = values;
        for (int i = 0; i < k; i++) {
            String[] parts = reader.readLine().split("\\s+");
            if (parts[0].equals("map")) {
                int amount = Integer.parseInt(parts[2]);
                for (int j = 0; j < values.size(); j++) {
                    values.set(j, parts[1].equals("add") ? values.get(j) + amount : values.get(j) * amount);
                }
            } else if (parts[0].equals("filter")) {
                List<Integer> filtered = new ArrayList<>();
                for (int value : values) {
                    if (parts[1].equals("even") && value % 2 == 0) filtered.add(value);
                    else if (parts[1].equals("odd") && value % 2 != 0) filtered.add(value); 
                    else if (parts[1].equals("gt") && value > Integer.parseInt(parts[2])) filtered.add(value);
                }
                values = filtered;
            } else if (parts[1].equals("sum")) {
                int sum = 0; 
                for (int value : values) sum += value; 
                result = sum;
            } else {
                if (values.isEmpty()) result = "none";
                else { 
                    int max = values.get(0); 
                    for (int value : values) {
                        if (value > max) max = value; 
                    }
                    result = max; 
                }
            }
        }

        if (result instanceof List) {
            if (!values.isEmpty()) { 
                for (int i = 0; i < values.size(); i++) { 
                    if (i > 0) System.out.print(' '); 
                    System.out.print(values.get(i)); 
                } 
                System.out.println(); 
            }
        } else System.out.println(result);
    }
}
