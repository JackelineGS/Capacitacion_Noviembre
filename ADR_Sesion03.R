###############################################################################
##########                                                           ##########
##########          Curso-Taller: Análisis de Datos con R            ##########
##########                       Sesión 03                           ##########
##########          Avances en Medición Psicológica (AMP)            ##########
##########                                                           ##########
###############################################################################

# Preparando paquetes
library(tidyverse) # Manipulación y visualización de datos
library(openxlsx)  # Exportar archivos excel
library(patchwork) # Manipulación de gráficos

# library(pacman)
# pacman::p_load(tidyverse, openxlsx, patchwork)

# Importación de datos
salud_mental_df <- readxl::read_excel("data1_clean.xlsx")

# Reconocimiento de variables
glimpse(salud_mental_df)

# Gráficos con ggplot2 ----

## Introducción con histogramas ----
# Los gráficos en ggplot se realizan a través de capas que van
# adicionando una tras otra mediante el operador `+`
salud_mental_df %>%
  ggplot() # Se dibuja un espacio que será usado para gráficos

salud_mental_df %>%
  ggplot(aes(x = depresion)) # La variable depresión será usado en el eje X.

salud_mental_df %>%
  ggplot(aes(x = depresion)) +
  geom_histogram() # Solicita que se dibuje un histograma con los datos

salud_mental_df %>%
  ggplot(aes(x = depresion)) +
  geom_histogram(binwidth = 1) # Controlas el ancho de las barras

salud_mental_df %>%
  ggplot(aes(x = depresion)) +
  geom_histogram(binwidth = 1,
                 fill = "steelblue") # Especifica el color del relleno

salud_mental_df %>%
  ggplot(aes(x = depresion)) +
  geom_histogram(binwidth = 1,
                 color = "black", # Especifica sobre el color del contorno
                 fill = "#D7B3FF") +
  theme_bw() # Un tema pre-configurado relativamente limpio

## Configuraciones adicionales ----

# Hay algunos elementos adicionales sobre las cuales podemos tener control,
# como por ejemplo: título, subtítulo, leyendas, nombres en los ejes,
# límites en los ejes, etc.

# Ahora mismo el gráfico tiene esta configuración
salud_mental_df %>%
  ggplot(aes(x = depresion)) +
  geom_histogram(binwidth = 1,
                 color = "black",
                 fill = "#D7B3FF") +
  labs(
    title = NULL,
    subtitle = NULL,
    x = "depresion",
    y = "count"
  ) +
  theme_bw()

# Vamos a modificarlo un poco

p1 <- salud_mental_df %>%
  ggplot(aes(x = depresion)) +
  geom_histogram(binwidth = 1,
                 color = "black",
                 fill = "#D7B3FF") +
  labs(
    title = "Distribución de puntajes de depresión",
    subtitle = "Base de datos 1 - Taller AMP",
    x = "Depresión",
    y = "Frecuencia"
  ) +
  theme_bw()

p1 # En el bloque anterior guardamos el gráfico con este nombre

p1 + # Sobre lo anterior creado, se pueden adicionar más cosas
  scale_y_continuous( # Personalizar el eje Y
    limits = c(0, 100)
  )

# Gráfico de barras ----

salud_mental_df %>%
  ggplot(aes(x = sueño_cat)) +
  geom_bar(fill = "steelblue") +
  theme_bw()

salud_mental_df %>%
  ggplot(aes(y = sueño_cat)) +
  geom_bar(fill = "steelblue") +
  theme_bw()

salud_mental_df %>%
  ggplot(aes(y = sueño_cat)) +
  geom_bar(fill = "steelblue") +
  theme_bw()

# ¿Y si queremos trabajar con porcentajes?

salud_mental_df %>%
  count(sueño_cat) %>%
  mutate(Porcentaje = n/sum(n)) # Necesitamos esto

p2 <- salud_mental_df %>%
  count(sueño_cat) %>%
  mutate(Porcentaje = n/sum(n)) %>%
  ggplot(aes(x = Porcentaje,
             y = sueño_cat)) +
  geom_col(fill = "steelblue") + # Se usa geom_col, cuando se tiene una tabla
  theme_bw()

p2 +
  scale_x_continuous(
    labels = scales::percent_format()
  )

p2 +
  scale_x_continuous(
    limits = c(0, 0.8),
    labels = scales::percent_format()
  )

p2 <- p2 +
  scale_x_continuous(
    limits = c(0, 0.8),
    labels = scales::percent_format()
  ) +
  labs(
    title = "Porcentaje de las categorías de calidad de sueño",
    subtitle = "Base de datos 1 - Taller AMP",
    x = NULL,
    y = NULL
  )

p2

# ¿La calidad de vida en mujeres y varones será igual?

p2 +
  facet_wrap(vars(sexo))

# Error: At least one layer must contain all faceting variables: `sexo`.
# ¿Qué significa eso?

salud_mental_df %>%
  count(sueño_cat) %>%
  mutate(Porcentaje = n/sum(n))

# Básicamente que, de la tabla donde estamos dibujando el gráfico de barras
# no tenemos la variable sexo integrada. Vamos a añadirlo.

salud_mental_df %>%
  count(sexo, sueño_cat) %>%
  group_by(sexo) %>%
  mutate(Porcentaje = n/sum(n)) %>%
  ungroup()

# Ahora si, agreguemos lo anterior de ggplot + facet_wrap

salud_mental_df %>%
  count(sexo, sueño_cat) %>%
  group_by(sexo) %>%
  mutate(Porcentaje = n/sum(n)) %>%
  ungroup() %>%
  ggplot(aes(x = Porcentaje,
             y = sueño_cat)) +
  geom_col(fill = "steelblue") + # Se usa geom_col, cuando se tiene una tabla
  theme_bw() +
  facet_wrap(vars(sexo))

p2 <- salud_mental_df %>%
  count(sexo, sueño_cat) %>%
  group_by(sexo) %>%
  mutate(Porcentaje = n/sum(n)) %>%
  ungroup() %>%
  ggplot(aes(x = Porcentaje,
             y = sueño_cat)) +
  geom_col(fill = "steelblue") +
  scale_x_continuous(
    limits = c(0, 0.8),
    labels = scales::percent_format()
  ) +
  labs(
    title = "Porcentaje de las categorías de calidad de sueño",
    subtitle = "Base de datos 1 - Taller AMP",
    x = NULL,
    y = NULL
  ) +
  theme_bw() +
  facet_wrap(vars(sexo))

p2

# Gráfico boxplot ----

salud_mental_df %>%
  ggplot(aes(y = sueño)) +
  geom_boxplot() +
  theme_bw()


salud_mental_df %>%
  ggplot(aes(y = sueño,
             x = sexo)) +
  geom_boxplot() +
  theme_bw()

p3 <- salud_mental_df %>%
  ggplot(aes(y = sueño,
             x = sexo)) +
  geom_boxplot(aes(fill = sexo)) +
  theme_bw()

p3 <- p3 +
  labs(
    title = "Puntajes de la calidad de sueño de acuerdo al sexo",
    subtitle = "Base de datos 1 - Taller AMP",
    x = NULL,
    y = NULL,
    fill = NULL
  )

p3 +
  scale_fill_manual(
    values = c("#2fe1b3", "#e12f78")
  )

# Scatterplot

p4 <- salud_mental_df %>%
  ggplot(aes(x = ansiedad,
             y = sueño)) +
  geom_point() +
  geom_smooth() +
  theme_bw()

p4

p4 <- p4 +
  labs(
    title = "Relación entre ansiedad y sueño",
    subtitle = "Base de datos 1 - Taller AMP",
    x = "Ansiedad",
    y = "Sueño"
  )

p4

# Exportar gráficos ----

ggsave(filename = "Gráfico de histrogramas.png",
       plot = p1,
       width = 6,
       height = 4,
       dpi = 300)


# Manipular gráficos con patchwork ----

## Uso básico ----
p1 + p2
p1 + p2 + p3
p1 + p2 + p3 + p4 #Por defecto, patchwork intentará
                  #completar el orden de filas

## Específicar distribución con plot_layout ----

# Filas y columnas
p1 + p2 + p3 + p4 + plot_layout(nrow = 1)
p1 + p2 + p3 + p4 + plot_layout(nrow = 4)

# Dimensiones
p1 + p2 + p3 + p4 + plot_layout(widths = c(2, 1))


## Posición de gráficos ----

# izquierda | derecha (| = alt + 124)
p1 | p3

# arriba / abajo
p2 / p4

# Izquierda, derecha, arriba, abajo
(p1 | p2) / p3

p1 | (p2 / p3)


## Agregar etiquetas con plot_annotation ----

# tags
(p1 | (p2 / p3)) +
  plot_annotation(tag_levels = c("A"))  # a, 1, I

# título, subtítulo y leyenda
(p2 + p3) +
  plot_annotation(
    title    = "Calidad de sueño",
    subtitle = "Puntaje total y categorías",
    caption  = "Avances en Medición Psicológica"
    )

p5 <- (p2 + p3) +
  plot_annotation(
    title    = "Calidad de sueño",
    subtitle = "Puntaje total y categorías",
    caption  = "Avances en Medición Psicológica",
    theme = theme(plot.title = element_text(size = 25, hjust = 0.5),
                  plot.subtitle = element_text(size = 18, hjust = 0.5))
    )

p5

## Exportar gráficos ----

ggsave(filename = "patchwork.png",
       plot = p5,
       height = 5,
       width = 8,
       scale = 1.5,
       dpi = 300)


# Complementos para ggplot2

#install.packages("plotly")
library(plotly)

ggplotly(p1)
ggplotly(p2)


#install.packages("gganimate")
library(gganimate)
library(datos)

glimpse(paises)

paises %>%
  filter(pais == "Perú") %>%
  ggplot(aes(x = anio, y = esperanza_de_vida)) +
  geom_line(color = "blue",
            size = 2) +
  labs(x = "esperanza de vida",
       y = "año") +
  transition_reveal(anio) +
  shadow_mark()


#install.packages("esquisse")
library(esquisse)

esquisse::esquisser(salud_mental_df)

ggplot(salud_mental_df) +
  aes(x = sueño_cat) +
  geom_bar(fill = "#4682B4") +
  labs(
    title = "Porcentaje de las categorías de calidad de sueño",
    subtitle = "Base de datos 1 - Taller AMP"
  ) +
  coord_flip() +
  theme_bw() +
  facet_wrap(vars(sexo))



