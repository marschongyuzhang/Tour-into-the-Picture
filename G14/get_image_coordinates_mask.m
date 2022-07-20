function [ pm,h_m ,w_m ] = get_image_coordinates_mask( rxm,rym )

    rx = [rxm(1) rym(1)+rxm(1)];
    ry = [rxm(2) rym(2)+rxm(2)];

% hold on
% plot([rx(1),rx(2),rx(2),rx(1)],[ry(1),ry(1),ry(2),ry(2)],'LineWidth',5)

    % p1...p12 are pixel points
    p1m = [rx(1),ry(1)];
    p2m = [rx(2),ry(1)];
    p3m = [rx(2),ry(2)];
    p4m = [rx(1),ry(2)];
    pm=[p4m;p3m;p1m;p2m];
    h_m = abs(p3m(2)-p1m(2));
    w_m = abs(p2m(1)-p1m(1));

end

