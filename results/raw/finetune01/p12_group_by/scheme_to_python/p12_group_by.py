from collections import defaultdict
 
def main():
    # read in data
    num_lines = int(input())
    lines = [input().split() for _ in range(num_lines)]
 
    # create dictionary where keys are names and values are lists of ages
    name_ages = defaultdict(list)
    for name, age in lines:
        name_ages[name].append(int(age))
 
    # print out results
    for name, ages in sorted(name_ages.items()):
        print('{} {} {}'.format(
            name,
            len(ages),
            sum(ages)/len(ages)
        ))
 
if __name__ == '__main__':
    main()
