function H = HMatrix(p1,p2)
    % p1:u1,v1;u3,v3;u5,v5;u7,v7 8x1
    % p2:u2,v2;u4,v4;u6,v6;u8,v8
    % P_H = [blkdiag([p1(1:2),1],[p1(1:2),1]),[-p1(1)*p2(1),-p1(2)*p2(1);-p1(1)*p2(2),-p1(2)*p2(2)];]
    P_H = [get_PH(p1,p2,1);
        get_PH(p1,p2,3);
        get_PH(p1,p2,5);
        get_PH(p1,p2,7);];
    H = inv(P_H)*p2(:);
    H=H';
    H = [H(1:3);H(4:6);[H(7:8),1]];
    
    function P_H = get_PH(p1,p2,i)
        P_H = [blkdiag([p1(i:i+1),1],[p1(i:i+1),1]),...
            [-p1(i)*p2(i),-p1(i+1)*p2(i);-p1(i)*p2(i+1),-p1(i+1)*p2(i+1)]];
    end
end