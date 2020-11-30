M0 = 1;
T1 = 200;
T2 = 50;
angle = 39*pi/180;
TR = 50;
np = 50;
nt = 100;

Mz = zeros(np);
Mxy = zeros(np);
Mz_highres = zeros(nt, np);
Mxy_highres = zeros(nt, np);

t = [0:(nt-1)].*TR./(nt-1);

Mz_before_pulse = M0;
Mxy_before_pulse = 0;

for p = 1:np
    
    Mz(p) = Mz_before_pulse;
    
    Mz_after_pulse = Mz_before_pulse*cos(angle) - Mxy_before_pulse*sin(angle);
    Mxy_after_pulse = Mz_before_pulse*sin(angle) + Mxy_before_pulse*cos(angle);
    
    Mxy(p) = Mxy_after_pulse;
    
    Mz_highres(:,p) = (Mz_after_pulse - M0)* exp(-t./T1) + M0;
    Mxy_highres(:,p) = Mxy_after_pulse* exp(-t./T2);
    
    Mz_before_pulse = Mz_highres(nt,p);
    Mxy_before_pulse = Mxy_highres(nt,p);
end

figure
subplot(2,1,1), plot(Mz), axis tight, ylim([-1,1]), title('Mz');
subplot(2,1,2), plot(Mxy), axis tight, ylim([-1,1]), title('Mxy');

figure
subplot(2,1,1), plot(reshape(Mz_highres,1,np*nt)), axis tight, ylim([-1,1]), title('Mz');
subplot(2,1,2), plot(reshape(Mxy_highres,1,np*nt)), axis tight, ylim([-1,1]), title('Mxy');

fprintf('steady-state Mz : %7.5f\n', Mz(np));
fprintf('steady-state Mxy : %7.5f\n', Mxy(np));


    
    
    