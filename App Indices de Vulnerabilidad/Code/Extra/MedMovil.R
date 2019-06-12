#Funcion para analisis de Medias Moviles

MedMovBeta = function(x,n=5){
  
  #Algoritmo Medias Moviles   ------------------------
  mvx = stats::filter(x, rep(1 / n, n), sides = 2)
  
  # Extrapolacion de valores perdidos antes
  mvxRecup = extrapolacion(mvx)
  
  return(data.frame(x,mvx,mvxRecup))
}

