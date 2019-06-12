# Función para rellenar Medias Moviles con Polinomios Interpolantes

# library(polynom)

# x0 = rnorm(20, 10, 2)
# y = c(NA,NA,NA,2*x0,NA,NA,NA)

# extrapolacion = function(y,ord = 2){
#   x= 1:length(y)
#   tmin = min(which(!is.na(y)))
#   tmax = max(which(!is.na(y)))
#   #orden del Polinomio Interpolante
#   if(length(y[!is.na(y)])>ord){
#     ord = ord+1
#     Pinf = as.function(poly.calc(x[tmin:(tmin+ord)],y[tmin:(tmin+ord)]))
#     Psup = as.function(poly.calc(x[(tmax-ord):tmax],y[(tmax-ord):tmax]))
#   }
#   
#   #Valores Extrapolados
#   y[1:(tmin-1)] = Pinf(1:(tmin-1))
#   y[(tmax+1):length(y)] = Psup((tmax+1):length(y))
#   return(y)
# }

# extrapolacion(y)
# 
# par(mfrow=c(2,1))
# plot(y,type="l",ylim = c(-27,12))
# plot(extrapolacion(y,ord=2),type="l")


# Otra opcion es tomar más datos y hacer regresion polinomial
# Luego solo predecimos los futuros





# Extrapolación (Regresion Polinomial)   --------------------------------
# n = 20
# x = 1:n
# y = c(NA,NA,NA,2*x^2,NA,NA,NA) + rnorm(n+6,0,20)
extrapolacion = function(y,ord = 3){
  x= 1:length(y)
  tmin = min(which(!is.na(y)))
  tmax = max(which(!is.na(y)))
  #orden del Polinomio Interpolante
  if(length(y[!is.na(y)])>2*(ord+3)){
    # Modelo cola izquerda
    f=0.9
    df.inf = data.frame(x = x[tmin:round(f*tmin+(1-f)*tmax)],
                        y = y[tmin:round(f*tmin+(1-f)*tmax)])
    model.inf = lm(y ~ poly(x,ord), data = df.inf) 
    
    #Modelo Cola Derecha
    df.sup = data.frame(x = x[round((1-f)*tmin+f*tmax):tmax],
                        y = y[round((1-f)*tmin+f*tmax):tmax])
    model.sup = lm(y ~ poly(x,ord), data = df.sup) 
  }
  
  #Valores Extrapolados  ---------------
  y[1:(tmin-1)] = as.numeric(predict(model.inf , 
                                     data.frame(x = 1:(tmin-1),y = NA)))
  y[(tmax+1):length(y)] = as.numeric(predict(model.sup, 
                                             data.frame(x = (tmax+1):length(y),y = NA)))
  
  return(y)
}

