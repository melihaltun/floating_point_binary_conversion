% @fileName binary2float.m
% @author Melih Altun @2016

function f = binary2float(b, exponentBits, fractionBits)

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

if ~ischar(b) && ~isstring(b)
    error('Input needs to be a char array or string of bits!');
end

if isstring(b) && length(b) == 1
    b = char(b);
elseif isstring(b) && length(b) ~= 1
    error('Incompatible string input!');
end

if length(b) ~= fractionBits+exponentBits+1
    error(sprintf('Input size is incorrect: It needs to be 1 bit sign %d bit exponent %d bit mantissa.', exponentBits, fractionBits));
end


exp_bias = 2^(exponentBits - 1)-1;

exponent = bin2dec(b(2:exponentBits+1)) - exp_bias;

fraction = 0;
if any(b(exponentBits+2:end) == '1')
    fraction = 1;
end

for k = 1:fractionBits
    if(bin2dec(b(1 + exponentBits + k)))
        fraction = fraction + 2^-k;
    end
end

sign = (-1)^bin2dec(b(1));

f = sign * 2^exponent * fraction;





