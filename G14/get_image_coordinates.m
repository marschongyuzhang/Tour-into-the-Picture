function [ p,vx_i,vy_i,h,w ] = get_image_coordinates( I )
    imshow(I);
    [max_y, max_x, c] = size(I);
    roi1=drawrectangle('Label', 'Rückwand', 'Color', [1 0 0]);
    rx = [roi1.Position(1) roi1.Position(1)+roi1.Position(3)];
    ry = [roi1.Position(2) roi1.Position(2)+roi1.Position(4)];
    
    hold on
    plot([rx(1),rx(2),rx(2),rx(1),rx(1)],[ry(1),ry(1),ry(2),ry(2),ry(1)],'LineWidth',3)
    
    while(1)
        [vx, vy, button] = ginput(1);
        if (isempty(button))
          break;
        end
        vx_i = vx;
        vy_i = vy;
        % If 'Enter' is the input key, then 'button' is empty.
    
        % p1...p12 are pixel points
        p1 = [rx(1),ry(2)];
        p2 = [rx(2),ry(2)];
        p3 = [rx(1),ry(1)];
        p4 = [rx(2),ry(1)];
        p11 = P_inter(vx,vy,rx(1),ry(1),'x',1);
        p10 = P_inter(vx,vy,rx(1),ry(1),'y',1);
        p7 = P_inter(vx,vy,rx(2),ry(2),'x',max_x);
        p6 = P_inter(vx,vy,rx(2),ry(2),'y',max_y);
        p9 = P_inter(vx,vy,p4(1),p4(2),'y',1);
        p8 = P_inter(vx,vy,p4(1),p4(2),'x',max_x);
        p5 = P_inter(vx,vy,p1(1),p1(2),'y',max_y);
        p12 = P_inter(vx,vy,p1(1),p1(2),'x',1);
        p=[p1;p2;p3;p4;p5;p6;p7;p8;p9;p10;p11;p12];
        
        plot([vx p5(1)], [vy p5(2)], 'y','LineWidth',1);
        plot([vx p6(1)], [vy p6(2)], 'y','LineWidth',1);
        plot([vx p9(1)], [vy p9(2)], 'y','LineWidth',1);
        plot([vx p10(1)], [vy p10(2)], 'y','LineWidth',1);
        hold off;
    end
    h = abs(p3(2)-p1(2));
    w = abs(p2(1)-p1(1));

end

