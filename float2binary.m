% @fileName float2binary.m
% @author Melih Altun @2016

% convert a floating number to binary representation as a single precision, double precision or arbitrary exponent & mantissa size bit stream;

function b = float2binary(f, exponentBits, fractionBits)

if nargin == 1   % assume 32 bit float if fraction and exponent aren't provided.
    fractionBits = 23;
    exponentBits = 8;  % 23 bit fraction + 8 bit exponent + 1 bit sign;
elseif nargin == 2
    if isstring(exponentBits)
        exponentBits = char(exponentBits);
    end
    if ~ischar(exponentBits) || length(exponentBits) > 1 || ~(exponentBits == 'f' ||  exponentBits == 's' || exponentBits == 'd' || exponentBits == 'F' ||  exponentBits == 'S' || exponentBits == 'D')
        error('Incorrect parameters! Use as b = float2binary(num); (assumes single precision), b = float2binary(num, ''s''); (single), b = float2binary(num, ''d'') (double) or b = float2binary(num, exponentBits, fractionBits) (arbitrary size)')
    end
    if exponentBits == 'f' ||  exponentBits == 's' || exponentBits == 'F' ||  exponentBits == 'S'
        fractionBits = 23; % single precision
        exponentBits = 8;  % 23 bit fraction + 8 bit exponent + 1 bit sign;
    else
        fractionBits = 52;  % double precision
        exponentBits = 11;  % 52 bit fraction + 11 bit exponent + 1 bit sign;
    end
elseif nargin == 3
    if exponentBits < 1 || fractionBits < 1
        error ('Exponent and fraction size must be positive numbers!')
    end
end

exp_bias = 2^(exponentBits - 1)-1;


if f < 0
    f=f*-1;
    signBit = '1';
else
    signBit = '0';
end

% check if num is closer to 0 than minimum possible fraction 
if abs(f) < 2^(-2^exponentBits - 2)
    fractionStr = repmat('0',[1, fractionBits]);
    expStr = repmat('0',[1, exponentBits]);
    b = [signBit, expStr, fractionStr];
    return
end

exponent = 0;
while ~(f>=1 && f<2)
    if(f >= 2)
        f = f/2;
        exponent = exponent+1;
    elseif(f<1)
        f=f*2;
        exponent = exponent-1;
    end
end

decFraction = mod(f,1);
fractionStr = '';
for k=1:fractionBits
    if decFraction >= 2^-k
        decFraction = decFraction - 2^-k;
        fractionStr = [fractionStr,'1'];    
    else
        fractionStr = [fractionStr,'0']; 
    end
end

expStr = dec2bin(exponent+exp_bias);

b = [signBit, expStr, fractionStr];

        
    