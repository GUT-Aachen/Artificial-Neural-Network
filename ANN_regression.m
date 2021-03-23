function [ net,TrResult ] = ANN_regression( TrainData,TrainTarget,Flag )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
       si=[8 10 18 16];  
       TF1 = 'tansig';   % {tansig, logsig, purelin} ==> Transfer Function for first hidden layer
       TF2 = 'tansig';   % {tansig, logsig, purelin} ==> Transfer Function for second hidden layer
       TF3 = 'purelin';   % {tansig, logsig, purelin} ==> Transfer Function for second hidden layer
       BTF = 'trainlm';  % train+{bfg, br, cgb, cgf, cgp, gd, gdm, gda, gdx, lm, oss, r, rp, scg}, ==> Train Function
       PF = 'msereg';    % Performance Metric for MLP
      net = newff(TrainData',TrainTarget',si,{TF1 TF3 TF2},BTF,PF);
      net.trainparam.epochs =1000;
      net.trainparam.goal = 0.000001;
%       net.trainparam.mu = 0.001;
%       net.trainparam.mu_dec = 0.001;
%       net.trainparam.mu_inc = 0.001;
%       net.trainparam.mu_max = 0.001;
%       net.trainparam.mem_reduc = 0.001;
%       net.trainparam.Max_perf_inc = 1.004;

%       net.trainparam.Lr = 0.02;
%       net.trainparam.Lr_dec = 0.05;
%       net.trainparam.Lr_inc = 1.05;
        net.divideparam.trainRatio = 50;
        net.divideparam.valRatio = 25;
        net.divideparam.testRatio = 25;
        
        net.performParam.regularization=0.01;
      
      net.performFcn=PF;
      net=init(net); %initialising the weight and bias wectors
      net=train(net,TrainData',TrainTarget'); %training the network
      Predicted=sim(net,TrainData'); %simulation the network
      TrResult.MSE=mse(Predicted'-TrainTarget);
      TrResult.RMSE=sqrt(mse(Predicted'-TrainTarget));
      TrResult.CORR=corr2(Predicted',TrainTarget);
      TrResult.R2=rsquare(Predicted',TrainTarget);
      if Flag
          view(net)
          figure
          PlotResults(Predicted', TrainTarget, 'Train Data')
      end
end