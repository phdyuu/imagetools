function res = dna_decode(m, flags, h, w, op)
    tmp = [];
    switch op
        case 'dynamic'
            for i = 1:length(m)
                dmap = DNAca(flags(i));
                tmp = [tmp, dmap(m(i))];
            end
        case 'static'
            dmap = DNAca(flags);
            for i = 1:length(m)
                tmp = [tmp, dmap(m(i))];
            end
    end    
    res = reshape(tmp, 8, [])';
    res = bin2dec(res);
    res = reshape(res, h, w)';
end


function res = DNAca(flag)
    key = {'A', 'T', 'G', 'C'};
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
    res = containers.Map(key, values{flag});
end