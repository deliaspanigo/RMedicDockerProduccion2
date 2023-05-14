# # # # #  Un RStudio...
FROM rocker/rstudio:4.3.0

# # # # #  Le instalamos tambien un servidor Shiny...
RUN /rocker_scripts/install_shiny_server.sh

# Automaticamente pasa lo siguiente:
# 1) Por el puerto 3838 te conectas a la app Shiny
# 2) Por el puerto 8787 te conectas a RStudio para trabajar desde el docker

################################################################################################


# # # # # Instalacion de Librerias
ENV RENV_VERSION 0.17.3
RUN R -e "install.packages('remotes', repos = c(CRAN = 'https://cloud.r-project.org'))"
RUN R -e "remotes::install_github('rstudio/renv@${RENV_VERSION}')"

WORKDIR /project
COPY renv.lock renv.lock
RUN R -e "renv::restore()"

################################################################################################



# # # Contenido para RStudio
WORKDIR /home/rstudio/
RUN git clone https://github.com/deliaspanigo/RMedic.git

################################################################################################


## FORMA 01 
## Me sale Index... Y tengo que elegir RMedic...
##  Contenido para Shiny
RUN rm -rf /srv/shiny-server/*
WORKDIR /srv/shiny-server/
RUN git clone https://github.com/deliaspanigo/RMedic.git .

################################################################################################


# FORMA 02
# Contenido para Shiny
# RUN rm -rf /srv/shiny-server/*
# WORKDIR /srv/shiny-server/
# COPY ./RMedic* ./ 
# RUN git clone https://github.com/deliaspanigo/RMedic.git

################################################################################################







