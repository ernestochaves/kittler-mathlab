function kittler
    U = rgb2gray(imread('cuadro1_005.bmp'));    
    histU = getHistogram(U);
    figure(1);
    plot(histU);
    P = getP(histU, 1, 255);
    mu = getMu(histU, 1, 255, P);
    varU = getVar(histU, 1, 150, P, mu);
%     kittlerThresh(histU);
end
 
function histU = getHistogram(U)
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
   
    
end
 
 
%kittler
function [thOpt, gmmParams] = kittlerThresh(histU)
    
 
end
 
%applies the given treshold to the image
function Th = applyThreshold(U, tau)
   
end

