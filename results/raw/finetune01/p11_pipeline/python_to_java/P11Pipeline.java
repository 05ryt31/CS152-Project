import java.util.*;
 
public class Pipeline {
    public static void main(String[] args) {
        List<Integer> pipeline = Arrays.asList(1, 2, 3, 4, 5);
        System.out.println(pipeline);
 
        // map add 1
        pipeline = map(pipeline, new Adder(1));
        System.out.println(pipeline);
 
        // filter even
        pipeline = filter(pipeline, new EvenFilter());
        System.out.println(pipeline);
 
        // map multiply by 2
        pipeline = map(pipeline, new Multiplier(2));
        System.out.println(pipeline);
 
        // reduce sum
        Integer sum = reduce(pipeline, new SumReducer(), 0);
        System.out.println(sum);
    }
 
    private static <T> List<T> map(List<T> pipeline, Mapper<T> mapper) {
        List<T> result = new ArrayList<>();
        for (T item : pipeline) {
            T mappedItem = mapper.map(item);
            result.add(mappedItem);
        }
        return result;
    }
 
    private static <T> List<T> filter(List<T> pipeline, Filter<T> filter) {
        List<T> result = new ArrayList<>();
        for (T item : pipeline) {
            if (filter.accept(item)) {
                result.add(item);
            }
        }
        return result;
    }
 
    private static <T> T reduce(List<T> pipeline, Reducer<T> reducer, T identity) {
        T result = identity;
        for (T item : pipeline) {
            result = reducer.reduce(result, item);
        }
        return result;
    }
}
 
interface Mapper<T> {
    T map(T item);
}
 
interface Filter<T> {
    boolean accept(T item);
}
 
interface Reducer<T> {
    T reduce(T accumulator, T item);
}
 
class Adder implements Mapper<Integer> {
    private final int value;
 
    public Adder(int value) {
        this.value = value;
    }
 
    @Override
    public Integer map(Integer item) {
        return item + value;
    }
}
 
class Multiplier implements Mapper<Integer> {
    private final int value;
 
    public Multiplier(int value) {
        this.value = value;
    }
 
    @Override
    public Integer map(Integer item) {
        return item * value;
    }
}
 
class EvenFilter implements Filter<Integer> {
    @Override
    public boolean accept(Integer item) {
        return item % 2 == 0;
    }
}
 
class SumReducer implements Reducer<Integer> {
    @Override
    public Integer reduce(Integer accumulator, Integer item) {
        return accumulator + item;
    }
}
