s = 'HOLA';
n = double(s);
if length(n) < 64
    for i=length(n) + 1: 64
        n(i) = 0;
    end
end
s=[char(n)]