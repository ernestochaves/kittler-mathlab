function kittler
    U = rgb2gray(imread('trackedCell15.tif'));    
    histU = getHistogram(U);
    hn = HistogramaNormalizado(U)
    figure(1);
    plot(histU);
    figure(2);
    plot(hn);
%     kittlerThresh(histU);
end

function histU = getHistogram(U)
    histU = double(histc(U(:), 0:255)) / size(U(:), 1);
end
function hn = HistogramNormalized(U)
    [f,c]=size(U);
    hist = Histograma(U);
    histn = hist/(f*c);
    hn = histn;
end
function hist = Histogram (U)
    img = double(U);
    [f,c]=size(img);
    for i=1:256
        h(i) = 0;
    end
    for i=1:f
       for j=1:c
           k = img(i,j);
           h(k+1) = h(k+1)+1;
       end
    end
    hist = h; 
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
