
clc;clear;close all

cd '/home/hadiabmontero/1D_PDAF/inputs_offline'

addpath('/home/hadiabmontero/1D_PDAF/inputs_offline')

num_ens=10;

% Load ensembles
tau_ens={};
vy_ens={};
tau_ens_mean=zeros(201,1);
vy_ens_mean=zeros(202,1);

for i=1:num_ens
    vy_ens{i}=load(strcat('ens_',num2str(i),'_vy.txt'));
    tau_ens{i}=load(strcat('ens_',num2str(i),'_tau.txt'));
    
    vy_ens_mean=vy_ens_mean+vy_ens{i};
    tau_ens_mean=tau_ens_mean+tau_ens{i};
end

vy_ens_mean=(1/num_ens)*vy_ens_mean;
tau_ens_mean=(1/num_ens)*tau_ens_mean;


% Load initial condition
load('state_init_tau.txt')
load('state_init_vy.txt')

% Load truth
load('init_tau_truth.txt')
load('init_vy_truth.txt')

% Load obs
load('obs_tau.txt')

obs_tau_vect=ones(201,1).*(-999);
obs_tau_vect(1,1)=obs_tau;

figure (1)

z_tau=1:1:201;
z_vy=1:1:202;



for i=1:num_ens
    scatter(tau_ens{i},z_tau)
    scatter(tau_ens_mean,z_tau,'k','filled')
    scatter(init_tau_truth,z_tau,'b','filled')
    scatter(obs_tau_vect,z_tau,'r','filled')
    
    hold on
   
    tau_vect(i)=tau_ens{1,i}(1);
end

figure (2)

histogram(tau_vect,12)

    
figure (3)
for i=1:num_ens 
    scatter(vy_ens{i},z_vy)
    scatter(vy_ens_mean,z_vy,'k','filled')
    scatter(init_vy_truth,z_vy,'b','filled')
end

% init_tau_truth=zeros(201,1);
% init_tau_truth(:)=38*1e6;
% 

% Save observation

% obs_tau=init_tau_truth(1)+normrnd(0,1*1e6,1);
% dlmwrite('obs_tau.txt',obs_tau);