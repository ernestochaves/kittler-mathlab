function kittler
    %Esta parte es solo requerida con la imagen RGB
    %U = rgb2gray(imread('trackedCell15.tif'));    

    %Procesando la imagen 1, escala de grises
    U = imread('cuadro1_005.bmp');  
    histU = getHistogram(U);
    figure(1);
    plot(histU);
    [thOpt, gmmParams]=kittlerThresh(histU);
    fprintf('thOpt: %i\n', thOpt)
    fprintf('gmmParams: %i\n', gmmParams)
    figure(2);
    plot(plotJth(histU));

    um = applyThreshold(U, thOpt);
    figure(3);
    imshow(um);
    %Procesando la imagen 2
    img2 = rgb2gray(imread('trackedCell15.tif'));
    histU2 = getHistogram(img2);
    [thOpt2, gmmParams2]=kittlerThresh(histU2);
    figure(4);
    um2 = applyThreshold(img2, thOpt2);
    imshow(um2);
end
 
function histU = getHistogram(U)
    %[height, width, colour_planes]=size(U);
    %height, width, colour_planes
    histU = double(histc(U(:), 0:255)) / size(U(:), 1);
end
 
%calculates the cum sum of a histogram from a to b
function P = getP(histU, a, b)
   P = sum(histU(a:b));
end
 
%calculates the mean in the given interval
function mu = getMu(histU, a, b, P)    
    mu = sum(histU(a:b) .* (a:b)') / P;
end
 
%calculates the variance in a given interval
function varU = getVar(histU, a, b, P, mu)
    varU = sum(histU(a:b) .* (((a:b)' - mu) .^2) ) / P;
end

%gets the likelihood of a given threshold, using kittler
function [Jth, P1, mu1, var1, P2, mu2, var2] = getLikelihood(histU, th)
    %We need a big number here so doesnt get confused with the min. 
    Jth=Inf*1; 
    P1=0;
    mu1=0;
    var1=0;
    P2=0;
    mu2=0;
    var2=0;
    P1 = getP(histU,1,th);
    P2 = getP(histU,th+1,255);
    %to avoid division by zero errors
    if (P1 > 0) && (P2 > 0)
        mu1 =  getMu(histU, 1, th, P1);  
        mu2 =  getMu(histU, th+1, 255, P2);  
        var1 = getVar(histU, 1, th, P1, mu1);
        var2 = getVar(histU, th+1,255, P2, mu2);
        %Avoid weird errors with -inf
        if (sqrt(var1) > 0) && (sqrt(var2) > 0)
            Jth= 1 + 2 * (P1 * log(sqrt(var1)) + P2 * log(sqrt(var2)))- 2 * (P1 * log(P1) + P2 * log(P2));   
        end
    end 
end

%kittler
function [thOpt, gmmParams] = kittlerThresh(histU)
    %gmmParams: see https://www.coursera.org/lecture/robotics-learning/1-4-2-gmm-parameter-estimation-via-em-79fAL
    minJth=Inf*1; 
    results = zeros(255,1);
    for T = 1:255
        [Jth, P1, mu1, var1, P2, mu2, var2]= getLikelihood(histU,T);
        if(P1 > 0) && (P2 > 0)
            if(Jth<minJth)
                % Optimal threshold is where Jth is at its minimum 
                % We could also return the "T"
                minJth=Jth;
                thOpt=T;
                gmmParams=[Jth, P1, mu1, var1, P2, mu2, var2];
            end
        end
    end
end
 
%applies the given treshold to the image
function Th = applyThreshold(U, tau)

   Th =(U > tau);

end

function JthsPlot = plotJth(histU)
    JthsPlot = zeros(255,1);
    for T = 1:255
        [Jth, P1, mu1, var1, P2, mu2, var2]= getLikelihood(histU,T);
        JthsPlot(T) = Jth;
    end
end

