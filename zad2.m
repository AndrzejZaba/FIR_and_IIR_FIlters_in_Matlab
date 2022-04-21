clc
close all
clear all
%% Time and frequency vectors declaration
Fs = 300;
dt = 1/Fs;
Tk = 0.5;
t = 0:dt:(Tk-dt);

L = length(t);
df = Fs / L;

fvec = (0:L-1)*df;

%% Signal creation
f1 = 10;
f2 = 80;
f3 = 120;

x1 = sin(2*pi*f1*t);
x2 = 3*sin(2*pi*f2*t + pi/4 );
x3 = 2*sin(2*pi*f3*t + pi/2);

S = x1+x2+x3;
%% FFT of signal
one = fft(S);
plot(fvec, 2*abs(one)/L)
%% Filter parameters
fNyq = Fs / 2;                  % for all
%2nd
fRow2 = 15;
fOdc2 = f2 / fNyq;
% Seeking of A and B matrixes
B1 = fir1(fRow2, [70 90]/fNyq, 'bandpass');


%% Filters
F2 = filter(B1,1,S);
FF2 = fft(F2);
X2 = fft(x2);

figure(1)
plot(fvec,2*abs(FF2) / L ,'m'); hold on
%plot(fvec,2*abs(X2) / L ,'--r'); 

Filt2 = filtfilt(B1,1,S);
FFilt2 = fft(F2);
plot(fvec,2*abs(FFilt2) / L, '--g');

figure(2)
plot(t,F2,'b'); hold on
plot(t,Filt2,'--r')