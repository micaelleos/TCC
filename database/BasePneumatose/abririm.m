function [ varargout ] = abririm(varargin)
%Abreturas da imagem do exame e máscara
Ag = imread(varargin{1});

if length(size(Ag))==3
   A=double(rgb2gray(Ag));
else
    A=double(Ag);
end 

varargout{1}=A;

if(length(varargin)==2)
    Am = imread(varargin{2});

    if length(size(Am))==3
       AM=double(rgb2gray(Am));
    else
        AM=double(Am);
    end 
    varargout{2}=AM;
end

end

