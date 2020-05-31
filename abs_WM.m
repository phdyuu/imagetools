function qr = abs_WM(img, key, a)
    [ica1, ~, ~, ~] = dwt2(img(:,:,1), 'haar');
    [ica2, ~, ~, ~] = dwt2(ica1, 'haar');
    [ica3, ~, ~, ~] = dwt2(ica2, 'haar');
    [~, Sc1_, ~] = svd(ica3);
    Sc_i_ = key.Uc1 * Sc1_ * key.Vc1';
    Sw0_ = (Sc_i_ - key.Sc) / a;
    [h, w] = size(Sw0_);
    t1 = h/2+1;
    t2 = w/2+1;
    Sw_ = Sw0_(t1:end, t2:end);
    [h, ~] = size(Sw_);
    for i = 1:h
         temp(i) = Sw_(i, i);
    end
    temp = sort(temp, 'descend');
    for i = 1:h
        Sw_(i, i) = temp(i);
    end

    LL2_ = key.Uw*Sw_*key.Vw';
    LL1 = idwt2(LL2_,key.qch2, key.qcv2, key.qcd2, 'haar');
    qr = idwt2(LL1,key.qch1, key.qcv1, key.qcd1, 'haar');
end