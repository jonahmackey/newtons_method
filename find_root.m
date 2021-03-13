function t = find_root(f, x0, d)
    % An implementation of Newton's method.
    % Compute the root of the function f to d correct decimals, based on 
    % the initial approximation x0.
    %
    % Newton's method is defined by the following iteration formula:
    %   x_n+1 = x_n + h_n
    %   h_n = -f(x_n)/f'(x_n)
    % 
    % Preconditions:
    %  - The function f has two continuous derivatives
    %  - The root is a simple root, i.e. f'(root) ~= 0
    
    
    syms x % Create symbolic variable

    % Find the 1st order derivative of f
    df1 = diff(f(x));
    f1 = matlabFunction(df1); 

    % Define variable h_0 as seen in the iteration formula
    h = -f(x0) / f1(x0);
    
    % Calculate first estimate and its error.
    estimate = x0;
    
    % Create array for the estimates.
    estimates = [estimate];

    % Calculate successive estimates until level of precision is satisfied,
    % i.e. when we compute the root to d correct decimals
    while abs(h) > (1/2)*10^-d
        estimate = estimate + h; % Compute the next estimate
        h = -f(estimate) / f1(estimate);
        estimates(end + 1) = estimate; % Add estimate to estimates array
    end
    
    % The root has been determined to the desired level of precision. 
    % Assign it to a local variable
    root = estimates(end)
    
    % Create an array containing the error in each estimate
    errors = (estimates - root);
    errors(end) = NaN;
    
    %Create an array containing the indices of each step.
    indices = 0 : 1 : length(estimates) - 1;
    
    % Put results into a table.
    t = table(indices', estimates', errors', 'VariableNames',...
        {'n', 'Estimate', 'Error'});
end










