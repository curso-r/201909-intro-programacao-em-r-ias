library(tidyverse)
library(readxl)
library(readr)
library(skimr)

# leitura da aba 'bd_exp' --------------------------------------------------

bd_exp <- # preencher aqui. DICA: linha 137 do arquivo 02-importacao
  
# um pouco de vocabulario pra explorar um data.frame (tabela)
View(bd_exp)
glimpse(bd_exp)
names(bd_exp)
head(bd_exp)
tail(bd_exp)
bd_exp$cod_suj
bd_exp[1:10, 1:5]
table(bd_exp$turma)
unique(bd_exp$turma)
skim(bd_exp)

# guarda a tabela no computador
write_rds(bd_exp, "dados/bd_exp.rds")





# legendas --------------------------------------------------------------------------
# ATENÇÃO: CÓDIGO DE R AVANÇADO, SÓ VOLTAREMOS A FALAR DELE APÓS A AULA DE MANIPULAÇÃO DE DADOS

legendas <- read_excel("dados/senna_sal_ex1.xlsx", sheet = "legenda_arrumada")

# 'Com quem mora' e 'Quem ajuda estudar' esvatam na forma "errada" ------------------
com_quem_mora <- read_excel("dados/senna_sal_ex1.xlsx", sheet = "com_quem_mora") %>%
  gather(categoria, Legenda, sim, não) %>%
  rename(
    variavel = `Com quem mora`
  ) %>%
  arrange(variavel)

quem_ajuda_estudar <- read_excel("dados/senna_sal_ex1.xlsx", sheet = "quem_ajuda_estudar") %>%
  gather(categoria, Legenda, Ajuda, `Não ajuda`) %>%
  rename(
    variavel = `Quem ajuda estudar`
  ) %>%
  arrange(variavel)

# junta as duas tabelinhas com a tabela principal -----------------------------------
legendas <- legendas %>%
  bind_rows(
    com_quem_mora,
    quem_ajuda_estudar
  )

write_rds(legendas, "dados/legendas.rds")
