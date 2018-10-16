// =========
// JACOBIAN
// =========
Jacobian {
  { Name JVol ; Case { { Region All ; Jacobian Vol ; } } }
  { Name JSur ; Case { { Region All ; Jacobian Sur ; } } }
}

// ======================
// INTEGRATION PARAMETERS
// ======================
Integration {
  { Name I1 ;
    Case {
      { Type Gauss ;
        Case {
          { GeoElement Point ; NumberOfPoints  1 ; }
          { GeoElement Line ; NumberOfPoints  4 ; }
          { GeoElement Triangle ; NumberOfPoints  6 ; }
          { GeoElement Quadrangle ; NumberOfPoints 7 ; }
          { GeoElement Tetrahedron ; NumberOfPoints 15 ; }
          { GeoElement Hexahedron ; NumberOfPoints 34 ; }
        }
      }
    }
  }
}

// ==============
// FUNCTION SPACE
// ==============

FunctionSpace{
  {Name H_grad; Type Form0;
    BasisFunction{
      {Name u; NameOfCoef ui; Function BF_Node;
	Support Region[{Omega, GammaInf}]; Entity NodesOf[All];}
    }
    Constraint{
      }
  }
}//End FunctionSpace

// ============
// FORMULATIONS
// ============
Formulation {
  // Formulation for a Dirichlet boundary condition
  { Name Helmholtz; Type FemEquation;
    Quantity{
      { Name u ; Type Local; NameOfSpace H_grad;}
    }
    Equation{
      //Helmholtz equation
      Galerkin{[Dof{Grad u}, {Grad u}];
	In Omega; Jacobian JVol; Integration I1;}
      Galerkin{[-k^2*n[]^2*Dof{u}, {u}];
	In Omega; Jacobian JVol; Integration I1;}
      Galerkin{[-f[], {u}];
	In Source; Jacobian JVol; Integration I1;}

      //Sommerfeld radiation condition (approx.)
      Galerkin{[-I[]*k*n[]*Dof{u}, {u}];
	In GammaInf; Jacobian JSur; Integration I1;}

    }
  }
}//End Formulation

// ===========
// RESOLUTIONS
// ===========
Resolution{
  {Name WiFi;
    System{ {Name A; NameOfFormulation Helmholtz; Type Complex; } }
    Operation{
      Generate[A]; 
      Solve[A];
    }
  }
} // End Resolution


// ================
// POST-PROCESSINGS
// ================
PostProcessing{
  {Name Wave; NameOfFormulation Helmholtz;
    Quantity {
      {Name u; Value {Local { [{u}] ; In Omega; Jacobian JVol; }}}
      {Name uNorm; Value {Local { [Norm[{u}]] ; In Omega; Jacobian JVol; }}}
    }
  }
} // End Postprocessing.

// ===============
// POST-OPERATIONS
// ===============

PostOperation{
  {Name Wave; NameOfPostProcessing Wave ;
    Operation {
      Print [u, OnElementsOf Omega, File "u.pos"];
      Print [uNorm, OnElementsOf Omega, File "u_Abs.pos"];
    }
  }
} // End PostOperation
