;+
;Function: sine rectifier
;Purpose:   Calculate the sine rectifier of the IMF given its three components.
;           Can accept a series of values in the form of 1-dimensional arrays.
;           
;Parameters:
;  Bx = GSE X component of the IMF in nT
;  By = GSE Y component of the IMF in nT
;  Bz = GSE Z component of the IMF in nT
;
;Outputs:
;  Bs = sine rectifier of the IMF in nT
;  
;Example:
;  bs = sine_rectifier(8,4,3)
;  
;  bs containes the sine rectifier of the IMF for Bx = 8nT, By = 4nT, and
;  Bz = 3nT (GSE coordinates). This is equal to 1.8868nT.
;  
; $LastChangedBy: Connor O'Brien $
; $LastChangedDate: 2020-12-22 17:00:00 -0500 (Tue, 22 Dec 2020) $
; $URL: https://github.com/connor-obrien888/tractrix $
;

function sine_rectifier, bx, by, bz
  bs = sqrt(bx^2+by^2+bz^2)*(sin(atan(by,bz)/2)^2)
  return, Bs
end

test_bs = [sine_rectifier(0,1,0),sine_rectifier(sin(1),0,-cos(1)), sine_rectifier(0,0,-1)]
print, test_bs
print, 'This procedure tests the function SINE_RECTIFIER. If you want to use that function, please call SINE_RECTIFIER, NOT sine_rectifier.pro'
end