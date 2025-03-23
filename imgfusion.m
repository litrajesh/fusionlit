% Function for image fusion using DWT
function outimage = imgfusion(Im1, Im2, ftype, wtype)
    % Perform Discrete Wavelet Transform on both images
    [cA1, cH1, cV1, cD1] = dwt2(double(Im1), wtype, 'per');
    [cA2, cH2, cV2, cD2] = dwt2(double(Im2), wtype, 'per');
    
    % Initialize the coefficients matrices
    [r, c] = size(cA1);
    cA = zeros(r, c);
    cH = zeros(r, c);
    cV = zeros(r, c);
    cD = zeros(r, c);

    % Switch case for different fusion types
    switch ftype
        case 'MeanMean'
            cA = mean(cat(3, cA1, cA2), 3);
            cH = mean(cat(3, cH1, cH2), 3);
            cV = mean(cat(3, cV1, cV2), 3);
            cD = mean(cat(3, cD1, cD2), 3);

        case 'MeanMax'
            cA = mean(cat(3, cA1, cA2), 3);
            cH = max(cat(3, cH1, cH2), [], 3);
            cV = max(cat(3, cV1, cV2), [], 3);
            cD = max(cat(3, cD1, cD2), [], 3);

        case 'MeanMin'
            cA = mean(cat(3, cA1, cA2), 3);
            cH = min(cat(3, cH1, cH2), [], 3);
            cV = min(cat(3, cV1, cV2), [], 3);
            cD = min(cat(3, cD1, cD2), [], 3);

        case 'MaxMean'
            cA = max(cat(3, cA1, cA2), [], 3);
            cH = mean(cat(3, cH1, cH2), 3);
            cV = mean(cat(3, cV1, cV2), 3);
            cD = mean(cat(3, cD1, cD2), 3);

        case 'MaxMax'
            cA = max(cat(3, cA1, cA2), [], 3);
            cH = max(cat(3, cH1, cH2), [], 3);
            cV = max(cat(3, cV1, cV2), [], 3);
            cD = max(cat(3, cD1, cD2), [], 3);

        case 'MaxMin'
            cA = max(cat(3, cA1, cA2), [], 3);
            cH = min(cat(3, cH1, cH2), [], 3);
            cV = min(cat(3, cV1, cV2), [], 3);
            cD = min(cat(3, cD1, cD2), [], 3);

        case 'MinMean'
            cA = min(cat(3, cA1, cA2), [], 3);
            cH = mean(cat(3, cH1, cH2), 3);
            cV = mean(cat(3, cV1, cV2), 3);
            cD = mean(cat(3, cD1, cD2), 3);

        case 'MinMax'
            cA = min(cat(3, cA1, cA2), [], 3);
            cH = max(cat(3, cH1, cH2), [], 3);
            cV = max(cat(3, cV1, cV2), [], 3);
            cD = max(cat(3, cD1, cD2), [], 3);

        case 'MinMin'
            cA = min(cat(3, cA1, cA2), [], 3);
            cH = min(cat(3, cH1, cH2), [], 3);
            cV = min(cat(3, cV1, cV2), [], 3);
            cD = min(cat(3, cD1, cD2), [], 3);
    end

    % Perform Inverse Discrete Wavelet Transform to get the fused image
    outimage = idwt2(cA, cH, cV, cD, wtype, 'per');
end