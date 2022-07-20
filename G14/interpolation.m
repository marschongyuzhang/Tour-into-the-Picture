function [ I_new_8 ] = interpolation( I_new_8 )
    
%     mask_down=logical(zeros(size(I_new_8(:,:,1))));
    mask_down=zeros(size(I_new_8(:,:,1)));
    mask_down(I_new_8(:,:,1)==0)=1;
    I_new_8(:,:,1)=regionfill(I_new_8(:,:,1),mask_down);
    I_new_8(:,:,2)=regionfill(I_new_8(:,:,2),mask_down);
    I_new_8(:,:,3)=regionfill(I_new_8(:,:,3),mask_down);

end

