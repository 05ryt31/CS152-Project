>>> def dedupe(items):
    seen = set()
    for item in items:
        if item not in seen:
            yield item
            seen.add(item)
 
>>> list(dedupe([1,2,2,3,4,5,5,6]))
[1, 2, 3, 4, 5, 6]
>>>
