# Tractrix (IDL Library)

This is a library for IDL containing an implementation of the tractrix magnetopause model from O'Brien et al. (2021), with some utility functions.

Install by downloading the above folder into wherever you prefer to keep IDL libraries.

As of Version 0.1.0, the functions included are:
```
Function: tractrix
Purpose:   Generate a tractrix model magnetopause surface from input
           solar wind parameters. Can generate multiple surfaces from
           multiple sets of input conditions.
Parameters:
  sin_rec = Sine rectifier of the IMF in nT. 
            Given as Btot * sin^2 (clock angle /2 )
  p_dyn = Solar wind dynamic pressure in nPa.
  n = number of points in the curve to generate. Default 1000.
  sparam = The three tuning parameters used in the subsolar standoff 
            position function. Default values from O'Brien et al. (2021).
  wparam = The three tuning parameters used in the asymptotic tail width 
            function. Default values from O'Brien et al. (2021).
 
Outputs:
  surfaces = Points describing magnetopause surfaces for given input 
             conditions. First index is the index of the solar wind
             conditions the surface corresponds to, second index indicates 
             GSE X/Y, and third index contains the position values.
Example:
  surfaces = tractrix([0,5],[2,6],n=50)
  
  surfaces[0,0/1,*] contains the GSE X/Y position of the magnetopause for 
  nominal solar wind conditions. surfaces[1,0/1,*] contains the GSE X/Y
  position of a compressed magnetopause.
```
```
Function: sine rectifier
Purpose:   Calculate the sine rectifier of the IMF given its three components.
           Can accept a series of values in the form of 1-dimensional arrays.
           
Parameters:
  Bx = GSE X component of the IMF in nT
  By = GSE Y component of the IMF in nT
  Bz = GSE Z component of the IMF in nT

Outputs:
  Bs = sine rectifier of the IMF in nT
  
Example:
  bs = sine_rectifier(8,4,3)
  
  bs containes the sine rectifier of the IMF for Bx = 8nT, By = 4nT, and
  Bz = 3nT (GSE coordinates). This is equal to 1.8868nT.
```

If you make use of this code, please cite the paper from which the model was derived:

```
Citation to come
```
