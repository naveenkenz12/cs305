import sys
import os
import csv

arr = sys.argv			#file as arguement
f = open(arr[1], 'r')	#open file in read mode as r

lines = f.readlines()	#read file line by line

count_sin = 0		#initialize both count by 0
count_mul = 0

for line in lines:
	if line.find("[")!=-1 and line.find("]")!=-1 :
		#print(line)
		if line.find("lw")!=-1:			#if lw add count_mul by 5, count_sin by 1
			count_sin = count_sin + 1
			count_mul = count_mul + 5
		elif line.find("sw")!=-1:		#if sw add count_mul by 4, count_sin by 1
			count_sin = count_sin + 1
			count_mul = count_mul + 4
		elif line.find("bne")!=-1 or line.find("beq")!=-1 or line.find("bge")!=-1 or line.find("blt")!=-1:
							#if b type add count_mul by 3, count_sin by 1
			count_sin = count_sin + 1
			count_mul = count_mul + 3
		else:					#for all other instructions, add count_mul by 4, count_sin by 1
			count_sin = count_sin + 1
			count_mul = count_mul + 4

print("single cycle = "+str(count_sin))
print("Multiple cycle = "+str(count_mul))
x= float((count_mul+0.0)/(5*(count_sin+0.0)))		#calculation of ration btwn mutiple cycle and single cycle
x = 1/x
print("Multi Cycle is "+str(x)+" times faster.")
