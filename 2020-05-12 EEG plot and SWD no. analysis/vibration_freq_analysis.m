function vibration_freq_analysis(vibration_rawdata,start_t,end_t)
Fs = 100;            % Sampling frequency
T = 1/Fs;             % Sampling period
L = 100;             % Length of signal
t = (0:L-1)*T;        % Time vector
X = vibration_rawdata;

% X(:,8)= X(:,8)+3.05;  % Data

for i=1:1200
    c=(i-1)*100+1;
    d=(i*100);
    Y(i,:)=fft(X(c:d));    
end

P2 = abs(Y/L);
P1 = P2(:,1:L/2+1);
P1(:,2:end-1) = 2*P1(:,2:end-1);   % Intensity
f = Fs*(0:(L/2))/L;                % fequency
% plot(f,P1(:,:))
P1=P1';

color = max(P1(:));
clims = [0 color/3];
P=P1;

surfc(P(2:1:end,:))
% imagesc(P(2:1:end,:),clims)
% colormap(hot)
colorbar;
% view(5,10);
view(0,90);
caxis([0.0 0.01])
% caxis('auto')
% ylim([1 25])
xlim([start_t end_t])


% cb=colorbar;
% cb.Ruler.Scale='log';
% cb.Ruler.Minortick='on';

% fig = imagesc(P1(2:1:end,:),clims);

%
% surf(P1(2:1:end,:))
% hold on
% imagesc(P1(2:1:end,:),clims)
% colorbar;

%    image(f,P1)
%    colorbar
%
%
% A=sum(Y)./50;
% P2 = abs(A/L);
% P1 = P2(1:L/2+1);
% P1(2:end-1) = 2*P1(2:end-1);
% f = Fs*(0:(L/2))/L;
% % B=smooth(P1);
% plot(f,P1)
% axis([3 50 0 0.1])


xlabel('Time [s]')
ylabel('Frequency [Hz]')


% plot freq range

end


