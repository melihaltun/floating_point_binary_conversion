# float_binary_conversion
Pair functions to convert a floating number to a single precision, double precision, or arbitrary size bit representation and convert a single, double or arbitrary size bit string back into a number. 

This repository contains 2 Matlab functions:

float2binary.m converts a floating number to its binary string representation as a single precision, double precision or arbitrary size bit string.

binary2float.m converts a single precision, double precision or arbitrary size bit string back to a floating number. 


Here are some use cases:


% pi as single precision (32 bits):

float2binary(pi)

ans =
    '01000000010010010000111111011010'


% pi as double precision (64 bits):

float2binary(pi,'d')

ans =
    '0100000000001001001000011111101101010100010001000010110100011000'


% pi as arbitrarily selected 10 bit exponent and 28 bit mantissa digits (+1 sign = 39 bits)

float2binary(pi, 10, 28)

ans =
    '010000000001001001000011111101101010100'
   

% convert single precision bit string back to a number    

binary2float('01000000010010010000111111011010')

ans =
          3.14159250259399


% convert double precision bit string back to a number  

binary2float('0100000000001001001000011111101101010100010001000010110100011000', 'd')

ans =
          3.14159265358979


% convert arbitrary size exponent and mantissa bit string back to a number  

binary2float('010000000001001001000011111101101010100', 10, 28)

ans =
          3.14159265160561
