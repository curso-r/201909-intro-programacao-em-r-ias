# Nome dos objetos/variáveis ----------------------------------------------

# Os nomes devem começar com uma letra. Podem conter letras, números, _ e .

eu_uso_snake_case
outrasPessoasUsamCamelCase
algumas.pessoas.usam.pontos
E_algumasPoucas.Pessoas_RENUNCIAMconvenções

# Criando objetos/variáveis -----------------------------------------------

obj <- 1
obj

# ATALHO para rodar o código: CTRL + ENTER
# ATALHO para a <- : ALT - (alt menos)

# O R difencia minúscula de maiúscula!

a <- 5
A <- 42

# Vetores -----------------------------------------------------------------

# Ver figura img/vetores.png

# Vetores são conjuntos ordenados de números

c(1, 4, 3, 10)

1:10

# Subsetting

vetor <- c(4, 8, 15, 16, 23, 42)

vetor[1]
vetor[c(1, 3)]
vetor[-5]
vetor[-c(1, 3)]

# Operações vetoriais

a <- 1:3
b <- 4:9

a + 1
b * 2
a + b

# Texto -------------------------------------------------------------------

# Caracteres (character, strings)

obj <- "a"
obj2 <- "masculino"


# Lógicos -----------------------------------------------------------------

obj <- TRUE
obj

obj2 <- FALSE
obj2

# Funções -----------------------------------------------------------------

# Argumentos e ordem

seq(to = 10, from = 1, by = 2)
seq(1, 10, 2)

# Funções dentro de funções

mean(seq(1, 10, 2))

# Guardando as saídas

y <- seq(1, 10, length.out = 5)
y

# Criando funções

minha_soma <- function(x, y) {
  
  x + y
  
}

minha_soma(2, 3)

# Retornando explicitamente

minha_soma2 <- function(x, y) {
  
  x <- x^2
  y <-y^2
  
  soma <- x + y
  
  return(soma)
  
}

minha_soma2(1, 2)

# Identação ---------------------------------------------------------------

funcao_com_muitos_argumentos(argumento_1 = 10, argumento_2 = 14, argumento_3 = 30, argumento_4 = 11)

# ATALHO: CTRL+I

# Pacotes -----------------------------------------------------------------

# Para instalar pacotes

install.packages(c("tidyverse", "rmarkdown", "devtools"))

# Para carregar pacotes

library(dplyr)

# Também é possível acessar as funções usando ::

dplyr::select()

# Tidyverse ---------------------------------------------------------------

# O tidyverse é um pacote de pacotes.

library(tidyverse)

# Os pacotes do tidyverse seguem uma mesma filosofia e sintaxe.

