clc
close all


mdlPlant = 'mpc_pendcartPlant';
load_system(mdlPlant)
open_system([mdlPlant '/Pendulum and Cart System'],'force')


mdlMPC = 'Mpc';
open_system(mdlMPC)


io(1) = linio([mdlPlant '/dF'],1,'openinput');
io(2) = linio([mdlPlant '/F'],1,'openinput');
io(3) = linio([mdlPlant '/Pendulum and Cart System'],1,'openoutput');
io(4) = linio([mdlPlant '/Pendulum and Cart System'],3,'openoutput');


opspec = operspec(mdlPlant);
opspec.States(1).Known = true; 
opspec.States(1).x = 0;

opspec.States(3).Known = true;
opspec.States(3).x = 0;     


options = findopOptions('DisplayReport',false);
op = findop(mdlPlant,opspec,options);

plant = linearize(mdlPlant,op,io);
plant.InputName = {'dF';'F'};
plant.OutputName = {'x';'theta'};

pole(plant)
bdclose(mdlPlant)


plant = setmpcsignals(plant,'ud',1,'mv',2);


Ts = 0.01;
PredictionHorizon = 50;
ControlHorizon = 5;
mpcobj = mpc(plant,Ts,PredictionHorizon,ControlHorizon);

mpcobj.MV.Min = -100;
mpcobj.MV.Max = 100;
mpcobj.OV(2).Min = -pi/2;
mpcobj.OV(2).Max = pi/2;
mpcobj.Weights.ECR = 100;



mpcobj.MV.ScaleFactor = 100;


mpcobj.Weights.MVRate =2; 
mpcobj.OV(1).Min = 0;  % Limite inferiore per la posizione del carrello (x = 0)
mpcobj.OV(1).Max = 0;  % Limite superiore per la posizione del carrello (x = 0)

mpcobj.Weights.OV = [4 3];


disturbance_model = getindist(mpcobj);
setindist(mpcobj,'model',disturbance_model*10);


disturbance_model = getoutdist(mpcobj);
setoutdist(mpcobj,'model',disturbance_model*10);

% Parametri del controllo MPC
Ts = mpcobj.Ts;
PredictionHorizon = mpcobj.PredictionHorizon;
ControlHorizon = mpcobj.ControlHorizon;
MV_Min = mpcobj.MV.Min;
MV_Max = mpcobj.MV.Max;
OV_Weights = mpcobj.Weights.OV;
MVRate_Weight = mpcobj.Weights.MVRate;
ECR_Weight = mpcobj.Weights.ECR;

% Tabella dei parametri
fprintf('--- Parametri MPC ---\n');
fprintf('Ts: %.3f s\n', Ts);
fprintf('Prediction Horizon: %d\n', PredictionHorizon);
fprintf('Control Horizon: %d\n', ControlHorizon);
fprintf('Minimo Input (MV): %.2f\n', MV_Min);
fprintf('Massimo Input (MV): %.2f\n', MV_Max);
fprintf('Penalizzazione MVRate: %.2f\n', MVRate_Weight);
fprintf('Penalizzazione ECR: %.2f\n', ECR_Weight);
fprintf('Penalizzazioni OV: [%.2f, %.2f]\n', OV_Weights(1), OV_Weights(2));

% Matrici di penalizzazione Q e R
Q = diag(mpcobj.Weights.OV); % Matrice di pesi sullo stato
R = diag(mpcobj.Weights.MVRate); % Matrice di pesi sul controllo

fprintf('\n--- Matrici Q e R ---\n');
disp('Matrice Q (penalizzazione stato):');
disp(Q);
disp('Matrice R (penalizzazione input):');
disp(R);

open_system([mdlMPC '/System/Graph'])
sim(mdlMPC)


