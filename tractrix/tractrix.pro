;+
;Function: tractrix
;Purpose:   Generate a tractrix model magnetopause surface from input
;           solar wind parameters
;Parameters:
;  sin_rec = Sine rectifier of the IMF in nT. 
;            Given as Btot * sin^2 (clock angle /2 )
;  p_dyn = Solar wind dynamic pressure in nPa.
;  n = number of points in the curve to generate. Default 1000.
;  sparam = The three tuning parameters used in the subsolar standoff 
;            position function. Default values from O'Brien et al. (2021).
;  wparam = The three tuning parameters used in the asymptotic tail width 
;            function. Default values from O'Brien et al. (2021).
; 
;Outputs:
;  surfaces = Points describing magnetopause surfaces for given input 
;             conditions. First index is the index of the solar wind
;             conditions the surface corresponds to, second index indicates 
;             GSE X/Y, and third index contains the position values.
;Example:
;  surfaces = tractrix([0,5],[2,6],n=50)
;  
;  surfaces[0,0/1,*] contains the GSE X/Y position of the magnetopause for 
;  nominal solar wind conditions. surfaces[1,0/1,*] contains the GSE X/Y
;  position of a compressed magnetopause.
;             
; $LastChangedBy: Connor O'Brien $
; $LastChangedDate: 2020-12-22 17:00:00 -0500 (Tue, 22 Dec 2020) $
; $URL: https://github.com/connor-obrien888/tractrix $
;

function tractrix, sin_rec, p_dyn, n = num, sparam = si, wparam = wi
    if keyword_set(num) then n = num else n = 1000
    if keyword_set(si) then sp = si else sp = [14.56,-0.0354,5.697]   
    if keyword_set(wi) then wp = wi else wp = [32.31,-0.265,11.80]
    
    s = (sp[0] + sp[1] * sin_rec) * (p_dyn ^ (-1 / sp[2]))
    w = (wp[0] + wp[1] * sin_rec) * (p_dyn ^ (-1 / wp[2]))
    
    surfaces = fltarr(size(sin_rec, /n_elements), 2 ,num)
    for i = 0,(size(sin_rec, /n_elements)-1) do begin
      surfaces[i,1,*] = findgen(num,INCREMENT=(w[i]/(num+1)))
      if (w[i]<0) then surfaces[i,1,*] = !VALUES.F_NAN
      surfaces[i,0,*] = s[i] - w[i] * alog((w[i] + sqrt(abs(w[i] ^ 2 - (w[i] - surfaces[i,1,*]) ^ 2))) / abs(w[i] - surfaces[i,1,*])) + sqrt(abs(w[i] ^ 2 - (w[i] - surfaces[i,1,*]) ^ 2))
    endfor
    
    return, surfaces
end

test = tractrix(0, 2.38, n = 10)
print, test
scatter = scatterplot(test[0,0,*],test[0,1,*])
print, 'This procedure tests the function TRACTRIX. If you want to use that function, please call TRACTRIX, NOT tractrix.pro'
end
