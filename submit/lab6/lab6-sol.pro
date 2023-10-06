  sum_lengths([], 0).
  sum_lengths([X|Xs], Sum):-
   sum_lengths(Xs, XsSum),
   length(X,L),
   Sum is L + XsSum.


   quadratic_roots(A,B,C,Z):-
     Discr is sqrt((B*B)-(4*A*C)),
     Z is (((-1 * B) + Discr)/ (2*A)).
  
   quadratic_roots(A,B,C,Z):-
     Discr is sqrt((B*B)-(4*A*C)),
     Z is ((-1 * B) - Discr) / (2*A).

   quadratic_roots2(A,B,C,Z):-
   Discr is sqrt((B*B)-(4*A*C)),
   quadratic_roots2(A, B, C, Discr, Z).

   quadratic_roots2(A, B, C, Discr, Z):-
    Z is (((-1 * B) + Discr)/ (2*A)).

  quadratic_roots2(A, B, C, Discr, Z):-
    Z is (((-1 * B) - Discr)/ (2*A)).