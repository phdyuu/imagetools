function [flags, res] = dna_encode(m, op, varargin)
    [h, w] = size(m);
    tmp = [];
    for i = 1:h
        for j = 1:w
            t = dec2bin(m(i,j),8);
            tmp = [tmp, t];
        end
    end
    switch op
        case 'dynamic'
            f = 1;
            count = 2;
            flags = [];
            flags(1) = 1;
            for i = 3:2:length(tmp)
                curr = [tmp(i), tmp(i+1)];
                pre  = [tmp(i-2), tmp(i-1)];
                if curr == pre
                    if f < 4           
                        f = f +1;
                        flags(count) = f;
                        count = count+1;
                    else
                        f = 1;
                        flags(count) = f;
                        count = count +1;
                    end
                else
                    flags(count) = f;
                    count = count + 1;
                end
            end
            res = toDNA(tmp, flags, 'dynamic');
            
        case 'static'
            flags = varargin{:};
            res = toDNA(tmp, flags, 'static');
    end
end

function res = toDNA(m, flags, op)
    l = length(m);
    res = [];
    switch op
        
        case 'dynamic'
            count = 1;
            for i = 1:2:l
                dmap = DNAca(flags(count));
                count = count+1;
                tmp = [m(i), m(i+1)];
                res = [res, dmap(tmp)];
            end
            
        case 'static'
            dmap = DNAca(flags);
            for i = 1:2:l
                tmp = [m(i), m(i+1)];
                res = [res, dmap(tmp)];
            end
    end
    
end

function ca = DNAca(flag)
        key = {'00', '01', '10', '11'};
        values = {
            {'A', 'G', 'C', 'T'},...
            {'G', 'A', 'T', 'C'},...
            {'C', 'T', 'A', 'G'},...
            {'T', 'C', 'G', 'A'},...
            {'A', 'C', 'G', 'T'},...
            {'C', 'A', 'T', 'G'},...
            {'G', 'T', 'A', 'C'},...
            {'T', 'G', 'C', 'A'}
        };
        ca = containers.Map(key, values{flag});
end