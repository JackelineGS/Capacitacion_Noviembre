## ----setup, include=FALSE-------------------------
options(htmltools.dir.version = FALSE)


## ----xaringan-themer, warning=FALSE, include=FALSE----
library(xaringanthemer)

style_mono_accent(
  base_color       = "#E94B4F",
  padding          = "16px 50px 12px 50px",
  code_font_google = google_font("Fira Mono")
)



## ----xaringanExtra, echo=FALSE--------------------
#devtools::install_github("gadenbuie/xaringanExtra")
library(xaringanExtra)

xaringanExtra::use_xaringan_extra(c("tile_view", "tachyons", "panelset"))

xaringanExtra::use_tile_view()

xaringanExtra::use_editable()

xaringanExtra::use_scribble()

xaringanExtra::use_logo(
  image_url ="imagenes/logo.png", 
  link_url = "https://medicionpsicologica.com",
  width = 120, 
  height = 120
  )

xaringanExtra::use_clipboard(
  button_text = "Copiar",
  success_text = "Copiado",
  error_text = "Presiona Ctrl+C para copiar"
)

xaringanExtra::use_fit_screen()

xaringanExtra::use_extra_styles(
  hover_code_line = TRUE,          #<<
  mute_unhighlighted_code = FALSE  #<<
)



## ----echo = FALSE, out.width = "100%"-------------
knitr::include_graphics("imagenes/ggplot2_capas_básicas.png", dpi = 500)


## ----message = FALSE, warning = FALSE-------------
library(tidyverse)                


## ---- eval = FALSE--------------------------------
## ggplot(data = iris)


## ----echo = FALSE, fig.height = 5.5, fig.width = 5.5, fig.align = "center"----
ggplot(data = iris)


## ---- eval = FALSE--------------------------------
## ggplot(data = iris,
##        aes(x = Petal.Length,   #<<
##            y = Sepal.Length))  #<<


## ----echo = FALSE, fig.height = 5.5, fig.width = 5.5, fig.align = "center"----
ggplot(data = iris,
       aes(x = Petal.Length,
           y = Sepal.Length))  


## ---- eval = FALSE--------------------------------
## ggplot(data = iris,
##        aes(x = Petal.Length,
##            y = Sepal.Length)) +
##        geom_point()             #<<


## ----echo = FALSE, fig.height = 5.5, fig.width = 5.5, fig.align = "center"----
ggplot(data = iris,
       aes(x = Petal.Length,
           y = Sepal.Length)) +
       geom_point()


## ----echo = FALSE---------------------------------
library(countdown)


## -------------------------------------------------
countdown(minutes = 10, seconds = 10, play_sound = TRUE)


## ---- eval = FALSE--------------------------------
## ggplot(data = iris,
##        aes(x = Petal.Length,
##            y = Sepal.Length,
##            colour = Species)) +  #<<
##        geom_point()


## ----echo = FALSE, fig.height = 5, fig.width = 5, fig.align = "center"----
ggplot(data = iris,
       aes(x = Petal.Length,
           y = Sepal.Length,
           colour = Species)) +
       geom_point()


## ---- eval = FALSE--------------------------------
## ggplot(data = iris,
##        aes(x = Petal.Length,
##            y = Sepal.Length,
##            colour = Species)) +
##        geom_point() +
##        theme_classic()         #<<


## ----echo = FALSE, fig.height = 5, fig.width = 5, fig.align = "center"----
ggplot(data = iris,
       aes(x = Petal.Length,
           y = Sepal.Length,
           colour = Species)) +
       geom_point() +
       theme_classic()


## ---- eval = FALSE--------------------------------
## ggplot(data = iris,
##        aes(x = Petal.Length,
##            y = Sepal.Length,
##            colour = Species)) +
##        geom_point() +
##        theme_classic() +
##        labs(                                        #<<
##        title = "Distribución de las especies",      #<<
##        subtitle = "Gráfica propia"                  #<<
##        caption  = "Avances en Medición Psicólogica" #<<
##        )                                            #<<


## ----echo = FALSE, fig.height = 5, fig.width = 5, fig.align = "center"----
ggplot(data = iris,
       aes(x = Petal.Length,
           y = Sepal.Length,
           colour = Species)) +
       geom_point() +
       theme_classic() +
       labs(                                    
       title = "Distribución de las especies",  
       subtitle = "Gráfica propia",      
       caption  = "Avances en Medición Psicólogica"
       )                                      

