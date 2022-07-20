function P = P_inter(x1,y1,x2,y2,varargin)

    p=inputParser;
    p.addParameter('x',-Inf);
    p.addParameter('y',-Inf);
    p.parse(varargin{:});
    x_edge = p.Results.x;
    y_edge = p.Results.y;
    
    if x1 == x2
        x = x1;
        y = y_edge;
    elseif y1 == y2
        x = x_edge;
        y = y1;
    else
        k = (y2-y1)/(x2-x1);
        b = y1-k*x1;
        if x_edge ~= -inf
            x = x_edge;
            y = k*x+b;
        else
            y = y_edge;
            x = (y-b)/k;
        end
    end
    P = [x,y];
    
end