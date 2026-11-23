def pipeline(k, values):
    while k > 0:
        command = raw_input()
        if command == "":
            break
        cmd, arg = command.split(" ", 1)
        if cmd == "map":
            amount = int(arg)
            values = [v + amount for v in values]
        elif cmd == "multiply":
            amount = int(arg)
            values = [v * amount for v in values]
        elif cmd == "filter":
            if arg == "even":
                values = [v for v in values if v % 2 == 0]
            elif arg == "odd":
                values = [v for v in values if v % 2 != 0]
            else:
                threshold = int(arg)
                values = [v for v in values if v > threshold]
        elif cmd == "sum":
            print sum(values)
            return
        elif cmd == "maximum":
            print max(values)
            return
        k -= 1
    print values[0] if len(values) > 0 else None
 
values = map(int, raw_input().split(" "))
k = int(raw_input())
pipeline(k, values)
