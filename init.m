%-----------------------------------
%
%  this file holds the parameters 
%  defining the kinematic structure
%  in Denavit-Hartenbarg terms
%
%-----------------------------------

clear all; clc;

%% The denavit-hartenberg defines each frame as a homognous transformation
% definded by:
%               Ai=Rot_z(theta)Trans_z(d)Trans_x(a)Rot_x(alpha)
%

%clear all;clc;

d2r=pi/180;
r2d=180/pi;
n=6;



% Tbi is the parent class of all transformations from body to frame i -
% with both homoegneous, rotation and position matrices/vectors
Tbi=struct('gbi',zeros(4,4,n),'Rbi', zeros(3,3,n),'pbi', zeros(3,1,n),'Adgbi',zeros(6,6,n));

%Tbi.gbi=struct('gb1',zeros(4,4),'gb2',zeros(4,4),'gb3',zeros(4,4),'gb4',zeros(4,4),'gb5',zeros(4,4),'gb6',zeros(4,4));
% Tbi.Rbi=struct('Rb1',zeros(3,3),'Rb2',zeros(3,3),'Rb3',zeros(3,3),'Rb4',zeros(3,3),'Rb5',zeros(3,3),'Rb6',zeros(3,3)); %, 'names', ['Rb1','Rb2','Rb3','Rb4','Rb5','Rb6']);
% Tbi.pbi=struct('pb1',zeros(3,1),'pb2',zeros(3,1),'pb3',zeros(3,1),'pb4',zeros(3,1),'pb5',zeros(3,1),'pb6',zeros(3,1));%  , 'names',['pb1','pb2','pb3','pb4','pb5','pb6']);
% Tbi.Adgbi=struct('Adgb1',zeros(6,6),'Adgb2',zeros(6,6),'Adgb3',zeros(6,6),'Adgb4',zeros(6,6),'Adgb5',zeros(6,6),'Adgb6',zeros(6,6));%  ,'names', ['Adgb1','Adgb2','Adgb3','Adgb4','Adgb5','Adgb6']);




DH=struct('a',zeros(n,1),'d',zeros(n,1),'alpha',zeros(n,1));
DH.a(1) = 0.2;
DH.a(2) = 1;
DH.a(3) = 0.6;
DH.a(4) = 0.4;
DH.a(5) = 0;
DH.a(6) = 0;

DH.d(1) = 0;
DH.d(2) = 0;
DH.d(3) = 0;
DH.d(4) = 0;
DH.d(5) = 0;
DH.d(6) = 0.4;

DH.alpha(1) = pi/2;
DH.alpha(2) = 0;
DH.alpha(3) = 0;
DH.alpha(4) = -pi/2;
DH.alpha(5) = -pi/2;
DH.alpha(6) = 0;

busInfo = Simulink.Bus.createObject(DH);
busInfo2 = Simulink.Bus.createObject(Tbi);

%% joint limits - global parameters 

global qmin;
global qmax;

qmin(1)=-70*(pi/180);
qmax(1)=70*(pi/180);

qmin(2)=-70*(pi/180);
qmax(2)=70*(pi/180);

qmin(3)=-70*(pi/180);
qmax(3)=70*(pi/180);

qmin(4)=-70*(pi/180);
qmax(4)=70*(pi/180);

qmin(5)=90*(pi/180) - 70*(pi/180);
qmax(5)=70*(pi/180) + 90*(pi/180);

qmin(6)=-160*(pi/180);
qmax(6)=160*(pi/180);




%% set robot configurations
global six_link;

for i =1:6
    l(i) = Link([0, DH.d(i), DH.a(i), DH.alpha(i)]);
end


six_link = SerialLink(l,'name','six link');
 


aq=[0,3,0,0,0,1];

six_link.fkine(aq)



%%

sim('uvms',1)





