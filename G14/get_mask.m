function [maskRGB, I, pm,rxm, rym, hm, wm] = get_mask(I)
    h_ = drawrectangle('Label', 'Vorwand', 'Color', [0 1 0]);
    rxm = [h_.Position(1) h_.Position(2)];
    rym = [h_.Position(3) h_.Position(4)];
    [ pm,hm,wm] = get_image_coordinates_mask( rxm,rym );
    mask = createMask(h_);
    maskRGB=create_mask(I,h_);
    J = inpaintExemplar(I,mask);
    I = J;
end

