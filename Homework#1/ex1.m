%-------- input k_x, k_y -----------------

k_x = input('please input k_x');
k_y = input('please input k_y');

%-------------- Q1 ------------------------

[x,y] = meshgrid(0:0.01:1);
z = exp(sqrt(-1)*((k_x)*x + (k_y)*y)); %wave 
figure(1)
plot3(x,y,z)
xlabel('x');
ylabel('y');
zlabel('wave')

%-------------- Q2 ------------------------

re = real(z);  % real part of the wave
im = imag(z);  % imaginary part of the wave
mag = abs(z);  % magnitute of the wave
ph = angle(z); % phase of the wave

figure(2)
subplot(2,2,1); plot3(x,y,re); xlabel('x');ylabel('y');zlabel('real part'); title('real part of the wave')
subplot(2,2,2); plot3(x,y,im); xlabel('x');ylabel('y');zlabel('imaginary part'); title('imaginary part of the wave')
subplot(2,2,3); plot3(x,y,mag); xlabel('x');ylabel('y');zlabel('magnitude'); title('magnitude of the wave')
subplot(2,2,4); plot3(x,y,ph); xlabel('x');ylabel('y');zlabel('phase'); title('phase of the wave')

%-------------- Q5 -------------------------

% The LSI system is S[f] = alpha * f where alpha is a constant number 
% Let alpha = 2

z_LSI = 2 * z


%-------------- Q6 -------------------------

re1 = real(z_LSI);  % real part of the wave after applying LSI
im1 = imag(z_LSI);  % imaginary part of the wave after applying LSI
mag1 = abs(z_LSI);  % magnitute of the wave after applying LSI
ph1 = angle(z_LSI); % phase of the wave after applying LSI

figure(3)
subplot(2,2,1); plot3(x,y,re1); xlabel('x');ylabel('y');zlabel('real part'); title('real part of the wave after applying LSI')
subplot(2,2,2); plot3(x,y,im1); xlabel('x');ylabel('y');zlabel('imaginary part'); title('imaginary part of the wave after applying LSI')
subplot(2,2,3); plot3(x,y,mag1); xlabel('x');ylabel('y');zlabel('magnitude'); title('magnitude of the wave after applying LSI')
subplot(2,2,4); plot3(x,y,ph1); xlabel('x');ylabel('y');zlabel('phase'); title('phase of the wave after applying LSI')
