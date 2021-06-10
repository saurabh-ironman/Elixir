import sys

print(sys.argv[1:])
input1, input2, *_ = sys.argv[1:]
print(input1)
list1 = input1.split()
print(list1)
print(input2)
list2 = input2.split()
print(list2)