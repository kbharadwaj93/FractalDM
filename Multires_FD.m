% Multi-res Box counting                                                                                                %
% by Kamalesh Bharadwaj                                                                                                 %
%                                                                                                                       %
% reference: “Computing Fractal Dimension of Signals using Multiresolution Box-counting Method”                         %                
% by B. S. Raghavendra, and D. Narayana Dutt. World Academy of Science,Engineering and Technology,Vol:4 2010-01-21      %
% x(i)= time elapsed in 1/fs seconds; y(i)= recorded data or value; fs = sampling frequency                             %

clc;
clear;
R = 20;                                 % R / fs is max. coarse time resolution, Needs to be played to observe change in plot
datas = load('datas.txt');
x=datas(:,1);
y=datas(:,2);
N=length(x);        
B=zeros(R,R);
Br = 0;
lnr = zeros(R);
lnBr = zeros(R);

for r = 1:R
    
    for i = 1:N-1
        dt = r * (x(i+1)- x(i));
        h = y(i+1) - y(i);
        bi = ceil(abs(h)/dt);
        Br = Br + bi;
        if (h>0)
            y(i+1) = y(i) + abs(h) - dt;
        end
        if (h<0)
            y(i+1) = y(i) - abs(h) + dt;
        end     
    end
    
    log_Br(r) = log(Br);
    log_1byr(r) = log(1/r);
end

plot(log_Br, log_1byr)
title('Multi-res FD : Plot of log(B(r)) vs log(1/r)' )
xlabel(' log(B(r)) ')
ylabel(' log(1/r) ')

coef = polyfit(log_1byr,log_Br,1);                      %least squares linear fit
De=coef(1)                                              %Coefficient of linear fit is Multires Fractal dimension of signal
