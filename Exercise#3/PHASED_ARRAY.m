%=========================================================================
%                                                                     
%       BIOMEDICAL IMAGING
%       ULTRASOUND 2
%
%=========================================================================

%=========================================================================
%	PHASED ARRAY
%=========================================================================



    clear all; close all; 
    
    fprintf ( '-----------------------------------------\n' );  
    fprintf ( ' PHASED ARRAY                            \n' );  
    fprintf ( '-----------------------------------------\n' );  
    
    
    % Ultrasound specs
    
    f = 1.5E6;                      % frequency [Hz]
    c = 1480;                       % speed of sound in water [m/s]
    k = 2*pi*f/c;                   % wave number [rad/m]
    lambda = c/f;                   % wavelength [m]
    
    
    % Transducer array
    
    nt = 40;                         % number of transducers
    pitch = 0.5*lambda;          % spacing of transducers
    c = pitch*nt;
    
    % Definition of 2D grid for wave calculation
    
    n = 1024;                       % grid size in each dimension
    x_range = [0,0.4];              % covered range in x [m]
    y_range = [-0.2,0.2];           % covered range in y [m]
    
    x_values = x_range(1)+(x_range(2)-x_range(1))*[0:(n-1)]./(n-1);    % vector of x values on the grid
    y_values = y_range(1)+(y_range(2)-y_range(1))*[0:(n-1)]./(n-1);    % vector of y values on the grid
    
    [x,y] = meshgrid(x_values,y_values);    % the grid, given by 2D arrays x,y   
      
    %task3 deflection
    deflect = input('task3 - deflect');
    alpha = 20*pi/180;
    
    %task 4 grating lobe
    grating_lobe = input('task4 - grating_lob');
    if  grating_lobe==1
        deflect = 1;
        alpha = 20*pi/180;
        pitch = 1.0*lambda;
    end
    
    %task5 focus
    focus = input('task5 - focus');
    dis = 0.05;
    
    %task6 Gaussian apodization
    apodize = input('task6 - apodize');
    sigma = input('sigma');
    
    
        
        
    
    % Loop through transducers and sum up their wave contributions
    
    wave = zeros(n,n);                      % container for pressure wave
    
    for t = 1:nt  
        
        x0 = -0.001;                        % x coordinate of transducer, 1 mm outside the container 
        y0 = pitch*(t-(nt+1)/2);            % y coordinate of transducer
        
        r = sqrt((x-x0).^2+(y-y0).^2);      % distance from transducer, on the grid
               
        phase = 0;                          % phase of transducer input [rad]
        amplitude = 1;                      % relative amplitude of transducer input        
        
      %----------------- Deflection --------------------------%%   
        if deflect
            phase = -k*y0*sin(alpha);
        end
      %----------------- Focus --------------------------------%% 
        if focus
            phase = -k*(sqrt(y0*y0+dis*dis)-dis);
        end
        
      %-------------------- Apodize ----------------------------%% 
        if apodize
            
            amplitude = exp(-((t-nt/2)*pitch)^2/(2*sigma*sigma));
        end
            
        wave = wave + exp(i*(k*r))./sqrt(r) .* amplitude .* exp(i*phase);   % add partial wave to net wave
      
            
    end

    figure('position',[100 100 800 500])    
    imagesc(real(wave)), title('real part');  
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);
    
    figure('position',[100 100 800 500])
    imagesc(abs(wave)), title('magnitude')
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);    
    
   