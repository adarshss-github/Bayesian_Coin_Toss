function p_PH = prior_P1_TRI_bia(PH,b)

if PH >= 0 && PH <= b  

    p_PH = 2/b*PH ;

elseif PH > b && PH <= 1

    p_PH = 2/(1-b)*(1-PH) ;

end

end



