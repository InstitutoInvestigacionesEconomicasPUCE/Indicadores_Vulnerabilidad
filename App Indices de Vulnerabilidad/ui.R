# ========================================================================
# !!!!!!!!!!!!!!!!!!!!!!    USER INTERFACE   !!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# ========================================================================

navbarPage(title = "Precios Ecuador",
           header = tags$h3(" - ",tags$head(tags$link(rel='shortcut icon', 
                                                      href='puce.ico', 
                                                      type='image/x-icon'))),
           position = "fixed-top",theme=shinytheme('yeti'),#theme = 'estilo.css',
           footer = fluidRow(tags$hr(),column(12,img(src='puce_logo.png',width='90px',align='center'),
                                              tags$b('Proyecto: '),
                                              ' "Análisis del Poder de Mercado (Series IPC)".' ,
                                              '-',tags$a('Instituto de Investigaciones Económicas - PUCE (2018)',
                                                         href='https://www.puce.edu.ec'),
                                              tags$b('  ||  '),tags$b('Desarrollado por: '),
                                              tags$a('Cristian Pachacama',
                                                     href='http://www.linkedin.com/in/cristian-david-pachacama')
           )
           ),
           
           #INTRODUCCION E INFORMACION DEL PROYECTO ---------------------------
           tabPanel('Introducción',icon=icon('home'),
                    
                    fluidRow(
                      
                      sidebarPanel(img(src='puce_logo2.png',width='90%',align='center' ),
                                   fluidRow(' '),
                                   hr(),
                                   fluidRow(
                                     column(3,tags$b('Proyecto:')),column(1),
                                     column(8,'Análisis del Índice de Precios al Consumidor - Ecuador')
                                   ),hr(),
                                   fluidRow(
                                     column(3,tags$b('Linea de Investigación:')),column(1),
                                     column(8,'Econometría')
                                   ),hr(),
                                   fluidRow(
                                     column(3,tags$b('Unidad:')),column(1),
                                     column(8,'Instituto de Investigaciones Económicas')
                                   ),hr(),
                                   fluidRow(
                                     column(3,tags$b('Director:')),column(1),
                                     column(8,'PhD. Pedro Páez')
                                   ),hr(),
                                   fluidRow(
                                     column(3,tags$b('Investigador:')),column(1),
                                     column(8,'Cristian Pachacama')
                                   )
                                   
                      ),
                      
                      mainPanel(
                        h3('Indicadores Cantonales de Vulerabilidad de Precios'),
                        h4('Ecuador, Periodo 2005-2019'),hr(),
                        fluidRow(' '),
                        p('
Bajo la dinámica de capitalismo subdesarrollado, además de una marcada 
concentración  en ciudades como Quito, Guayaquil y Cuenca, la población 
del Ecuador se ubica principalmente a lo largo de las principales vías 
principales, en los valles interandinos y cerca de los cauces fluviales 
de la costa y el oriente; de modo que el “territorio” parece estructurado 
por una red de ciudades, intermedias entre cabeceras cantonales y 
parroquiales, articuladas a través de las vías de comunicación, esbozando 
un escenario en el que evidentes desigualdades -dentro y entre- han 
llevado a considerar distintas alternativas de desarrollo; entre ellas, 
el fortalecimiento de los vínculos urbano rurales, tanto al interior de 
las provincias como entre ellas.
'),
                        p('
Por otro lado, la formación de los precios y sus fluctuaciones son una 
manifestación del sistema de producción, comercialización y venta presente 
en los territorios y entre estos.'),
                        p('
En este contexto, ubicar en la matriz de polarización social y de 
concentración de los medios de producción precapitalistas como son la 
tierra, los recursos y el control de comercio, pasa a ser parte de un 
proceso de concentración capitalista moderno que se refuerza y reproduce 
de manera ampliada a través del mercado, por lo tanto, los precios 
reflejan una microfísica del poder en cada localidad, además de reflejar 
a nivel macro una correlación de fuerzas entre distintos capitales. 
En ese sentido el poder de mercado de los distintos capitales define 
cual es la evolución de los precios relativos y por tanto reproduce de 
también manera ampliada las asimetrías estructurales en lo que tiene que 
ver con la distribución de la riqueza, del ingreso y de los recursos.'), 
                        p('
En la medida en la que la política estatal persigue el bien común tanto 
desde el gobierno central como desde los gobiernos seccionales, se tiende 
a reducir esos niveles estructurales de asimetría, pero el mercado los 
reproduce aceleradamente, es decir, “la plata llama a la plata”.'),
                        p('
Mientras mayores son los capitales involucrados estos tienden a 
concentrarse en los nichos de mercado que son más rentables, que pueden 
defender mejor sus precios, y el poder de mercado les permite sea a 
través de precios, cantidades o calidades siempre quedarse con la mejor parte.'),
                        p('
Por otro lado, existe todo un gradiente de productores menores, inclusive 
capitalistas, tanto urbanos como rurales, que pueden defender sus precios 
relativos a una escala mucho menor que los más grandes. Y al final de esta 
cadena se encuentran los pequeños productores, los campesinos, los artesanos, 
y demás miembros de la economía popular y solidaria, quienes no tienen poder 
de mercado, pero conforman el grueso del aparato productivo del país y que al
ser vulnerables a pequeñas fluctuaciones en los precios, su situación económica 
debe ser prioridad de las políticas públicas locales y nacionales.
                                '),
                        p('
Es así que surge la necesidad de contar con herramientas adecuadas que nos 
permitan ubicar de manera temprana, posibles sectores productivos en riesgo,
situación que como ya mencionamos afectaría principalmente a los pequeños
productores de la Economía Popular y Solidaria , y largo plazo escalaría otros sectores, 
y a la poste a nivel nacional. Con ese objetivo proponemos 
la construcción de indicadores de alerta temprana de los sectores productivos en el 
territorio provincial y cantonal. Partiremos de la reconstrucción la serie del Indice 
de precios al Consumidor (IPC) para todos los cantones del Ecuador, para ello haremos
uso de dos modelos, por una parte un modelo termodinámico, que estime el IPC de
determinado cantón como una función del IPC de cantones aledaños, y por otra parte
un modelo gravitacional, que además considere en la estimación a la masa económica 
(VAB) de cada cantón. 
                          '),
                        p('
A partir de lo anterior construimos un índice compuesto, proporcional al Índice de
Precios al Productor (IPP), pero inversamente proporcional al IPC estimado localmente,
así este indicador condensaría la relación Productor - Consumidor, que nos permitiría
identificar sectores en riesgo.
                          '),
                        p(tags$b('Palabras Clave:'),
                          tags$em('Modelo Gravitacional, Modelo Termodinámico, 
                                  Indicadores regionales, Indicadores compuestos, 
                                  Modelos de Riesgo')
                        ),
                        tags$br(),
                        h4('Metodología'),
                        p('
Para la construcción de este indicador se utilizarán 3 fuentes primarias: 
Índice de Precios al Consumidor (IPC), Índice de Precios al Productor (IPP), 
Valor Agregado Bruto (VAB). Debido a que el IPC de manera oficial se calcula 
mensualmente únicamente para 9 cantones se estimará los valores para el 
resto del territorio nacional. 
                          '),
                        img(src='mapa_indicadores.png',width='90%',align='center' ),
                        p('
                          Se propone realizar la reconstrucción del IPC partiendo de un modelo termodinámico, 
                          de difusión de calor, en combinación con un modelo gravitacional, para lo cual, asumimos que los
                          precios de los distintos productos en cada cantón influyen en el precio de los 
                          cantones aledaños, hecho que podría justificarse debido a que el intercambio 
                          comercial entre cantones es un factor determinante en la fijación de precios.
                          '),
                        p('El modelo propuesto en este caso es el siguiente:'),
                        withMathJax(),
                        p('$$ IPC_t^{(j)} = \\sum_{k=1}^{9} \\alpha_k IPC_t^{j_k}  $$'),
                        p('Donde:'),
                        p('\\(\\alpha_k = K g(j;j_k)     \\)'),
                        p('\\(g(j;j_k)=\\frac{M_j,M_{j_k}}{d^2(j;j_k)}     \\)'),
                        p('\\(K = (\\sum_{p=1}^{9} g(j;j_p) )^{-1}    \\)'),
                        p('Así, es evidente que \\( \\sum \\alpha_k =1  \\)')
                        
                      )
                      
                      
                      
                    )#,hr()
                    
                    
           ),
           
           # ANALISIS MULTIVARIANTE DE SERIES ============================
           tabPanel('Análisis',
                    
                    fluidRow(
                      # Panel Lateral -------------------------------
                      column(width = 2, p(" ")
                                   # h4('Panel Control Graficos'),
                                  
                                   # Seleccion de Producto IPC
                                   # selectInput('producto', 
                                   #             label= h5('Selecciona Producto'),
                                   #             selected = 2,
                                   #             choices=ProductosLista),
                                   # 
                                   # # uiOutput("moreControls")
                                   # checkboxGroupInput("periodos",
                                   #                    label = "Eligir Periodos de Corte",
                                   #                    choices = PeriodoLista,
                                   #                    selected = c(2007,2010,2015))
                      ),
                      
                      
                      # # Barra Flotante ----------------------------------
                      # absolutePanel(
                      #   top = 180, right = 50, width = 330,
                      #   draggable = TRUE,
                      #   wellPanel(
                      #     # HTML(markdownToHTML(fragment.only=TRUE, text=c(
                      #     #   "This is outputs:"
                      #     # ))),
                      #     
                      #     # h4('Panel Control Graficos'),
                      #     
                      #     # Seleccion de Producto IPC
                      #     selectInput('producto', 
                      #                 label= h5('Selecciona Producto'),
                      #                 selected = 2,
                      #                 choices=ProductosLista)#,
                      #     
                      #     # uiOutput("moreControls")
                      #     # checkboxGroupInput("periodos", 
                      #     #                    label = "Eligir Periodos de Corte", 
                      #     #                    choices = PeriodoLista,
                      #     #                    selected = c(2007,2010,2015))
                      #   ),
                      #   style = "opacity: 0.92"
                      # ),
                      
                      
                      
                      
                      # Panel Central ------------------------------------
                      column(width = 9,
                        # h3('Distribución del IPC Deflactado'),
                        h3(align="center", "Indicadores de Vulnerabilidad en Sectores Productivos" ),
                        h4(align="center", textOutput('productNombre')),hr(),
                        
                        # Mapa Cantonal Historico Animado 
                        checkboxInput(inputId="fijar_mapa",
                                      label="Fijar escala de color en el tiempo",
                                      value = FALSE),
                        tags$p(align = "center", highcharter::highchartOutput("mapaCantonal",height = "700px")),
                        tags$br(),
                        tags$br(),
                        tags$br(),
                        # tags$br(),
                        # tags$br(),
                        
                        # Graficos Series y Densidades
                        h3("Análisis de Indicadores"),
                        fluidRow(
                          
                          column(width = 6,
                                 selectInput('provincia', 
                                             label = 'Selecciona Provincia',
                                             selected = Provincias_lista[1],
                                             choices = Provincias_lista)
                          ),
                          
                          column(width = 6,
                                 selectInput('region', 
                                             label= 'Selecciona Cantón',
                                             selected = Cantones_lista[1],
                                             choices= Cantones_lista)
                          )
                          
                        ),
                        # Mapa Provincia Especifica 
                        # tags$p(align = "center", highcharter::highchartOutput("mapaProvincia",height = "300px")),
                        # tags$br(),
                        tags$br(),
                        tags$br(),
                        
                        # Analisis Grafico Indicadores (Series)
                        plotOutput('graficoDist',height = "540px",width = '100%'),
                        plotOutput('graficoVar',height = "280px",width = '100%'),
                        h4('Resumen del Modelo'),
                        
                        # Tabla de Estimaciones
                        DTOutput('resumenRegres'),
                        
                        
                        
                        
                        
                        
                        # Barra Flotante =======================================
                        absolutePanel(
                          top = 190, right = 50, width = 280,height = 80,
                          draggable = TRUE, fixed = FALSE,
                          wellPanel(
                            # HTML(markdownToHTML(fragment.only=TRUE, text=c(
                            #   "This is outputs:"
                            # ))),
                            
                            # h4('Panel Control Graficos'),
                            
                            # Seleccion de Producto IPC
                            selectInput('producto', 
                                        label= h5('Selecciona Producto'),
                                        selected = 2,
                                        choices=ProductosLista)#,
                            
                            # uiOutput("moreControls")
                            # checkboxGroupInput("periodos", 
                            #                    label = "Eligir Periodos de Corte", 
                            #                    choices = PeriodoLista,
                            #                    selected = c(2007,2010,2015))
                          ),
                          style = "opacity: 0.92"
                        ),
                        
                        absolutePanel(
                          top = 140, left = 20, width = 170,
                          draggable = TRUE, fixed = TRUE,
                          wellPanel(
                            # HTML(markdownToHTML(fragment.only=TRUE, text=c(
                            #   "This is outputs:"
                            # ))),
                            
                            # h4('Panel Control Graficos'),
                            
                            # Seleccion de Producto IPC
                            # selectInput('producto', 
                            #             label= h5('Selecciona Producto'),
                            #             selected = 2,
                            #             choices=ProductosLista)#,
                            
                            # uiOutput("moreControls")
                            checkboxGroupInput("periodos",
                                               label = "Eligir Periodos de Corte",
                                               choices = PeriodoLista,
                                               selected = c(2007,2010,2015))
                          ),
                          style = "opacity: 0.92"
                        )#,
                        
                        
                        
                        
                      )
                    )#,hr()
           )
)

