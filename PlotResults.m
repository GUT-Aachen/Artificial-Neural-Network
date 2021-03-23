function PlotResults(targets, outputs, Name)

    errors=targets-outputs;
    
    MSE=mean(errors.^2);
    RMSE=sqrt(MSE);
    
    subplot(2,1,1);
    plot(targets,'k');
    hold on;
    plot(outputs,'r');
    legend('Target','Output');
    title(Name);
    xlabel('Sample Index');
    grid on;

    subplot(2,1,2);
    plot(errors);
    legend('Error');
    title(['MSE = ' num2str(MSE) ', RMSE = ' num2str(RMSE)]);
    grid on;

    
    figure
    plotregression(targets, outputs)


end