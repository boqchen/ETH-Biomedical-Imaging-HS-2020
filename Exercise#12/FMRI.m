%=========================================================================
%                                                                     
%       BIOMEDICAL IMAGING
%       MRI 3
%
%=========================================================================

%=========================================================================
%	FMRI
%=========================================================================

function [] = FMRI()

    clear all; close all; 
    
    % Load data
    [nx,ny,nt,fmri_data,anatomical_data,paradigm] = load_data();                % Load data
                                                                                % anatomical image of one brain slice 
                                                                                % series of 200 functional images of the same slice
                                                                                % paradigm = time course of visual stimulus
            
    % Show anatomical data
    figure
    imshow(mat2gray(anatomical_data)), title('Anatomical');
    
    % Show paradigm
    figure
    plot(paradigm),ylim([-2 2]);
    
    % Show functional data  
    
    figure
    for i = 1:10
        t = 20*(i-1)+1;
        subplot(2,5,i), imshow(mat2gray(fmri_data(:,:,t))), title(strcat('Frame ',num2str(t)));
    end
    
    
    % TASK: Try to find pixels with temporal fluctuation that resembles the paradigm
    
    
    figure
    imagesc(fmri_data(:,:,10) - fmri_data(:,:,30)); title('Pixels with Activity');
    colormap(gray);
    
    figure
    imagesc(fmri_data(:,:,10) - fmri_data(:,:,30)); title('Pixels with Activity');
    colormap(gray);
    
    time = 1:1:nt;
    
    pos_act_pixel = zeros(1,nt);
    neg_act_pixel = zeros(1,nt);
    
    pos_act_pixel(1,:) = fmri_data(400,168,:);
    neg_act_pixel(1,:) = fmri_data(393,204,:);
    
    figure
    subplot(1,3,1); plot(paradigm); ylim([-2 2]); xlabel('Time(ms)'); ylabel('Input'); title('Paradigm vs. Time');
    subplot(1,3,2); plot(time, pos_act_pixel); xlabel('Time(ms)'); ylabel('Signal Intensity'); title('Temporal Fluctuation of Positive Activity');
    subplot(1,3,3); plot(time, neg_act_pixel); xlabel('Time(ms)'); ylabel('Signal Intensity'); title('Temporal Fluctuation of Negative Activity');
    
    % TASK: Calculate an activation map
    
    temp_var = zeros(1,nt);             
    
    % Activation Map
    actv_map = zeros(ny,nx);           
    
    % Standard Deviation Map
    stdv_map = zeros(ny,nx); 
    
    % Masked Activation Map
    mask = zeros(ny,nx);                
    
    masked_actv_map = zeros(ny,nx);     
    
    stdv_tot = 0; indx = 0;
    
    square_sum = 0; idx = 0;
    
    threshold = input('Pls input threshold = ');
    
    for j = 1 : ny
        
        for k = 1 : nx
            
            temp_var(1,:) = fmri_data(j,k,:);
            
            actv_map(j,k) = sum(temp_var.*paradigm);
            
            % TASK: Calculate map of temporal standard deviation, determine noise level
            
            stdv_map(j,k) = std(temp_var);
            
            if (stdv_map(j,k) < 3)
                
                stdv_tot = stdv_tot + stdv_map(j,k);
                
                indx = indx + 1;
            end
            
                
            
            % TASK: Display thresholded activation map superimposed on anatomical data
            
            if((actv_map(j,k) > threshold) || (actv_map(j,k) < - threshold))
                
                mask(j,k) = 1;
                
            else
                
                mask(j,k) = 0;
                
            end
            
            masked_actv_map(j,k) = mask(j,k)*actv_map(j,k);
            
        end
        
    end
    
    fprintf('Thermal noise level:');
    
    thermal_noise_level = stdv_tot / indx
    
    
    anatomical_data = mat2gray(anatomical_data) + mat2gray(masked_actv_map);
    
    figure
    imagesc(actv_map); colormap(gray); title('Activation Map');
    
    figure
    imagesc(stdv_map); colormap(gray); title('Standard Deviation Map');
    
    figure
    imagesc(masked_actv_map); colormap(gray); title('Masked Activation Map');
    
    figure
    imagesc(anatomical_data); colormap(gray); title('Anatomical Image Superimposed with Activity');
             
end



function [nx,ny,nt,fmri_data,anatomical_data,paradigm] = load_data()

    nx = 382;
    ny = 482;
    nt = 200;
    
    fmri_data = zeros(ny,nx,nt);
    anatomical_data = zeros(ny,nx);
    paradigm = zeros(1,nt);
    
    fileID = fopen('fMRI_data.bin');
    for t = 1:nt
        fmri_data(:,:,t) = fread(fileID,[ny,nx],'float');
    end
    fclose(fileID);
    
    fileID = fopen('anatomical_data.bin');
    anatomical_data(:,:) = fread(fileID,[ny,nx],'float');
    fclose(fileID);
    
    fileID = fopen('paradigm.bin');
    paradigm(:) = fread(fileID,[nt],'float');
    fclose(fileID);
    
end
    
