function [flags, res] = dna_encode2(m, op, v, varargin)
    tmpFlags = cell2mat(varargin(:));
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
            if isempty(tmpFlags) 
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
            else 
                flags = tmpFlags;
            end
            res = toDNA(tmp, flags, 'dynamic', v);
        case 'static'
            flags = v;
            res = toDNA(tmp, flags, 'static', v);
    end
end

function res = toDNA(m, flags, op, v)
    l = length(m);
    res = [];
    switch op
        
        case 'dynamic'
            count = 1;
            for i = 1:2:l
                dmap = DNAca(flags(count), v);
                count = count+1;
                tmp = [m(i), m(i+1)];
                res = [res, dmap(tmp)];
            end
            
        case 'static'
            dmap = DNAca(flags, 3);
            for i = 1:2:l
                tmp = [m(i), m(i+1)];
                res = [res, dmap(tmp)];
            end
    end
    
end

function ca = DNAca(flag, v)
        key = {'00', '01', '10', '11'};
        switch v
            case 1
                values = {
                    {'A', 'G', 'C', 'T'},...
                    {'G', 'A', 'T', 'C'},...
                    {'C', 'T', 'A', 'G'},...
                    {'T', 'C', 'G', 'A'},
                };
            case 2
                values = {
                    {'A', 'C', 'G', 'T'},...
                    {'C', 'A', 'T', 'G'},...
                    {'G', 'T', 'A', 'C'},...
                    {'T', 'G', 'C', 'A'}
                };
            case 3
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
        end
        ca = containers.Map(key, values{flag});
end