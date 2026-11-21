import sys

def rle_encode(input_string):
    result = []
    i = 0

    while i < len(input_string):
        j = i
        while j < len(input_string) and input_string[j] == input_string[i]:
            j += 1
        result.append(input_string[i])
        result.append(str(j - i))
        i = j

    return ''.join(result)

if __name__ == "__main__":
    input_text = input()
    encoded_text = rle_encode(input_text)
    print(encoded_text)
