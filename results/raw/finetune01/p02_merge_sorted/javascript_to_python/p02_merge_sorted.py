def merge_lists(list1, list2):
    merged_list = []
    while len(list1) > 0 and len(list2) > 0:
        if list1[0] < list2[0]:
            merged_list.append(list1.pop(0))
        else:
            merged_list.append(list2.pop(0))
 
    # append remaining elements
    merged_list.extend(list1)
    merged_list.extend(list2)
 
    return merged_list
 
# test
list1 = [1, 3, 5, 7]
list2 = [2, 4, 6, 8]
print(merge_lists(list1, list2))
