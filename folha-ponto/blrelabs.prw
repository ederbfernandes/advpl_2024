#INCLUDE "PROTHEUS.CH"
#INCLUDE "ABSENT.CH"
#INCLUDE "RWMAKE.CH"



User Function LASARABS()
//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Define Variaveis Locais (Basicas)                            �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
Local cDesc1  := STR0001  // 'Absenteismo'
Local cDesc2  := STR0002  // 'Ser� impresso de acordo com os parametros solicitados pelo'
Local cDesc3  := STR0003  // 'usuario.'
Local cString := 'SRA' //-- Alias do arquivo principal (Base)
Local aOrd    := {STR0004 , STR0005 , STR0006 , STR0007 , STR0038 } // 'Matricula'###'Centro de Custo'###'Nome'###'Turno'###'C.Custo+Nome'
Local wnRel

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Define Variaveis PRIVATE(Basicas)                            �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
Private aReturn    := { STR0008 , 1, STR0009 , 2, 2, 1, '',1 } // 'Zebrado'###'Administra뇙o'
Private nomeprog   := 'blrelabs'
Private aLinha     := {}
Private nLastKey   := 0
Private cPerg      := 'ABSENT'

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Verifica as perguntas selecionadas                           �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
Pergunte(cPerg,.F.)

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Variaveis Utilizadas na funcao IMPR                          �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
Private Titulo   := OemToAnsi(STR0001 ) // 'Absenteismo'
Private cCabec   := ''
Private AT_PRG   := 'ABSENT'
Private wCabec0  := 1
Private wCabec1  := STR0011  //'Matric Nome                  Periodo  Hrs.Prev.  Hrs.Real     %  (1)Hrs.Adic.     %  (2)Hrs.N.Trab.     %  (3)Hrs.Abonadas     %   '
Private CONTFL   := 1
Private LI       := 0
Private nTamanho := 'M'

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Define Variaveis Private(Programa)                           �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
Private nOrdem

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Reinicializa as Static do SIGAPON                            �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
PonDestroyStatic()

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Verifica as perguntas selecionadas                           �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
Pergunte('ABSENT',.F.)

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Envia controle para a funcao SETPRINT                        �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
wnrel := 'ABSENT' //-- Nome Default do relatorio em Disco
wnrel := SetPrint(cString,wnrel,cPerg,@Titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,,nTamanho)

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Verifica Ordem do Relatorio                                  �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
nOrdem     := aReturn[8]

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Carregando variaveis MV_PAR?? para Variaveis do Sistema.     �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
cFilDe     	:= MV_PAR01					//Filial De           ?
cFilAte    	:= MV_PAR02					//Filial Ate          ?
CcDe       	:= MV_PAR03					//Centro de Custo De  ?
CcAte      	:= MV_PAR04					//Centro de Custo Ate ?
TurDe      	:= MV_PAR05					//Turno De            ?
TurAte     	:= MV_PAR06					//Turno Ate           ?
MatDe      	:= MV_PAR07					//Matricula De        ?
MatAte     	:= MV_PAR08					//Matricula Ate       ?
NomDe      	:= MV_PAR09					//Nome De             ?
NomAte     	:= MV_PAR10					//Nome Ate            ?
cSit       	:= MV_PAR11					//Situacoes a Impr.   ?
cCat       	:= MV_PAR12					//Categorias a Impr.  ?
lCC        	:= If(MV_PAR13 == 1,.T.,.F.)	//C.C. em Outra Pag.  ? Sim/Nao
dDataDe    	:= MV_PAR14					//Data De             ?
dDataAte   	:= MV_PAR15					//Data Ate            ?
lSintetico 	:= If(MV_PAR16 == 1,.F.,.T.)	//Analitico/Sintetico ? Analitico/Sintetico
lDiscri    	:= If(MV_PAR17 == 1,.T.,.F.)	//Discrimina Eventos  ? Sim/Nao
lAfastPrev	:= If(MV_PAR18 == 1,.T.,.F.)	//Considera o Afastamento como Previsto ? Sim/Nao

//-- Consiste periodo de impressao do relatorio
If dDataAte<dDataDe .or. Empty(dDataAte) .Or. Empty(dDataDe)
    Help( ''  , 1 , 'NVAZIO' ,OemToAnsi( STR0032 ) ,OemToAnsi( STR0033 ) , 5 , 0 )
	Return Nil
Endif

If	nLastKey == 27
	Return Nil
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
	Return Nil
Endif

cCabec := STR0001+' '+Transf(dDataDe,'@E')+' - '+Transf(dDataAte,'@E')  // 'Absenteismo'

Titulo := OemToAnsi(cCabec)
RptStatus({|lEnd| ABSENTImp(@lEnd,wnRel,cString)},Titulo)

Return Nil

/*
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴엽�
굇쿑un뇙o    쿌BSENTImp � Autor � Alexsandro Pereira    � Data � 15.05.00 낢�
굇쳐컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴눙�
굇쿏escri뇙o � Absenteismo                                                낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿞intaxe e � ABSENTImp(lEnd,wnRel,cString)                              낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿛arametros�                                                            낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿢so       � Gen굍ico                                                   낢�
굇읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴袂�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�*/
Static Function ABSENTImp(lEnd,WnRel,cString)

//-- Variaveis Locais
//Local cDet         := ''				//-- Linha de detalhe da impressao
Local cSeqAnt      := '  '				//-- Sequencia anterior
Local nX           := 0					//-- Variavel de loop for
Local aAbon        := {}				//-- Itens de abono GERAL
Local aNTra        := {}				//-- Itens de hrs nao trabalhadas GERAL
Local aAdic        := {}				//-- Itens de hrs adicionais GERAL
Local aCodHeAut    := {}				//-- Codigos de hora extra autorizada
Local aCodAbat     := {}				//-- Codigos de horas nao trabalhadas
Local aTurnos      := {}				//-- Trocas de turno do periodo
Local aPeriodos    := {}				//-- Periodos a imprimir
Local cColuna01    := ''				//-- Detalhe da coluna 1 do relatorio
Local cColuna02    := ''				//-- Detalhe da coluna 2 do relatorio
Local cColuna03    := ''				//-- Detalhe da coluna 3 do relatorio
Local cAlias       := 'SPC'				//-- Alias do arquivo a partir do qual os lancamentos serao lidos
Local lSemApo	   := .F.				//-- Indicador se Existe Apontamentos
Local nHrsPrev     := 0					//-- Horas previstas
Local nHrsReal     := 0					//-- Horas reais
Local nPReal       := 0					//-- Percentual horas reais
Local nHrsAdic     := 0					//-- Horas adicionais
Local nPAdic       := 0					//-- Percentual horas adicionais
Local nPNTra       := 0					//-- Percentual horas nao trabalhadas
Local nHrsAbon     := 0					//-- Horas abonadas
Local nHrsGS		:= 0
Local nPAbo        := 0					//-- Percentual horas abonadas
Local dPerIni      := Ctod("  /  /  ")	//-- Data de inicio do periodo
Local dPerFim      := Ctod("  /  /  ")	//-- Data fim do periodo
Local dPonmesIni   := Ctod("  /  /  ")	//-- Data de inicio do periodo aberto
Local dPonmesFim   := Ctod("  /  /  ")	//-- Data fim do periodo aberto
Local cAcessaSRA   := &("{ || " + ChkRH("ABSENT","SRA","2") + "}")
Local dtInicio	   := Ctod('') 			//-- Auxiliar Inicio do Periodo considerando Data Admissao
Local aOfusca		:= If(FindFunction('ChkOfusca'), ChkOfusca(), { .T., .F. })//[2]Ofuscamento
Local aFldRel		:= Iif( aOfusca[2], FwProtectedDataUtil():UsrNoAccessFieldsInList( {"RA_NOME"} ), {} )
Local lOfusca		:= Len(aFldRel) > 0
Local lIntegraGS	:= FindFunction("TecPNMTAB") .AND. FindFunction("TecExecPNM") .AND. TecExecPNM()

Private cFilAnte   := ''				//-- Filial anterior
Private cFilRegra  := ''				//-- Filial para uso na consulta do arquivo Regra
Private cTnoAnt    := ''				//-- Turno anterior
Private cCcAnt     := ''				//-- Centro de custo anterior
Private nHrsnTra   := 0					//-- Horas nao trabalhadas
Private aTabPadrao := {}				//-- Tabela de horario padrao
Private aTabCalend := {}				//-- Calendario de trabalho
Private aAdicT     := {}					//-- Totalizador hrs adicionais turno
Private aNTraT     := {}					//-- Totalizador hrs nao trab. turno
Private aAbonT     := {}					//-- Totalizador hrs abonadas turno
Private aAdicC     := {}					//-- Totalizador hrs adicionais centro de custo
Private aNTraC     := {}					//-- Totalizador hrs nao trabalhadas centro de custo
Private aAbonC     := {}					//-- Totalizador hrs abonadas centro de custo
Private aAdicF     := {}					//-- Totalizador hrs adicionais filial
Private aNTraF     := {}					//-- Totalizador hrs nao trabalhadas filial
Private aAbonF     := {}					//-- Totalizador hrs abonadas filial
Private aAdicE     := {}					//-- Totalizador hrs adicionais empresa
Private aNTraE     := {}					//-- Totalizador hrs nao trabalhadas empresa
Private aAbonE     := {}					//-- Totalizador hrs abonadas empresa
Private aTotalF    := {}
Private aTotalE    := {}
Private aTotalC    := {}
Private aTotalT    := {}
Private aInfo      := {}
Private lPrimVez   := .T.

//-- aPeriodos
//-- [n,1] - data inicio do periodo.
//-- [n,2] - data termino do periodo.
//-- [n,3] - data inicio do acumulo dos dados dentro do periodo.
//-- [n,4] - data fim do acumulo dos dados dentro do periodo.

//-- Carga da tabela de horario padrao
If !fTabTurno(aTabPadrao)
	Help(' ',1,'TPADNCAD')
	Return Nil
EndIf

//-- Posiciona registro inicial de acordo com de/ate
dbSelectArea('SRA')
dbGoTop()
dbSetOrder(nOrdem)
If nOrdem == 1
	dbSeek(cFilDe + MatDe,.T.)
	cInicio := 'SRA->RA_FILIAL + SRA->RA_MAT'
	cFim    := cFilAte + MatAte
ElseIf nOrdem == 2
	dbSeek(cFilDe + CcDe + MatDe,.T.)
	cInicio := 'SRA->RA_FILIAL + SRA->RA_CC + SRA->RA_MAT'
	cFim    := cFilAte + CcAte + MatAte
ElseIf nOrdem == 3
	dbSeek(cFilDe + NomDe + MatDe,.T.)
	cInicio := 'SRA->RA_FILIAL + SRA->RA_NOME + SRA->RA_MAT'
	cFim    := cFilAte + NomAte + MatAte
ElseIf nOrdem == 4
	dbSeek(cFilDe + TurDe,.T.)
	cInicio := 'SRA->RA_FILIAL + SRA->RA_TNOTRAB'
	cFim    := cFilAte + TurAte
ElseIf nOrdem == 5
	dbSetOrder(8)
	dbSeek(cFilDe + CcDe + NomDe,.T.)
	cInicio  := 'SRA->RA_FILIAL + SRA->RA_CC + SRA->RA_NOME'
	cFim     := cFilAte + CcAte + NomAte
Endif

//-- Inicializa regua de processamento
SetRegua(SRA->(RecCount()))

cFilAnte     := Replicate("@", FWGETTAMFILIAL)
cCcAnt       := Replicate("@", GetSx3Cache("RA_CC", "X3_TAMANHO"))
cTnoAnt      := Replicate("@", GetSx3Cache("RA_TNOTRAB", "X3_TAMANHO"))
lImprTitulo	 := .T.

While SRA->(!Eof()) .And. &cInicio <= cFim
	//-- Incrementa regua de processamento
	IncRegua()

	//-- Cancelamento de impressao pelo usuario
	If lEnd
		Impr(cCancela,'C')
		Exit
	EndIF

	//-- Processa a Quebra de Filial
	If SRA->RA_FILIAL != cFilAnte
		If cFilAnte != Replicate("@", FWGETTAMFILIAL)
			fImpFil()    // Totaliza Filial
		Endif

		cFilAnte   	:= SRA->RA_FILIAL
		cCcAnt  	:= SRA->RA_Cc

		//-- Dados da empresa/filial
		If !fInfo(@aInfo,SRA->RA_FILIAL)
			Exit
		Endif

		//-- Carrega os codigos de horas nao trabalhadas
		fCarCodAbat(@aCodAbat)
		cFilRegra:= fFilFunc("SPA")

		/*
		旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
		� Carrega periodo de Apontamento Aberto						  �
		읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�*/
		IF !CheckPonMes( @dPerIni , @dPerFim , .F. , .T. , .F. , cFilAnte )
			Exit
		EndIF

		//-- Obtem o Periodo Aberto
		GetPonMesDat( @dPonMesIni , @dPonMesFim , cFilAnte )
	Endif

	//-- Processa a Quebra de Turno
	If cTnoAnt+cSeqAnt != SRA->RA_TNOTRAB+SRA->RA_SEQTURN
		cSeqAnt := SRA->RA_SEQTURN
		cTnoAnt := SRA->RA_TNOTRAB

		//-- Carrega os codigos de horas nao trabalhadas
		fCarCodAbat(@aCodAbat)
	Endif

	//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
	//� Consiste controle de acessos e filiais validas               �
	//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
	If !(SRA->RA_FILIAL $ fValidFil()) .Or. !Eval(cAcessaSRA)
		fCabTotal()
		Loop
	EndIf

	//-- Consiste Parametrizacao do Intervalo de Impressao
	If (SRA->RA_DEMISSA 	< dDataDe 	.And. !Empty(SRA->RA_DEMISSA)) 	.Or. ;
		(SRA->RA_TNOTRAB 	< TurDe) 	.Or. (SRA->RA_TNOTRAB 	> TurAte) 	.Or. ;
		(SRA->RA_NOME 		< NomDe) 	.Or. (SRA->RA_NOME 		> NomAte) 	.Or. ;
		(SRA->RA_MAT 		< MatDe) 	.Or. (SRA->RA_MAT 		> MatAte) 	.Or. ;
		(SRA->RA_CC 		< CcDe) 	.Or. (SRA->RA_CC 		> CCAte) 	.Or. ;
		!(SRA->RA_SITFOLH 	$ cSit) 	.Or. !(SRA->RA_CATFUNC 	$ cCat)
		fCabTotal()
		Loop
	Endif

	/*
	旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
	쿝etorna Periodos de Apontamentos Selecionados				  �
	읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�*/
	aPeriodos := Monta_per( dDataDe , dDataAte , cFilAnte , SRA->RA_MAT , dPerIni , dPerFim )

	//-- Monta o Array aImp com as ocorr늧cias do per죓do
	aImp := {}

	For nX := 1 To Len(aPeriodos)


		cSeqTurn := '**'

		//-- Chamada a fTrocaTno() para identificar o turno correto a ser passado para retseq.
		fTrocaTno(aPeriodos[nX,1], aPeriodos[nX,2], @aTurnos)

		cSeqTurn := SRA->RA_SEQTURN
		cTno     := If(Len(aTurnos)==0,SRA->RA_TNOTRAB,aTurnos[1,1])

		//-- Se periodo for anterior ao atual arquivo de trabalho sera SPH
		If ( aPeriodos[nX,2] < dPonMesIni )
			cAlias := 'SPH'
		Else
			cAlias := 'SPC'
		Endif
		//-- Considera a Data de Admissao para o Inicio do Periodo
		dtInicio:=Max(aPeriodos[nX,3],SRA->RA_ADMISSA)

		//-- Monta calendario com horarios de trabalho
		If !CriaCalend( Max(aPeriodos[nX,1],SRA->RA_ADMISSA),aPeriodos[nX,2],cTno,cSeqTurn,aTabPadrao,@aTabCalend,SRA->RA_FILIAL,SRA->RA_MAT,SRA->RA_CC,@aTurnos,NIL,NIL,.F.)
			dbSelectArea("SRA")
			Loop
		EndIf
		
		//-- Apura as horas adicionais, horas nao trabalhadas e as horas abonadas, a partir do SPC e/ou SPH
		nHrsAdic	:= 0
		nHrsAbon	:= 0
		nHrsnTra	:= 0
		
		//-- Apura as horas trabalhadas a partir do calendario de trabalho
		nHrsPrev := fHrsPrev(aTabCalend,dtInicio,aPeriodos[nX,4])
		
		fSomaHrs(aCodAbat, aCodHeAut, @aAdic, @aNTra, @aAbon, @nHrsAdic, @nHrsnTra, @nHrsAbon, dtInicio, aPeriodos[nX,4], cAlias, @lSemApo, @nHrsGS, lIntegraGS)

		//-- Apura as horas efetivamente trabalhadas ( previstas - nao trab )
		If ! Empty(nHrsnTra)
			IF lIntegraGS .AND. nHrsGS > 0
				nHrsPrev := SomaHoras(nHrsPrev, nHrsGS)
				nHrsGS	:= 0
			EndIf
			nHrsReal := SubHoras(nHrsPrev,nHrsnTra)
			
			nHrsReal := If(nHrsReal < 0.00, 0.00, nHrsReal)
		Else
			If lSemApo
				//Verifica se trata de um periodo de apontamento futuro
				If ( aPeriodos[nX, 1] > dPonMesFim )
					nHrsReal := 0.00
				Else
					nHrsReal := nHrsPrev
				Endif
			Else
				nHrsReal := nHrsPrev
			Endif
		Endif
		//-- Percentual de horas reais x previstas
		nPReal   := (fConvHr(nHrsReal,'D') / fConvHr(nHrsPrev,'D')) * 100
		//-- Percentual de horas extras x previstas
		nPAdic   := (fConvHr(nHrsAdic,'D') / fConvHr(nHrsPrev,'D')) * 100
		//-- Percentual de horas nao trabalhadas x previstas
		nPNTra   := (fConvHr(nHrsnTra,'D') / fConvHr(nHrsPrev,'D')) * 100
		//-- Percentual de horas abonadas x horas nao trabalhadas
		nPAbo    := (fConvHr(nHrsAbon,'D') / fConvHr(nHrsnTra,'D')) * 100

		//-- Monta array de impressao
		If ! lSintetico
			AAdd(aImp, If(nX==1,SRA->RA_MAT+Space(01)+If(lOfusca, Replicate('*',20), Left(SRA->RA_NOME,20)),Space(27))+'  '+StrZero(Month(aPeriodos[nX,2]),2)+'/'+Transf(Year(aPeriodos[nX,2]),'9999')+'  '+Transf(nHrsPrev, "@E 999.99")+;
			Space(05)+Transf(nHrsReal, "@E 999.99")+Space(02)+Transf(nPReal,"@E 999.99")+;
			Space(03)+Transf(nHrsAdic, "@E 999.99")+Space(05)+Transf(nPAdic,"@E 999.99")+;
			Space(05)+Transf(nHrsnTra, "@E 999.99")+Space(05)+Transf(nPNTra, "@E 999.99")+;
			Space(05)+Transf(nHrsAbon, "@E 999.99")+Space(06)+Transf(nPAbo, "@E 999.99"))
		Endif

		//-- Acumula os totais do Periodo por : filial/centro de custo/turno
        fTotLinPer({@aTotalF,@aTotalC,@aTotalT,@aTotalE}	,nHrsPrev,nHrsReal,nHrsAdic,nHrsnTra,nHrsAbon,aPeriodos[nX,2],nPReal, nPAdic, nPnTra, nPAbo)
	Next nX


    If !lSintetico .AND. Len(aPeriodos) > 0
		//-- Espacamento de uma linha apos a linha de informacoes
		AAdd(aImp, '*')
    Endif

	//-- Emite resumo com a dicriminacao das horas
	nX := 0
	If lDiscri .And. !lSintetico .And. (Len(aAdic)+Len(aNTra)+Len(aAbon)) > 0
	  //	AAdd(aImp, STR0010) //'(1) Descricao                  Horas      % (2) Descricao                  Horas      %  (3) Descricao                  Horas      %'
		//-- Calcula Percentuais
		fCalcPerc(@aAdic)
		fCalcPerc(@aNTra)
		fCalcPerc(@aAbon)
		For nX := 1 To Max(Max(Len(aAdic), Len(aNTra)),Len(aAbon))
			cColuna01 := If(nX<=Len(aAdic),aAdic[nX,1]+Space(01)+Left(aAdic[nX,2],19)+Space(01)+Transf(aAdic[nX,3],"@E 99999.99")+Space(01)+Transf(aAdic[nX,4],"@E 999.99"),Space(39))
			cColuna02 := If(nX<=Len(aNTra),aNTra[nX,1]+Space(01)+Left(aNTra[nX,2],19)+Space(01)+Transf(aNTra[nX,3],"@E 99999.99")+Space(01)+Transf(aNTra[nX,4],"@E 999.99"),Space(39))
			cColuna03 := If(nX<=Len(aAbon),aAbon[nX,1]+Space(01)+Left(aAbon[nX,2],19)+Space(01)+Transf(aAbon[nX,3],"@E 99999.99")+Space(01)+Transf(aAbon[nX,4],"@E 999.99"),Space(39))
			AAdd(aImp, Space(04)+cColuna01+Space(05)+cColuna02+Space(06)+cColuna03)
		Next nX
	Endif

    //-- Totaliza os Array de Eventos aos Acumuladores: Filial,CC,Turno e Empresa
    fTot(aAdic,{@aAdicF,@aAdicC,@aAdicT,@aAdicE})
    fTot(aNTra,{@aNTraF,@aNTraC,@aNTraT,@aNTraE})
    fTot(aAbon,{@aAbonF,@aAbonC,@aAbonT,@aAbonE})

	//-- Reinicializa variaveis de lancamentos
	aAdic := {}
	aNTra := {}
	aAbon := {}

	If Len(aImp) == 0
		fCabTotal()
		Loop
	Endif

    If !lSintetico
    	//-- Imprime funcionario Percentuais e Eventos                                         �
  		fImpFun(@aImp)
    Endif

	//-- Verifica QUEBRA
	//-- Imprime cabecalho e Totais de Acumuladores: Filial/CC/Turno/Empresa
	fCabTotal()

EndDo

dbSelectArea("SRA")
dbSetOrder(1)

Set Device To Screen
If aReturn[5] == 1
	Set Printer To
	Commit
	OurSpool(wnrel)
Endif
MS_FLUSH()

*---------------------------*
Static Function fCabTotal()
*---------------------------*

cCcAnt  := SRA->RA_CC
cTnoAnt := SRA->RA_TNOTRAB
cFilAnte := SRA->RA_FILIAL
dbSelectArea( "SRA" )
SRA->( dbSkip() )
If	Eof() .Or. &cInicio > cFim
	fImpCc()
	fImpFil()
	fImpEmp()
Elseif cFilAnte != SRA->RA_FILIAL
	fImpCc()
	fImpFil()
Elseif (cCcAnt != SRA->RA_Cc .AND. (nOrdem == 2 .OR. nOrdem == 5)) .Or. ;
       (cTnoAnt != SRA->RA_TNOTRAB  .AND. nOrdem == 4) .And. !Eof()
	fImpCc()
Endif
Return Nil

*---------------------*
Static Function fImpFun(aImp)     // Imprime um Funcionario
*---------------------*

fImprime(aImp,1) 		//Imprime Total Funcionario

aImp := {}         		//Zera Total do Funcionario

Return Nil

*--------------------*
Static Function fImpCc 	// Imprime Centro de Custo
*--------------------*

If nOrdem ==  2 .Or. nOrdem == 5
   If Len(aTotalC) == 0
   	  Return Nil
   Endif
   fImprime({},2) 		// Imprime Identificacao C.Custo

ElseIf nOrdem == 4
    If Len(aTotalT) == 0
   	   Return Nil
    Endif
    fImprime({},4) 		// Imprime Identificacao  Turno

Endif

Return Nil

*---------------------*
Static Function fImpFil // Imprime Filial
*---------------------*
If  Len(aTotalF) == 0
	Return Nil
Endif

fImprime({},3) 			//Imprime Identificacao

Return Nil

*---------------------*
Static Function fImpEmp // Imprime Empresa
*---------------------*
If Len(aTotalE) == 0
	Return Nil
Endif

fImprime({},0) 			//Imprime Identificacao

Return Nil


*-----------------------------------------------*
Static Function fImprime(aFun,nTipo)
*-----------------------------------------------*
// nTipo: 1- Funcionario
//        2- Centro de Custo
//        3- Filial
//        4- Turno
Local nPre   	:= 0
Local lCabEve	:=.F.
Local lJaPrtEve	:=.F.
Local lImprimir :=.F.
Local naFun		:= 0

//-- Imprime Identificacao se lImprTitulo .T.
//-- Desconsidera se for imprimir Total da Empresa e de Filial
//-- Desconsidera se for Sintetico
If lImprTitulo .AND. nTipo<> 0 .and. nTipo<>3   .AND. !lSintetico
   	If nOrdem == 2	.Or. nOrdem == 4 .Or. nOrdem == 5 // - Centro de Custo ou Turno de Trab
	   fImprCab(nOrdem,,"C",.T.)
	Else
	   fImprCab(3,,"P",.T.)
	Endif
   lImprTitulo:=.F.		//-- Desabilita a Impressao de Cabec de Identificacao
Endif

If nTipo == 1 .And. !lSintetico
    naFun:=Len(aFun)
	For nPre := 1 to naFun
	    //-- Se os proximos elementos forem Eventos
		If aFun[nPre]=="*"
		   //-- Se Existirem Eventos a Imprimir
		   If  nPre<naFun
		       //-- "Liga" a impressao de SubCab
		       lCabEve		:=.T.
		       lJaPrtEve	:=.T.
		       aFun[nPre]	:=""
		   Else
		   	   //-- Nao Imprime "" (Linha em Branco) pois nao ha eventos para Print
		   	   Loop
		   Endif

		Endif
	    If Li>52
	       //-- Se, por exemplo, Li=57 , forca a quebra de pag
	       //-- para que o subcabec seja impresso com os totais
	       //-- Verifica a Ordem para Imprimir a Identificacao do Tipo de Relatorio
    	   If nOrdem == 2	.Or. nOrdem == 4 .Or. nOrdem == 5 // - Centro de Custo ou Turno de Trab
			   fImprCab(nOrdem,,"P",.T.)
		   Else
			   fImprCab(3,,"P",.T.)
		   Endif
		   //-- Se Jah houve impressao de algum evento forca a impressao do SubCab
		   lCabEve:=If(lJaPrtEve,.T.,.F.)
		Endif

		//-- Impressao de Descricao de Eventos
		If lCabEve
		   cDet := STR0010 //'(1) Descricao                  Horas      % (2) Descricao                  Horas      %  (3) Descricao                  Horas      %'
		   Impr(cDet,'C')

		   lCabEve:=.F.
		Endif
		lImprimir :=.T.
		fImprCab(1,aFun[nPre])
	Next nPre
	//Imprimir os separadores apenas quando houver informacoes anteriores impressas //
	If lImprimir
		fImprCab(1,Replicate("-",132))
	EndIf

ElseIf nTipo == 2	// Salta pagina a cada Centro de Custo
	If lCC
		fImprCab(2,,"P")
	Endif
    //-- Imprime Totais
    fTotais(2)

ElseIf nTipo == 3	// Salta pagina a cada Filial
	fTotais(3)

ElseIf nTipo == 4	// Salta pagina a cada Turno
	fTotais(4)

ElseIf nTipo == 0	// Total Empresa
	fTotais(0)
Endif

//-- Salta de Pagina
if nTipo == 2
	If lCC          //-- Se imprime C.Custo e Deseja-se C.Custo em Outra Pagina
		Impr("","P")
	Endif
	lImprTitulo:=.T.
Elseif nTipo == 3  //-- A Cada Filial
		Impr("","P")
		lImprTitulo:=.T.   	//-- Liga Impressao da Identificacao da Filial na Pag.Seguinte
							//-- Proxima Impressao de Funcionario
Elseif nTipo == 4  //-- A Cada Turno
	   lImprTitulo:=.T.   	//-- Liga Impressao da Identificacao da Filial na Pag.Seguinte
							//-- Proxima Impressao de Funcionario
Endif
Return Nil

*-----------------------------------------------*
Static Function fImprCab(nTipo,Det,cPara,lAtual)
*-----------------------------------------------*
// nTipo: 1		 - Funcionario
//        2 ou 5 - Centro de Custo
//		  3		 - Filial
//        4		 - Turno
//		  0		 - Empresa
// Det : Linha Detalhe do Funcionario
Local cDet:=""
nTipo := If(nTipo==NIL,0,nTipo)
cPara := If(cPara==Nil,"C",cPara)
//-- Se lAtual .T. Imprime Filial/C.Custo/Turno do funcionario
//-- que nao nao foram colocados nas variaveis verificadoras de quebra
lAtual:= If(lAtual==NIL,.F.,.T.)

If Li >52 .Or. cPara == "P"
	Impr("","P")
Endif

//-- Para Tipos de Impressao Diferentes de Funcionario
//-- Imprime o Cabec Identificacao
If nTipo <> 1
	if (nTipo == 2 .OR. nTipo == 5) .and. (nOrdem == 2 .Or. nOrdem == 5)
	   	If !lAtual
	   	   	cDet:= STR0027+cFilAnte+Space(2)+STR0030+cCcAnt+' - '+DescCc(cCcAnt,cFilAnte)		//"Filial: "###"  C.C: "
	   	Else
			cDet:= STR0027+SRA->RA_FILIAL+Space(2)+STR0030+SUBS(SRA->RA_CC+SPACE(20),1,20)+' - '+DescCc(SRA->RA_CC,SRA->RA_FILIAL,30)		//"Filial: "###"  C.C: "
	   	Endif
	Elseif nTipo == 3
		If !lAtual
	   		cDet:= STR0027+cFilAnte+" - "+aInfo[1]		//"Filial: "
	   	Else
	   	   	fInfo(@aInfo,SRA->RA_FILIAL)
	   		cDet:= STR0027+SRA->RA_FILIAL+" - "+aInfo[1]		//"Filial: "
	   		fInfo(@aInfo,cFilAnte)
	   	Endif
	Elseif nTipo == 4
	   	If !lAtual
	   		cDet:= STR0027+cFilAnte+STR0014+cTnoAnt+' - '+FDescTno(cFilAnte,cTnoAnt)		//"Filial: "###" Turno: "
   		Else
   			cDet:= STR0027+SRA->RA_FILIAL+STR0014+cTnoAnt+' - '+FDescTno(SRA->RA_FILIAL,cTnoAnt)		//"Filial: "###" Turno: "
	   	Endif
	Elseif nTipo == 0
	    	cDet:= STR0018 + Sm0->m0_Nomecom // "Empresa: "
	Endif
	IMPR(cDet,"C")

	If !lSintetico
	   IMPR(Repl("-",132),"C")
	Endif
Endif

//-- Imprime Linha Detalhe quando Funcionario
If nTipo == 1 .And. Det<>Nil
	Impr(Det,"C")
Endif

Return Nil

/*
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴엽�
굇쿑un뇙o    � fTotais  � Autor � MauricioMR            � Data �04/04/02  낢�
굇쳐컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴눙�
굇쿏escri뇙o � Define Impressao de Totais e Zera Acumuladores             낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿞intaxe   � fTotais(nTipo)                                             낢�
굇�          � nTotais(nTipo)                                             낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿛arametros� nTipo --> 3 ou 1 Total de Filial                           낢�
굇�          �           2 ou 5 Centro de Custo                           낢�
굇�          �           4      Turno                                     낢�
굇�          �           0      Empresa                                   낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿢so       � Gen굍ico                                                   낢�
굇읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴袂�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�*/
Static Function fTotais(nTipo)
Local clinTot	 := ''

If nTipo == 3 .Or. nTipo == 1 //-- Filial
   	cLinTot := STR0015+cFilAnte+' - '+aInfo[1] //'TOTAIS PARA A FILIAL '
   	fImpTot(@aTotalF,clinTot,@aAdicF,@aNTraF,@aAbonF)

ElseIf nTipo == 2  //-- Centro de custo + Filial
   	cLinTot:= STR0020+cCcAnt+' - '+Alltrim(DescCc(cCcAnt,cFilAnte))+' - '+STR0027+cFilAnte //'TOTAIS PARA O CENTRO DE CUSTO '
   	fImpTot(@aTotalC,clinTot,@aAdicC,@aNTraC,@aAbonC)

ElseIf nTipo == 4 //-- Turno de trabalho +Filial
	cLinTot:= STR0019+cTnoAnt+' - '+Alltrim(fDescTno(cFilAnte,cTnoAnt))+' - '+STR0027+cFilAnte //'TOTAIS PARA O TURNO '
   	fImpTot(@aTotalT,clinTot,@aAdicT,@aNTraT,@aAbonT)

ElseIf nTipo == 0 //-- Empresa
	cLinTot:= cDet := STR0018+aInfo[3] //'TOTAIS PARA A EMPRESA '
   	fImpTot(@aTotalE,clinTot,@aAdicE,@aNTraE,@aAbonE)

Endif

Return Nil

/*
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴엽�
굇쿑un뇙o    쿯ImpTot   � Autor � Mauricio MR           � Data �04/04/02  낢�
굇쳐컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴눙�
굇쿏escri뇙o 쿔mprime Totais dos Acumuladores                             낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿞intaxe   쿯ImpTot(aTot,cLintot,aAdic,aNTra,aAbon)                     낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿛arametros쿪Tot  --> Array com os Acumuladores dos Periodos:Fil,CC,... 낢�
굇�          쿬LinTot-> String com a Descricao do Total especifico        낢�
굇�          쿪Adic  -> Array de Adicionais dos Acumuladores  especificos 낢�
굇�          쿪Ntra  -> Array de Hor.Nao Trab. Acumuladas especificas     낢�
굇�          쿪Abon  -> Array de Abonos Acumulados especificos            낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿢so       � Gen굍ico                                                   낢�
굇읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴袂�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�*/
Static Function fImpTot(aTot,clinTot,aAdicTot,aNTraTot,aAbonTot)
Local cColuna01  := ''
Local cColuna02  := ''
Local cColuna03  := ''
Local cDet       := ''
Local nX         := 0
Local nElementos := 0
Local naTot:=Len(aTot)

For nX := 1 To naTot
	//Imprime SubCabec Na 1a Vez ou sempre que o acumulado for impresso na pag. seguinte
	If nX == 1  .OR. Li>52
	    If Li>52         	//-- Se, por exemplo, Li=57 , forca a quebra de pag
	       IMpr('','P')  	//-- para que o subcabec seja impresso com os totais
	    Endif
		Impr(cLinTot,'C')
		Impr('','C')
		cDet := STR0016 //'Periodo     Hrs.Prev.     Hrs.Real       % (1)Hrs.Adic.      % (2)Hrs.N.Trab.      % (3)Hrs.Abonadas      %'
		//                 99/9999  9,999,999.99 9,999,999.99  999.99 9,999,999.99 999.99   9,999,999.99 999.99    9,999,999.99 999.99
		Impr(cDet,'C')
	Endif

	cDet := aTot[nX,1]+'  '+Transf(aTot[nX,2], "@E 9,999,999.99")+;
	Space(01)+Transf(aTot[nX,3], "@E 9,999,999.99")+Space(02)+Transf(aTot[nX,04],"@E 999.99")+;
	Space(01)+Transf(aTot[nX,5], "@E 9,999,999.99")+Space(01)+Transf(aTot[nX,06],"@E 999.99")+;
	Space(03)+Transf(aTot[nX,7], "@E 9,999,999.99")+Space(01)+Transf(aTot[nX,08], "@E 999.99")+;
	Space(04)+Transf(aTot[nX,9], "@E 9,999,999.99")+Space(01)+Transf(aTot[nX,10], "@E 999.99")
	Impr(cDet,'C')
Next nX

//-- Quando nao houver totais nao emite corpo totalizador
If (nElementos := Max(Max(Len(aAdicTot),Len(aNTraTot)),Len(aAbonTot))) > 0

	//-- Imprime totalizador dos itens
	For nX := 1 To nElementos
		//Imprime SubCabec Na 1a Vez ou sempre que o evento for impresso na pag. seguinte
		If nX == 1  .OR. Li>52
		   	If Li>52         	//-- Se, por exemplo, Li=57 , forca a quebra de pag
	       		IMpr('','P')  	//-- para que o subcabec seja impresso com os totais
	    	Endif
			Impr('','C')
			cDet := STR0017 //'(1) Descricao                  Horas      % (2) Descricao                  Horas      %  (3) Descricao                  Horas      %'
			Impr(cDet,'C')
		Endif
		cColuna01 := If(nX<=Len(aAdicTot),aAdicTot[nX,1]+Space(01)+Left(aAdicTot[nX,2],19)+Space(01)+Transf(aAdicTot[nX,3],"@E 99999.99")+Space(01)+Transf(aAdicTot[nX,4],"@E 999.99"),Space(39))
		cColuna02 := If(nX<=Len(aNTraTot),aNTraTot[nX,1]+Space(01)+Left(aNTraTot[nX,2],19)+Space(01)+Transf(aNTraTot[nX,3],"@E 99999.99")+Space(01)+Transf(aNTraTot[nX,4],"@E 999.99"),Space(39))
		cColuna03 := If(nX<=Len(aAbonTot),aAbonTot[nX,1]+Space(01)+Left(aAbonTot[nX,2],19)+Space(01)+Transf(aAbonTot[nX,3],"@E 99999.99")+Space(01)+Transf(aAbonTot[nX,4],"@E 999.99"),Space(39))

		cDet := Space(04)+cColuna01+Space(05)+cColuna02+Space(06)+cColuna03

		Impr(cDet,'C')
	Next nX
Endif

Impr(Replic('*',132),'C')

//-- Zera Totais Especificos
aTot   	  := {}
aAdicTot  := {}
aNTraTot  := {}
aAbonTot  := {}

Return

/*
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇
굇旼컴컴컴컴컫컴컴컴컴컴컫컴컴컴컫컴컴컴컴컴컴컴컴컴컴컴컫컴컴컴쩡컴컴컴컴커굇
굇쿑un뇙o    쿯CarCodAbat� Autor � Alexsandro Pereira    � Data �          낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컨컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컨컴컴컴좔컴컴컴컴캑굇
굇쿏escri뇙o �                                                             낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑굇
굇쿞intaxe   �                                                             낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑굇
굇쿛arametros�                                                             낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑굇
굇쿢so       � Gen굍ico                                                    낢�
굇읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸굇
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇*/
Static Function fCarCodAbat(aCodAbat)

If SP9->(dbSeek(fFilFunc('SP9')))
	Do While ! SP9->(Eof()) .And. SP9->P9_FILIAL == fFilFunc('SP9')
		If SP9->P9_TIPOCOD = "2" //Evento de Desconto
			Aadd(aCodAbat, SP9->P9_CODIGO)
		Endif
		SP9->(dbSkip())
	Enddo
Endif

Return Nil

/*
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴엽�
굇쿑un뇙o    � fHrsPrev � Autor � Alexsandro Pereira    � Data �          낢�
굇쳐컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴눙�
굇쿏escri뇙o �                                                            낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿞intaxe   �                                                            낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿛arametros�                                                            낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿢so       � Gen굍ico                                                   낢�
굇읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴袂�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�*/
Static Function fHrsPrev(aTabCalend,dPerIni,dPerfim)

Local nHrsPrev := 0
Local nX       := 0
Local dData    := 0
Local cTipodia 		:= ''
Local lTrbFeriado	:=.F.
Local cFRegra		:= ''
Local cOrdem		:= '!!'
Local lAfastado		:= .F.
Local lForaPer		:= .F.

For nX := 1 To Len(aTabCalend)

	dData := aTabCalend[nX,1]


    //Somente verifica afastamento para Ordem ainda nao lida
    If cOrdem <> aTabCalend[nX,2]
    	cOrdem	:= aTabCalend[nX,2]
  	   	//-- Desconsidera as datas fora do periodo solicitado
	   	lForaPer	:= (dData < dPerIni .OR. dData > dPerFim)  .OR. SRA->( RA_SITFOLH $ 'D�T' .and. dData > RA_DEMISSA )
	   	//-- Desconsidera as datas de afastamento
		lAfastado:=  fAfasta(SRA->RA_FILIAL,SRA->RA_MAT,dData)
	Endif

    //Desconsidera a data de APONTAMENTO se estiver fora do periodo solicitado ou se o funcionario esta afastado
    //e nao se quer considerar o afastamento.
    If lForaPer .OR. (lAfastado .AND. !lAfastPrev)
       Loop
    Endif

	    //-- Verifica se funcionario Trabalha em Feriado
    If cfRegra <> ( cFilRegra + aTabCalend[ nX , 23 ] )
       cFRegra		:= ( cFilRegra + aTabCalend[ nX , 23 ]  )
       lTrbFeriado	:= GetTrbFer( cFilRegra , aTabCalend[ nX , 23 ] )
	Endif

    // *** Verifica Tipo Dia ***
    //-- Se Feriado
         //-- Se Excecao
              //Tipo Dia
         //--Senao Excecao
	         //-- Se NaoTrabalha Feriado
	         //   Tipo dia  = "Feriado"
	         //---Senao NaoTrabalha Feriado
	         //   Tipo dia
	         //-- Fim se Nao Trabalha Feriado
         //-- Fim se Escecao
    //Senao
    //   Tipo Dia
    //-- Fim se Feriado

	cTipoDia	:= IF( aTabCalend[ nX , 19 ] , IF(  aTabCalend[ nX , 10 ]  == "E" , aTabCalend[ nX , 06 ] , IF(!lTrbFeriado,"F",aTabCalend[ nX , 06 ] ) ) , aTabCalend[ nX , 06 ] )

	If (aTabCalend[ nX , 10 ]  != "E" .and. cTipoDia == "F" .and. !lTrbFeriado) //se n�o for exce豫o e n�o trabalha em feriado
		Loop
	EndIf

	If ( cTipoDia !='S' )
		// Funcion�rio afastado e dia originalmente trabalhado
		If lAfastado .And. lAfastPrev .And. aTabCalend[nX,36] == "S" .And. !Empty(aTabCalend[nX,7])
			nHrsPrev := SomaHoras(nHrsPrev,aTabCalend[nX,7])
			nHrsnTra := SomaHoras(nHrsnTra, aTabCalend[nX,7])
		EndIf
	Else
		If !Empty(aTabCalend[nX,7])
			nHrsPrev := SomaHoras(nHrsPrev,aTabCalend[nX,7])
		EndIf
	EndIf

Next nX

Return nHrsPrev

/*
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇
굇旼컴컴컴컴컫컴컴컴컴컴컫컴컴컴컫컴컴컴컴컴컴컴컴컴컴컴컫컴컴컴쩡컴컴컴컴커굇
굇쿑un뇙o    쿒etTrbFer  � Autor � Equipe RH             � Data �          낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컨컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컨컴컴컴좔컴컴컴컴캑굇
굇쿏escri뇙o � Retorna  .T. se Trabalha .F. senao.                         낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑굇
굇쿞intaxe   � GetTrbFer(cFil, cRegra)                                     낢�
굇�          � cFil   -> Filial para Consulta da Regra em SPA              낢�
굇�          � cRegra -> Regra a ser Pesquisada                            낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑굇
굇쿛arametros�                                                             낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑굇
굇쿢so       � Absent                                                      낢�
굇읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸굇
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇*/
Static Function GetTrbFer( cFil , cRegra )
Return( ( PosSPA( cRegra , cFil , "PA_FERIADO" , 1 , .F. ) == "S" ) )

/*
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴엽�
굇쿑un뇙o    � fSomaHrs � Autor � Alexsandro Pereira    � Data �          낢�
굇쳐컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴눙�
굇쿏escri뇙o �                                                            낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿞intaxe   �                                                            낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿛arametros�                                                            낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿢so       � Gen굍ico                                                   낢�
굇읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴袂�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�*/
Static Function fSomaHrs(aCodAbat, aCodHeAut, aAdic, aNTra, aAbon, nHrsAdic, nHrsnTra, nHrsAbon, dPerIni , dPerFim, cAlias, lSemApo, nHrsGS, lIntegraGS)
Local nX      	:= 0
Local nHoras  	:= 0
Local nPos	  	:= 0
Local aAbonosPer:= {}
Local cMatricula:= SRA->RA_MAT
Local cFilMat	:= SRA->RA_FILIAL

cPD     := cAlias+'->'+Right(cAlias,2)+'_PD'		//-- Campo codigo de evento
cFil    := cAlias+'->'+Right(cAlias,2)+'_FILIAL'	//-- Campo codigo da filial
cMat    := cAlias+'->'+Right(cAlias,2)+'_MAT'		//-- Campo matricula
cPDI    := cAlias+'->'+Right(cAlias,2)+'_PDI'		//-- Campo codigo de evento informado
cPD     := cAlias+'->'+Right(cAlias,2)+'_PD'		//-- Campo codigo de evento gerado
dData   := cAlias+'->'+Right(cAlias,2)+'_DATA'		//-- Campo data de referencia do lancamento
cQuantc := cAlias+'->'+Right(cAlias,2)+'_QUANTC'	//-- Campo quantidade de horas calculadas
cQuanti := cAlias+'->'+Right(cAlias,2)+'_QUANTI'	//-- Campo quantidade de horas informadas
cTpMarca:= cAlias+'->'+Right(cAlias,2)+'_TPMARCA'	//-- Campo tipo de marcacao
cCC		:= cAlias+'->'+Right(cAlias,2)+'_CC'	    //-- Campo centro de custo

lSemApo:= .T.

/*
旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
쿎orre Todos os Lancamentos do Periodo     					  �
읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�*/
dbSelectArea(cAlias)
If dbSeek(fFilFunc(cAlias)+SRA->RA_MAT)
	/*
	旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
	쿎arrega os Abonos Conforme Periodo       					  �
	읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�*/
	fAbonosPer( @aAbonosPer , dPerIni , dPerFim , &cFil , SRA->RA_MAT )
	Do While &cFil + &cMat == SRA->RA_FILIAL + SRA->RA_MAT
	    //-- Desconsidera Apontamentos fora do Periodo solicitado
	    If &dData < dPerIni .Or. &dData > dPerFim
			(cAlias)->( dbSkip() )
			Loop
		Endif

        lSemApo		:= .F.

		cEvento := If(Empty(&cPDI),&cPD,&cPDI)

	    //-- Obtem as horas do Evento
		nQuant := If(Empty(&cPDI),&cQuantc,&cQuanti)

       	//-- Verifica se Evento eh de Desconto
       	If ( Ascan(aCodAbat, cEvento) <> 0 )
			//-- Acrescenta o Evento ou Acumula horas do Evento para Array GERAL
			fAcumula(@aNTra , cEvento, nQuant)
			//-- Acumula Total de Horas de Todos os Eventos
			nHrsnTra := SomaHoras(nHrsnTra, nQuant)
		Else
		    //-- Verifica se Evento eh Horas Extras
	        If ( nPos := aScan( aTabCalend, {|x| x[1] == &dData .and. x[4] == '1E' } ) ) > 0
			    //-- Carrega tabela de Horas Extras / Horas Extras Noturnas
		        IF ( lRet := GetTabExtra( @aCodHeAut , SRA->RA_FILIAL , aTabCalend[ nPos , 14 ] , .F. , .T. ) )
					//-- Verifica se Evento eh hora extra valida para o turno
					If (Ascan(aCodHeAut,{|x| x[4] == cEvento .Or. x[5] == cEvento}) <> 0 )
						//-- Acrescenta o Evento ou Acumula horas do Evento para Array GERAL
						fAcumula(@aAdic , cEvento, nQuant)
						//-- Acumula Total de Horas de Todos os Eventos
						nHrsAdic := SomaHoras(nHrsAdic, nQuant)
			        Else
	        			(cAlias)->( dbSkip() )
						Loop
			        Endif
			    Else
        			(cAlias)->( dbSkip() )
					Loop
		        Endif
            Else
            	(cAlias)->( dbSkip() )
				Loop
            Endif
        Endif

        If(Empty(&cPDI))
        	nHrsAbon:=SomaHoras(fHrsAbon(&dData , &cPD, &cTPMARCA , &cCC , aAbonosPer, @aAbon ),nHrsAbon)
        Endif

		(cAlias)->( dbSkip() )
	Enddo
Endif

//-- Calcula Percentual das Horas do Evento em relacao ao total de horas apontadas
fCalcPerc(aAbon,nHrsAbon)

If lIntegraGS
	CalcAfastGS( cMatricula, cFilMat, @aNTra, @nHrsnTra, dPerIni , dPerFim, @nHrsGS)
EndIf

Return

/*
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴엽�
굇쿑un뇙o    � fAcumula � Autor � Mauricio MR           � Data �          낢�
굇쳐컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴눙�
굇쿏escri뇙o � Acumula Evento em array de Acumuladores                    낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿞intaxe   � fAcumula(aColuna , cEvento, nQuant)                        낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿛arametros�                                                            낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿢so       � Absent                                                     낢�
굇읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴袂�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�*/

Static Function fAcumula(aColuna , cEvento, nQuant)
Local nPos:=0

//-- Acrescenta o Evento ou Acumula horas do Evento para Array GERAL
If Len(aColuna) > 0 .And. (nPos := Ascan(aColuna, { |x| x[1] == cEvento })) > 0
	aColuna[nPos,3] := SomaHoras(aColuna[nPos,3], nQuant)
Else
	Aadd(aColuna, { cEvento, DescPDPon(cEvento), nQuant, 0 })
Endif

Return

/*
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴엽�
굇쿑un뇙o    � fHrsAbon � Autor � Alexsandro Pereira    � Data �          낢�
굇쳐컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴눙�
굇쿏escri뇙o �                                                            낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿞intaxe   �                                                            낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿛arametros�                                                            낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿢so       � Gen굍ico                                                   낢�
굇읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴袂�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�*/
Static Function fHrsAbon(dData , cPD, cTPMARCA , cCC , aAbonosPer, aAbon )

Local nHrsAbon 	:= 0
Local nX       	:= 0
Local aAbonos  	:= {}
Local aJustifica:= {}
Local cEvento	:= ""
Local lAbHoras	:= .F.
Local nPos		:= 0

If fAbonos( dData , cPD , NIL , @aJustifica , cTPMARCA , cCC , aAbonosPer ) > 0
	//-- Corre Todos os Abonos
	For nX := 1 To Len(aJustifica)
		/*
		旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
		� Cria Array Analitico de Abonos com horas Convertidas.		   �
		읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸*/
		//-- Obtem a Quantidade de Horas Abonadas
	    If ( nPos := aScan( aAbon, { |x| x[1] == aJustifica[nX,1] } ) ) > 0
			aAbon[nPos,3] := SomaHoras(aAbon[nPos,3], aJustifica[nX,2] ) //_QtAbono
		Else
			Aadd(aAbon, {aJustifica[nX,1] , DescAbono(aJustifica[nX,1],'C'), aJustifica[nX,2], 0 })
		EndIf
		nHrsAbon:=	SomaHoras( nHrsAbon, aJustifica[nX,2] )
	Next nX
Endif

Return(nHrsAbon)

/*
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴엽�
굇쿑un뇙o    쿯Tot      � Autor � Mauricio MR           � Data �04/04/02  낢�
굇쳐컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴눙�
굇쿏escri뇙o 쿟otaliza os Acumuladores de Emp,Fil,CC e Turno              낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿞intaxe   쿯Tot(aCodigos,aCodTot)                                      낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿛arametros쿪Codigos --> Array com os eventos a serem totalizados       낢�
굇�          쿪CodTot  --> Array com os SubArrays: Emp,Fil,CC e Turno     낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿢so       � Gen굍ico                                                   낢�
굇읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴袂�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�*/
Static Function fTot(aCodigos,aCodTot)

Local naCodigos :=Len(aCodigos)
Local naCodTot  :=Len(aCodTot)
Local nX		:=0
Local nY		:=0

For nX := 1 To naCodigos
    For nY := 1 To naCodTot

		If (nPos := Ascan(aCodTot[nY], { |x| x[1] == aCodigos[nX,1] })) > 0
			aCodTot[nY,nPos,3] := SomaHoras(aCodTot[nY,nPos,3],aCodigos[nX,3])
		Else
			Aadd(aCodTot[nY], { aCodigos[nX,1], aCodigos[nX,2], aCodigos[nX,3], 0 })
		Endif
    Next nY
Next nX

//Calcula Percentual de Cada Totalizador
aEval(aCodTot, { |aTotal| fCalcPerc(aTotal)})

Return

/*
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴엽�
굇쿑un뇙o    � fCalcPerc� Autor � Mauricio MR           � Data � 05/04/02 낢�
굇쳐컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴눙�
굇쿏escri뇙o � Calcula Percentual de Horas de um Evento em Relacao ao to- 낢�
굇�          � tal geral.                                                 낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿞intaxe   � fCalcPerc(aColuna)                                         낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿛arametros� aColuna  --> Array de Eventos e Horas                      낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿝etorno   � nHoras   --> Total de Horas                                낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿢so       � Gen굍ico                                                   낢�
굇읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴袂�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�*/
Static Function fCalcPerc(aColuna,nHoras)

Local nX      := 0

nHoras  := If(nHoras==Nil,0,nHoras)


//---- Calcula o Total GERAL de Horas
If Empty(nHoras)
	aEval(aColuna, { |y| nHoras := SomaHoras(nHoras,y[3]) })
Endif

//-- Calcula o percentual de cada item em relacao ao total
aEval(aColuna, { |y| y[4]:=(fConvHr(y[3],'D') / fConvHr(nHoras,'D')) * 100 })

Return nHoras


/*
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴엽�
굇쿑un뇙o    � Monta_Per� Autor 쿐quipe Advanced RH     � Data �          낢�
굇쳐컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴눙�
굇쿏escri뇙o �                                                            낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿞intaxe e �                                                            낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿛arametros�                                                            낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿢so       � Gen굍ico                                                   낢�
굇읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴袂�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�*/
Static Function Monta_Per( dDataIni , dDataFim , cFil , cMat , dIniAtu , dFimAtu )

Local aPeriodos := {}
Local cFilSPO	:= xFilial( "SPO" , cFil )
Local dAdmissa	:= SRA->RA_ADMISSA
Local dPerIni   := Ctod("//")
Local dPerFim   := Ctod("//")
Local dData		:= Ctod("//")

SPO->( dbSetOrder( 1 ) )
SPO->( dbSeek( cFilSPO , .F. ) )

//Obtem os periodos Historicos se estiverem compreendidos pelo periodo solicitado
While SPO->( !Eof() .and. PO_FILIAL == cFilSPO )

    dPerIni := SPO->PO_DATAINI
    dPerFim := SPO->PO_DATAFIM

    //-- Filtra Periodos de Apontamento a Serem considerados em funcao do Periodo Solicitado
    IF dPerFim < dDataIni .OR. dPerIni > dDataFim
		SPO->( dbSkip() )
		Loop
    Endif

    //-- Somente Considera Periodos de Apontamentos com Data Final Superior a Data de Admissao
    IF ( dPerFim >= dAdmissa )
       aAdd( aPeriodos , { dPerIni , dPerFim , Max( dPerIni , dDataIni ) , Min( dPerFim , dDataFim ) } )
	EndIF

	SPO->( dbSkip() )

End While

//Inclui o periodo atual se estiver compreendido pelo periodo solicitado
IF ( aScan( aPeriodos , { |x| x[1] == dIniAtu .and. x[2] == dFimAtu } ) == 0.00 )
	dPerIni := dIniAtu
	dPerFim	:= dFimAtu
	IF !(dPerFim < dDataIni .OR. dPerIni > dDataFim)
		IF ( dPerFim >= dAdmissa )
			aAdd(aPeriodos, { dPerIni, dPerFim, Max(dPerIni,dDataIni), Min(dPerFim,dDataFim) } )
		EndIF
    Endif
EndIF

If !Empty(aPeriodos)
	dData	:= aPeriodos[ Len(aPeriodos), 2 ] + 1
	dPerIni	:= aPeriodos[ Len(aPeriodos), 1 ]
	dPerFim	:= aPeriodos[ Len(aPeriodos), 2 ]
Else
	dData	:= dDataIni
	dPerIni	:= dIniAtu
	dPerFim	:= dFimAtu
endif

//Inclui periodos futuros se estiverem compreendidos pelo periodo solicitado
If dData > dFimAtu
	While .T.
		If !PerAponta(@dPerIni,@dPerFim,dData,Nil, Nil, .T., Nil, Nil, .T.)
			HELP(' ',1,'PERNCAD')
			Return Nil
		Endif

		//-- Filtra Periodos de Apontamento a Serem considerados em funcao do Periodo Solicitado
		IF ( dPerFim >= dAdmissa )  .and.  !(   dPerFim < dDataIni .OR. dPerIni > dDataFim )
			Aadd(aPeriodos, { dPerIni, dPerFim, Max(dPerIni,dDataIni), Min(dPerFim,dDataFim) })
		Endif

		If dDataFim > dPerFim
			dData := dPerFim + 1
		Else
			Exit
		Endif

	Enddo
Endif

Return( aPeriodos )


/*
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴엽�
굇쿑un뇙o    쿯TotLinPer� Autor � Mauricio MR           � Data �04/04/02  낢�
굇쳐컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴눙�
굇쿏escri뇙o 쿎alcula Totais de um Periodo                                낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿞intaxe   쿯TotLinPer(aTot,nHrsPrev,nHrsReal,nHrsAdic,nHrsnTra,        낢�
굇�          �        nHrsAbon,dPeriodo,nPReal, nPAdic, nPnTra, nPAbo)    낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿛arametros쿪Tot  --> Array com os Acumuladores do Periodo              낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿢so       � Gen굍ico                                                   낢�
굇읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴袂�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�*/
Static Function fTotLinPer(aTot,nHrsPrev,nHrsReal,nHrsAdic,nHrsnTra,nHrsAbon,dPeriodo,nPReal, nPAdic, nPnTra, nPAbo)

//-- aTotal
//-- [n,01] Periodo
//-- [n,02] Horas previstas
//-- [n,03] horas realizadas
//-- [n,04] percentual realizado
//-- [n,05] Horas adicionais
//-- [n,06] percentual adicional
//-- [n,07] Horas nao trabalhadas
//-- [n,08] Percentual horas nao trabalhadas
//-- [n,09] Horas abonadas
//-- [n,10] Percentual horas abonadas
Local nX:=0
Local anTot:=Len(aTot)

For nX:=1 To anTot
	//-- Calcula Totalizador de um Periodo
	If Len(aTot[nX]) > 0 .And. (nPos := Ascan(aTot[nX], { |x| x[1] == StrZero(Month(dPeriodo),2)+'/'+Transf(Year(dPeriodo),'9999') })) > 0
		aTot[nX,nPos,02] := SomaHoras(aTot[nX,nPos,02], nHrsPrev)
		aTot[nX,nPos,03] := SomaHoras(aTot[nX,nPos,03], nHrsReal)
		aTot[nX,nPos,04] := (fConvHr(aTot[nX,nPos,03],'D') / fConvHr(aTot[nX,nPos,02],'D')) * 100
		aTot[nX,nPos,05] := SomaHoras(aTot[nX,nPos,05], nHrsAdic)
		aTot[nX,nPos,06] := (fConvHr(aTot[nX,nPos,05],'D') / fConvHr(aTot[nX,nPos,02],'D')) * 100
		aTot[nX,nPos,07] := SomaHoras(aTot[nX,nPos,07], nHrsnTra)
		aTot[nX,nPos,08] := (fConvHr(aTot[nX,nPos,07],'D') / fConvHr(aTot[nX,nPos,02],'D')) * 100
		aTot[nX,nPos,09] := SomaHoras(aTot[nX,nPos,09], nHrsAbon)
		aTot[nX,nPos,10] := (fConvHr(aTot[nX,nPos,09],'D') / fConvHr(aTot[nX,nPos,07],'D')) * 100
	Else
		Aadd(aTot[nX], { StrZero(Month(dPeriodo),2)+'/'+Transf(Year(dPeriodo),'9999'),;
		nHrsPrev,nHrsReal, nPReal, nHrsAdic, nPAdic, nHrsnTra, nPnTra, nHrsAbon, nPAbo })
	Endif
Next nX

Return

//------------------------------------------------------------------------------------------------------------------------------------------------------------
/*/{Protheus.doc} CalcAfastGS

@description Fun豫o para pegar afastamento caso a agenda esteja cancelada e possua SR8 cadastrada no periodo
@return lRet

@author	Augusto Albuquerque
@since	14/09/2021
/*/
//------------------------------------------------------------------------------------------------------------------------------------------------------------
Static Function CalcAfastGS( cMat, cFilMat, aNTra, nHrsnTra, dDtIni , dDtFim, nHrsGS)
Local cCodEvent	:= ""
Local cDescEve	:= ""
Local aArea		:= GetArea()
Local cQuery	:= ""
Local cAliasABB	:= GetNextAlias()
Local nHoraTot	:= 0

cQuery := ""
cQuery += " SELECT ABB.ABB_HRINI, ABB.ABB_HRFIM, SR8.R8_TIPOAFA, RCM.RCM_DESCRI FROM " + RetSqlName("ABB") + " ABB "
cQuery += " INNER JOIN " + RetSqlName("ABR") + " ABR "
cQuery += " ON ABR.ABR_AGENDA = ABB.ABB_CODIGO " 
cQuery += " AND ABR.D_E_L_E_T_ = ' ' "
cQuery += " INNER JOIN " + RetSqlName("ABN") + " ABN "
cQuery += " ON ABN.ABN_CODIGO = ABR.ABR_MOTIVO " 
cQuery += " AND ABN.D_E_L_E_T_ = ' ' "
cQuery += " AND ABN.ABN_TIPO = '05' "
cQuery += " INNER JOIN " + RetSqlName("TDV") + " TDV "
cQuery += " ON TDV.TDV_CODABB = ABB.ABB_CODIGO " 
cQuery += " AND TDV.TDV_FILIAL = ABB.ABB_FILIAL "
cQuery += " AND TDV.TDV_DTREF BETWEEN '" + Iif(ValType(dDtIni) == "D",dToS(dDtIni),dDtIni ) + "' AND '" + Iif(ValType(dDtFim)=="D",dToS(dDtFim), dDtFim) + "'" 
cQuery += " AND TDV.D_E_L_E_T_ = ' ' "
cQuery += " INNER JOIN " + RetSqlName("AA1") + " AA1 "
cQuery += " ON AA1.AA1_CODTEC = ABB.ABB_CODTEC "
cQuery += " AND AA1.D_E_L_E_T_ = ' ' "
cQuery += " INNER JOIN " + RetSqlName("SRA") + " SRA "
cQuery += " ON SRA.RA_MAT = AA1.AA1_CDFUNC "
cQuery += " AND SRA.RA_FILIAL = '" + cFilMat + "' "
cQuery += " AND SRA.D_E_L_E_T_ = ' ' "
cQuery += " INNER JOIN " + RetSqlName("SR8") + " SR8 "
cQuery += " ON SR8.R8_MAT = SRA.RA_MAT " 
cQuery += " AND SR8.D_E_L_E_T_ = ' ' "
cQuery += 		" AND ("
cQuery += 			"(TDV.TDV_DTREF >= SR8.R8_DATAINI AND TDV.TDV_DTREF <= SR8.R8_DATAFIM) OR 
cQuery += 			"(TDV.TDV_DTREF >= SR8.R8_DATAINI AND SR8.R8_DATAFIM ='') OR "
cQuery += 			"(TDV.TDV_DTREF <= SR8.R8_DATAINI AND (TDV.TDV_DTREF >= SR8.R8_DATAFIM AND SR8.R8_DATAFIM <> ''))"
cQuery += 			" )"
cQuery += " INNER JOIN " + RetSqlName("RCM") +" RCM ON RCM.RCM_TIPO = SR8.R8_TIPOAFA AND "
cQuery += " " + FWJoinFilial("SR8" , "RCM" , "SR8", "RCM", .T.) + " "
cQuery += " AND RCM.D_E_L_E_T_ = ' ' "
cQuery += " WHERE "
cQuery += " SRA.RA_MAT = '" + cMat + "' "
cQuery += " AND ABB.D_E_L_E_T_ = ' ' "

cQuery := ChangeQuery(cQuery)
dbUseArea( .T., "TOPCONN", TCGENQRY(,,cQuery),cAliasABB, .F., .T.)

While !(cAliasABB)->(EOF())
	If cCodEvent <> (cAliasABB)->R8_TIPOAFA
		If !Empty(cCodEvent)
			AADD( aNTra, {cCodEvent, cDescEve, nHoraTot, 0 })
			nHrsnTra := SomaHoras(nHrsnTra, nHoraTot)
			nHrsGS := SomaHoras(nHrsGS, nHoraTot)
		EndIF
		cCodEvent := (cAliasABB)->R8_TIPOAFA
		cDescEve := (cAliasABB)->RCM_DESCRI
		nHoraTot := 0
		nHoraTot := SomaHoras(nHoraTot, Val(STRTRAN(ElapTime( AllTrim((cAliasABB)->ABB_HRINI)+":00" , AllTrim((cAliasABB)->ABB_HRFIM)+":00"), ":",".")))
	Else
		nHoraTot := SomaHoras(nHoraTot, Val(STRTRAN(ElapTime( AllTrim((cAliasABB)->ABB_HRINI)+":00" , AllTrim((cAliasABB)->ABB_HRFIM)+":00"), ":",".")))
	EndIf
    (cAliasABB)->(dbSkip())
End
If !Empty(cCodEvent) 
	AADD( aNTra, {cCodEvent, cDescEve, nHoraTot, 0 })
	nHrsnTra := SomaHoras(nHrsnTra, nHoraTot)
	nHrsGS := SomaHoras(nHrsGS, nHoraTot)
EndIf
(cAliasABB)->(DbCloseArea())

RestArea(aArea)
Return
