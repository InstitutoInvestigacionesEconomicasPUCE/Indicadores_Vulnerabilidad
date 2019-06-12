library(readxl)
library(dplyr)

Poblacion = read_excel("data/POBLACION_CANTONES.xlsx")

VAB2007 = read_excel("data/Can2007.xlsx")
VAB2008 = read_excel("data/Can2008.xlsx")
VAB2009 = read_excel("data/Can2009.xlsx")
VAB2010 = read_excel("data/Can2010.xlsx")
VAB2011 = read_excel("data/Can2011.xlsx")
VAB2012 = read_excel("data/Can2012.xlsx")
VAB2013 = read_excel("data/Can2013.xlsx")
VAB2014 = read_excel("data/Can2014.xlsx")
VAB2015 = read_excel("data/Can2015.xlsx")
VAB2016 = read_excel("data/Can2016.xlsx")
VAB2017 = read_excel("data/Can2017.xlsx")


# Vab_pob = Poblacion %>% left_join(VAB2017,by= c("PROVINCIA","COD_PROVINCIA","CANTON","COD_CANTON"))
Vab_pob = Poblacion %>% left_join(VAB2017,by= c("PROVINCIA","COD_PROVINCIA","CANTON"))

