# Wi-Fi waves in a flat

This model uses [onelab](https://onelab.info) to simulate the propagation of a Wi-Fi waves in a flat.


## How to use it?

1. Download the [Onelab bundle](https://onelab.info)
2. Download this code
3. Move the binaries `gmsh` and `getdp` into the folder of the code
4. Launch it
    ```bash
    gmsh wifi.pro
    ```
5. Click on run and have fun

Within the graphical interface, it is possible to :

- Modify (a little) the geometry
- Increase the precision (mesh refinement) `NLambda` (between 10 and 20)
- Increase the frequency (set at 1GHz by default). Be **careful**, a simulation with a 2.5GHz frequency is very costly and it can lead to a **computer crash**! Do not complain if you didn't read the README before launching it...


## Mathematical Model

### Helmholtz equation

Mathematically, a wave $\mathscr{E}(\mathbf{x},t)$ depends on both time $t$ and space $\mathbf{x}$, and satisfies the *wave equation*:

$$
\Delta \mathscr{E}(\mathbf{x},t) = \frac{1}{c^2}\frac{\partial^2 \mathscr{E}}{\partial t^2}(\mathbf{x},t),
$$
where $c$ is the celerity of the wave in the medium (which can depends on the position $\mathbf{x}$!). For example,,in the case of an electromagnetic wave and in the vaccuum, $c$ is the speed of light: $299792458\mathrm{m.s}^{-1}$. The quantity $\mathbf{x}$ is here a vector of dimension $d=2$.

When excited by a time-harmonic source, that is when the pulsation $\omega$ (in $\mathrm{rad.s}^{-1}$) of the wave is constant, then the waves reads as $\mathscr{E}(\mathbf{x},t) = \Re\left(u(\mathbf{x})e^{-\imath \omega t}\right)$ where $\imath=\sqrt{-1}$ and the *spatial wave*  $E$ is solution of the Helmholtz equation:

$$
\Delta E + \frac{\omega^2}{c^2}E = f.
$$
This equation is obtained by replacing $\mathscr{E}(\mathbf{x},t)$ by $E(\mathbf{x})e^{-\imath \omega t}$ in the wave equation. In general, the wavenumber $k = \frac{\omega}{c}$ (in $\mathrm{rad.m}^{-1}$) and the wavelength $\lambda = \frac{2\pi}{k}$ (in $\mathrm{m}$) are introduced so that the Helmholtz equation becomes:

$$
\Delta E + k^2E = f.
$$
The source $f$ is spatial only and in the case of a point source located in $\mathbf{s}$, the quantity $f$ is a Dirac delta function:
$$
\Delta E + k^2E = -\delta_{\mathbf{s}}.
$$

Wi-Fi waves that follow the [IEEE 802.11g norm](\url{https://en.wikipedia.org/wiki/IEEE_802.11) have a frequency between 2.4GHz and 2.5GHz. 

### The flat

The Wi-Fi router is located in a flat denoted by $\Omega$. The walls are supposed to be drywall. The domain $\Omega = \Omega_{air}\cup\Omega_{walls}$ is decomposed in two parts: the air $\Omega_{air}$ and the walls $\Omega_{walls}$.

### Linear system 

Assuming that the air have the same electromagnetic parameters as the vaccum, then a possible model for this problem is:

$$
\left\{
  \begin{array}{r c l l}
    \Delta E(\mathbf{x}) + k^2n(\mathbf{x})^2E(\mathbf{x})  &= & -\delta_{\text{router}}(\mathbf{x}) & \text{ dans } \Omega,\\
    \partial_{\mathbf{n}} E(\mathbf{x}) - \imath k n(\mathbf{x}) E(\mathbf{x}) & = & 0 & \text{ sur }\partial\Omega,
  \end{array}
\right.
$$
where we have

- $\delta_{\text{router}}$ : position of the router.
- $n$ : *constrast function* that takes into account the electromagnetic properties of the walls and the air:

$$
n(\mathbf{x}) =
\left\{
  \begin{array}{l l l}
    1 & \text{ si } \mathbf{x}\in\Omega_{air} & (\textit{i.e. } \mathbf{x} \text{ is in theair}),\\
    2.4 & \text{ si } \mathbf{x}\in\Omega_{walls} & (\textit{i.e. } \mathbf{x} \text{ is in the walls}).
  \end{array}
\right.
$$

Please note that these values are close to reality and are not fancy mathématician values.

- The last equation: $\partial_{\mathbf{n}} E - \imath k n E = 0$ is an **absorbing boundary condition**. The $\mathbf{n}$ is the unit normal vector pointing outside $\Omega$. This condition mimic (with a mitigated success) a "transparent" boundary (without reflexion). 

