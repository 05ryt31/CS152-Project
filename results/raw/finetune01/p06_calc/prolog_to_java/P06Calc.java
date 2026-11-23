import java.math.BigInteger;
 
public class Calculator {
	public static BigInteger calc(String s) {
		return new BigInteger(s);
	}
 
	public static void main(String[] args) {
		System.out.println(calc("123456789012345678901234567890"));
	}
}
