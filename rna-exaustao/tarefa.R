# Carrega as bibliotecas necessárias

library("neuralnet");
library(hydroGOF);


# Lê o csv em que se encontram os dados

dataset <- read.csv("C:\\Users\\Lúcia\\Dropbox\\Trabalho de SRCR\\Exercicio3\\exaustao\\exaustao_norm_versao2_shuffle.csv", header=TRUE,sep=",", dec=".")


# Extrair 560 casos do dataset para um novo dataset que será usado para treinar a rede neuronal 

treino <- dataset[1:560, ]

# Extrair os restantes casos do dataset para um dataset que sera usado para testar a redeneuronal

teste <- dataset[561:844, ]


# ------------------ Fórmulas usadas para especificar os modelos ------------------ #

# 9 
formulaRNA_tarefa <- Performance.Task ~ Performance.KDTMean + Performance.MAMean + Performance.MVMean + Performance.TBCMean + Performance.DDCMean + Performance.DMSMean + Performance.AEDMean + Performance.ADMSLMean + FatigueLevel

# 8 
formulaRNA_tarefa <- Performance.Task ~ Performance.KDTMean + Performance.MAMean + Performance.MVMean + Performance.DDCMean + Performance.DMSMean + Performance.AEDMean + Performance.ADMSLMean + FatigueLevel

# 7
formulaRNA_tarefa <- Performance.Task ~ Performance.KDTMean + Performance.MAMean + Performance.DDCMean + Performance.DMSMean + Performance.AEDMean + Performance.ADMSLMean + FatigueLevel

# 6 
formulaRNA_tarefa <- Performance.Task ~ Performance.KDTMean + Performance.DDCMean + Performance.DMSMean + Performance.AEDMean + Performance.ADMSLMean + FatigueLevel

# 4
formulaRNA_tarefa <- Performance.Task ~ Performance.KDTMean + Performance.DDCMean + Performance.DMSMean + FatigueLevel


# --------------------------------------------------------------------------------- #


# Treinar a rede neuronal, com Performance.Task como ouput 

rna_tarefa <- neuralnet(formulaRNA_tarefa, treino, hidden = c(4), threshold = 0.1, lifesign = "full", linear.output = FALSE)

rna_tarefa <- neuralnet(formulaRNA_tarefa, treino, hidden = c(4), threshold = 0.01, lifesign = "full", linear.output = FALSE)

rna_tarefa <- neuralnet(formulaRNA_tarefa, treino, hidden = c(8, 4), threshold = 0.1, lifesign = "full", linear.output = FALSE)

rna_tarefa <- neuralnet(formulaRNA_tarefa, treino, hidden = c(8, 4), threshold = 0.01, lifesign = "full", linear.output = FALSE)

rna_tarefa <- neuralnet(formulaRNA_tarefa, treino, hidden = c(16, 8, 4), threshold = 0.1, lifesign = "full", linear.output = FALSE)

rna_tarefa <- neuralnet(formulaRNA_tarefa, treino, hidden = c(16, 8, 4), threshold = 0.01, lifesign = "full", linear.output = FALSE)


# ------------------ Definir as variaveis de input para teste ------------------ #

# 9 
teste_tarefa <- subset(teste, select = c("Performance.KDTMean","Performance.MAMean","Performance.MVMean","Performance.TBCMean","Performance.DDCMean","Performance.DMSMean","Performance.AEDMean","Performance.ADMSLMean","FadigueLevel"))

#8
teste_tarefa <- subset(teste, select = c("Performance.KDTMean","Performance.MAMean","Performance.MVMean","Performance.DDCMean","Performance.DMSMean","Performance.AEDMean","Performance.ADMSLMean","FadigueLevel"))

#7
teste_tarefa <- subset(teste, select = c("Performance.KDTMean","Performance.MAMean","Performance.DDCMean","Performance.DMSMean","Performance.AEDMean","Performance.ADMSLMean","FadigueLevel"))

#6
teste_tarefa <- subset(teste, select = c("Performance.KDTMean","Performance.DDCMean","Performance.DMSMean","Performance.AEDMean","Performance.ADMSLMean","FadigueLevel"))

#4
teste_tarefa <- subset(teste, select = c("Performance.KDTMean","Performance.DDCMean","Performance.DMSMean","FatigueLevel"))

# ------------------------------------------------------------------------------ #


# Testar a rede com os casos

rna_tarefa.resultados <- compute(rna_tarefa, teste_tarefa)

# Guardar os resultados

resultados <- data.frame(atual = teste$Performance.Task, previsao = rna_tarefa.resultados$net.result)

# Guardar o valor do RMSE (root-mean-square error)

rmse(c(teste$Performance.Task), c(resultados$previsao)) 



# ------------------ Determinar atributos significativos ------------------ #

library(leaps);

regg1 <- regsubsets(Performance.Task ~ Performance.KDTMean + Performance.MAMean + Performance.MVMean + Performance.TBCMean + Performance.DDCMean + Performance.DMSMean + Performance.AEDMean + Performance.ADMSLMean + FadigueLevel , dataset)

summary(regg1)

# ------------------------------------------------------------------------- #
