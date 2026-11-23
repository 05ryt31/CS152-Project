>>> eval('2+3*5')
17
>>> eval('2+(3*5)')
17
>>> eval('(2+3)*5')
25
>>> eval('2**3**2')
1024
>>> eval('2**3**2*(1+1)')
2048
>>> eval('2**3**2*(1+1)**(1/2)')
565.6854249492381
>>> eval('2**3**2*(1+1)**(1/2)', {'__builtins__': None}, {})
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
  File "<string>", line 1
SyntaxError: invalid syntax
>>> eval('2**3**2*(1+1)**(1/2)', {'__builtins__': {}})
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
ZeroDivisionError: integer division or modulo by zero
>>> eval('2**3**2*(1+1)**(1//2)', {'__builtins__': {}})
2048
>>>
