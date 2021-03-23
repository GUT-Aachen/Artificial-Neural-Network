clc
clear all
close all
warning off
%% Read Data
AllData=xlsread('AllData.xlsx');
[Row, Col] = size(AllData);
%% Normalization 
Data=AllData(:,1:end-1);
Data=mapminmax(Data',0,1)';
AllData(:,1:end-1)=Data;
%%
RandInd=randperm(Row);
AllData=AllData(RandInd,:);
%% Make Train and Test Set (Train Set = 70%, Test Set = 30%)
TrainInfo=AllData(1:ceil(0.7*Row),:);
TestInfo=AllData(ceil(0.7*Row)+1:end,:);
%% 
TrainTarget=TrainInfo(:,end); % Ar
TrainData=TrainInfo(:,1:end-1); % Parameters

TestTarget=TestInfo(:,end);
TestData=TestInfo(:,1:end-1);
% [Row,Col]=size(TrainData);


%% Determine New Data
SelectedParam=[1 2 3 4 5 6];
TrainData=TrainData(:,SelectedParam);
TestData=TestData(:,SelectedParam);
%% Make ANN Model
Plot=1; % 1. show net and Train Result , 0: Don't Show
[ AnnModel,TrResult ] = ANN_regression( TrainData,TrainTarget,Plot );
%%
  Predicted=sim(AnnModel,TestData'); %simulation the network
  TeResult.MSE=mse(Predicted'-TestTarget);
  TeResult.RMSE=sqrt(mse(Predicted'-TestTarget));
  TeResult.CORR=corr2(Predicted',TestTarget);
  TeResult.R2 = rsquare(Predicted',TestTarget);
  figure
  PlotResults(Predicted', TestTarget, 'Test Data')
  %%
  xlswrite('R2.xlsx',[Predicted', TestTarget, Predicted'-TestTarget]);