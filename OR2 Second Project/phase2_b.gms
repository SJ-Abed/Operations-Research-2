Sets
i Companies /CA, NY, WA,TX, FL/
j Warehouses/Warehouse1,Warehouse2,Warehouse3/
k Customers /Customer1,Customer2,Customer3,Customer4/;

parameters C(i) Capacity of each company;
$call gdxxrw.exe C:\Users\sabed\Documents\gamsdir\projdir\Phase2_Data_OR2.xlsx par=C Rng=Capacity!C5:G6 cdim=1
$gdxin Phase2_Data_OR2.gdx
$load C
$gdxin
;
parameters D(k) Demand of each customer;
$call gdxxrw.exe C:\Users\sabed\Documents\gamsdir\projdir\Phase2_Data_OR2.xlsx par=D Rng=Demand!C7:F8 cdim=1
$gdxin Phase2_Data_OR2.gdx
$load D
$gdxin
;
parameters PC(i,j) Cost of Production and inventory;
$call gdxxrw.exe C:\Users\sabed\Documents\gamsdir\projdir\Phase2_Data_OR2.xlsx par=PC Rng=Cost_W!B4:E9 rdim=1 cdim=1
$gdxin Phase2_Data_OR2.gdx
$load PC
$gdxin
;
parameters SC(j,k) Cost of Production and inventory;
$call gdxxrw.exe C:\Users\sabed\Documents\gamsdir\projdir\Phase2_Data_OR2.xlsx par=SC Rng=Cost_C!B5:F8 rdim=1 cdim=1
$gdxin Phase2_Data_OR2.gdx
$load SC
$gdxin
;
parameters yC(i) fixed cost of each company;
$call gdxxrw.exe C:\Users\sabed\Documents\gamsdir\projdir\Phase2_Data_OR2.xlsx par=yC Rng=Cost_F!B5:C9 rdim=1
$gdxin Phase2_Data_OR2.gdx
$load yC
$gdxin
;
parameters wC(j) fixed cost of each warehouse;
$call gdxxrw.exe C:\Users\sabed\Documents\gamsdir\projdir\Phase2_Data_OR2.xlsx par=wC Rng=Cost_F!B10:C12 rdim=1
$gdxin Phase2_Data_OR2.gdx
$load wC
$gdxin
;

Variables
z Goal
y(i) company initialize
w(j) warehouse initialize
P(i,j) tonnage of production
S(j,k) tonnage of Supply
;
positive variable
P
S;
binary variable
y
w;

equations
cost objective func
capacity_limit(i)
demand_supplies(k)
inventory(j)
warehouse_initialize(j);
cost .. z=e=100*sum((i,j),P(i,j)*PC(i,j))+sum((j,k),S(j,k)*SC(j,k))+1000*sum(i,y(i)*yC(i))+1000*sum(j,w(j)*wC(j));
capacity_limit(i) .. sum(j,P(i,j))=l=C(i)*y(i);
demand_supplies(k) .. sum(j,S(j,k))=e=D(k);
inventory(j) .. sum(k,S(j,k))=l=sum(i,P(i,j));
warehouse_initialize(j) .. sum(i,P(i,j))=l=w(j)*900;

model main/all/;
solve main using mip minimizing z;
display Z.l,P.l,S.l,y.l,w.l,P.m,S.m,z.m;

execute_unload"Phase2_Data_OR2.gdx" z, P, S;
execute'gdxxrw.exe  Phase2_Data_OR2.gdx o=Phase2_Data_OR2.xlsx var=z Rng=z!b2'
execute'gdxxrw.exe  Phase2_Data_OR2.gdx o=Phase2_Data_OR2.xlsx var=P Rng=p!b2'
execute'gdxxrw.exe  Phase2_Data_OR2.gdx o=Phase2_Data_OR2.xlsx var=S Rng=s!b2'
