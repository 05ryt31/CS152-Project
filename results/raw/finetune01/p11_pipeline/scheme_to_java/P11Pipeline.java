import java.util.*;
 
public class Pipeline {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        List<Integer> numbers = Arrays.asList(scanner.nextLine().split("\\s+")).stream()
                .map(Integer::parseInt).collect(Collectors.toList());
        int stages = Integer.parseInt(scanner.nextLine());
        while (stages-- > 0) {
            String stage = scanner.nextLine();
            if ("sum".equals(stage)) {
                System.out.println(numbers.stream().reduce(0, Integer::sum));
                return;
            }
            switch (stage.split(" ")[0]) {
                case "add":
                    numbers.replaceAll(i -> i + Integer.parseInt(stage.split(" ")[1]));
                    break;
                case "multiply":
                    numbers.replaceAll(i -> i * Integer.parseInt(stage.split(" ")[1]));
                    break;
                case "filter":
                    switch (stage.split(" ")[1]) {
                        case "even":
                            numbers.removeIf(i -> i % 2 != 0);
                            break;
                        case "odd":
                            numbers.removeIf(i -> i % 2 == 0);
                            break;
                        default:
                            numbers.removeIf(i -> i < Integer.parseInt(stage.split(" ")[1]));
                    }
                    break;
            }
        }
        System.out.println(numbers);
    }
}
