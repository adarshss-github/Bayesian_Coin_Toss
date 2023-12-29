function L_PH = like_PH(N,NH,PH)

L_PH = nchoosek(N,NH)*(PH)^NH*(1-PH)^(N-NH) ;

end
