#### install.packages('xts',dependencies = T) ####
#Correccion de Version en paquete 'xts' ===============
# install.packages('devtools', dependencies = T)
# require(devtools)
# install_version("xts", version = "0.9-7", repos = "http://cran.us.r-project.org")

# Analisis de : IPC (Serie Empalmada Regional)
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#---------------        ANALISIS Regresion IPC - PUCE      ----------------
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
library(shiny)
library(shinythemes)
library(latex2exp)
library(markdown)
#Tablas
library(readxl)
library(readr)
library(curl)
library(xtable)
library(DT)
library(tidyverse)
#Series de Tiempo
library(polynom)
library(TSdist)
library(gridExtra)
# library(xts)
library(forecast)
library(hexbin)
library(MASS)
#Graficos
library(ggplot2)
library(ggridges)
library(highcharter)
library(rjson)
#Colores
library(viridis)
library(viridisLite)
library(colormap)
#Extrapolacion
library(polynom)

#>> Carga de Datos ----------------------------------------------
# http://www.ecuadorencifras.gob.ec/series-empalmadas-ipc-base-2004/
# IPC = read_csv("Data/IPChistorico.csv")

# Datos Cantonales ----------------------------------------------
load("Data/IPC_Cantonal.RData")
IPC_canton = IPC_canton_corre
remove(IPC_canton_corre)



# Data Nacional  ------------------------------------------------
source(file ="Code/CargaData.R" ,local = TRUE)

Productos = names(IPC_canton[[1]])[-1]
productos = Productos
ProductosLista = 1:length(productos)
names(ProductosLista) = paste(ProductosLista,".",productos)

PeriodoLista = 2006:2018
names(PeriodoLista) = paste("Año:",PeriodoLista)



#  Datos  MAPA CANTONAL     --------------------------------------
MapaCanton = fromJSON(file = "Data/Mapa/Mapa_Cantonal.geojson")
ArchCodCanton = read.csv("Data/Mapa/ArchCodCanton.csv")
ArchCodCanton$COD_CANTON = substr(ArchCodCanton$ARCH_CANTON,start = 1,stop = 4)



# Listados Provincia - Cantones  ---------------------------------
# Cantones_lista = 1:length(IPC_canton)
# names(Cantones_lista) = names(IPC_canton)
Cantones_lista = as.character(ArchCodCanton$ARCH_CANTON)

Provincias_lista = unique(as.character(ArchCodCanton$PROVINCIA))


# Funciones Extras
#-----------------------------------------------
source(file = "Code/Extra/Extrapolacion.R", local = TRUE)
source(file ="Code/Extra/MedMovil.R" ,local = TRUE)
#-----------------------------------------------


# Paleta de Colores  ---------------------------
map2color<-function(x,pal,limits=NULL){
  if(is.null(limits)) limits=range(x)
  pal[findInterval(x,seq(limits[1],
                         limits[2],
                         length.out=length(pal)+1), 
                   all.inside=TRUE)]
}

#map2color(0:11,rainbow(200),limits=c(1,10))

# colormap(colormap = colormaps$viridis, 
#          nshades = 72, format = "hex",
#          alpha = 1, reverse = FALSE)
