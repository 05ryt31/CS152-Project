def generate(letters, used, current):
    if len(current) == len(letters): 
        print(current)
        return 

    for i in range(len(letters)):
        if not used[i]:
            used[i] = True 
            current += letters[i]
            generate(letters, used, current)
            current = current[:-1] 
            used[i] = False

if __name__ == "__main__":
    letters = sorted(input())
    generate(letters, [False] * len(letters), "")
