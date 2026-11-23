def merge_sorted_lists(l1, l2):
    """Return a sorted list containing all elements in both lists"""
    # Create a new list which will be returned at the end
    merged_list = []
 
    # While there are still items in either list
    while len(l1) > 0 or len(l2) > 0:
        # If there are no more items in list 1, append the first item of list 2
        if len(l1) == 0:
            merged_list.append(l2.pop(0))
        # If there are no more items in list 2, append the first item of list 1
        elif len(l2) == 0:
            merged_list.append(l1.pop(0))
        # Otherwise, compare the first items of each list and append the smaller
        elif l1[0] < l2[0]:
            merged_list.append(l1.pop(0))
        else:
            merged_list.append(l2.pop(0))
 
    return merged_list
 
if __name__ == '__main__':
    print(merge_sorted_lists([1, 3, 5], [2, 4, 6]))
    print(merge_sorted_lists([], [2, 4, 6]))
    print(merge_sorted_lists([1, 3, 5], []))
    print(merge_sorted_lists([], []))
