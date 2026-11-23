import java.util.Scanner;
 
public class Bank {
	public static void main(String[] args){
		System.out.println("Enter number of transactions:");
		Scanner sc = new Scanner(System.in);
		int numTransactions = Integer.parseInt(sc.nextLine());
		long balance = 0;
		for(int i=0;i<numTransactions;i++){
			String[] transaction = sc.nextLine().split("\\s+");
			if(transaction[0].equals("deposit")){
				balance += Long.parseLong(transaction[1]);
			}
			else if(transaction[0].equals("withdraw")){
				balance -= Long.parseLong(transaction[1]);
			}
			System.out.println(balance);
		}
		sc.close();
	}
}
