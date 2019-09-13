# Pacotes -----------------------------------------------------------------

library(dplyr)

# Base de dados -----------------------------------------------------------

imdb <- read_rds("dados/imdb.rds")
bd_exp <- read_rds("dados/bd_exp.rds")
legendas <- read_rds("dados/legendas.rds")

# ---------------------------------------------------
# Vamos ver:

# pipe (%>%) - Um operador muito útil!
# select() - seleciona colunas
# arrange() - ordena a tabela
# filter() - filtra linhas
# mutate() - cria colunas novas
# summarise() - sumariza a tabela
# group_by() + summarise() - sumariza a tabela para cada grupo
# left_join() - une duas tabelas (caso particular é o PROCV do Excel)
# gather()/spread() - Muda o formato da tabela: 'derrete' ou 'condensa' a tabela

# ---------------------------------------------------
# Exemplo de código que aprenderemos a fazer ao fim dessa aula:

tabela <- bd_exp %>%
  filter(turma %in% c(51, 91)) %>%
  mutate(
    faixa_etaria = case_when(
      is.na(Idade0) ~ "não informado",
      Idade0 <  12 ~ "a até 11 anos",
      Idade0 <  14 ~ "b até 13 anos",
      Idade0 >= 14 ~ "c 14 anos ou mais"
    )
  ) %>%
  group_by(turma, Sexo, faixa_etaria) %>%
  summarise(
    sal_memor_i01_1_medio = mean(sal_memor_i01_1, na.rm = TRUE),
    sal_memor_i01_1_desvpad = sd(sal_memor_i01_1, na.rm = TRUE)
  ) %>%
  ungroup() %>%
  arrange(turma, Sexo, faixa_etaria) %>%
  left_join(
    legendas %>% filter(variavel %in% "Sexo") %>% select(-variavel),
    by = c("Sexo" = "Legenda")
  ) %>%
  select(-Sexo) %>%
  rename(Sexo = categoria)

tabela
  

# Pipe (%>%) --------------------------------------------------------------

# g(f(x)) = x %>% f() %>% g()

# Receita de bolo sem pipe. Tente entender o que é preciso fazer.

esfrie(
  asse(
    coloque(
      bata(
        acrescente(
          recipiente(
            rep(
              "farinha", 
              2
            ), 
            "água", "fermento", "leite", "óleo"
          ), 
          "farinha", até = "macio"
        ), 
        duração = "3min"
      ), 
      lugar = "forma", tipo = "grande", untada = TRUE
    ), 
    duração = "50min"
  ), 
  "geladeira", "20min"
)

# Veja como o código acima pode ser reescrito utilizando-se o pipe. 

recipiente(rep("farinha", 2), "água", "fermento", "leite", "óleo") %>%
  acrescente("farinha", até = "macio") %>%
  bata(duração = "3min") %>%
  coloque(lugar = "forma", tipo = "grande", untada = TRUE) %>%
  asse(duração = "50min") %>%
  esfrie("geladeira", "20min")

# ATALHO: CTRL + SHIFT + M


# select ------------------------------------------------------------------
glimpse(imdb)

# exemplo 1

imdb %>% select(titulo, ano, orcamento)

# exemplo 2 

imdb %>% select(starts_with("ator"))

# exemplo 3

imdb %>% select(-starts_with("ator"), -titulo)

# Exercício 1
# Crie uma tabela com apenas as colunas Sexo, turma e Idade0. Salve em um
# objeto chamado bd_exp_simples.


# Exercício 2
# Remova as colunas que comecem com 'sal'. Salve em um
# objeto chamado bd_exp_sem_sal.

# arrange -----------------------------------------------------------------

# exemplo 1

imdb %>% arrange(orcamento)

# exemplo 2

imdb %>% arrange(desc(orcamento))

# exemplo 3

imdb %>% arrange(desc(ano), titulo)

# exercício 1
# Ordene os sujeitos em ordem crescente de serie e decrescente de Idade0 e salve 
# em um objeto chamado bd_exp_ordenados



# exemplo 4
# NA

df <- tibble(x = c(NA, 2, 1), y = c(1, 2, 3))
arrange(df, x)


# Exercício 2: encadeamento de select() e arrange() com o '%>%'
# Selecione apenas as colunas Idade0 e sal_cexp_i03_1
# e então ordene de forma decrescente pelo sal_cexp_i03_1



# filter ------------------------------------------------------------------

# exemplo 1
imdb %>% filter(nota_imdb > 9)

# exemplo 2
filmes_bons <- imdb %>% filter(nota_imdb > 9)
filmes_bons

# exemplo 3
filmes_bons <- filmes_bons %>% filter(orcamento < 1000000)
filmes_bons

# exemplo 5
imdb %>% filter(ano > 2010 & nota_imdb > 8.5)
imdb %>% filter(orcamento < 100000 & receita > 1000000)

imdb %>% filter(receita > orcamento)
imdb %>% filter(receita > orcamento + 500000000)
imdb %>% filter(receita > orcamento + 500000000 | nota_imdb > 9)

imdb %>% filter(ano > 2010)
imdb %>% filter(!ano > 2010)
imdb %>% filter(!receita > orcamento)

# exercício 1
# Criar um objeto chamado notas_altas com alunos que tiveram nota no sal_cexp_i03_1 
# maior do que 2

# exercício 2
# Criar um objeto chamado com_carros_e_geladeira com alunos que tem carro(s) e geladeira(s)

# exercício 3
# Criar um objeto meninos_da_turma_51_ou_91 com apenas os alunos do sexo masculino e que estão
# nas turmas 51 ou 91.

# Exercício 4
# Crie uma tabela apenas com meninos da turma 51 ou 91 e apenas as colunas Idade0 e sal_cexp_i03_1,
# ordenadas de forma decrescente pelo sal_cexp_i03_1.

# exemplo 6
# %in%

pitts <- imdb %>% filter(ator_1 %in% c('Angelina Jolie Pitt', "Brad Pitt"))

# exercicio 6
# Refaça o exercício 5 usando o %in%.

# exemplo 7
df <- tibble(x = c(1, NA, 3))
filter(df, x > 1)
filter(df, is.na(x) | x > 1)

imdb %>% filter(is.na(orcamento))

# exercício 7
# Identifique os alunos que não possuem informação de Idade0


# exemplo 8
# str_detect

imdb %>% filter(str_detect(generos, "Action"))

# exercício 8
# Salve em um objeto action_comedy os filmes de Action e Comedy com nota_imdb maior do que 8.

###############################################################################################
# UM GRANDE E IMPORTANTE PARENTESES: Como o R enxerga os filtros por trás.
# O R transforma tudo em vetores de TRUE ou FALSE (chamamos de vetores lógicos)
# E ele vai pegar só aquelas posições em que tiver TRUE (e vai apagar as que forem FALSE).
# Exemplos...
x <- 1:10
x > 5

imdb$nota_imdb > 8
bd_exp$turma != 91
!bd_exp$turma %in% c(91, 92)


###############################################################################################

# mutate ------------------------------------------------------------------

# exemplo 1

imdb %>% mutate(duracao = duracao/60)

# exemplo 2

imdb %>% mutate(duracao_horas = duracao/60)

# exercício 1
# Crie uma variável chamada maior_de_12_anos. Salve em um objeto chamado bd_exp_12.

# exercicio 2
# Modifique a variável Idade0 para ficar na unidade de meses.


# exemplo 3 (extra) -----------------------------------------------
# gêneros
# https://github.com/meirelesff/genderBR

# install.packages("gender")
library(gender)

gender(c("William"), years = 2012)
gender(c("Robin"), years = 2012)

gender(c("Madison", "Hillary"), years = 1930, method = "ssa")
gender(c("Madison", "Hillary"), years = 2010, method = "ssa")

gender("Matheus", years = 1920)

obter_genero <- function(nome, ano) {
  
  if (is.na(nome) | is.na(ano)) {
    return(NA_character_)
  }
  
  ano_min <- ano - 60
  ano_max <- ano - 30
  
  if (ano_min < 1880) {
    ano_min <- 1880
  }
  
  genero <- gender(nome, years = c(ano_min, ano_max), method = "ssa")$gender
  
  if(length(genero) == 0) {
    genero <- NA_character_
  }
  
  genero
}

obter_genero("Madison", 1930)
obter_genero("Matheus", 1930)

# demora +- 10 min.
imdb_generos <- imdb %>%
  select(diretor, ano) %>%
  distinct() %>%
  mutate(
    diretor_primeiro_nome = str_extract(diretor, ".* ") %>% str_trim(),
    genero = map2_chr(diretor_primeiro_nome, ano, obter_genero)
  )

# saveRDS(imdb_generos, "data/imdb_generos.rds")
imdb_generos <- read_rds("dados/imdb_generos.rds")


# summarise ---------------------------------------------------------------

# exemplo 1

imdb %>% summarise(media_orcamento = mean(orcamento, na.rm=TRUE))

# exemplo 2

imdb %>% summarise(
  media_orcamento = mean(orcamento, na.rm=TRUE),
  mediana_orcamento = median(orcamento, na.rm = TRUE)
)

# exemplo 3

imdb %>% summarise(
  media_orcamento = mean(orcamento, na.rm=TRUE),
  mediana_orcamento = median(orcamento, na.rm = TRUE),
  qtd = n(),
  qtd_diretores = n_distinct(diretor)
)

# exemplo 4

imdb_generos %>%
  summarise(n_diretora = sum(genero == "female", na.rm = TRUE))

# exercício 1
# Calcule a duração média e mediana dos filmes da base imdb.

# exercício 2
# Calcule a nota média de senna_O_IntCur_i25_1 e senna_N_LAnx_i10_1 dos meninos.

# exercício 3 (difícil)
# Use o `summarise` para calcular a proporção de meninas na base de dados.

# group_by + summarise ----------------------------------------------------

# exemplo 1

imdb %>% group_by(ano)

# exemplo 2

imdb %>% 
  group_by(ano) %>% 
  summarise(qtd_filmes = n())

# exemplo 3

imdb %>% 
  group_by(diretor) %>% 
  summarise(qtd_filmes = n())

# exercício 1
# Crie uma tabela com as quantidades de alunos por turma.

# exercício 2
# Crie uma tabela com a média e mediana de sal_scverb_i44_1 por turma e Sexo.

# exemplo 4

imdb %>%
  filter(str_detect(generos, "Action"), !is.na(diretor)) %>%
  group_by(diretor) %>%
  summarise(qtd_filmes = n()) %>%
  arrange(desc(qtd_filmes))

# exemplo 5

imdb %>% 
  filter(ator_1 %in% c("Brad Pitt", "Angelina Jolie Pitt")) %>%
  group_by(ator_1) %>%
  summarise(
    orcamento = mean(orcamento), 
    receita = mean(receita), 
    qtd = n()
  )

# left join ---------------------------------------------------------------

# exemplo 1
imdb_generos2 <- imdb %>%
  left_join(
    imdb_generos, 
    by = c("diretor", "ano")
  )

# exemplo 2
depara_cores <- tibble(
  cor = c("Color", "Black and White"),
  cor2 = c("colorido", "pretoEbranco")
)

imdb_cor <- left_join(imdb, depara_cores, by = "cor")

# exemplo 3

imdb_generos3 <- imdb %>%
  left_join(
    imdb_generos, 
    by = c("diretor" = "diretor", "ano" = "ano")
  )

# exercicio 1
# Vamos trocar os códigos das turmas pelos rótulos de verdade.
legenda_da_turma <- legendas %>% 
  filter(variavel %in% "Série") %>% 
  select(-variavel)

tabela_da_turma <- bd_exp %>% count(turma)


# exercicio 2
# Repita o exercício 1, mas agora para a variável Sexo



# Para conhecimento, existem outros joins: inner_join, full_join, rigth_join...

# gather ------------------------------------------------------------------

# exemplo 1
imdb_gather <- imdb %>% gather("importancia_ator", "nome_ator", starts_with("ator"))

# exemplo 2 (vamos ao excel!)

# spread ------------------------------------------------------------------

# exemplo 1

imdb <- spread(imdb_gather, importancia_ator, nome_ator)


# Exercício final
# 1) filtre apenas os alunos que possuem informação de Idade0 (use is.na()).
# 2) selecione as colunas 'turma' e todas aquelas que começam com 'senna'. (select() + starts_with())
# 3) faça um gather() nas questoes que começam com 'senna'.
# 4) tire a média das notas de cada uma dessas perguntas e turmas. (group_by() + summarise() + mean())
