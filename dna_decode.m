function res = dna_decode2(m, flags, h, w, op, varargin)
    v = cell2mat(varargin(:));
    tmp = [];
    switch op
        case 'dynamic'
            for i = 1:length(m)
                dmap = DNAca(flags(i), v);
                tmp = [tmp, dmap(m(i))];
            end
        case 'static'
            dmap = DNAca(flags, 3);
            for i = 1:length(m)
                tmp = [tmp, dmap(m(i))];
            end
    end    
    res = reshape(tmp, 8, [])';
    res = bin2dec(res);
    res = reshape(res, h, w)';
end


function res = DNAca(flag, v)
    key = {'A', 'T', 'G', 'C'};
    switch v
        case 1
            values = {
                {'00', '11', '01', '10'},...
                {'01', '10', '00', '11'},...
                {'10', '01', '11', '00'},...
                {'11', '00', '10', '01'},
            };
        case 2
            values = {
                {'00', '11', '10', '01'},...
                {'01', '10', '11', '00'},...
                {'10', '01', '00', '11'},...
                {'11', '00', '01', '10'}
            };
        case 3
            values = {
                {'00', '11', '01', '10'},...
                {'01', '10', '00', '11'},...
                {'10', '01', '11', '00'},...
                {'11', '00', '10', '01'},...
                {'00', '11', '10', '01'},...
                {'01', '10', '11', '00'},...
                {'10', '01', '00', '11'},...
                {'11', '00', '01', '10'}
            };
    end
    res = containers.Map(key, values{flag});
end