function SWD_duration=SWD_duration_detect(P,threshold)

a1=sum(P(2:4,:));% delta
a2=sum(P(5:8,:));% theta
a3=sum(P(9:13,:));% alpha
a4=sum(P(1:51,:));% beta
a5=sum(P(31:51,:));% gamma

% c=sum(P(2:51,:));
% % c=1
% c=max(P);
% % c=max(c);
% 
% a1=a1./c;
% a2=a2./c;
% a3=a3./c;
% a4=a4./c;
% a5=a5./c;

% e1=a1;
% e1(e1<0.15)=0;
% [b1,c1]=findpeaks(e1);
% e1=a1;
% 
% e2=a2;
% e2(e2<0.15)=0;
% [b2,c2]=findpeaks(e2);
% e2=a2;
% 
% e3=a3;
% e3(e3<0.15)=0;
% [b3,c3]=findpeaks(e3);
% e3=a3;

% e4=a4;
% e4(e4<0.15)=0;
% [b4,c4]=findpeaks(e4);
% e4=a4;
e1=a1;
index1=find(e1>threshold);
% S=e2(index1);
T1=length(index1);

e2=a2;
index2=find(e2>threshold);
% S=e2(index2);
T2=length(index2);


e3=a3;
index3=find(e3>threshold);
% S=e3(index3);
T3=length(index3);

e4=a4;
index4=find(e4>threshold);
% S=e3(index);
T4=length(index4);

e5=a5;
index5=find(e5>threshold);
% S=e2(index2);
T5=length(index5);

SWD_duration=[T4];



% plot(a1,'c')
% hold on
% plot(a2,'r')

% plot(1:1200,e1,c1,b1,'b*')
% hold on
% plot(1:1200,e2,c2,b2,'k*')
% hold on
% plot(1:1200,e3,c3,b3,'r*')
% hold on
% % plot(1:1200,e4,c4,b4,'m*')
% % hold on


% plot(a3,'b')
% hold on
% plot(a4,'k')
% hold on
% plot(a5,'m')

% set(gca,'ytick',[0:0.5:2]);
% set(gca,'xtick',[0:20:100]);
% % set(gca,'LineWidth', 1.5);
% % ylabel('Intensity [a.u]','Fontsize',18);
% % xlabel('Time [s]','Fontsize',18);
end
