#!/usr/bin/python3.3

import sys

def fib(n):
  a, b = 0, 1
  while a < n:
    print(a, end=' ')
    a, b = b, a+b
  print()

n = int(input("Please enter an integer: "))
fib(n)
