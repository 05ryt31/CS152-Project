import re
 
def calc(expression):
    return eval(re.sub(r'(\d+)', r'int("\1")', expression))
 
if __name__ == '__main__':
    print(calc('2 + 3 * 5'))
    print(calc('2 + (3 * 5)'))
    print(calc('(2 + 3) * 5'))
    print(calc('2 + 3 * 5 / (7 - 2)'))
    print(calc('2 + 3 * 5 / (7 - 2) ^ 2 ^ 3'))
