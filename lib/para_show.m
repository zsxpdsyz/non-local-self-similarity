addpath(genpath('lib'));
addpath(genpath('results'));

figure(1);
plot(Out1{1}.PSNR,'LineWidth',1.5);legend('\rho=10');hold on;
plot(Out1{2}.PSNR,'LineWidth',1.5);legend('\rho=20');hold on;
plot(Out1{3}.PSNR,'LineWidth',1.5);legend('\rho=30');hold on;
plot(Out1{4}.PSNR,'LineWidth',1.5);legend('\rho=40');hold on;
plot(Out1{5}.PSNR,'LineWidth',1.5);legend('\rho=50');hold on;
%plot(Out1{6}.PSNR,'LineWidth',1.5);legend('\rho=10');hold on;
%plot(Out1{7}.PSNR,'LineWidth',1.5);legend('\rho=100');hold on;
%plot(Out1{8}.PSNR,'LineWidth',1.5);legend('\rho=50');hold on;
%plot(Out1{9}.PSNR,'LineWidth',1.5);legend('\rho=50');hold on;
%plot(Out1{10}.PSNR,'LineWidth',1.5);legend('\rho=50');hold on;
%plot(Out1{11}.PSNR,'LineWidth',1.5);legend('\rho=50');hold on;
%plot(Out1{12}.PSNR,'LineWidth',1.5);legend('\rho=50');hold on;

legend('0.01','0.005', '0.1', '0.2', '0.3', '0.4', '0.5', '0.6','0.7', '0.8', '0.9', '1.0');
xlabel('Iteration');
ylabel('PSNR');