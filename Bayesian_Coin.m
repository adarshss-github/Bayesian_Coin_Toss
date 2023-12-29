
%===========================================================================================================================================================
%***********************************************************************************************************************************************************
%
%                                      --------------------------------------------------
%                                                          PREAMBLE
%                                      --------------------------------------------------
%
%
%By Adarsh S, Ph.D. Candidate IIT Kanpur
%Email: adarshss@gmail.com
%
%Script description:
%-----------------------
%This MATLAB script demonstrates Bayesian updating for evaluating the bias
%of a coin. A triangular prior PDF is assumed and the peak of the prior can
%be set to an arbirary value. The bias is set upfront and the a set number of coin flip
%are simulated. The prior PDFs are successively updated by using the
%results from the flip to get the posteriror PDF of the bias, through Bayes
%theorem.
%
%
%Note:
%------ 
%The updated priors after each flip is stored in prior_PH_MAST
%The otcomes of the trials are stored in Flips (1 for heads and 0 for tails)
% After running Section 1, one may proceed to evaluate Sections 2 and 3 to
% plot the results
%
%                                      -----------------------------------------------
%                            *********|| All rights reserved; Adarsh S; October, 2019 || *********
%                                      -----------------------------------------------
%
%
%***********************************************************************************************************************************************************
%===========================================================================================================================================================



%%
%===========================================================================================================================================================
%===========================================================================================================================================================
clear all 
clc
%SECTION 1:
%-----------
%This section simulates the coin flips and updates the prior PDFs by Bayes
%theorem

%1) Set Bias of coin (say Head)
%------------------------------
%------------------------------
bias_Coin = 0.1 ;
%2) Set number of coin flips
%------------------------------
%------------------------------
coin_Flips = 1000 ;
%3) Set peak of traingular prior PDF
%------------------------------
%------------------------------
peak_Prior = 0.9 ;
%------------------------------
%------------------------------

PH = 0:0.001:1 ;
prior_PH = zeros(1,length(PH)) ;

for i = 1:1:length(PH)

%prior_PH(i) = prior_PH_TRI(PH(i)) ;
 %prior_PH(i) = prior_PH_UN(PH(i)) ;
prior_PH(i) = prior_P1_TRI_bia(PH(i),peak_Prior) ; %Peak of prior

end

%trapz(PH,prior_PH) ;

Tria = coin_Flips ; % Number of flips
prior_PH_MAST = zeros(1,length(PH),Tria) ;
post_PH = zeros(1,length(PH),Tria) ;
lik_PH = zeros(1,length(PH),Tria) ;
prior_PH_MAST(1,:,1) = prior_PH ;
NH = zeros(1,Tria) ;

bias_PH = bias_Coin ; %Bias of coin
Flips = double(rand(Tria,1) < bias_PH) ;
Flips = Flips' ;

for i = 1:1:Tria 

NH(i) = length(find(Flips(1:i)==1)) ;

   for j = 1:1:length(PH)

       lik_PH(1,j,i) = like_PH(i,NH(i),PH(j)) ;
       i
       j

   end


post_PH(1,:,i) =  (prior_PH_MAST(1,:,i).*lik_PH(1,:,i))/trapz(PH,prior_PH_MAST(1,:,i).*lik_PH(1,:,i))  ;

if i<Tria

prior_PH_MAST(1,:,i+1) = post_PH(1,:,i) ;

end

end

%===========================================================================================================================================================
%===========================================================================================================================================================

%%
%===========================================================================================================================================================
%===========================================================================================================================================================

%SECTION 2 (plots):
%-----------
%This section plots the updated prior PDFs after each flip

for i = 1:1:Tria
figure(1)
    plot(PH, prior_PH_MAST(1,:,i),'LineWidth',2,'Color',[0.6350 0.0780 0.1840])
    title(sprintf('Flip %d out of %d', i, Tria ),'FontSize',15,'FontName','Times New Roman')
    xlabel('$P_H$','interpreter','latex','FontSize',15,'FontName','Times New Roman')
     ylabel('$p(P_H)$','interpreter','latex','FontSize',15,'FontName','Times New Roman')
    set(gca,'Xtick',0:0.1:1,'fontname','times')
    ax = gca;
ax.XRuler.TickLabelInterpreter = 'tex';
ax.FontSize = 15;
ax.TickLength = [0.02,0] ;
  ax.LineWidth = 2;
    drawnow

 
end
%===========================================================================================================================================================
%===========================================================================================================================================================

%%
% %===========================================================================================================================================================
% %===========================================================================================================================================================
% 
% %SECTION 3 (plots):
% %----------
% %This section plots the comparison of probability estimated through
% %Bayesian and frequentist approaches
% 
for i  = 1:1:Tria
figure(1)

[~,I] = max(prior_PH_MAST(1,:,i)) ;
  % [~,I] = max(post_PH(1,:,i)) ;
    PHB = PH(I) ;
    PTB = 1 - PHB ;

    PHF = NH(i)/i ;
    PTF = 1 - PHF ;

    bar([PHB PTB; PHF PTF],'LineWidth',1.5) ;
    xticklabels({'Bayesian','Frequentist'})
    title(sprintf('Flip %d out of %d', i, Tria ))
     ylabel('Bias','FontSize',15,'FontName','Times New Roman')
     legend('H','T')
     legend('boxoff');
      legend('Location', 'eastoutside');
        set(gca,'fontname','times')
    ax = gca;
ax.XRuler.TickLabelInterpreter = 'tex';
ax.FontSize = 20;
ax.TickLength = [0.02,0] ;
  ax.LineWidth = 2;
    drawnow

end
% 
% %===========================================================================================================================================================
% %===========================================================================================================================================================



