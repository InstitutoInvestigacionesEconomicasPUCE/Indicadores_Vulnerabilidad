library(highcharter)
library(dplyr)
library(rjson)
library(stringr)
library(readxl)
library(readr)

library(polynom)
# Colores
library(viridisLite)
# Funciones Extras
source(file = "Code/Extrapolacion.R", local = TRUE)
source(file = "Code/MedMovil.R", local = TRUE)

#Carga de Datos --------------------------------------
load("IPC_Cantonal.RData")
IPC_canton = IPC_canton_corre
remove(IPC_canton_corre)
#
ArchCodCanton = read.csv("IPC Cantonal/Mapa/ArchCodCanton.csv")
ArchCodCanton$COD_CANTON = substr(ArchCodCanton$ARCH_CANTON,start = 1,stop = 4)

# Estandarización de Datos  ==========================
pd = 2  #producto
Productos = names(IPC_canton[[1]])

#i = 1
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
  inner_join(BDDMap,by="ARCH_CANTON") %>%
  select(COD_CANTON,CANTON,Fecha,Valor)


#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#-------------------------  MAPA ANIMADO  --------------------------
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#Data para Animacion Mapa
# MapaCanton = fromJSON(file = "https://raw.githubusercontent.com/Rusersgroup/mapa_ecuador/master/ec-all.geo.json")
producto = Productos[pd+1]
# BDDMap = read_excel("Data/Mapa/Mapa_Data_Ej.xlsx")  #!!!!!!
MapaCanton = fromJSON(file = "IPC Cantonal/Mapa/Mapa_Cantonal.geojson")
# glimpse(MapaCanton)

# Colores Mapa --------------------------------------
n=400
colores = substring(inferno(n + 1), 0, 7)
lista_colores = data.frame(q = 0:n/n,
                           c = colores,
                           stringsAsFactors = FALSE)
lista_colores = list_parse2(lista_colores)
dl = 4


# Datos adecuados para hchart  ---------------------
DFMap = BDDMap %>% 
  group_by(COD_CANTON) %>% 
  do(item = list(
    COD_CANTON = first(.$COD_CANTON),
    sequence = .$Valor,
    value = first(.$Valor))) %>% 
  .$item

#----------------------------------------------------------
highchart(type = "map") %>%
  hc_title(text = "<b>Índice de Precios al Consumidor</b>",
           margin = 20, align = "center") %>% 
  hc_subtitle(text = producto,
              align = "center") %>% 
  hc_tooltip(followPointer =  TRUE) %>%
  hc_add_series(data = DFMap,
                mapData = MapaCanton,
                name = "IPC",
                value = "Valor", 
                joinBy = c("DPA_CANTON", "COD_CANTON"),
                dataLabels = list(enabled = TRUE,
                                  format = '{point.properties.DPA_DESCAN}')) %>%
  
  # hc_motion(enabled = TRUE,series = 1,labels = 1:n) %>% 
  # hc_colorAxis(dataClasses = color_classes(seq(25124, 3645483, length.out = 12))) %>%
  # hc_colorAxis(minColor = "#922B21", maxColor = "#F9EBEA")  %>%
  
  # Usando Lista de Colores Paleta "Viridis" 
  hc_colorAxis(stops = lista_colores#,
               # type = "logarithmic",
               # min= min(BDDMap$Valor)+dl*(10^(-4)),
               # max= max(BDDMap$Valor)-dl*(10^(-4))
               ) %>%
  
  
  
  # hc_colorAxis(dataClasses = color_classes(breaks = seq(25124, 3645483, length.out = 40),
  #                                          colors = c("#ff0000", "#ffcc00", "#33cc33"))) %>%
  hc_mapNavigation(enabled = TRUE) %>%
  #!!!!!!!!!!!!!!!!       Temas      !!!!!!!!!!!!!!!!!!!!!!!!!!!!
  # hc_add_theme(hc_theme_ffx()) %>%
  
  hc_legend(layout = "vertical", reversed = TRUE,
            floating = TRUE, align = "right") %>% 
  hc_motion(
    enabled = TRUE,
    axisLabel = "Fecha",
    labels = sort(unique(BDDMap$Fecha)),
    series = 0,
    updateIterval = 10,
    magnet = list(
      round = "floor",
      step = 0.19 #Velocidad !!!!!!!!!!!
    )
  )



