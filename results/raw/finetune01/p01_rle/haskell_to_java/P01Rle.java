import java.util.*;
 
public class RLE {
	public static String encode(String s) {
		if(s == null || s.length() == 0)
			return "";
		StringBuilder encoded = new StringBuilder();
		char c = s.charAt(0);
		int count = 1;
		for(int i = 1; i < s.length(); i++) {
			if(c != s.charAt(i)) {
				encoded.append(count).append(c);
				c = s.charAt(i);
				count = 1;
			} else {
				count++;
			}
		}
		encoded.append(count).append(c);
		return encoded.toString();
	}
 
	public static String decode(String s) {
		if(s == null || s.length() == 0)
			return "";
		StringBuilder decoded = new StringBuilder();
		for(int i = 0; i < s.length(); i += 2) {
			int count = Integer.parseInt(s.substring(i, i + 1));
			while(count-- > 0)
				decoded.append(s.charAt(i + 1));
		}
		return decoded.toString();
	}
 
	public static void main(String[] args) {
		System.out.println("Encoding:");
		String[] testStrings = {"", "a", "aa", "ab", "aabbb", "aaaabb"};
		for(String s : testStrings)
			System.out.printf("%s -> %s%n", s, encode(s));
		System.out.println("\nDecoding:");
		for(String s : testStrings)
			System.out.printf("%s -> %s%n", s, decode(encode(s)));
	}
}
