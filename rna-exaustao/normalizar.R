
# Normalização dos valores para diferentes níveis de exaustão


# ------------------------------------------------------------------------------------------------------------------------ #
# ------------------------------------------------------- 7 niveis ------------------------------------------------------- #
# ------------------------------------------------------------------------------------------------------------------------ #

1 - 0
2 - 0.166667
3 - 0.333333
4 - 0.5
5 - 0.666667
6 - 0.833333
7 - 1

normalizar <- function(dataset) {

	new_dataset <- dataset

	new_dataset$FatigueLevel[new_dataset$FatigueLevel == 1] = 0
	new_dataset$FatigueLevel[new_dataset$FatigueLevel == 2] = 0.166667
	new_dataset$FatigueLevel[new_dataset$FatigueLevel == 3] = 0.333333
	new_dataset$FatigueLevel[new_dataset$FatigueLevel == 4] = 0.5
	new_dataset$FatigueLevel[new_dataset$FatigueLevel == 5] = 0.666667
	new_dataset$FatigueLevel[new_dataset$FatigueLevel == 6] = 0.833333
	new_dataset$FatigueLevel[new_dataset$FatigueLevel == 7] = 1

	return (new_dataset)
}

sete <- normalizar(dataset)

treino <- sete[1:560, ]
teste <- sete[561:844, ]


# ------------------------------------------------------------------------------------------------------------------------ #
# ------------------------------------------------------- 2 niveis ------------------------------------------------------- #
# ------------------------------------------------------------------------------------------------------------------------ #

1 - 0
2 - 1

normalizar <- function(dataset) {

	new_dataset <- dataset

	new_dataset$FatigueLevel[new_dataset$FatigueLevel <= 3] = 0
	new_dataset$FatigueLevel[new_dataset$FatigueLevel > 3] = 1

	return (new_dataset)
}

dois <- normalizar(dataset)

treino <- dois[1:560, ]
teste <- dois[561:844, ]


# ------------------------------------------------------------------------------------------------------------------------ #
# ------------------------------------------------------- 6 niveis ------------------------------------------------------- #
# ------------------------------------------------------------------------------------------------------------------------ #

1 - 0
2 - 0.2
3 - 0.4
4 - 0.6
5 - 0.8
6 +7- 1

normalizar <- function(dataset) {

	new_dataset <- dataset

	new_dataset$FatigueLevel[new_dataset$FatigueLevel == 1] = 0
	new_dataset$FatigueLevel[new_dataset$FatigueLevel == 2] = 0.2
	new_dataset$FatigueLevel[new_dataset$FatigueLevel == 3] = 0.4
	new_dataset$FatigueLevel[new_dataset$FatigueLevel == 4] = 0.6
	new_dataset$FatigueLevel[new_dataset$FatigueLevel == 5] = 0.8
	new_dataset$FatigueLevel[new_dataset$FatigueLevel >= 6] = 1

	return (new_dataset)
}

seis <- normalizar(dataset)

treino <- seis[1:560, ]
teste <- seis[561:844, ]


# ------------------------------------------------------------------------------------------------------------------------ #
# ------------------------------------------------------- 5 niveis ------------------------------------------------------- #
# ------------------------------------------------------------------------------------------------------------------------ #

1 - 0
2 - 0.25
3 - 0.5
4 - 0.75
5+6+7 - 1

normalizar <- function(dataset) {

	new_dataset <- dataset

	new_dataset$FatigueLevel[new_dataset$FatigueLevel == 1] = 0
	new_dataset$FatigueLevel[new_dataset$FatigueLevel == 2] = 0.25
	new_dataset$FatigueLevel[new_dataset$FatigueLevel == 3] = 0.5
	new_dataset$FatigueLevel[new_dataset$FatigueLevel == 4] = 0.75
	new_dataset$FatigueLevel[new_dataset$FatigueLevel >= 5] = 1

	return (new_dataset)
}

cinco <- normalizar(dataset)

treino <- cinco[1:560, ]
teste <- cinco[561:844, ]


# ------------------------------------------------------------------------------------------------------------------------ #
# ------------------------------------------------------- 4 niveis ------------------------------------------------------- #
# ------------------------------------------------------------------------------------------------------------------------ #


# ------------------------------ Versao a) ------------------------------ #

1 - 0
2 - 0.333333
3 - 0.666667
4+5+6+7 - 1

normalizar <- function(dataset) {

	new_dataset <- dataset

	new_dataset$FatigueLevel[new_dataset$FatigueLevel == 1] = 0
	new_dataset$FatigueLevel[new_dataset$FatigueLevel == 2] = 0.333333
	new_dataset$FatigueLevel[new_dataset$FatigueLevel == 3] = 0.666667
	new_dataset$FatigueLevel[new_dataset$FatigueLevel >= 4] = 1

	return (new_dataset)
}

quatroA <- normalizar(dataset)

treino <- quatroA[1:560, ]
teste <- quatroA[561:844, ]

# ------------------------------ Versao b) ------------------------------ #

1+2
3
4+5
6+7 

normalizar <- function(dataset) {

	new_dataset <- dataset

	new_dataset$FatigueLevel[new_dataset$FatigueLevel <= 2] = 0
	new_dataset$FatigueLevel[new_dataset$FatigueLevel == 3] = 0.333333
	new_dataset$FatigueLevel[new_dataset$FatigueLevel >= 4 & new_dataset$FatigueLevel <= 5] = 0.666667
	new_dataset$FatigueLevel[new_dataset$FatigueLevel >= 6] = 1

	return (new_dataset)
}

quatroB <- normalizar(dataset)

treino <- quatroB[1:560, ]
teste <- quatroB[561:844, ]



# ------------------------------------------------------------------------------------------------------------------------ #
# ------------------------------------------------------- 3 niveis ------------------------------------------------------- #


# ------------------------------ Versao a) ------------------------------ #

1+2- 0
3 - 0.5
4+5+6+7 - 1

normalizar <- function(dataset) {

	new_dataset <- dataset

	new_dataset$FatigueLevel[new_dataset$FatigueLevel >= 1 & new_dataset$FatigueLevel <= 2] = 0
	new_dataset$FatigueLevel[new_dataset$FatigueLevel == 3] = 0.5
	new_dataset$FatigueLevel[new_dataset$FatigueLevel >= 4] = 1

	return (new_dataset)
}

tresA <- normalizar(dataset)

treino <- tresA[1:560, ]
teste <- tresA[561:844, ]


# ------------------------------ Versao b) ------------------------------ #

1+2+3
4+5
6+7

normalizar <- function(dataset) {

	new_dataset <- dataset

	new_dataset$FatigueLevel[new_dataset$FatigueLevel >= 1 & new_dataset$FatigueLevel <= 3] = 0
	new_dataset$FatigueLevel[new_dataset$FatigueLevel >= 4 & new_dataset$FatigueLevel <= 5] = 0.5
	new_dataset$FatigueLevel[new_dataset$FatigueLevel >= 6] = 1

	return (new_dataset)
}

tresB <- normalizar(dataset)

treino <- tresB[1:560, ]
teste <- tresB[561:844, ]

