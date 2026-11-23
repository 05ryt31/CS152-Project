import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;
 
public class Pipeline {
	public static void main(String[] args) {
		List<Integer> numbers = Arrays.asList(1, 2, 3, 4, 5, 6, 7, 8, 9);
 
		int k = 3;
 
		for (int i = 0; i < k; i++) {
			String[] command = args[i + 1].split(" ");
 
			switch (command[0]) {
				case "map":
					if ("add".equals(command[1])) {
						numbers = numbers.stream().map(n -> n + Integer.parseInt(command[2])).collect(Collectors.toList());
					} else if ("multiply".equals(command[1])) {
						numbers = numbers.stream().map(n -> n * Integer.parseInt(command[2])).collect(Collectors.toList());
					}
					break;
				case "filter":
					if ("even".equals(command[1])) {
						numbers = numbers.stream().filter(n -> n % 2 == 0).collect(Collectors.toList());
					} else if ("odd".equals(command[1])) {
						numbers = numbers.stream().filter(n -> n % 2 != 0).collect(Collectors.toList());
					} else if ("greater than".equals(command[1])) {
						numbers = numbers.stream().filter(n -> n > Integer.parseInt(command[2])).collect(Collectors.toList());
					}
					break;
				case "reduce":
					if ("sum".equals(command[1])) {
						System.out.println(numbers.stream().mapToInt(Integer::intValue).sum());
					} else if ("max".equals(command[1])) {
						System.out.println(numbers.stream().max(Integer::compare).orElse(null));
					}
					return;
			}
		}
 
		System.out.println(numbers);
	}
}
