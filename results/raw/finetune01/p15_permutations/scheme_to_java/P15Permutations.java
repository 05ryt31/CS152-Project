import java.util.Arrays;
 
public class Permutation {
	public static void main(String[] args) {
		String s = "abc";
		char[] chars = s.toCharArray();
		do {
			System.out.println(Arrays.toString(chars));
		} while (nextPermutation(chars));
	}
 
	static boolean nextPermutation(char[] chars) {
		int i = chars.length - 2;
		while (i >= 0 && chars[i] >= chars[i + 1]) {
			i--;
		}
		if (i < 0) {
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
 
	static void swap(char[] chars, int i, int j) {
		char temp = chars[i];
		chars[i] = chars[j];
		chars[j] = temp;
	}
 
	static void reverse(char[] chars, int start, int end) {
		while (start < end) {
			swap(chars, start++, end--);
		}
	}
}
