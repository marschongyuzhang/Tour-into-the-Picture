function [ H_left,H_down,H_up,H_right,H_middle,P ] = get_world_coordinates( p,h,w )

    p1=p(1,:);
    p2=p(2,:);
    p3=p(3,:);
    p4=p(4,:);
    p5=p(5,:);
    p6=p(6,:);
    p7=p(7,:);
    p8=p(8,:);
    p9=p(9,:);
    p10=p(10,:);
    p11=p(11,:);
    p12=p(12,:);
    
    %% Determine the world coordinates P1...P12
    depth = 400;
    % z1 = bottom 
    length1 = p2(1) - p1(1);
    length2 = p6(1) - p5(1);
    factor = length1/length2;
    z1 = (depth-factor*depth) / factor;
    %z2 = right
    length1 = p4(2) - p2(2);
    length2 = p8(2) - p7(2);
    factor = length1/length2;
    z2 = (depth-factor*depth) / factor;
    %z3 = left;
    length1 = p3(2) - p1(2);
    length2 = p11(2) - p12(2);
    factor = length1/length2;
    z3 = (depth-factor*depth) / factor;
    %z4 = up;
    length1 = p4(1) - p3(1);
    length2 = p9(1) - p10(1);
    factor = length1/length2;
    z4 = (depth-factor*depth) / factor;
    P1 = [0 0 0];
    P2 = [w 0 0];
    P3 = [0 h 0];
    P4 = [w h 0];
    P5 = [0 0 z1];
    P6 = [w 0 z1];
    P7 = [w 0 z2];
    P8 = [w h z2];
    P9 = [w h z4];
    P10 = [0 h z4];
    P11 = [0 h z3];
    P12 = [0 0 z3];
    P=[P1;P2;P3;P4;P5;P6;P7;P8;P9;P10;P11;P12];
    
    P_left = [P1;P3;P12;P11]';
    P_left = P_left(2:3,:);
    P_right= [P2;P4;P7;P8]';
    P_right = P_right(2:3,:);
    P_up = [P3;P4;P9;P10]';
    P_up = [P_up(1,:);P_up(3,:)];
    P_down = [P1;P2;P5;P6]';
    P_down = [P_down(1,:);P_down(3,:)];
    
    %% Calculate the corresponding perspective matrix
    p_left = [p1;p3;p12;p11]';
    p_right= [p2;p4;p7;p8]';
    p_up = [p3;p4;p9;p10]';
    p_down = [p1;p2;p5;p6]';
    H_left = HMatrix(p_left,P_left);
    H_down = HMatrix(p_down,P_down);
    H_up = HMatrix(p_up,P_up);
    H_right = HMatrix(p_right,P_right);
    
    p_middle = [p1;p2;p3;p4]';
    P_middle = [P1;P2;P3;P4]';
    P_middle = P_middle(1:2,:);
    H_middle = HMatrix(p_middle,P_middle);

end

