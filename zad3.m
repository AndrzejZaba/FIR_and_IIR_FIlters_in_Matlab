clc
clear all
close all
%% Time and frequency vectors declaration
Fs = 300;
dt = 1/Fs;
Tk = 2;
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

SClear = x1+x2+x3;
figure(11)
plot(t,SClear); hold on
%% Noise creation
Mx = max(SClear);
Mn = min(SClear);
Max = max(abs(Mx) , abs(Mn));
Asignal = abs(Max - abs(mean(SClear)))
Aszum = 1/10                         %  10% szum
SNR = 20 * log10(Asignal / Aszum);
SNRrounded = round(SNR)

S = awgn(SClear,SNRrounded);

plot(t,S,'r'); hold off

%% FFT of signal
one = fft(S);
figure(1)
plot(fvec, 2*abs(one)/L)
%% Filter parameters
fNyq = Fs / 2;                  % for all
% 1st
fRow1 =8;
fOdc1 = f1 / fNyq;
%2nd
fRow2 = 15;
fOdc2 = f2 / fNyq;
%3rd
fRow3 = 20;
fOdc3 = (f3-10 )/ fNyq;
% Seeking of A and B matrixes
B1 = fir1(fRow1,fOdc1,"low");
B2 = fir1(fRow2,[70 90]/fNyq ,"bandpass");
B3 = fir1(fRow3,fOdc3,"high");
%% Filters
% 1st signal
F1 = filter(B1,1,S);

%plot(t,F1,'b'); hold on
%plot(t,x1,'--r'); hold off

% if wanted in the frequancy domain.
FF1 = fft(F1);
X1 = fft(x1);
figure(2)
plot(fvec,2*abs(FF1)/L,'b'); hold on
plot(fvec,2*abs(X1)/L,'--r')

% 2nd signal
F2 = filter(B2,1,S);
%figure(3)
%plot(t,F2,'b'); hold on;
%plot(t,x2,'--r');

FF2 = fft(F2);
X2 = fft(x2);
figure(3)
plot(fvec,2*abs(FF2)/L,'b'); hold on
plot(fvec,2*abs(X2)/L,'--r'); hold off

F3 = filter(B3,1,S);
FF3 = fft(F3);
X3 = fft(x3);
figure(4)
plot(fvec,2*abs(FF3)/L,'b'); hold on
plot(fvec,2*abs(X3)/L,'--r'); hold off

%% IIR filters 

fIRow1 = 8;
[BI1 AI1] = butter(fIRow1,15 / fNyq,"low");


% signal 1
FI1 = filter(BI1,AI1,S) ;
FFI1 = fft(FI1);
X1 = fft(x1);
figure(5)
plot(fvec,2*abs(FFI1)/L,'b'); hold on
plot(fvec,2*abs(X1)/L,'--r'); hold off


% Signal 2
fIRow2 = 8;
[BI2 AI2] = butter(fIRow2,[70 90]/fNyq,"bandpass");



FI2 = filter(BI2,AI2,S) ;
FFI2 = fft(FI2);
X2 = fft(x2);
figure(6)
plot(fvec,2*abs(FFI2)/L,'b'); hold on
plot(fvec,2*abs(X2)/L,'--r'); hold off

% Signal 3

fIRow3 = 8;
[BI3 AI3] = butter(fIRow3,fOdc3,"high");



FI3 = filter(BI3,AI3,S) ;
FFI3 = fft(FI3);
X3 = fft(x3);
figure(7)
plot(fvec,2*abs(FFI3)/L,'b'); hold on
plot(fvec,2*abs(X3)/L,'--r'); hold off
