function res = DnaOper(m, j, op)
    switch op
        case 'add'
            res = dAdd(m,j);
        case 'sub'
            res = dSub(m,j);
        case 'xor'
            res = dXor(m, j);
    end

end

function res = dAdd(m, j)
    res = [];
    key = {'AA', 'AG', 'AC', 'AT'...
           'GA', 'GG', 'GC', 'GT'...
           'CA', 'CG', 'CC', 'CT'...
           'TA', 'TG', 'TC', 'TT'};
    value = {'A', 'G', 'C', 'T'...
              'G', 'C', 'T', 'A'...
              'C', 'T', 'A', 'G'...
              'T', 'A', 'G', 'C'};
    l = length(m);
    ca = containers.Map(key, value);
    for i = 1:l
        tmp = [m(i), j(i)];
        res = [res, ca(tmp)];
    end
end

function res = dSub(m, j)
    res = [];
    key = {'AA', 'AG', 'AC', 'AT'...
           'GA', 'GG', 'GC', 'GT'...
           'CA', 'CG', 'CC', 'CT'...
           'TA', 'TG', 'TC', 'TT'};
    value = {'A', 'T', 'C', 'G'...
              'G', 'A', 'T', 'C'...
              'C', 'G', 'A', 'T'...
              'T', 'C', 'G', 'A'};
    l = length(m);
    ca = containers.Map(key, value);
    for i = 1:l
        tmp = [m(i), j(i)];
        res = [res, ca(tmp)];
    end
end

function res = dXor(m, j)
    res = [];
    key = {'AA', 'AG', 'AC', 'AT'...
           'GA', 'GG', 'GC', 'GT'...
           'CA', 'CG', 'CC', 'CT'...
           'TA', 'TG', 'TC', 'TT'};
    value = {'A', 'G', 'C', 'T'...
              'G', 'A', 'T', 'C'...
              'C', 'T', 'A', 'G'...
              'T', 'C', 'G', 'A'};
    l = length(m);
    ca = containers.Map(key, value);
    for i = 1:l
        tmp = [m(i), j(i)];
        res = [res, ca(tmp)];
    end
end
