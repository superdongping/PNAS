function freq_sum_plot(P,start_t,end_t)

a1=sum(P(2:3,start_t:end_t)); % delta
a2=sum(P(4:7,start_t:end_t)); % theta
a3=sum(P(8:12,start_t:end_t)); % alpha
a4=sum(P(13:29,start_t:end_t)); % beta
a5=sum(P(30:50,start_t:end_t)); % gamma

hold on
plot(a1,'k') % delta black
plot(a2,'g') % theta green
plot(a3,'r') % alpha red
plot(a4,'c') % beta cyan
plot(a5,'m') % gamma magnenta
hold off

% c=sum(P(2:51,start_t:end_t));
% % c=1
% % % c=max(P);
% % % c=max(c);
% a1=smooth(a1./c);
% a2=smooth(a2./c);
% a3=smooth(a3./c);
% a4=smooth(a4./c);
% a4=smooth(a5./c);
% 
% 
% hold on
% plot(smooth(a1),'k') % delta black
% plot(smooth(a2),'g') % theta green
% plot(smooth(a3),'r') % alpha red
% plot(smooth(a4),'c') % beta cyan
% plot(smooth(a5),'m') % gamma magnenta
% hold off

% set(gca,'ytick',[0:0.5:2]);
% set(gca,'xtick',[0:100:600]);
set(gca,'LineWidth', 1.5);
ylabel('Intensity [a.u]','Fontsize',18);
xlabel('Time [s]','Fontsize',18);
% axis([start_t end_t 0 100])

end