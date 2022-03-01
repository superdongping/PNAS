function [SWD_no_output,SWD_event_time]=SWD_no_detect(P,duration_t,threshold)
% a1=sum(P(2:11,:));
% a2=sum(P(12:21,:));
% a3=sum(P(22:31,:));
% a4=sum(P(32:41,:));
% a5=sum(P(42:51,:));
% c=sum(P);
% a1=a1./c;
% a2=a2./c;
% a3=a3./c;
% a4=a4./c;
% a5=a5./c;
% plot(smooth(a1))
% hold on
% plot(smooth(a2))
% hold on
% plot(smooth(a3))
% hold on
% plot(smooth(a4))
% hold on
% plot(smooth(a5))

a1=sum(P(2:4,:));
a2=sum(P(5:8,:));
a3=sum(P(9:13,:));
a4=sum(P(1:51,:));
a5=sum(P(31:51,:));

c=sum(P(2:51,:));
% c=1
c=max(P);
c=max(c);
% figure
% a1=sum(P(2:3,start_t:end_t)); % delta
% a2=sum(P(4:7,start_t:end_t)); % theta
% a3=sum(P(8:12,start_t:end_t)); % alpha
% a4=sum(P(13:29,start_t:end_t)); % beta
% a5=sum(P(30:50,start_t:end_t)); % gamma

% a1=a1./c;% delta
% a2=a2./c;% theta
% a3=a3./c;% alpha
% a4=a4./c;% beta
% a5=a5./c;% gamma

% hold on
% plot(a1,'k') % delta black
% plot(a2,'g') % theta green
% plot(a3,'r') % alpha red
% plot(a4,'c') % beta cyan
% plot(a5,'m') % gamma magnenta
% hold off

e1=a1;
e1(e1<threshold)=0;
[b1,c1]=findpeaks(e1);
e1=a1;

e2=a2;
e2(e2<threshold)=0;
[b2,c2]=findpeaks(e2);
e2=a2;

e3=a3;
e3(e3<threshold)=0;
[b3,c3]=findpeaks(e3);
e3=a3;

e4=a4;
threshold_95 = prctile(e4,95) % find the 95% threshold value
% threshold_95=500;
e4(e4<threshold_95)=0;
[b4,c4]=findpeaks(e4);
e4=a4;

% threshold_95 = prctile(e4,95) % find the 95% threshold value

e5=a5;
e5(e5<threshold)=0;
[b5,c5]=findpeaks(e5);
e5=a5;

% plot(a1,'c')
% hold on
% plot(a2,'r')

% plot(1:1200,e1,c1,b1,'b*')
% hold on
% plot(1:1200,e2,c2,b2,'k*')
% hold on
% plot(1:1200,e3,c3,b3,'r*')
% hold on

% figure (70)
plot(1:duration_t,e4,c4,b4,'m*')
axis([1 duration_t 0 max(e4)+100])
% hold on
% set(figure (70), 'Position', [40 40 450 90]);
pause(1)

% plot(a3,'b')
% hold on
% plot(a4,'k')
% hold on
% plot(a5,'m')

% set(gca,'ytick',[0:0.5:2]);
% set(gca,'xtick',[0:20:100]);
set(gca,'LineWidth', 1.5);
ylabel('Intensity [a.u]');
xlabel('Time [s]');

SWD_no_output=length(b4);
SWD_event_time=c4;
end

