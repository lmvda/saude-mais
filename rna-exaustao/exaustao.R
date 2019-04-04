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

# 9 (com tarefa)
formulaRNA_exaustao <- FatigueLevel ~ Performance.KDTMean + Performance.MAMean + Performance.MVMean + Performance.TBCMean + Performance.DDCMean + Performance.DMSMean + Performance.AEDMean + Performance.ADMSLMean + Performance.Task

# 8 (sem tarefa)
formulaRNA_exaustao <- FatigueLevel ~ Performance.KDTMean + Performance.MAMean + Performance.MVMean + Performance.TBCMean + Performance.DDCMean + Performance.DMSMean + Performance.AEDMean + Performance.ADMSLMean

# 6 (com tarefa)
formulaRNA_exaustao <- FatigueLevel ~ Performance.KDTMean + Performance.MAMean + Performance.MVMean + Performance.DDCMean + Performance.DMSMean + Performance.ADMSLMean + Performance.Task

# 6 (sem tarefa)
formulaRNA_exaustao <- FatigueLevel ~ Performance.KDTMean + Performance.MAMean + Performance.MVMean + Performance.DDCMean + Performance.DMSMean + Performance.ADMSLMean

# 4 (com tarefa)
formulaRNA_exaustao <- FatigueLevel ~ Performance.MAMean + Performance.MVMean + Performance.DDCMean + Performance.Task

# 4 (sem tarefa)
formulaRNA_exaustao <- FatigueLevel ~ Performance.KDTMean + Performance.MAMean + Performance.MVMean + Performance.DDCMean 

# --------------------------------------------------------------------------------- #


# Treinar a rede neuronal, com FatigueLevel como ouput 

rna_exaustao <- neuralnet(formulaRNA_exaustao, treino, hidden = c(4), threshold = 0.1, lifesign = "full", linear.output = FALSE)

rna_exaustao <- neuralnet(formulaRNA_exaustao, treino, hidden = c(4), threshold = 0.01, lifesign = "full", linear.output = FALSE)

rna_exaustao <- neuralnet(formulaRNA_exaustao, treino, hidden = c(8, 4), threshold = 0.1, lifesign = "full", linear.output = FALSE)

rna_exaustao <- neuralnet(formulaRNA_exaustao, treino, hidden = c(8, 4), threshold = 0.01, lifesign = "full", linear.output = FALSE)

rna_exaustao <- neuralnet(formulaRNA_exaustao, treino, hidden = c(16, 8, 4), threshold = 0.1, lifesign = "full", linear.output = FALSE)

rna_exaustao <- neuralnet(formulaRNA_exaustao, treino, hidden = c(16, 8, 4), threshold = 0.01, lifesign = "full", linear.output = FALSE)


# ------------------ Definir as variaveis de input para teste ------------------ #

# 9 (com tarefa)
teste_exaustao <- subset(teste, select = c("Performance.KDTMean","Performance.MAMean","Performance.MVMean","Performance.TBCMean","Performance.DDCMean","Performance.DMSMean","Performance.AEDMean","Performance.ADMSLMean","Performance.Task"))

# 8 (sem tarefa)
teste_exaustao <- subset(teste, select = c("Performance.KDTMean","Performance.MAMean","Performance.MVMean","Performance.TBCMean","Performance.DDCMean","Performance.DMSMean","Performance.AEDMean","Performance.ADMSLMean"))

# 6 (com tarefa)
teste_exaustao <- subset(teste, select = c("Performance.DDCMean","Performance.MAMean","Performance.MVMean","Performance.KDTMean","Performance.DMSMean","Performance.ADMSLMean","Performance.Task"))

# 6 (sem tarefa)
teste_exaustao <- subset(teste, select = c("Performance.DDCMean","Performance.MAMean","Performance.MVMean","Performance.KDTMean","Performance.DMSMean","Performance.ADMSLMean"))

# 4 (com tarefa)
teste_exaustao <- subset(teste, select = c("Performance.DDCMean","Performance.MAMean","Performance.MVMean","Performance.Task"))

# 4 (sem tarefa)
teste_exaustao <- subset(teste, select = c("Performance.DDCMean","Performance.MAMean","Performance.MVMean","Performance.KDTMean"))

# ------------------------------------------------------------------------------ #


# Testar a rede com os casos

rna_exaustao.resultados <- compute(rna_exaustao, teste_exaustao)

# Guardar os resultados

resultados <- data.frame(atual = teste$FatigueLevel, previsao = rna_exaustao.resultados$net.result)

# Guardar o valor do RMSE (root-mean-square error)

rmse(c(teste$FatigueLevel), c(resultados$previsao)) 



# ------------------ Determinar atributos significativos ------------------ #

library(leaps);

regg1 <- regsubsets(FatigueLevel ~ Performance.KDTMean + Performance.MAMean + Performance.MVMean + Performance.TBCMean + Performance.DDCMean + Performance.DMSMean + Performance.AEDMean + Performance.ADMSLMean + Performance.Task , dataset)

summary(regg1)

# ------------------------------------------------------------------------- #
