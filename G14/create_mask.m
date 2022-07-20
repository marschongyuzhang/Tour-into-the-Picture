function [maskRGBimage, masko] = create_mask(image,h)
    % input: a image h: polygon
    %   put the colorful image back into the background
    % rgbImage = imread(image); 
    rgbImage = image;
    % [rows, columns, numberOfColorChannels] = size(rgbImage);
    % imshow(rgbImage);
    % Extract the red, green, and blue color channels.
    redChannel = rgbImage(:, :, 1);
    greenChannel = rgbImage(:, :, 2);
    blueChannel = rgbImage(:, :, 3);
    % Create a mask of the foreground only.
    masko = h;
    masko = createMask(masko);masko=uint8(masko);
    redmask = redChannel.*masko;
    greenmask = greenChannel.*masko;
    bluemask = blueChannel.*masko;
    maskRGBimage = cat(3,redmask,greenmask,bluemask);
    % Display the mask image.
    % imshow(maskRGBimage);
end

