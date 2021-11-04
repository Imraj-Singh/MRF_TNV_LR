function [proxout] = proximal_map(q, eta, sig)
% Proximal map (Appendix B)
%
% Author: Imraj Singh 10 June 2021

% Find l2 norm
normWq = norm(q(:),2);

if normWq <= sig*eta
    disp('q norm small')
    proxout = zeros(size(q),'like', q);
else
    % Eqn. B.5 all Wjj=1, so reduces to quadratic
    q2 = normWq^2;
    root1 = (-(eta^2)*sig + sqrt(q2)*eta)/(((eta^2)*(sig^2) - q2));
    root2 = (-(eta^2)*sig - sqrt(q2)*eta)/(((eta^2)*(sig^2) - q2));
    %disp(['Root 1: ' num2str(root1) ' root 2: ' num2str(root2)])
    
    % Choose the positive root
    if root1 > 0
        lams = root1;
    else
        lams = root2;
    end
    proxout = q / (1+sig*lams);
end
end

