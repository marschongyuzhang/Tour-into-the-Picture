function zip_image = zip_pooling(im)
%zip a image
imgsize = size(im);
while 1==1
    if mod(imgsize(1),3)== 0
        break;
    end
    im = im(1:end-1,:,:);
    imgsize = size(im);
end

while 1==1
    if mod(imgsize(2),3)== 0
        break;
    end
    im = im(:,1:end-1,:);
    imgsize = size(im);
end
im1=im(1:3:end,1:3:end,:);
im2=im(2:3:end,1:3:end,:);
im3=im(3:3:end,1:3:end,:);
im4=im(1:3:end,2:3:end,:);
im5=im(2:3:end,2:3:end,:);
im6=im(3:3:end,2:3:end,:);
im7=im(1:3:end,3:3:end,:);
im8=im(2:3:end,3:3:end,:);
im9=im(3:3:end,3:3:end,:);
zip_image = max(cat(4,im1,im2,im3,im4,im5,im6,im7,im8,im9),[],4);

end

