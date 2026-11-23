import java.util.*;
 
public class Dedupe {
    public static void main(String[] args) {
        Scanner in = new Scanner(System.in);
        while(in.hasNext()) {
            List<Integer> nums = new ArrayList<>();
            String[] tokens = in.next().split("\\s+");
            for(String token : tokens) {
                int num = Integer.parseInt(token);
                if(!nums.contains(num)) {
                    nums.add(num);
                }
            }
            Collections.sort(nums);
            for(Integer num : nums) {
                System.out.print(num + " ");
            }
            System.out.println();
        }
    }
}
