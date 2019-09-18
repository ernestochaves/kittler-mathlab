
function kittler()
  U=imread('cuadro1_005.bmp');
  histU = getHistogram(U);
  figure; plot(histU);
  #kittlerThresh(histU);
end

function histU = getHistogram(U)
    histU = double(histc(U(:), 0:)) / size(U(:), 1);
end

%calculates the cum sum of a histogram from a to b
function P = getP(histU, a, b)
   
end

%calculates the mean in the given interval
function mu = getMu(histU, a, b, P)    
    
end

%calculates the variance in a given interval
function varU = getVar(histU, a, b, P, mu)
    
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
