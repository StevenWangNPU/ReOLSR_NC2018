function T = Retargeting(R, label)
%--------------------------------------------------------------------------
% Retargeting function
% Input:
%       R:  1*classNum regression result
%       label:  class index
% Output:
%       T:  1*classNum target vector
%--------------------------------------------------------------------------
classNum = length(R);
T = zeros(1, classNum);
V = R + 1 - repmat(R(label), 1, classNum);    
step = 0;
num = 0;
for i = 1:classNum
    if i~=label
        dg = V(i);
        for j = 1:classNum;
            if j~=label
                if V(i) < V(j)
                    dg = dg + V(i) - V(j);
                end
            end
        end
        if dg > 0
            step = step + V(i);
            num = num + 1;
        end
    end
end
step = step / (1+num);
for i = 1:classNum
    if i == label
        T(i) = R(i) + step;
    else
        T(i) = R(i) + min(step - V(i), 0);
    end
end
return;