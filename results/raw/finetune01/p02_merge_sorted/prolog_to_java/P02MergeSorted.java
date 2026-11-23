import java.util.Arrays;
 
public class MergeSort {
	public static int[] merge(int[] left, int[] right){
		int[] result = new int[left.length + right.length];
		int i = 0, j = 0, k = 0;
		while(i < left.length && j < right.length){
			if(left[i] <= right[j]){
				result[k++] = left[i++];
			}
			else{
				result[k++] = right[j++];
			}
		}
		while(i < left.length){
			result[k++] = left[i++];
		}
		while(j < right.length){
			result[k++] = right[j++];
		}
		return result;
	}
 
	public static int[] sort(int[] array){
		if(array.length == 1){
			return array;
		}
		int mid = array.length / 2;
		int[] left = Arrays.copyOfRange(array, 0, mid);
		int[] right = Arrays.copyOfRange(array, mid, array.length);
		left = sort(left);
		right = sort(right);
		return merge(left, right);
	}
 
	public static void main(String[] args){
		int[] array = {38, 27, 43, 3, 9, 82, 10};
		System.out.println(Arrays.toString(sort(array)));
	}
}
