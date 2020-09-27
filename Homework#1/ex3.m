n = 256;    % length of inputs 
x = [0:n-1]-n/2; 
k = [-n/2:1:n/2-1]*2*pi/n; % sampling points
f = zeros(1,n);

display('delta_x has to be two to the power of an interger')
delta_x = input('please input delta_x'); % change delta_x to see the results

%---------- loop begins ------------

for j = 0:n/delta_x-1             
    
    f(n/2+1+j*delta_x) = 1;
    f(n/2+1-j*delta_x) = 1; 
    
    f_corr = exp(-1i.*k.*x(1)).*fftshift(fft(f)); % phase correction
    
    figure
    subplot(2,2,1); plot(x,f); xlabel('x');ylabel('f');axis tight;ylim(range(f));title('Comb Function');
    subplot(2,2,2); plot(x,abs(f_corr)); xlabel('x');ylabel('magnitude');axis tight;ylim(range(abs(f_corr))); title('magnitude');
    subplot(2,2,3); plot(x,real(f_corr)); xlabel('x');ylabel('real part');axis tight;ylim(range(real(f_corr))); title('real part');
    subplot(2,2,4); plot(x,imag(f_corr)); xlabel('x');ylabel('imaginary part');axis tight;ylim(range(imag(f_corr))); title('imaginary part');
    
end  

function r = range(x)
    d = 0.1*(max(x)-min(x))
    if(d==0),
        d=1
    end
    r = [min(x)-d max(x)+d]
    
end

    