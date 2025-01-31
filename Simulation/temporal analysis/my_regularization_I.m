% make the matrix to be SPD

function re_matrix = my_regularization_I(matrix,appropriate_p)  
%test all simulation appropriate_p=2  (see find_regularize_ro and python find p (1.507525457258608))
%  appropriate_p = ceil(appropriate_p)

   ro = appropriate_p./(appropriate_p+1);

   re_matrix = (1-ro)*matrix + ro*eye(size(matrix,1),size(matrix,1));

end
