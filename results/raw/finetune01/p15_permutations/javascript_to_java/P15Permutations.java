import java.util.Arrays;
 
public class Permutation {
	public static void main(String[] args) {
		String s = "abc";
		char[] chars = s.toCharArray();
		Arrays.sort(chars);
		do {
			System.out.println(new String(chars));
		} while (nextPermutation(chars));
	}
 
	private static boolean nextPermutation(char[] chars) {
		int i = chars.length - 2;
		while (i >= 0 && chars[i] >= chars[i + 1]) {
			i--;
		}
		if (i == -1) {
			return false;
		}
		int j = chars.length - 1;
		while (chars[j] <= chars[i]) {
			j--;
		}
		swap(chars, i, j);
		reverse(chars, i + 1, chars.length - 1);
		return true;
	}
 
	private static void swap(char[] chars, int i, int j) {
		char temp = chars[i];
		chars[i] = chars[j];
		chars[j] = temp;
	}
 
	private static void reverse(char[] chars, int start, int end) {
		while (start < end) {
			swap(chars, start++, end--);
		}
	}
}
