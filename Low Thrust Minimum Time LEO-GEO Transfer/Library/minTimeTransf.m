function J = minTimeTransf(X)
% Description: this function takes as input the unknown quantities in X and
% returns the scalar value of the objective function J

tf = X(end);
J = tf;

global iteration
iteration = iteration + 1;

end