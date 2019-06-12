# ========================================================================
# !!!!!!!!!!!!!!!!!!!!!!!!     SERVER      !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# ========================================================================
function(input, output,session) {
  #Carga de Datos Reactiva --------------------
  source(file = "Code/DataReactiva.R", local = TRUE)
  
  #Subtitulo Producto  ------------------------
  output$productNombre = renderText({
    
    nomPord=names(ProductosLista)[as.numeric(input$producto)]
    print(paste("Producto",nomPord))
    
  })
 
  
  # Mapas CANTONAL  -------------------------
  source(file="Code/Mapa/Data Mapa.R",local = TRUE)
  output$mapaCantonal =renderHighchart({
    k = as.numeric(input$producto)
    periodos = c(2005,as.numeric(input$periodos),2019)
    pd = as.numeric(input$producto)
    
    source(file="Code/Mapa/Mapa Cantonal.R",local = TRUE)
    return(MapaListo)
  })
  
  
  # Actualizacion de Lista Canton ----------------
  observe({
    cantones_react = ArchCodCanton$ARCH_CANTON[ArchCodCanton$PROVINCIA == input$provincia]
    updateSelectInput(session,"region",
                      choices = cantones_react,
                      selected = cantones_react[1] ) 
  })
  
  # Mapa Provincia Especifica   --------------
  
  output$mapaProvincia=renderHighchart({
    k = as.numeric(input$producto)
    periodos = c(2005,as.numeric(input$periodos),2019)
    pd = as.numeric(input$producto)
    
    source(file="Code/Mapa/Mapa Provincia_sola.R",local = TRUE)
    return(MapaListo)
  })
  
  
  
  
  # Grafico IPC Deflactado  ----------------------
  output$graficoDist = renderPlot({
    IPC = IPCreact()
    #Datos Iniciales y Analisis 
    k = as.numeric(input$producto)
    periodos = c(2005,as.numeric(input$periodos),2019)
    #Regresion   
    source(file = "Code/Regresiones/RegresionPanel.R", local = TRUE)
    #Graficos Individuales 
    source(file = "Code/Graficos/Grafico3.R", local = TRUE)
    
    
  })
  
  
  # Grafico Inflacion ---------------------------
  output$graficoVar = renderPlot({
    IPC = IPCreact()
    try({
      #Regresion   
      source(file = "Code/Regresiones/RegresionPanel.R", local = TRUE)
      #Graficos Individuales 
      source(file = "Code/Graficos/Grafico3 VaR.R", local = TRUE)
    })
    
    
  })
  
  
  # Tabla resumen de Regresion  -----------------------------
  output$resumenRegres = renderDT({
    IPC = IPCreact()
    try({
      source(file = "Code/Regresiones/RegresionPanel.R", local = TRUE)
      source(file = "Code/Tablas/Tabla3.R", local = TRUE)
    })
    
    
    #Compila Tabla
    ResumenTabla
  })
  
}

