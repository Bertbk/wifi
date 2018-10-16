Include "wifi_data.pro";

lambda=  2*Pi/k;
h = lambda / nLambda;

p = newp; Point(p) = {0, 0, 0,h};
p = newp; Point(p) = {salon_x, 0, 0,h};
p = newp; Point(p) = {salon_x, sdb_y, 0,h};
p = newp; Point(p) = {salon_x + d, sdb_y, 0,h};
p = newp; Point(p) = {salon_x + d, 0, 0,h};
p = newp; Point(p) = {salon_x + d + entree_x, 0, 0,h};
p = newp; Point(p) = {salon_x + d + entree_x, sdb_y, 0,h};
p = newp; Point(p) = {salon_x + d + entree_x + d + 0.5, sdb_y, 0,h};
p = newp; Point(p) = {salon_x + d + entree_x + d + 0.5, sdb_y - d, 0,h};
p = newp; Point(p) = {salon_x + d + entree_x + d, sdb_y - d, 0,h};
p = newp; Point(p) = {salon_x + d + entree_x + d, 0, 0,h};
p = newp; Point(p) = {Long, 0, 0,h};
p = newp; Point(p) = {Long, sdb_y-d, 0,h};
p = newp; Point(p) = {salon_x + d + entree_x + d + 0.5 + porte, sdb_y - d, 0,h};
p = newp; Point(p) = {salon_x + d + entree_x + d + 0.5 + porte, sdb_y, 0,h};
p = newp; Point(p) = {Long, sdb_y, 0,h};
p = newp; Point(p) = {Long, sdb_y + couloir_y, 0,h};
p = newp; Point(p) = {cuisine_x + 2*d + salon_x + porte, sdb_y + couloir_y, 0, h};
p = newp; Point(p) = {cuisine_x + 2*d + salon_x + porte, sdb_y + couloir_y + d, 0, h};
p = newp; Point(p) = {Long, sdb_y + couloir_y + d, 0,h};
p = newp; Point(p) = {Long, Larg, 0,h};
p = newp; Point(p) = {cuisine_x + 2*d + salon_x, Larg , 0, h};
p = newp; Point(p) = {cuisine_x + 2*d + salon_x, sdb_y+couloir_y, 0, h};
p = newp; Point(p) = {cuisine_x + d +salon_x, sdb_y+couloir_y, 0, h};
p = newp; Point(p) = {cuisine_x + d +salon_x, Larg, 0, h};
p = newp; Point(p) = {d + salon_x, Larg, 0, h};
p = newp; Point(p) = {d + salon_x, sdb_y+couloir_y +d, 0, h};
p = newp; Point(p) = {cuisine_x + d +salon_x - porte, sdb_y + couloir_y + d, 0, h};
p = newp; Point(p) = {cuisine_x + d +salon_x - porte, sdb_y + couloir_y, 0, h};
p = newp; Point(p) = {salon_x, sdb_y+couloir_y, 0, h};
p = newp; Point(p) = {salon_x, Larg, 0, h};
p = newp; Point(p) = {0, Larg, 0, h};

For i In {1:p-1}
  l = newl; Line(l) = {i,i+1};
EndFor
l = newl; Line(l) = {p,1};

Line Loop(1) = {1:p};

//Bord
pb = newp; Point(pb) = {0-d, 0-d, 0, h};
pb = newp; Point(pb) = {Long+d, 0-d, 0, h};
pb = newp; Point(pb) = {Long+d, Larg+d, 0, h};
pb = newp; Point(pb) = {0-d, Larg+d, 0, h};

lb = newl; Line(lb) = {p+1,p+2};
lb = newl; Line(lb) = {p+2,p+3};
lb = newl; Line(lb) = {p+3,p+4};
lb = newl; Line(lb) = {p+4,p+1};

Line Loop(2) = {l+1:l+4};

//Source
Point(1000) = {xs, ys,0,h};
Point(1001) = {xs+es, ys,0,h};
Point(1002) = {xs, ys+es,0,h};
Point(1003) = {xs-es, ys,0,h};
Point(1004) = {xs, ys-es,0,h};
Circle(1000) = {1001, 1000, 1002};
Circle(1001) = {1002, 1000, 1003};
Circle(1002) = {1003, 1000, 1004};
Circle(1003) = {1004, 1000, 1001};

Line Loop(3) = {1000,1001,1002,1003};

Plane Surface(1) = {1,3};
Plane Surface(2) = {2,1};
Plane Surface(3) = {3};

Physical Surface(1) = {1};
Physical Surface(2) = {2};
Physical Surface(3) = {3};
Physical Line(10) = {l+1:l+4};
