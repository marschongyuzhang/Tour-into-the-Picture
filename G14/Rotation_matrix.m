function [ Rotation ] = Rotation_matrix( alpha,beta,theta )

    R_x=[1 0 0;0 cosd(alpha) sind(alpha);0 -sind(alpha) cosd(alpha)];
    R_y=[cosd(beta) 0 -sind(beta);0 1 0;sind(beta) 0 cosd(beta)];
    R_z=[cosd(theta) sind(theta) 0;-sind(theta) cosd(theta) 0;0 0 1];
    Rotation =R_z*R_y*R_x;

end

