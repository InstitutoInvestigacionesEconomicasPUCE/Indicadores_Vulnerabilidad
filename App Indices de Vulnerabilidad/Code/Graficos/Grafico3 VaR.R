# Serie de la variación Porcentual del IPC (Inflacion) -----------------
BDDgrafVar = BDDgraf %>% dplyr::select(Fecha,PeriodoCorte) 
BDDgrafVar = BDDgrafVar[-1,]
BDDgrafVar$SerieVar = diff(BDDgraf$SerieOrig)

seriegrafVar =  ggplot(data = BDDgrafVar, aes(x = Fecha, y = SerieVar)) +
  geom_line(size = 0.7) + theme_minimal() +
  labs(title = paste("Inflación: ", productos[k]) , 
       y = "Variación % del IPC (t-1)") +
  geom_vline(
    xintercept = as.Date(paste0(periodos[-c(1, length(periodos))], "-01-01")),
    linetype = "dashed",
    color = "red",
    size = 1,
    labels()
  )+
  geom_hline(yintercept = 0,color="#3F88AB")+
  theme(
    legend.title = element_text(size = 12, color = "black", face = "bold"),
    legend.justification = c(0, 1),
    legend.position = c(0.75,0.5),
    legend.background = element_blank(),
    legend.key = element_blank(),
    axis.text.x=element_text(angle=90)
  ) +
  # annotate("text",
  #          label = round(BDDgrafVar$SerieVar[dim(BDDgrafVar)[1]],2),
  #          x = BDDgrafVar$Fecha[dim(BDDgrafVar)[1]],
  #          y = BDDgrafVar$SerieVar[dim(BDDgrafVar)[1]] ,
  #          size = 4,
  #          color = "red"
  # ) + 
  # geom_label(aes(label = ifelse(SerieVar<0,SerieVar,"")),colour = "red",
  #            data = BDDgrafVar[dim(BDDgrafVar)[1],])+

  scale_x_date(                                        
    breaks = "4 months",
    date_labels = "%b %Y"
  ) 


BV_aux = BDDgrafVar[dim(BDDgrafVar)[1],]
if(BV_aux$SerieVar<0){
  seriegrafVar = seriegrafVar+ 
    geom_label(aes(label = round(SerieVar,digits = 3)),
               colour = "red",
               data = BV_aux)
}else{
  seriegrafVar = seriegrafVar+ 
    geom_label(aes(label = round(SerieVar,digits = 3)),
               colour = "#02AF69",
               data = BV_aux)
}

# Variaciones Pocentuales IPC (inflacion) -------------------------------

BVar = BDDgraf %>%
  dplyr::filter(PeriodoCorte == etiquetas[length(etiquetas)]) %>% 
  dplyr::select(Fecha,PeriodoCorte,SerieOrig)
VaR = quantile(diff(BVar$SerieOrig),0.05)
BVar = with(density(diff(BVar$SerieOrig)), data.frame(x, y))
# Grafico Densidad
al=0.35;al2=0.23;
VarGraf = ggplot(data = BVar, mapping = aes(x = x, y = y)) +
  labs(title = TeX("Distribución: Inflación"),
       subtitle = paste("[",etiquetas[length(etiquetas)],"]")
       ) +
  geom_line(size=1,colour="grey")+
  geom_area(mapping = aes(x = ifelse(x< VaR , x, NA)), fill = "red",alpha=0.4) +
  geom_area(mapping = aes(x = ifelse(x> VaR , x, NA)), fill = "#33cccc",alpha=0.4) +
  ylim(0,max(BVar$y)) + ylab("Densidad")+
  xlim(min(BVar$x), max(BVar$x)) + xlab("Variación Porcentual del IPC") +
  geom_vline(aes(xintercept = VaR),
             linetype = "dashed",
             colour = "red",
             size = 1.2)+
  annotate("text",
           label = paste("5% VaR(Inflación)=",round(VaR,3),"%"),
           x = al*min(BVar$x)+(1-al)*VaR,
           #Posicion Y
           y = al*max(BVar$y),
           size = 5
  ) +
  # annotate("text",
  #          label = round(VaR,5),
  #          x = al*min(BVar$x)+(1-al)*VaR,
  #          #Posicion Y
  #          y = al2*max(BVar$y),
  #          size = 5
  # )+
  theme(plot.title = element_text(size = 16, face = "bold"))+
  coord_flip()




# Distribución del IPC deflactado  -----------------------------
# BVar = BDDpanel %>%
#   dplyr::filter(PeriodoCorte == etiquetas[length(etiquetas)]) %>% 
#   dplyr::select(Fecha,PeriodoCorte,SerieStnd)
# VaR = quantile(BVar$SerieStnd,0.05)
# BVar = with(density(BVar$SerieStnd), data.frame(x, y))
# 
# #Grafico Densidad
# al=0.3;al2=0.23;
# VarGraf = ggplot(data = BVar, mapping = aes(x = x, y = y)) +
#   labs(title = TeX(paste("Distribucion: IPC Deflactado (",etiquetas[length(etiquetas)],")"))) +
#   geom_line(size=1,colour="grey")+
#   geom_area(mapping = aes(x = ifelse(x< VaR , x, NA)), fill = "red",alpha=0.4) +
#   geom_area(mapping = aes(x = ifelse(x> VaR , x, NA)), fill = "#33cccc",alpha=0.4) +
#   ylim(0,max(BVar$y)) + ylab("Densidad")+
#   xlim(min(BVar$x), max(BVar$x)) + xlab("IPC Deflactado") +
#   geom_vline(aes(xintercept = VaR),
#              linetype = "dashed",
#              colour = "red",
#              size = 1.2)+
#   annotate("text",
#            label = "5% VaR",
#            x = al*min(BVar$x)+(1-al)*VaR,
#            #Posicion Y
#            y = al*max(BVar$y),
#            size = 5
#   )+
#   annotate("text",
#            label = round(VaR,5),
#            x = al*min(BVar$x)+(1-al)*VaR,
#            #Posicion Y
#            y = al2*max(BVar$y),
#            size = 5
#   )+
#   coord_flip()


#Grafico Multiple -----------------
grid.arrange(
  grobs = list(seriegrafVar,VarGraf),
  widths = c(3, 2),
  layout_matrix = rbind(c(1, 2))
)



