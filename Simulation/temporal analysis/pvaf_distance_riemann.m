function a = pvaf_distance_riemann(A,B,p)

   A = pvaf_my_regularization_I(A,p);
   B = pvaf_my_regularization_I(B,p);
   a = sqrt(sum(log(eig(A,B)).^2));

   disp(a);
end