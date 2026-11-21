import sys

def main():
    line = input().strip()
    if not line:
        print("")
        return

    seen = set()
    result = []

    for token in line.split():
        if not token:
            continue
        
        value = int(token)
        if value not in seen:
            seen.add(value)
            result.append(str(value))

    if result:
        print(" ".join(result))

if __name__ == "__main__":
    main()
