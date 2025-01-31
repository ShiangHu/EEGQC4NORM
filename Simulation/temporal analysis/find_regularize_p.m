function p = find_regularize_p(matrix)
   e = real(eig(matrix));
   p = abs(min(e))+1;
   disp(p);
   p = ceil(p);
end

