// data contains some usefull values (e.g. the wavenumber)
Include "wifi_data.pro";
// =======
// GROUPS
// =======
Group{
  GammaInf = Region[10];
  //propagation domain
  Air = Region[{1,3}];
  Concrete = Region[{2}];
  Omega = Region[{1,2,3}];
  Source = Region[{3}];
}

// ========
// Functions
Function {
  I[] = Complex[0., 1.] ; // sqrt(-1)

  DefineConstant[
    xs = {0.2, Min 0.2, Max Long-0.2, Step 0.1, Name 'Source x'},
    ys = {0.2, Min 0.2, Max Larg-0.2, Step 0.1, Name 'Source y'}
  ];
  
  n[Air] = 1; // Air
  n[Concrete] = 2.55 + 0.01*I[]; // Concrete
  n[GammaInf] = 2.55 + 0.01*I[]; // Concrete (infty)
  
  XYZ_source[] = Vector[xs, ys, 0];
  rs[] = Sqrt[(X[] - xs)^2 + (Y[] - ys)^2];
  f[Source] = 3/Pi/es/es*(1-rs[]/es);
}
Include "helmholtz.pro";

//GetDP parameters (hidden)
DefineConstant[
  R_ = {"WiFi", Name "GetDP/1ResolutionChoices", Visible 0},
  C_ = {"-solve -pos -v 2", Name "GetDP/9ComputeCommand", Visible 0},
  P_ = {"Wave", Name "GetDP/2PostOperationChoices", Visible 0}
];
