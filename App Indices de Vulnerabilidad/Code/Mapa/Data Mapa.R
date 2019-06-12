
# DATOS Mapa CANTONAL  ===========================
BDDMapReact = reactive({
  periodos = c(2005,as.numeric(input$periodos),2019)
  pd = as.numeric(input$producto)
  
  BDDMap = data.frame()
  for(i in 1:length(IPC_canton)){
    Fechas_aux = IPC_canton[[i]][,1] #Corregir
    
    # IPC_val_aux = IPC_canton[[i]][,pd+1]
    mav12 = MedMovBeta(IPC_canton[[i]][,2],n=12)
    IPC_val_aux = IPC_canton[[i]][,pd+1]/as.numeric(mav12$mvxRecup) #IPC Deflactado
    
    nombre_aux = names(IPC_canton)[i]
    BDDMap_aux = data.frame(ARCH_CANTON = nombre_aux,
                            Fecha=Fechas_aux, 
                            Valor = IPC_val_aux)
    BDDMap = rbind(BDDMap, BDDMap_aux)
  }
  
  BDDMap = ArchCodCanton %>%
    dplyr::inner_join(BDDMap,by="ARCH_CANTON") %>%
    dplyr::select(COD_CANTON,CANTON,Fecha,Valor)
  return(BDDMap)
})



# Datos Betas Cantonal  =================================

BDDMapBetas = reactive({
  
  # periodos = c(2005,as.numeric(input$periodos),2019)
  # print("Aqui se calcula Periodos !!!!!!!!!!!!")
  # print(periodos)
  
  pd = as.numeric(input$producto)
  
  BDDMap = data.frame()
  for(i in 1:length(IPC_canton)){
    Fechas_aux = IPC_canton[[i]][,1] #Corregir
    mav12 = MedMovBeta(IPC_canton[[i]][,2],n=12)
    IPC_val_aux = IPC_canton[[i]][,pd+1]/as.numeric(mav12$mvxRecup) #IPC Deflactado
    nombre_aux = names(IPC_canton)[i]
    
    
    #Base del Canton i y producto pd  -------------------
    # periodos = c(2007,2010,2015)
    # periodos = c(2005,as.numeric(periodos),2019)
    periodos = c(2005,as.numeric(input$periodos),2019)
    Fecha = as.Date(IPC_canton[[1]]$Fecha, format = "%Y-%m-%d")
    Anio = as.numeric(format(Fecha, "%Y")) #;remove(Fecha)
    etiquetas = c()
    for (i in 1:(length(periodos) - 1)) {
      etiquetas[i] = paste0("Periodo: ", periodos[i], " - ", periodos[i + 1])
    }
    PeriodoCorte = cut(Anio,
                       breaks = periodos ,
                       labels = etiquetas ,
                       right = F)
    remove(Anio,periodos,Fecha,i)
    #----------------------------
    BDD_aux = data.frame(Periodo = PeriodoCorte,
                         Tmp = 1:length(Fechas_aux),
                         Valor = IPC_val_aux
                         # Valor = round(IPC_val_aux,digits = 5)
                         # Valor = format(IPC_val_aux, scientific = TRUE)
                         )      #mapa
    remove(mav12,Fechas_aux,IPC_val_aux)
    
    #Regresion de Panel  --------------------------------
    modelo = lm(data = BDD_aux, formula = Valor ~ Tmp*Periodo)
    
    # Betas del Modelo  ---------------------------------
    resumen = data.frame(round(xtable(summary(modelo)),digits = 5))
    names(resumen) = c("Estimación","Error Estándar","t-valor","Pr(>|t|)")

    remove(BDD_aux,modelo)
    
    b_nomb=startsWith(rownames(resumen),"Tmp")
    betas=resumen$`Estimación`[b_nomb]
    tablabetas=resumen[b_nomb,c(1,2)]
    remove(b_nomb)
    #Betas Acumulados (Sumado el pivote)
    tablabetas[2:length(tablabetas[,1]),1]=tablabetas[2:length(tablabetas[,1]),1]+tablabetas[1,1]
    tablabetas = data.frame(ARCH_CANTON = nombre_aux, #mapa
                            Fecha = as.character(etiquetas), 
                            Valor = round(tablabetas[,1],digits = 6))
    #Datos para MAPA  ----------------------------------
    BDDMap = rbind(BDDMap, tablabetas)
  }
  
  BDDMap = ArchCodCanton %>%
    dplyr::inner_join(BDDMap,by="ARCH_CANTON") %>%
    dplyr::select(COD_CANTON,CANTON,Fecha,Valor)
  
  return(BDDMap)
  
})



# Datos Para Mapa de Provincia Sola ----------------------


BDDMapBetasProv = reactive({
  
  BDDMap = BDDMapBetas()
  BDDMap = BDDMap %>% 
    dplyr::inner_join(ArchCodCanton[,c("COD_CANTON","PROVINCIA")],by="COD_CANTON") %>% 
    dplyr::filter(PROVINCIA == input$provincia) %>% 
    dplyr::select(COD_CANTON,CANTON,Fecha,Valor)
  
  return(BDDMap)
  
})





