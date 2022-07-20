function view  = plot_new_image( I,vx_i,vy_i,x2_cam )

    x2_cam(1,:)=x2_cam(1,:)+round(size(I,1)-vy_i);
    x2_cam(2,:)=x2_cam(2,:)+round(vx_i); %calibrate the original point of view
    
    view=zeros(size(I,2),size(I,1),3);
    for i=1:size(x2_cam,2)
        if 1<=x2_cam(1,i) && x2_cam(1,i)<=size(I,1) && 1<=x2_cam(2,i) && x2_cam(2,i)<=size(I,2)
            view(x2_cam(2,i),x2_cam(1,i),1) = x2_cam(4,i);
            view(x2_cam(2,i),x2_cam(1,i),2) = x2_cam(5,i);
            view(x2_cam(2,i),x2_cam(1,i),3) = x2_cam(6,i);
        end
    end
    view=uint8(view);

end

