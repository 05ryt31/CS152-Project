def main():
    print("Enter your stack machine instructions:")
    print("Each instruction is on a separate line.")
    print("End your input by entering 'end'.")
 
    # Get user input
    instructions = []
    while True:
        ins = input()
        if ins == "end":
            break
        instructions.append(ins)
 
    # Run the VM
    vm = StackVM(instructions)
    vm.run()
 
class StackVM(object):
    def __init__(self, instructions):
        self.instructions = instructions
        self.stack = []
        self.output = ""
 
    def push(self, value):
        self.stack.append(value)
 
    def pop(self):
        return self.stack.pop()
 
    def add(self):
        self.push(self.pop() + self.pop())
 
    def mul(self):
        self.push(self.pop() * self.pop())
 
    def dup(self):
        self.push(self.stack[-1])
 
    def swap(self):
        self.stack[-1], self.stack[-2] = self.stack[-2], self.stack[-1]
 
    def print_(self):
        self.output += str(self.pop()) + "\n"
 
    def error(self):
        raise Exception("Error in VM")
 
    def run(self):
        for ins in self.instructions:
            try:
                eval('self.' + ins + '()')
            except AttributeError:
                self.error()
        print(self.output)
 
if __name__ == "__main__":
    main()
