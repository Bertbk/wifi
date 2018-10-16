porte = 0.8;
couloir_y = 0.7;
Long = 7;
Larg = 5;

DefineConstant[
  d = {0.15, Min 0.1, Max 0.2, Step 0.01, Name '0Geo/Wall Thickness'},
  salon_x = {3.5, Min 2, Max 3.5, Step 0.1, Name '0Geo/Living Room (x-length)'},
  entree_x = {1, Min 0.5, Max 1.5, Step 0.1, Name '0Geo/Hall (x-length)'},
  cuisine_x = {1.5, Min 1, Max 2, Step 0.1, Name '0Geo/Kitchen (x-length)'},
  sdb_y = {1.5, Name '0Geo/Bathroom (y-length)', Visible 0, ReadOnly 1}
  es = {0.1, Min 0.1, Max 0.1, Step 0.1, Name '5Routeur/Radius', ReadOnly 1},
  xs = {2*es, Min 2*es, Max Long-2*es, Step 0.1, Name '5Routeur/X'},
  ys = {2*es, Min 2*es, Max Larg-2*es, Step 0.1, Name '5Routeur/Y'},
  Freq = {1, Min 0.5, Max 2.5, Step 0.1, Name '8Wave/Frequency (GHz)'},
  c_light =  {299792458, Name '8Wave/Speed of light', ReadOnly 1},
  k = {2*Pi*Freq*1e9/c_light, Name '8Wave/Wavenumber k', ReadOnly 1},
  nLambda = {10, Min 10, Max 20, Step 1, Name '8Wave/Nlambda (precision)'}
];
