import java.util.*;
 
public class RLE {
	public static String encode(String s) {
		if(s == null || s.isEmpty()) return "";
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
		if(s == null || s.isEmpty()) return "";
		StringBuilder decoded = new StringBuilder();
		String[] chars = s.split("(\\d+)");
		String[] counts = s.split("([a-zA-Z]+)");
		for(int i = 0; i < chars.length; i++) {
			decoded.append(chars[i].replaceAll("\\D", "").repeat(Integer.parseInt(counts[i])));
		}
		return decoded.toString();
	}
 
	public static void main(String[] args) {
		System.out.println(encode("WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWB"));
		System.out.println(decode("12W1B12W3B24W1B"));
	}
}
