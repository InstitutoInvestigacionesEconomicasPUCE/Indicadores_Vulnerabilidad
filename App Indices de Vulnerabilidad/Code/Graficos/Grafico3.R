#------------------------------------------------------------
#!!!!!!!!!!!!!!!!!!!  GRAFICAS INDIVIDUALES 3  !!!!!!!!!!!!!!
#------------------------------------------------------------
# Graficos del IPC Deflactado, Regresion Panel
# k=2
anhos=function(periodos){
  
  periodos[2:length(periodos)]=periodos[2:length(periodos)]+1
  periodos=paste0("01-06-",periodos)
  periodos=as.Date(periodos,format = "%d-%m-%Y")
  return(periodos[1:length(periodos)-1])
}
perd=anhos(periodos)
#---------------------------------------
BDDgraf1 = BDDgraf
resumen = data.frame(round(xtable(summary(modelo1)),digits = 5))
names(resumen) = c("Estimación","Error Estándar","t-valor","Pr(>|t|)")
Pval = as.numeric(summary(modelo1)$coefficients[,4])
rangos = cut(Pval,breaks = c(0,0.001,0.01,0.05,0.1,1),
             labels = c("***","**","*","."," "))
resumen$Signif = rangos
x=startsWith(rownames(resumen),"Tmp")
betas=resumen$`Estimación`[x]
tablabetas=resumen[x,c(1,2)]

#---------------------------------------
tablabetas[2:length(tablabetas[,1]),1]=tablabetas[2:length(tablabetas[,1]),1]+tablabetas[1,1]
N=300
etiquetas1 = c()
for (i in 1:(length(periodos) - 1)) {
  etiquetas1=c(etiquetas1,replicate(N,etiquetas[i]))
}
etiquetas1=as.factor(etiquetas1)

# periodos = c(2010,2011,2012,2013)
xsim=c()
set.seed(1)
for (i in 1:length(tablabetas[,1])) {
  xsim=c(xsim,rnorm(N,tablabetas[i,1],tablabetas[i,2]))
}
BDDFF=data.frame(Periodos_Corte = etiquetas1,xsim)  
mediasbetas=data.frame(medias=tablabetas[,1], periodos1=etiquetas)
BDDgraf1 = BDDgraf1[,c(1,3,4)]
names(BDDgraf1) = c("Fecha",
                    "Serie Original",
                    "MM12(IPC General)")

BDDgraf1 = BDDgraf1 %>%
  gather(key = "Serie", value = "value", -Fecha)
# n=dim(BDDgraf1)[1]
# print("Nombre BDDgraf1 !!!!!!!!!!!")
# print(names(BDDgraf1))
# Blab = data.frame(Fecha=BDDgraf1$Fecha[n],
#                   value=)
#-------------------------------------------
seriegraf1 = ggplot(BDDgraf1, aes(x = Fecha, y = value)) + 
  geom_line(aes(color = Serie), size = 0.7) +
  
  scale_color_manual(values = c("#0174DF","#2E2E2E")) +
  theme_minimal()+
  labs(title = paste("IPC:", productos[k]) , y = "IPC") +
  geom_vline(
    xintercept = as.Date(paste0(periodos[-c(1,length(periodos))],"-01-01")),
    linetype = "dashed",
    color = "red",
    size = 1
  ) +
  # annotate("text",
  #          label = round(BDDgraf$SerieOrig[dim(BDDgraf)[1]],2),
  #          x = BDDgraf$Fecha[dim(BDDgraf)[1]],
  #          y = 0.96*BDDgraf$SerieOrig[dim(BDDgraf)[1]] ,
  #          size = 4
  # ) +
  geom_label(aes(label = round(value,digits = 2)),
             colour = "#007DB7",
             data = BDDgraf1[round(dim(BDDgraf1)[1]),]  
             #Tomamos el valor de la MM12, esta al final)
  )+
  geom_label(aes(label = round(value,digits = 2)),
             colour = "#4E5D64",
             data = BDDgraf1[round(dim(BDDgraf1)[1]/2),]  
             #Estan dos series seguidas(necesitamos el valor de la original no de la MM12)
  )+
  theme(
    legend.title = element_text(size = 12, color = "black", face = "bold"),
    legend.justification = c(0, 1),
    legend.position = c(0.05, 0.95),
    legend.background = element_blank(),
    legend.key = element_blank(),
    axis.text.x=element_text(angle=90)
  )+ 
  scale_x_date(                                        
    breaks = "4 months",
    date_labels = "%b %Y"
  )
#----------------------------------------
#Paleta Colores
rangoBeta = abs(max(mediasbetas$medias)-min(mediasbetas$medias))
dl = 0.4
limitesBeta = c(min(mediasbetas$medias)-dl*rangoBeta,max(mediasbetas$medias)+dl*rangoBeta)
paletaBeta = colormap(colormaps$inferno)
paletaBeta = map2color(mediasbetas$medias,paletaBeta,
                       limits=limitesBeta)
# paletaBeta =c("#000004ff" ,"#180939ff", "#3e0e5dff", "#67166cff")
# ---------------------------------------
posY = 0.92
seriegraf2 =  ggplot(data = BDDgraf, aes(x = Fecha, y = SerieStnd)) +
  geom_line(size = 0.7) + theme_minimal() +
  labs(title = paste("IPC Deflactado & Regresión por Periodo:", productos[k]) , 
       y = "IPC Deflactado") +
  # Lineas Marca Periodos
  geom_vline(
    xintercept = as.Date(paste0(periodos[-c(1, length(periodos))], "-01-01")),
    linetype = "dashed",
    color = "red",
    size = 1,
    labels()
  ) +
  
  # Rectas Regresoras
  geom_line(
    data = predicted,  #Anadir Lineas de Regresion !!!!!!!!!
    aes(x = Fecha, y = IPCfit,colour = PeriodoCorte), #,colour = PeriodoCorte)
    size = 0.7
  ) +
  
  # Color de Lineas  --------
  # scale_color_manual(values=c('#999999','#E69F00','#999999','#E69F00'))+
  scale_colour_manual(values=paletaBeta) +
  # scale_color_viridis(discrete=TRUE,option="inferno") +
  # scale_color_colormap(discrete = TRUE ,colormap = colormaps$viridis, reverse = T)
  
  # Texto Betas
  annotate("text",
           label = TeX(paste0("$ \\beta = ",
                              round(betas,5),"$",
                              as.character(rangos[x]))
           ),
           x = perd,
           # x = as.Date("01-01-2010", format = "%d-%m-%Y"), 
           y = max(BDDgraf$SerieStnd)*1.07,
           size = 4
  )+
  annotate("text",
           label = TeX(paste0("$ \\alpha = ",
                              round(mediasbetas$medias,5),"$"
           )
           ),
           x = perd,
           #Posicion Y
           y = posY*max(BDDgraf$SerieStnd)*1.07 + (1-posY)*min(BDDgraf$SerieStnd),
           size = 4
  )+
  theme(
    legend.title = element_text(size = 12, color = "black", face = "bold"),
    legend.justification = c(0, 1),
    legend.position = c(0.75,0.5),
    legend.background = element_blank(),
    legend.key = element_blank(),
    axis.text.x=element_text(angle=90)
  )+ 
  scale_x_date(                                        
    breaks = "4 months",
    date_labels = "%b %Y"
  )


#Grafico Densidades  BETAS   ---------------------------------
al=0.35
VaR2 = -0.0008
xsim_ultimo = BDDFF$xsim[BDDFF$Periodos_Corte == BDDFF$Periodos_Corte[dim(BDDFF)[1]] ]
den_xsim_ult = with(density(diff(xsim_ultimo)), data.frame(x, y))
VaR2 = quantile(xsim_ultimo,0.05)

densidades = ggplot(data = BDDFF ,
                    aes(x = xsim, y = Periodos_Corte ,fill = ..x..)) +  
  # Densidades
  geom_density_ridges_gradient(scale = 3, rel_min_height = 0.01) +
  scale_fill_viridis(name = "Temp. [F]", option = "C") +
  #Titulos
  labs(title = TeX("Distribución de $\\alpha 's$ por Periodo"), 
       subtitle = "Simulación Monte Carlo") +
  geom_vline(data = mediasbetas,
             aes(xintercept = medias, color="grey"),
             linetype = "dashed") +
  
  #Linea VaR
  geom_vline(xintercept = VaR2, linetype="dashed",
             color = "red", size=1.2) +
  
  annotate("text",
           label = TeX(paste("5% VaR($\\alpha$)=",round(VaR2,3))),
           x = al*min( xsim_ultimo )+(1-al)*VaR2,
           #Posicion Y
           y = 2 ,
           size = 5
  ) +
  
  ## Tema
  # theme(
#   legend.title = element_text(size = 12, color = "black", face = "bold"),
#   legend.justification = c(0, 1),
#   legend.position = c(0.05, 0.95),
#   legend.background = element_blank(),
#   legend.key = element_blank()
# ) + 

  theme(legend.position = "none",
        axis.text.x=element_text(angle=90),
        plot.title = element_text(size = 21, face = "bold"),
        plot.subtitle = element_text(size = 15)) +
  
  xlab( TeX("Pendiente del periodo")) +
  ylab("") +
  # annotate("text",
  #          label = TeX(paste0("$ \\alpha = ",
  #                             round(mediasbetas$medias,5),"$"
  #          )
  #          ),
  #          x = mediasbetas$medias,
  #          #Posicion Y
  #          y = 0,
  #          size = 3
  # )#+
  coord_flip()

#Grafico Multiple -----------------
grid.arrange(
  grobs = list(seriegraf1,seriegraf2,densidades),
  widths = c(3, 2),
  layout_matrix = rbind(c(1, 3),
                        c(2, 3))
)

print("Grafico generado  ************************")
