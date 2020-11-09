x = [0.1 0.2 0.3 0.4 0.5];
x1 = 0:0.1:0.6;
y1 = [2.6 3.9 4.5 5.2 6];
f1=polyfit(x,y1,2);
y11=polyval(f1,x1)
y2 = [12.4 20.9 23.4 26.2 30]
f2=polyfit(x,y2,2);
y22=polyval(f2,x1)
plot(x,y1,'r*',x1,y11,'b',x,y2,'m*',x1,y22,'g'); 
legend('High Resolution Real Data','High Resolution Fitting','Low Resolution Real Data','Low Resolution Fitting'); 
title('SNR vs. Tube Current'); 
xlabel('Current(A)'); 
ylabel('SNR');

