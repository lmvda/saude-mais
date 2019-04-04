%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - MiEI/3 - Trabalho 2

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Servico Medico

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: Declaracoes iniciais

:- set_prolog_flag( discontiguous_warnings,off ).
:- set_prolog_flag( single_var_warnings,off ).
:- set_prolog_flag( unknown,fail ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: definicoes iniciais

:- op( 900,xfy,'::' ).
:- op( 600, xfy, 'and').
:- op( 700, xfy, 'or').
:- dynamic instituicao/2.
:- dynamic servico/4.
:- dynamic medico/3.
:- dynamic utente/4.
:- dynamic consulta/8.
:- dynamic nulo/1.
:- dynamic excecao/1.
:- dynamic '-'/1.


% ------------------------------- Rede de Clinicas SaudeMais ------------------------------- %
% Extensao do predicado instituicao: NomeInst, Cidade -> {V,F,D}


% Conhecimento perfeito positivo
instituicao( csmbraga, braga ).
instituicao( csmviana, viana ).
instituicao( csmporto, porto ).
instituicao( csmguimaraes, guimaraes ).

% Conhecimento perfeito negativo
-instituicao( NomeInst, Cidade ) :- nao( instituicao( NomeInst, Cidade )), 
                                      nao( excecao( instituicao( NomeInst, Cidade ))).

% Não existe a instituição csmlisboa em Lisboa
-instituicao( csmlisboa, lisboa ).

% Conhecimento imperfeito impreciso

% A instituição csmGualtar fica em vizela ou em celorico
excecao( instituicao(csmgualtar, vizela) ).
excecao( instituicao(csmgualtar, celorico) ).

% ------------------------------- cuidado prestado/servico --------------------------------- %
% Extensao do predicado servico: IdServ, Descricao, Instituicao, Cidade -> {V,F,D}


% Conhecimento perfeito positivo
servico( s1, ginecologia, csmbraga, braga ).
servico( s2, oftalmologia, csmviana, viana ).
servico( s3, ortopedia, csmporto, porto ).
servico( s4, pediatria, csmguimaraes, guimaraes ).
servico( s5, cardiologia, csmporto, porto ).
servico( s6, neurologia, csmviana, viana ).
servico( s7, dermatologia, csmguimaraes, guimaraes ).
servico( s8, medicinageral, csmbraga, braga ).
servico( s9, psiquiatria, csmviana, viana ).
servico( s10, urologia, csmbraga, braga ).


% Conhecimento perfeito negativo
-servico( IdServ, Descricao, Instituicao, Cidade ) :- 
			nao( servico( IdServ, Descricao, Instituicao, Cidade )), 
			nao( excecao( servico( IdServ, Descricao, Instituicao, Cidade ))).

% No porto não existe o serviço s1: ginecologia
-servico( s1, ginecologia, csmporto, porto ). 



% Conhecimento imperfeito incerto

% Desconhecida a instituição onde se presta este serviço
servico( s11, endocrinologia, xptos11, braga ).
excecao( servico(IdServ, Descricao, Instituicao, Cidade)) :- 
    servico( IdServ, Descricao, xptos11, Cidade ).

% Desconhecida a cidade onde se localiza a instituição que presta este serviço
servico( s12, psiquiatria, csmporto, xptos12 ).
excecao( servico(IdServ, Descricao, Instituicao, Cidade)) :- 
    servico( IdServ, Descricao, Instituicao, xptos12 ).


% Conhecimento imperfeito impreciso

% Não se sabe qual a descrição/especialidade do serviço s13 mas sabe-se que é oncologia ou podologia
excecao( servico( s13, oncologia, csmguimaraes, guimaraes ) ).
excecao( servico( s13, podologia, csmguimaraes, guimaraes ) ).

% Não se sabe qual em que instituição se disponibiliza o serviço s14 de pneumologia, ou é csmporto ou csmbraga.
excecao( servico( s14, pneumologia, csmbraga, braga ) ).
excecao( servico( s14, pneumologia, csmporto, porto ) ). 

% Conhecimento imperfeito interdito

% Nunca se poderá saber qual a instituição que tem o serviço 15
servico( s15, reumatologia, xptos15, porto).
excecao( servico( IdServ, Descricao, Instituicao, Cidade )) :- 
    servico( IdServ, Descricao, xptos15, Cidade ).
nulo( xptos15).

+servico( IdServ, Descricao, Instituicao, Cidade ) :: 
    (solucoes(
        (IdServ, Descricao, InstituicaoS, Cidade), 
        (servico( s15, reumatologia, InstituicaoS, porto), nao(nulo(InstituicaoS ))), 
        S),
    comprimento(S, N), N==0 ).




% ----------------------------------------- medico ----------------------------------------- %
% Extensao do predicado medico: IdMed, Nome, IdServ -> {V,F,D}


% Conhecimento perfeito positivo
medico( m1 , barros, s1 ).
medico( m2 , videira, s2 ).
medico( m3 , brandao, s3 ).
medico( m4 , lobo, s4 ).
medico( m5 , miranda, s5  ).
medico( m6 , rebelo, s6 ).
medico( m7 , nogueira, s7 ).
medico( m8 , amaral, s8 ).
medico( m9 , marques, s9 ).
medico( m10 , carvalho, s10 ).
medico( m11 , branco, s1 ).
medico( m12 , enes, s2 ).
medico( m13 , noronha, s3 ).
medico( m14 , martins, s4 ).
medico( m15 , castro, s5 ).
medico( m16 , mendes, s6 ).
medico( m17 , belo, s7 ).
medico( m18 , silva, s8 ).
medico( m19 , santos, s9 ).
medico( m20 , correia ,s10 ).




% Conhecimento perfeito negativo
-medico(IdMed, Nome, IdServ) :- nao(medico(IdMed, Nome, IdServ)), 
                                      nao(excecao(medico(IdMed, Nome, IdServ))).

% O médico m1: barros não tem o serviço 10
-medico(m1, barros, s10).




% Conhecimento imperfeito incerto

% Não se sabe qual o serviço que o médico gouveia está associado
medico( m21, gouveia, xptom21 ).
excecao( medico(IdMed, Nome, IdServ)) :- 
    medico(IdMed, Nome, xptom21).


% Conhecimento imperfeito impreciso

% Não se sabe se o médico m22, Dr. Peixoto, prestada o serviço s5 ou s6
excecao( medico( m22, peixoto, s5 ) ).
excecao( medico( m22, peixoto, s6 ) ).


% Conhecimento imperfeito interdito

% Nunca se poderá saber o nome do médico m23
medico(m23, xptom23, s10).
excecao(medico(IdMed, Nome, IdServ)) :- 
    medico(IdMed, xptom23, IdServ).
nulo(xptom23).

+medico(IdMed, Nome, IdServ) :: 
    (solucoes(
        (IdMed, NomeS, IdServ), 
        (medico(m23, NomeS, s10), nao(nulo(NomeS))), 
        S),
    comprimento(S, N), N==0).






% -------------------------------------- Utente -------------------------------------------- %
% Extensao do predicado utente: IdUt, Nome, Idade, Morada -> {V,F,D}



% Conhecimento perfeito positivo
utente( u1, maria, 20, galegos ).
utente( u2, rodrigo, 28, torre ).
utente( u3, joana, 59, barcelinhos ).
utente( u4, ricardo, 81, areias ).
utente( u5, margarida, 13, taipas ).
utente( u6, ana, 34, darque ).
utente( u7, salvador, 74, azurem ).
utente( u8, tiago, 45, lordelo ).
utente( u9, francisco, 17, povoa ).
utente( u10, sofia, 5, maia ).
utente( u11, almerinda, 27, paranhos ).
utente( u12, teresa, 37, meadela ).
utente( u13, joaquim, 65, arcozelo ).
utente( u14, antonio, 53, afife ).
utente( u15, bernardino, 90, gualtar ).



% Conhecimento perfeito negativo

-utente(IdUt, Nome, Idade, Morada) :- nao(utente(IdUt, Nome, Idade, Morada)), 
                                      nao(excecao(utente(IdUt, Nome, Idade, Morada))).
% A utente u1: maria não tem 30 anos
-utente( u1, maria, 30, galegos ).

% O utente u2: rodrigo não vive em galegos
-utente(u2, rodrigo, 28, galegos).


% Conhecimento imperfeito incerto

% Não se sabe a morada do utente jose
utente( u16, jose, 50, xptou16 ).
excecao( utente(IdUt, Nome, Idade, Morada)) :- 
    utente( IdUt, Nome, Idade, xptou16 ).

% Não se sabe a idade da utente susana
utente( u17, susana, xptou17, parada ).
excecao( utente(IdUt, Nome, Idade, Morada)) :- 
    utente( IdUt, Nome, xptou17, Morada ).

% Conhecimento imperfeito impreciso

% Não se sabe ao certo a idade do xavier mas sabe-se é 24 ou 25 anos
excecao( utente( u18, xavier, 24, gondizalves ) ).
excecao( utente( u18, xavier, 25, gondizalves ) ).

% Não se sabe ao certo a idade do sergio mas sabe-se que ou é entre 20 a 25 anos
excecao( utente(u19, sergio, Idade, gondizalves)) :- Idade >=20, Idade =<25.

%Não se conhece a morada da lucinda, é tondela ou meadela
excecao( utente( u20, lucinda, 45, tondela ) ).
excecao( utente( u20, lucinda, 45, meadela ) ).

% Conhecimento imperfeito interdito

% Não se sabe a morada do utente u21 em nunca se virá conhecer
utente(u21, marta, 35, xptou21).
excecao(utente(IdUt, Nome, Idade, Morada)) :- 
    utente(IdUt, Nome, Idade, xptou21).
nulo(xptou21).

+utente(IdUt, Nome, Idade, Morada) :: 
    (solucoes(
        (IdUt, Nome, Idade, MoradaS), 
        (utente(u21, marta, 35, MoradaS), nao(nulo(MoradaS))), 
        S),
    comprimento(S, N), N==0).

% Não se sabe a idade do utente u22 nem nunca se virá conhecer 
utente(u22, matilde, xptou22, tibaes).
excecao(utente(IdUt, Nome, Idade, Morada)) :- 
    utente(IdUt, Nome, xptou22, Morada).
nulo(xptou22).

+utente(IdUt, Nome, Idade, Morada) :: 
    (solucoes(
        (IdUt, Nome, IdadeS, Morada), 
        (utente(u22, matilde, IdadeS, tibaes), nao(nulo(IdadeS))), 
        S),
    comprimento(S, N), N==0).


% Não se sabe a nome do utente u23 nem nunca se virá conhecer
utente(u23, xptou23, 40, gualtar).
excecao(utente(IdUt, Nome, Idade, Morada)) :- 
    utente(IdUt, xptou23, Idade, Morada).
nulo(xptou23).

+utente(IdUt, Nome, Idade, Morada) :: 
    (solucoes(
        (IdUt, NomeS, Idade, Morada), 
        (utente(u23, NomeS, 40, gualtar), nao(nulo(NomeS))), 
        S),
    comprimento(S, N), N==0).





% --------------------------------- Ato Medico / Consulta ---------------------------------- %
% Extensao do predicado consulta: Ano, Mes, Dia, Hora, IdUt, IdServ, Custo, IdMed -> {V,F,D}

% Conhecimento perfeito positivo
consulta( 2017, 3, 16, 8, u5, s4, 45, m4).
consulta( 2017, 2, 23, 10, u5, s9, 25, m9).
consulta( 2017, 1, 5, 17, u2, s7, 50, m17).
consulta( 2016, 12, 15, 15, u15, s5, 37, m5).
consulta( 2016, 8, 14, 12, u5, s3, 81, m3).
consulta( 2017, 4, 13, 20, u4, s3, 55, m3).
consulta( 2017, 5, 16, 13, u1, s8, 45, m8).


% Conhecimento perfeito negativo
-consulta(Ano, Mes, Dia, Hora, IdUt, IdServ, Custo, IdMed) :- nao(consulta(Ano, Mes, Dia, Hora, IdUt, IdServ, Custo, IdMed)), 
                                      nao(excecao(consulta(Ano, Mes, Dia, Hora, IdUt, IdServ, Custo, IdMed))).

% A consulta de 16-3-2017 ao utente 5 do serviço s4 com o médico m4 não custou 100 euros.
-consulta(2017, 3, 16, 8, u5, s4, 100, m4).


% Conhecimento imperfeito incerto

% Não se sabe a que horas ocorreu a consulta (apesar de saber a data dia/mes/ano)
consulta( 2017, 1, 15, xptoc1, u10, s4, 40, m4).
excecao( consulta(Ano, Mes, Dia, Hora, IdUt, IdServ, Custo, IdMed)) :- 
    consulta(Ano, Mes, Dia, xptoc1, IdUt, IdServ, Custo, IdMed).

% Não se sabe que médico deu a consulta
consulta( 2017, 4, 3, 20, u10, s4, 42, xptoc2).
excecao( consulta(Ano, Mes, Dia, Hora, IdUt, IdServ, Custo, IdMed)) :- 
    consulta(Ano, Mes, Dia, Hora, IdUt, IdServ, Custo, xptoc2).


% Conhecimento imperfeito impreciso

% Custo da consulta é de 50 euros ou de 150 euros
excecao( consulta( 2016, 7, 17, 15, u8, s3, 50, m3) ).
excecao( consulta( 2016, 7, 17, 15, u8, s3, 150, m3) ).

% O valor da consulta está entre 20 a 30 euros
excecao( consulta( 2016, 3, 17, 16, u8, s3, Custo, m3) ) :- Custo >= 20 , Custo =< 30.

% Não se sabe se foi o médico m10 ou m20 que deu a consulta
excecao( consulta( 2017, 2, 10, 18, u14, s10, 50, m10) ).
excecao( consulta( 2017, 2, 10, 18, u14, s10, 50, m20) ).


% Conhecimento imperfeito interdito

% Não se sabe nem se virá a conhecer o custo da consulta
consulta(2017, 3, 10, 10, u5, s5, xptoc3, m5).
excecao(consulta(Ano, Mes, Dia, Hora, IdUt, IdServ, Custo, IdMed)) :- 
    consulta(Ano, Mes, Dia, Hora, IdUt, IdServ, xptoc3, IdMed).
nulo(xptoc3).

+consulta(Ano, Mes, Dia, Hora, IdUt, IdServ, Custo, IdMed) :: 
    (solucoes(
        (Ano, Mes, Dia, Hora, IdUt, IdServ, CustoS, IdMed), 
        (consulta(2017, 3, 10, 10, u5, s5, CustoS, m5), nao(nulo(CustoS))), 
        S),
    comprimento(S, N), N==0).












% --------------------------------------------------------------------------------------%
% -----------------------------------Invariantes Inserção ------------------------------%
% --------------------------------------------------------------------------------------%



% ---------- Utente --------------- %


% Invariante Estrutural
% Permitir apenas a existência de um predicado com um dado identificador
% de conhecimento perfeito positivo ou perfeito negativo.
% Em alternativa permite ter vários predicados com o mesmo identificador
% de conhecimento imperfeito.
+utente(IdUt, _, _, _) :: (
    solucoes(IdUt, utente(IdUt, _, _, _), Lista1),
    solucoes(IdUt, -utente(IdUt, _, _, _), Lista2),
    solucoesSemRepetidos(IdUt, excecao(utente(IdUt, _, _, _)), Lista3),
    comprimento(Lista1, N1),
    comprimento(Lista2, N2),
    comprimento(Lista3, N3),
     (N1+N2+N3) =:= 1).



% ---------- Instituição --------------- %

% Invariante Estrutural
% Permitir apenas a existência de um predicado com um dado identificador
% de conhecimento perfeito positivo ou perfeito negativo.
% Em alternativa permite ter vários predicados com o mesmo identificador
% de conhecimento imperfeito.
+instituicao(Instituicao, _) :: (
    solucoes(Instituicao, instituicao(Instituicao, _), Lista1),
    solucoes(Instituicao, -instituicao(Instituicao, _), Lista2),
    solucoesSemRepetidos(Instituicao, excecao(instituicao(Instituicao, _)), Lista3),
    comprimento(Lista1, N1),
    comprimento(Lista2, N2),
    comprimento(Lista3, N3),
     (N1+N2+N3) =:= 1).



% ---------- Médico --------------- %

% Invariante Estrutural
% Permitir apenas a existência de um predicado com um dado identificador
% de conhecimento perfeito positivo ou perfeito negativo.
% Em alternativa permite ter vários predicados com o mesmo identificador
% de conhecimento imperfeito.
+medico(IdMed, _, IdServ) :: (
    solucoes(IdMed, medico(IdMed, _, IdServ), Lista1),
    solucoes(IdMed, -medico(IdMed, _, IdServ), Lista2),
    solucoesSemRepetidos(IdMed, excecao(medico(IdMed, _, IdServ)), Lista3),
    comprimento(Lista1, N1),
    comprimento(Lista2, N2),
    comprimento(Lista3, N3),
     (N1+N2+N3) =:= 1).

% Invariante Referencial
% Não permitir inserção de um médico com mais que uma especialidade
+medico(IdMed, _, _) :: (
    solucoesSemRepetidos(Especialidade, (medico(IdMed,_, IdServ),servico(IdServ, Especialidade, _, _)), Lista),
    comprimento(Lista, N),
    N == 1).

% Invariante Referencial
% Não permitir inserção de um médico num serviço que não existe
+medico(IdMed, _, IdServ) :: (
    solucoes(IServ, servico(IdServ, _, _, _), Lista),
    comprimento(Lista, N),
    N > 0).



% ---------- Serviço --------------- %


% Invariante Estrutural
% Permitir apenas a existência de um predicado com um dado identificador
% de conhecimento perfeito positivo ou perfeito negativo.
% Em alternativa permite ter vários predicados com o mesmo identificador
% de conhecimento imperfeito.
+servico(IdServ ,_ , _, _) :: (
    solucoes(IdServ, servico(IdServ, _, _, _), Lista1),
    solucoes(IdServ, -servico(IdServ, _, _, _), Lista2),
    solucoesSemRepetidos(IdServ, excecao(servico(IdServ, _, _, _)), Lista3),
    comprimento(Lista1, N1),
    comprimento(Lista2, N2),
    comprimento(Lista3, N3),
     (N1+N2+N3) =:= 1).


% Invariante Referencial
% O serviço tem que corresponder a uma instituição existente na base de conhecimento
+servico(_ ,_ , Instituicao, Cidade) :: (
    solucoes(Instituicao, instituicao(Instituicao, Cidade), Lista),
    comprimento(Lista, N),
    N > 0).


% Invariante Estrutural
% Não permite repetir serviços numa instituição
+servico(_, Descricao, Instituicao, _) :: (
    solucoes(Descricao, servico(_, Descricao, Instituicao, _), Lista),
    comprimento(Lista, N),
    N == 1).


% ---------- Consulta --------------- %

% Invariante Estrutural
% Permitir apenas a existência de um predicado com um dado identificador
% de conhecimento perfeito positivo ou perfeito negativo.
% Em alternativa permite ter vários predicados com o mesmo identificador
% de conhecimento imperfeito.
+consulta(Ano, Mes, Dia, Hora, IdUt, IdServ, Custo, IdMed) :: (
    solucoes(Hora, consulta(Ano, Mes, Dia, Hora, IdUt, IdServ, Custo, IdMed), Lista1),
    solucoes(Hora, -consulta(Ano, Mes, Dia, Hora, IdUt, IdServ, Custo, IdMed), Lista2),
    solucoesSemRepetidos(Hora, excecao(consulta(Ano, Mes, Dia, Hora, IdUt, IdServ, Custo, IdMed)), Lista3),
    comprimento(Lista1, N1),
    comprimento(Lista2, N2),
    comprimento(Lista3, N3),
     (N1+N2+N3) =:= 1).


% Invariante Estrutural
% Não permitir a adição de uma consulta com um utente inexistente
+consulta(_, _, _,_, IdUt, _, _, _) :: ( 
    solucoes(IdUt, utente(IdUt, _, _, _), Lista),
    comprimento(Lista, N),
    N > 0).

% Invariante Estrutural
% Não permitir a adição de uma consulta com um médico inexistente
+consulta(_, _, _, _, _, _, _, IdMed) :: ( 
    solucoes(IdMed, medico(IdMed, _, _), Lista),
    comprimento(Lista, N),
    N > 0).


% Invariante Estrutural
% Não permitir a adição de uma consulta com um serviço inexistente numa Instituição
+consulta(_, _, _, _, _, IdServ, _, _) :: ( 
    solucoes(IdServ, servico(IdServ, _, _, _), Lista),
    comprimento(Lista, N),
    N > 0).


% Invariante Referencial
% Não permite inserir uma consulta com um médico que não forneça o serviço pretendido 
+consulta(_, _, _, _, _, IdServ, _, IdMed) :: ( 
    solucoes(IdMed, medico(IdMed, _, IdServ), Lista),
    comprimento(Lista, N),
    N > 0).



% Invariante Referencial
% Não permitir a adição de uma consulta nos meses que têm 31 dias, com o dia superior a 31.
+consulta(_, _, _, _, _, _, _, _) :: (
    solucoes(
        Mes,
        (consulta(_, Mes, Dia, _, _, _, _, _),
         pertence(Mes, [1,3,5,7,8,10,12]),
         Dia > 31),
        [])).

% Invariante Referencial
% Não permitir a adição de uma consulta nos meses que têm 30 dias, com o dia superior a 30.
+consulta(_, _, _, _, _, _, _, _) :: (
    solucoes(
        Mes,
        (consulta(_, Mes, Dia, _, _, _, _, _),
         pertence(Mes, [2,4,6,9,11]),
         Dia > 30),
        [])).

% Invariante Referencial
% Não permitir a adição de uma consulta no mês de fevereiro com o dia superior a 29.
+consulta(_, _, _, _, _, _, _, _) :: (
    solucoes(
        Dia,
        (consulta(_, 2, Dia, _, _, _, _, _),
         Dia > 29),
        [])).

% Invariante Referencial
% Não permitir a adição de uma consulta com um dia do mês menor que 1.
+consulta(_, _, _, _, _, _, _, _) :: (
    solucoes(
        Dia,
        (consulta(_, _, Dia, _, _, _, _, _),
         Dia < 1),
        [])).



% Invariante Referencial
% Não permitir a adição de uma consulta com um mês inferior a 1 e superior a 12
+consulta(Ano, Mes, Dia, Hora, IdUt, IdServ, _, IdMed) :: (
    solucoes(Mes, (consulta(Ano, Mes, Dia, Hora, IdUt, IdServ, _, IdMed), (Mes >= 1, Mes =< 12)), Lista),
    comprimento(Lista, N),
    N == 1).



% Invariante Referencial
% Não permitir a adição de consultas com a hora inferior a 8 ou superior a 22
+consulta(Ano, Mes, Dia, Hora, IdUt, IdServ, _, IdMed) :: (
    solucoes(Hora, (consulta(Ano, Mes, Dia, Hora, IdUt, IdServ, _, IdMed), (Hora >= 8, Hora =< 22)), Lista),
    comprimento(Lista, N),
    N == 1).


% Invariante Referencial
% Não permitir que um medico tenha mais que uma consulta à mesma hora 
+consulta(Ano, Mes, Dia, Hora, _, _, _, IdMed) :: (
    solucoes(IdMed, consulta(Ano, Mes, Dia, Hora, _, _, _, IdMed), Lista),
    comprimento(Lista, N),
    N == 1).

% Invariante Referencial
% Não permitir que um utente tenha mais que uma consulta à mesma hora 
+consulta(Ano, Mes, Dia, Hora, IdUt, _, _, _) :: (
    solucoes(IdUt, consulta(Ano, Mes, Dia, Hora, IdUt, _, _, _), Lista),
    comprimento(Lista, N),
    N == 1).

% Invariante Referencial
% Não permitir a adição de consultas com um custo negativo
+consulta(_, _,_ , _, _, _, Custo, _) :: (
    solucoes(Custo, (consulta( _, _, _, _, _, _, Custo, _), Custo < 0), Lista),
    comprimento(Lista, N),
    N == 0).


% Invariante Referencial
% Não permitir a adição de um predicado consulta negativa nos meses que têm 31 dias, com o dia superior a 31.
+consulta(_, _, _, _, _, _, _, _) :: (
    solucoes(
        Mes,
        (-consulta(_, Mes, Dia, _, _, _, _, _),
         pertence(Mes, [1,3,5,7,8,10,12]),
         Dia > 31),
        [])).

% Invariante Referencial
% Não permitir a adição de um predicado consulta negativa nos meses que têm 30 dias, com o dia superior a 30.
+consulta(_, _, _, _, _, _, _, _) :: (
    solucoes(
        Mes,
        (-consulta(_, Mes, Dia, _, _, _, _, _),
         pertence(Mes, [2,4,6,9,11]),
         Dia > 30),
        [])).

% Invariante Referencial
% Não permitir a adição de um predicado consulta negativa no mês de fevereiro com o dia superior a 29.
+consulta(_, _, _, _, _, _, _, _) :: (
    solucoes(
        Dia,
        (-consulta(_, 2, Dia, _, _, _, _, _),
         Dia > 29),
        [])).

% Invariante Referencial
% Não permitir a adição de um predicado consulta negativa com um dia do mês menor que 1.
+consulta(_, _, _, _, _, _, _, _) :: (
    solucoes(
        Dia,
        (-consulta(_, _, Dia, _, _, _, _, _),
         Dia < 1),
        [])).


% Invariante Referencial
% Não permitir a adição de um predicado consulta negativo com um mês inferior a 1 e superior a 12
+consulta(Ano, Mes, Dia, Hora, IdUt, IdServ, Custo, IdMed) :: (
    solucoes(Mes, (-consulta(Ano, Mes, Dia, Hora, IdUt, IdServ, Custo, IdMed), (Mes >= 1, Mes =< 12)), Lista),
    comprimento(Lista, N),
    N == 1).


% Invariante Referencial
% Não permitir a adição um predicado consulta negativa com a hora inferior a 0 ou superior a 23
+consulta(Ano, Mes, Dia, Hora, IdUt, IdServ, Custo, IdMed) :: (
    solucoes(Hora, (-consulta(Ano, Mes, Dia, Hora, IdUt, IdServ, Custo, IdMed), (Hora >= 0, Hora =< 23)), Lista),
    comprimento(Lista, N),
    N == 1).






% ------------------------------------------------------------------%
% -------------------Invariantes Gerais de Inserção-----------------%
% ------------------------------------------------------------------%

% Invariante Estrutural
% Invariante que não permite a adição de exceções repetidas
+excecao(E):: (
  solucoes( E , excecao(E) , Lista), comprimento(Lista,N), N==1).

% Invariante Estrutural
% Invariante que não permite a adição de nulo repetidos
+nulo(V)::( 
  solucoes( V, nulo(V), Lista), comprimento(Lista,N), N==1).







% --------------------------------------------------------------------------------------%
% -----------------------------------Invariantes Remoção -------------------------------%
% --------------------------------------------------------------------------------------%


% ---------- Utente --------------- %


% Invariante Referencial
% Não deixa remover um utente se este ainda estiver associado a alguma consulta
-utente(IdUt, _, _, _) :: (
    solucoes(Ano, consulta(Ano, _, _, _, IdUt, _, _, _), Lista),
    comprimento(Lista, N),
    N == 0).


% ---------- Médico --------------- %


% Invariante Referencial
% Não deixa remover um médico se este ainda estiver associado a alguma consulta
-medico(IdMed, Nome, IdServ) :: (
    solucoes(Ano, consulta(Ano, _, _, _, _, _, _, IdMed), Lista),
    comprimento(Lista, N),
    N == 0).


% ---------- Serviço --------------- %


% Invariante Referencial
% Não deixa remover um serviço caso este ainda esteja associado a alguma consulta
-servico(IdServ, Descricao, Instituicao, Cidade) :: (
    solucoes(Ano, consulta(Ano, _, _, _, _, IdServ, _, _), Lista),
    comprimento(Lista, N),
    N == 0).



% ---------- Instituição --------------- %

% Invariante Referencial
% Não deixa remover uma instituição caso ainda existam serviços associados a ela
-instituicao(NomeInst, Cidade) :: (
    solucoes(IdServ, servico(IdServ, _, NomeInst, _), Lista),
    comprimento(Lista, N),
    N == 0).







%-----------------------------------------------------------------------------------------------------%
%---------------------------------------Queries-------------------------------------------------------%
%-----------------------------------------------------------------------------------------------------%

% -------------------------------------------------------------------------------------------%
% Extensão do predicado que permite determinar a média de idade dos utentes com conhecimento perfeito positivo
% media_idades_utentes : Media -> {V,F,D}
media_idades_utentes(Media) :-
    solucoes(
        Idade,
        (utente(IdUt, Nome, Idade, Morada), nao(excecao(utente(IdUt, Nome, Idade, Morada))), nao(nulo(Idade))), 
        ListaIdades),
    somatorio(ListaIdades, S),
    comprimento(ListaIdades, C),
    Media is S/C.


% Extensão do predicado que permite determinar número de consultas de um serviço num determinado ano, 
% isto para predicados consulta com conhecimento perfeito positivo
% numero_consultas_servico: Ano, IdServico, NumeroConsultas -> {V,F,D}
numero_consultas_servico(Ano, IdServico, NumeroConsultas) :-
    solucoes( Ano, 
        (consulta(Ano, Mes, Dia, Hora, IdUt, IdServico, Custo, IdMed), 
        nao(execao(consulta(Ano, Mes, Dia, Hora, IdUt, IdServico, Custo, IdMed))), 
        nao(nulo(Ano))), Lista),
    comprimento(Lista, NumeroConsultas).



% Extensão do predicado que permite determinar o serviço mais consultado de 
% uma instituição num determinado ano, mas somente para predicados
% serviço com conhecimento perfeito positivo.
% servico_mais_consultado : Ano, NomeInst, Descricao -> {V,F, D}
servico_mais_consultado(Ano, NomeInst, Descricao) :-
    solucoesSemRepetidos((Desc, NumeroConsultas), 
        (servico(IdServico, Desc, NomeInst, Cidade), 
        nao(execao(servico(IdServico, Desc, NomeInst, Cidade))), 
        nao(nulo(Desc)), 
        numero_consultas_servico(Ano, IdServico, NumeroConsultas)), 
        Lista),
    maior_par(Lista, (Descricao, _)).



%----------------------------------- Evolução e Regressão ---------------------------------------%

% ------ Conhecimento positivo ------%

% Registar uma nova instituição
resgistaInstituicaoP(Nome, Cidade) :- 
    evolucaoPositivo(instituicao(Nome, Cidade)).

% Registar um serviço
resgistaServicoP(IdServ, Descricao, Instituicao, Cidade) :- 
    evolucaoPositivo(servico(IServ, Descricao, Instituicao, Cidade)).

% Registar um médico
registaMedicoP(IdMed, Nome, IServ) :- 
    evolucaoPositivo(medico(IdMed, Nome, IServ)).

% Registar um utente
registaUtenteP(IdUt, Nome, Idade, Morada) :- 
    evolucaoPositivo(utente(IdUt, Nome, Idade, Morada)).

% Registar uma consulta
registaConsultaP(Ano, Mes, Dia, Hora, IdUt, IServ, Custo, IdMed) :- 
    evolucaoPositivo(consulta(Ano, Mes, Dia, Hora, IdUt, IServ, Custo, IdMed)).

% Remover um instituição
removeInstituicaoP(Nome, Cidade) :-
    regressao(instituicao(Nome, Cidade)).

% Remover um serviço
removeServicoP(IdServ, _, _, _) :-
    regressao(servico(IdServ, _, _, _)).

% Remover um medico
removeMedicoP(IdMed, _, IServ) :-
    regressao(medico(IdMed, _, IdServ)).

% Remover um utente
removeUtenteP(IdUt, _, _, _) :-
    regressao(utente(IdUt, _, _, _)).

% Remove uma consulta
removeConsultaP(Ano, Mes, Dia, Hora, IdUt, IServ, _, IdMed) :-
    regressao(consulta(Ano, Mes, Dia, Hora, IdUt, IServ, _, IdMed)).



% ---------- Conhecimento negativo -----------%

% Registar uma nova instituição
resgistaInstituicaoN(Nome, Cidade) :- 
    evolucaoNegativo(-instituicao(Nome, Cidade)).

% Registar um serviço
resgistaServicoN(IdServ, Descricao, Instituicao, Cidade) :- 
    evolucaoNegativo(-servico(IServ, Descricao, Instituicao, Cidade)).

% Registar um médico
registaMedicoN(IdMed, Nome, IServ) :- 
    evolucaoNegativo(-medico(IdMed, Nome, IServ)).

% Registar um utente
registaUtenteN(IdUt, Nome, Idade, Morada) :- 
    evolucaoNegativo(-utente(IdUt, Nome, Idade, Morada)).

% Registar uma consulta
registaConsultaN(Ano, Mes, Dia, Hora, IdUt, IServ, Custo, IdMed) :- 
    evolucaoNegativo(-consulta(Ano, Mes, Dia, Hora, IdUt, IServ, Custo, IdMed)).

% Remover um instituição
removeInstituicaoN(Nome, Cidade) :-
    regressao(-instituicao(Nome, Cidade)).

% Remover um serviço
removeServicoN(IdServ, _, _, _) :-
    regressao(-servico(IdServ, _, _, _)).

% Remover um medico
removeMedicoN(IdMed, _, IServ) :-
    regressao(-medico(IdMed, _, IdServ)).

% Remover um utente
removeUtenteN(IdUt, _, _, _) :-
    regressao(-utente(IdUt, _, _, _)).

% Remove uma consulta
removeConsultaN(Ano, Mes, Dia, Hora, IdUt, IServ, _, IdMed) :-
    regressao(-consulta(Ano, Mes, Dia, Hora, IdUt, IServ, _, IdMed)).













% --------------------------------- Evolucao do Conhecimento ------------------------------- %
% Extensão do predicado que permite a evolucao do conhecimento
evolucao( Termo ) :-
    solucoes( Invariante, +Termo::Invariante, Lista ),
    insercao( Termo ),
    teste( Lista ).

evolucaoPositivo(X) :-  removeSeTemConhecimentoNegativo(X),
                        evolucao(X).
evolucaoPositivo(X) :-  removeSeTemConhecimentoImperfeitoIncerto(X),
                        evolucao(X).
evolucaoPositivo(X) :-  removeSeTemConhecimentoImperfeitoImpreciso(X),
                        evolucao(X).
evolucaoPositivo(X) :-  evolucao(X).


evolucaoNegativo(-X) :- removeSeTemConhecimentoPositivo(X),
                        evolucao(-X).
evolucaoNegativo(-X) :- removeSeTemConhecimentoImperfeitoIncerto(X),
                        evolucao(-X).
evolucaoNegativo(-X) :- removeSeTemConhecimentoImperfeitoImpreciso(X),
                        evolucao(-X).
evolucaoNegativo(-X) :-  evolucao(-X).

removeSeTemConhecimentoPositivo(utente(IdUt, Nome, Idade, Morada)) :-
    solucoes(IdUt, (utente(IdUt, _, _, _), 
                        nao(excecao(utente(IdUt, Nm, I, M))), 
                        nao(nulo(Nm)),
                        nao(nulo(I)),
                        nao(nulo(M))),
            S),
    comprimento(S, N),
    N>0,
    removeTermos(S).


removeSeTemConhecimentoPositivo(consulta(Ano, Mes, Dia, Hora, IdUt, IdServ, Custo, IdMed)) :-
    solucoes(Ano, (consulta(Ano, Mes, Dia, Hora, IdUt, IdServ, Custo, IdMed), 
                        nao(excecao(consulta(Ano, Mes, Dia, Hora, IdUt, IdServ, Custo, IdMed))), 
                        nao(nulo(Custo))),
            S),
    comprimento(S, N),
    N>0,
    removeTermos(S).

removeSeTemConhecimentoNegativo(utente(IdUt, _, _, _)) :-
    solucoes(utente(IdUt, Nome, Idade, Morada), 
        -utente(IdUt, Nome, Idade, Morada), 
        [NegativoGeral, NegativoExplicito]),
    remove(-NegativoExpliciUto).

removeSeTemConhecimentoNegativo(consulta(Ano, Mes, Dia, Hora, IdUt, IdServ, Custo, IdMed)) :-
    solucoes(consulta(Ano, Mes, Dia, Hora, IdUt, IdServ, Custo, IdMed), 
        -consulta(Ano, Mes, Dia, Hora, IdUt, IdServ, Custo, IdMed), 
        [NegativoGeral, NegativoExplicito]),
    remove(-NegativoExpliciUto).

removeSeTemConhecimentoImperfeitoIncerto(utente(IdUt, _, _, _)) :-
            solucoes(utente(IdUt, Nome, Idade, Morada), (utente(IdUt, Nome, Idade, Morada), 
                        excecao(utente(IdUt, Nome, Idade, Morada)), 
                        nao(nulo(Nome)),
                        nao(nulo(Idade)),
                        nao(nulo(Morada))), 
                    [Desconhecido]),
            removeTermos([
                Desconhecido, 
                (excecao(Desconhecido):-Desconhecido)]).

removeSeTemConhecimentoImperfeitoIncerto(consulta(Ano, Mes, Dia, Hora, IdUt, IdServ, Custo, _)) :-
            solucoes(consulta(Ano, Mes, Dia, Hora, IdUt, IdServ, Custo, IdMed), 
                        (consulta(Ano, Mes, Dia, Hora, IdUt, IdServ, Custo, IdMed), 
                        excecao(consulta(Ano, Mes, Dia, Hora, IdUt, IdServ, Custo, IdMed)), 
                        nao(nulo(Custo))), 
                    [Desconhecido]),
            removeTermos([
                Desconhecido, 
                (excecao(Desconhecido):-Desconhecido)]).

removeSeTemConhecimentoImperfeitoIncerto(consulta(Ano, Mes, Dia, _, IdUt, IdServ, Custo, IdMed)) :-
            solucoes(consulta(Ano, Mes, Dia, Hora, IdUt, IdServ, Custo, IdMed), 
                        (consulta(Ano, Mes, Dia, Hora, IdUt, IdServ, Custo, IdMed), 
                        excecao(consulta(Ano, Mes, Dia, Hora, IdUt, IdServ, Custo, IdMed)), 
                        nao(nulo(Custo))), 
                    [Desconhecido]),
            removeTermos([
                Desconhecido, 
                (excecao(Desconhecido):-Desconhecido)]).

removeSeTemConhecimentoImperfeitoImpreciso(utente(IdUt, _, _, _)) :-
        solucoes(
            excecao(utente(IdUt, Nome, Idade, Morada)), 
            (excecao(utente(IdUt, Nome, Idade, Morada)), 
                nao(nulo(Nome)),
                nao(nulo(Idade)),
                nao(nulo(Morada))), 
            S),
        comprimento(S, N),
        N>=1,
        removeTermos(S).

removeSeTemConhecimentoImperfeitoImpreciso(consulta(Ano, Mes, Dia, Hora, IdUt, IdServ, _, IdMed)) :-
        solucoes(
            excecao(consulta(Ano, Mes, Dia, Hora, IdUt, IdServ, Custo, IdMed)), 
            (excecao(consulta(Ano, Mes, Dia, Hora, IdUt, IdServ, Custo, IdMed)), nao(nulo(Custo))), 
            S),
        comprimento(S, N),
        N>1,
        removeTermos(S).

regressao( Termo ) :-
    solucoes( Invariante, -Termo::Invariante, Lista ),
    remocao( Termo ),
    teste( Lista ).

insercao( Termo ) :-
    assert( Termo ).
insercao( Termo ) :-
    retract( Termo ), !, fail.

remocao( Termo ) :-
    retract( Termo ).
remocao( Termo ) :-
    assert( Termo ), !, fail.

remove( Termo ) :-
    retract( Termo ).

removeTermos( [] ).
removeTermos( [X] ) :-
    retract(X).
removeTermos( [X|L] ) :-
    retract(X),
    removeTermos( L ).     

teste( [] ).
teste( [H|T] ) :- H,
    teste(T). 

% --------------------------------  Predicados auxiliares ---------------------------------- %

comprimento( [] , 0) .
comprimento( [X] , 1) .
comprimento( [X|L], R) :-
    comprimento(L, Y),
    R is Y + 1.

somatorio( [], 0).
somatorio( [H|L], R) :-
    somatorio( L, Y),
    R is H + Y.

solucoes(X,P,S) :- findall(X,P,S).

solucoesSemRepetidos(X,P,S) :-
    solucoes(X,P,R),
    eliminaOsRepetidos(R,S).


eliminaOsRepetidos([],[]).
eliminaOsRepetidos([Head|Tail],X) :-
    eliminaElementos(Head,Tail,SemRpetidos),
    concatenar([Head],Y,X),
    eliminaOsRepetidos(SemRpetidos,Y).

eliminaElementos(X,[],[]).
eliminaElementos(X,[X|L],R) :-
    eliminaElementos(X,L,R).
eliminaElementos(X,[H|L],[H|Z]) :-
    X \== H,
    eliminaElementos(X,L,Z).

concatenar([],A,A).
concatenar([A|B],C,[A|D]) :- concatenar(B,C,D).


maior_par([], (sem_resultado, -1)).
maior_par([(E,N)], (E,N)).
maior_par([(E,N)|T], (E,N)) :-
    maior_par(T, (E2,N2)),
    N >= N2.
maior_par([(E,N)|T], (E2,N2)) :-
    maior_par(T, (E2,N2)),
    N < N2.


pertence(X,[X|_]).
pertence(X,[Y|L]) :-
    X \= Y, pertence(X,L).

%---------------------------------- Predicado Consulta Demo--------------------------------- %
nao(Q) :- Q, !, fail.
nao(Q).

demo(Q1 and Q2, R) :-   demo(Q1, R1),
                        demo(Q2, R2),
                        conjuncao(R1, R2, R).

demo(Q1 or Q2, R) :-    demo(Q1, R1),
                        demo(Q2, R2),
                        disjuncao(R1, R2, R). 

demo(Q, verdadeiro) :- Q.
demo(Q, falso) :- -Q.
demo(Q, desconhecido) :- nao(Q), nao(-Q).

iguais(A, A).

conjuncao(verdadeiro, verdadeiro, verdadeiro).
conjuncao(falso, _, falso).
conjuncao(_, falso, falso).
conjuncao(_, _, desconhecido).

disjuncao(verdadeiro, _, verdadeiro).
disjuncao(falso, falso, falso).
disjuncao(_, verdadeiro, verdadeiro).
disjuncao(desconhecido, desconhecido, desconhecido).

% Extensao do meta-predicado demoListas: ListaQuestoes,ListaRespostas -> {V,F,D}
demoListas([],[]).
demoListas([Q|TQ],[R|TR]) :- demo(Q,R), demoListas(TQ,TR).







