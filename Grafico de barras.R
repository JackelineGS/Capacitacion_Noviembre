
#Crear proyecto
#Cargar paquetes
library("pacman")
pacman::p_load(tidyverse)
#Importación

BD <- readxl::read_excel("data3_clean.xlsx")

#Visualización de la data - variables

glimpse(BD)

# Gráfico de barras

BD %>%
  ggplot(aes(x = escuela)) +
  geom_bar(fill = "steelblue") +
  theme_bw()


# Gráfico de barras

BD %>% 
  count(ase_cat) %>% 
  mutate(
    ase_cat = factor(ase_cat),
    n  = factor(n)
  ) %>% 
  ggplot(aes(y = n, 
             x = ase_cat, 
             y = ase_cat)) +
  geom_col()

#colour = Species

#falta agregar guides

BD %>% 
  count(escuela, sexo) %>% 
  mutate(
    escuela = factor(escuela),
    sexo  = factor(sexo)
  ) %>% 
  ggplot(aes(y = n, x = escuela, fill = sexo)) +
  geom_col() +
  geom_label(aes(label = n),position = position_stack(vjust = 0.5)) +
  labs(
    title = "Tipos de escuela según sexo",
    x = "Escuelas",
    y = ""
  ) + theme_bw() +
  facet_wrap(var(sexo))


data3 <- readxl::read_excel("data3_clean.xlsx")
names(data3)

library(ggplot2)

ggplot(data = data3,
       aes(x = bur_cat,   #<<
           y = bur_total)) +
  geom_col()









  
  



