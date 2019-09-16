
# Caminhos até o arquivo --------------------------------------------------

# 1. Podem ser absolutos
"/home/william/Documents/Curso-R/intro-programacao-em-r-mestre/dados/imdb.csv"

# 2. Podem ser relativos ao diretório de trabalho
getwd()

# Arquivo de texto --------------------------------------------------------

library(readr)

imdb <- read_csv(file = "dados/imdb.csv")
imdb2 <- read_delim("dados/imdb2.csv", delim = ";")

View(imdb)

# Classes -----------------------------------------------------------------

# Data frame
class(imdb)

# Numeric
obj <- 1
class(obj)

# Character
obj <- "a"
class(obj)

# Variáveis
class(imdb$ano)
class(imdb$titulo)


# Coerção

class(c(1, 2, 3))

vetor <- c(1, 2, 3, "a")
c(1, 2, 3, "a") -> vetor
c(TRUE, FALSE, "a")
class(c(1L, 2L))
c(TRUE, FALSE, 1)

# character > numeric > inteiro > lógico

# Valores especiais -------------------------------------------------------

# Existem valores reservados para representar dados faltantes, 
# infinitos, e indefinições matemáticas.

NA   # (Not Available) significa dado faltante/indisponível. 

NaN  # (Not a Number) representa indefinições matemáticas, como 0/0 e log(-1). 
# Um NaN é um NA, mas a recíproca não é verdadeira.

Inf  # (Infinito) é um número muito grande ou o limite matemático, por exemplo, 
# 1/0 e 10^310. Aceita sinal negativo -Inf.

NULL # representa a ausência de informação.

# Lendo vários arquivos ---------------------------------------------------

imdb_2013 <- read_csv("dados/por-ano/imdb-2013.csv")
imdb_2014 <- read_csv("dados/por-ano/imdb-2014.csv")
imdb_2015 <- read_csv("dados/por-ano/imdb-2015.csv")

imdb <- rbind(imdb_2013, imdb_2014)

imdb <- rbind(imdb, imdb_2015)

# Comparações lógicas ------------------------------------------------------

1 > 0
2 < 1
3 == 3
3 != 1
5 %in% c(2, 4, 5)

# Use as funções is.na(), is.nan(), is.infinite() e is.null() 
# para testar se um objeto é um desses valores.

1 == NA

is.na(NA)

a <- NA
is.na(NA)

# Controle de fluxo -------------------------------------------------------

# if/else
x <- 0

if(x < 0) {
  "negativo"
} else if(x == 0) {
  "neutro"
} else {
  "positivo"
}

seq(1, 10, 2)

# for
for(i in 1:10) {
  if(i %% 2 != 0) {
    texto <- paste0("Essa é a repetição ", i, "!")
    print(texto)
  }
}

# Lendo vários arquivos 2 -------------------------------------------------

arquivos <- list.files(
  "dados/por-ano/", 
  full.names = TRUE
)

for(caminho in arquivos) {
  
  base <- read_csv(caminho)
  
  if(caminho == arquivos[1]) {
    base_final <- base
  } else {
    base_final <- rbind(base_final, base)
  }
  
}

# Excel -------------------------------------------------------------------
library(readxl)

imdb_excel <- read_excel("dados/imdb.xlsx", sheet = "Sheet1")

# SQL ---------------------------------------------------------------------

conexao <- src_sqlite("dados/imdb.sqlite", create = TRUE)
# copy_to(conexao, imdb, temporary = FALSE)

imdb_sqlite <- tbl(conexao, "imdb")
imdb_select <- tbl(conexao, sql("SELECT titulo, ano, diretor FROM imdb"))

# trazer para a memória
collect(imdb_sqlite)
collect(imdb_select)

# db.rstudio.com

# Outros formatos ---------------------------------------------------------

library(jsonlite)
imdb_json <- read_json("dados/imdb.json")

library(haven)

imdb_sas <- read_sas("dados/imdb.sas7bdat")
imdb_spss <- read_spss("dados/imdb.sav")

# pacote rio
library(rio)
imdb_rio <- rio::import("dados/imdb.xlsx")