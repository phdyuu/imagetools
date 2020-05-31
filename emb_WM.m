function [img, key] = emb_WM(img, qr, a)
    qr = uint8(abs(qr-1) *255);
    [ica1, ich1, icv1, icd1] = dwt2(img(:,:,1), 'haar');
    [ica2, ich2, icv2, icd2] = dwt2(ica1, 'haar');
    [ica3, ich3, icv3, icd3] = dwt2(ica2, 'haar');
    [qca1,qch1, qcv1, qcd1] = dwt2(qr, 'haar');
    [qca2,qch2, qcv2, qcd2] = dwt2(qca1, 'haar');
    [Uc, Sc, Vc] = svd(ica3);
    [Uw, Sw, Vw] = svd(qca2);
    Sw0 = zeros(size(Sc));
    [h, w] = size(Sw0);
    t1 = h/2+1;
    t2 = w/2+1;
    Sw0(t1:end, t2:end) = Sw;
    Sc_ = Sc+a*Sw0;
    [Uc1, Sc1, Vc1] = svd(Sc_);
    LL3_ = Uc * Sc1 * Vc';
    LL2 = idwt2(LL3_,  ich3, icv3, icd3, 'haar');
    LL1 = idwt2(LL2,  ich2, icv2, icd2, 'haar');
    img_qr = idwt2(LL1,  ich1, icv1, icd1, 'haar');
    img(:,:,1) = img_qr;
    key.qch1 = qch1;
    key.qcv1 = qcv1;
    key.qcd1 = qcd1;
    key.qch2 = qch2;
    key.qcv2 = qcv2;
    key.qcd2 = qcd2; 
    key.Uw = Uw;
    key.Vw = Vw;
    key.Uc1 = Uc1;
    key.Vc1 = Vc1;
    key.Sc = Sc;
end