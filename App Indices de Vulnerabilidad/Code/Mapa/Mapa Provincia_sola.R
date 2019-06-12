#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#-------------------------  MAPA ANIMADO  --------------------------
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

# Datos Reactivos
map_tipo = "betas"

if(map_tipo == "betas"){
  BDDMap = BDDMapBetasProv()
  velocidad = 10
  velocidad = velocidad*(10^(-3))
}else{
  BDDMap = BDDMapReact()
  velocidad = 200
  velocidad = velocidad*(10^(-3))
}
#
# periodos = c(2005,as.numeric(input$periodos),2019)
# pd = as.numeric(input$producto)

producto = Productos[pd]

# Colores Mapa --------------------------------------
n=400
colores = substring(inferno(n + 1), 0, 50)
lista_colores = data.frame(q = 0:n/n,
                           c = colores,
                           stringsAsFactors = FALSE)
lista_colores = list_parse2(lista_colores)
dl = 10
dl = dl*(10^(-5))

# Datos adecuados para hchart  ---------------------
DFMap = BDDMap %>% 
  group_by(COD_CANTON) %>% 
  do(item = list(
    COD_CANTON = first(.$COD_CANTON),
    sequence = .$Valor,
    value = first(.$Valor))) %>% 
  .$item

#----------------------------------------------------------
MapaListo = highchart(type = "map") %>%
  hc_title(text = paste("Provincia:",input$provincia),
           align = "center") %>%  #margin = 20
  # hc_subtitle(text = input$provincia,
  #             align = "center") %>% 
  hc_tooltip(followPointer =  TRUE) %>%
  hc_add_series(data = DFMap,
                events = list("click" = function(e){point.zoomTo(e)}),
                borderColor = "#E1D29C",
                mapData = MapaCanton,
                name = "IPC",
                value = "Valor", 
                joinBy = c("DPA_CANTON", "COD_CANTON"),
                dataLabels = list(enabled = TRUE,
                                  format = '{point.properties.DPA_DESCAN}')) %>%
  
  # Usando Lista de Colores Paleta "Viridis" 
  # hc_colorAxis(stops = lista_colores,
  #              min= min(BDDMap$Valor)+dl*(10^(-4)),
  #              max= max(BDDMap$Valor)-dl*(10^(-4))) %>%
  
  hc_mapNavigation(enabled = TRUE,
                   zoom = 2) %>%
  #!!!!!!!!!!!!!!!!       Temas      !!!!!!!!!!!!!!!!!!!!!!!!!!!!
  # hc_add_theme(hc_theme_ffx()) %>%
  
  hc_legend(layout = "vertical", reversed = TRUE,
            floating = T, align = "right") %>% 
  hc_motion(
    enabled = TRUE,
    axisLabel = "Fecha",
    labels = sort(unique(BDDMap$Fecha)),
    series = 0,
    updateIterval = 40,
    magnet = list(
      round = "floor",
      step = velocidad #Velocidad !!!!!!!!!!!
    )
  )

if(input$fijar_mapa == T){
  MapaListo = MapaListo %>% hc_colorAxis(stops = lista_colores,
                                         min= min(BDDMap$Valor)+dl,
                                         max= max(BDDMap$Valor)-dl)
}else{
  MapaListo = MapaListo %>% hc_colorAxis(stops = lista_colores)
}

