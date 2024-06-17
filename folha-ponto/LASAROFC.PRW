#include 'totvs.ch'


/*/{Protheus.doc} LASARABS
RELATORIO ABSENTEISMO
@type function
@version 1.0
@author eder.fernandes
@since 6/16/2024
@return variant, nill
/*/
User Function LASARABS()


	Local (cAliasTMP)  := GetNextAlias()
	Local nFor         := 0
	Local cPerg        := 'LASARABS'
	//Local lLiquido     := .F.
	Local cQry         := ''
	Local aReturn      := {}
	Local aBinds       := {}
	Local aSetFields   := {}
	Local nReg         := 0
	Local cErro        := ''
	Local nX           := 0
	Local nY           := 0
	Local lImp		:= .T.
	Local lImp1		:= .T.
	Local oExcel
	Local _cNome        := ""
	Local cArquivo     := ""
	Local cCSV   := "rel001.CSV"
	Local cType := OemToAnsi("Arquivos") + "(*.*) |*.*|"
	Local cDir     := cGetFile(cType, "Selecione o Diretorio",0,     , .T., GETF_LOCALHARD + GETF_NETWORKDRIVE + GETF_RETDIRECTORY)
	Local nCSV   := FCreate(cDir+cCSV)
	Local cLinha := ""
	Local aPeriodos := {}
	Private titulo
	Private AT_PRG     := "LASARABS"
	Private wCabec0
	Private wCabec1
	Private wCabec2
	Private CONTFL     := 1
	Private LI         := 0
	Private COLUNAS    := 220
	Private nTamanho   := "G"
	Private nChar      := 15
	Private cPict1     := If (MsDecimais(1)==2,"@E 99,999,999,999.99",TM( Val( Replicate( "9",13 - MsDecimais(1) ) ),17,MsDecimais(1) ) ) // "@E 99,999,999,999.99
	Private cPict2     := cPict1
	Private nNumLin    := 9
	Private cQuebraDet := ""
	Private aReturn1    :={"Zebrado" , 1         , "Administraçäo", 2, 2, 1, "", 1} // "Zebrado"###"Administra‡„o"
	Private aAC        :={"Abandona", "Confirma"} // "Abandona"###"Confirma"
	Private aLinha     :={},nLastKey := 0
	Private aInfo      := {}
	Private aTotais    := {}
	Private cVerba, cCodigos, cVerbaCod, nCtSB, nCtcPd
	Private Nomeprog   := "LASARABS"
	Private nOrdem
	Private aTabPadrao := {}

	If nCSV <= 0
		MsgAlert("Falha ao gerar o arquivo Excel no caminho: " + cDir)
		Return(Nil)
	EndIf

	If Pergunte(cPerg,.T., "Informe os Parametros")


		FilialDe  	:= mv_par01
		FilialAte 	:= mv_par02
		CcDe      	:= mv_par03
		CcAte     	:= mv_par04
		MatDe     	:= mv_par05
		MatAte    	:= mv_par06
		NomDe     	:= mv_par07
		NomAte    	:= mv_par08
		DatDe     	:= Substr(mv_par09,3,6) + Substr(mv_par09,1,2)
		DatAte    	:= Substr(mv_par10,3,6) + Substr(mv_par10,1,2)
		cSemanaDe 	:= mv_par11
		cSemanAte 	:= mv_par12
		cFormato   	:= mv_par13
		nValHor   	:= mv_par14
		nSinAna   	:= mv_par15
		lTodos    	:= If(Empty(mv_par20),.T.,If(mv_par16=1,.T.,.F.))
		lSalario  	:= If(mv_par17=1,.T.,.F.)
		cSituacao 	:= mv_par18
		cCategoria	:= mv_par19
		cCodigos  	:= AllTrim(mv_par20)
		cCodigos  	+= AllTrim(mv_par21)
		// lTotais   	:= If(mv_par22=1,.T.,.F.)
		// lLiquido  	:= If(mv_par23=1,.T.,.F.)
		// lSitHist  	:= If(mv_par24=1,.T.,.F.)
		// cAnoMesI	:=	SubStr(DatDe,3,4) + SubStr(DatDe,1,2)
		// cAnoMesF 	:=	SubStr(DatAte,3,4)  + SubStr(DatAte,1,2)
		cArquivo    := AllTrim(mv_par22)


//separa o codigo das verbas listadas
		cVerba := ""

		If !fTabTurno(aTabPadrao)
			Help(' ',1,'TPADNCAD')
			Return Nil
		EndIf

		// dDataDe  := DatDe + "01"
		// dDataAte := DatAte + ""

		// aPeriodos := Monta_per( dDataDe , dDataAte , cFilAnt , SRA->RA_MAT , dPerIni , dPerFim )

		cCodigos := Replace(cCodigos,"*","")
		If !Empty(cCodigos)
			For nFor := 1 To Len(ALLTRIM(cCodigos)) Step 3
				cVerba += "'"+Subs(cCodigos,nFor,3)+"'"
				If Len(ALLTRIM(cCodigos)) > ( nFor+3 )
					cVerba += ","
				EndIf
			Next nFor
		EndIf


		//-- Carga da tabela de horario padrao
		If !fTabTurno(aTabPadrao)
			Help(' ',1,'TPADNCAD')
			Return Nil
		EndIf


		cVerbaSql := '%' +'('+ cVerba +')' + '%'


		BeginSql Alias cAliasTMP
                SELECT
                    RA.RA_FILIAL, RA.RA_NOME, RD.RD_MAT, RD.RD_PD, RD.RD_PERIODO, RD.RD_VALOR, RD.RD_TIPO1, RD.RD_CC,RD.RD_HORAS
                FROM %table:SRD% RD 
                INNER JOIN %table:SRA% RA 
                ON RA.RA_FILIAL = RD.RD_FILIAL 
                AND RA.RA_MAT = RD.RD_MAT 
                AND RA.D_E_L_E_T_ = RD.D_E_L_E_T_
                WHERE RA.%notDel%
                AND RD.RD_PD IN %exp:cVerbaSql%
                AND RA.RA_FILIAL BETWEEN %exp:FilialDe% AND %exp:FilialAte%
                AND RD.RD_CC BETWEEN %exp:CcDe% AND %exp:CcAte%
                AND RD.RD_MAT BETWEEN %exp:MatDe% AND %exp:MatAte%
                AND RA.RA_NOME BETWEEN %exp:NomDe% AND %exp:NomAte%
                AND RD.RD_PERIODO BETWEEN %exp:DatDe% AND %exp:DatAte%
                ORDER BY RD.RD_FILIAL,RD.RD_MAT,RD.RD_PERIODO

		EndSql

		cQry := GetLastQuery()[2]

		aAdd(aSetFields,{'RD_VALOR'  ,'N',TAMSX3('RD_VALOR')[1],TAMSX3('RD_VALOR')[2]})
		aAdd(aSetFields,{'RD_HORAS'  ,'N',TAMSX3('RD_HORAS')[1],TAMSX3('RD_HORAS')[2]})
		nReg  := TCSqlToArr(cQry,@aReturn,aBinds,aSetFields)


		If nReg  < 0
			cErro :=  'Erro ao obter dados via Query'+TcSqlError()
			Return(.T.)
		Else
			//Criando o objeto que irá gerar o conteúdo do Excel
			//	oExcel := FWMsExcelEx():New()

			// If nVerHor = 2   //Horizontal
			// 	// Cria no vetor de totalizacao, as verbas solicitadas
			// 	If !Empty(cCodigos)
			// 		For nFor := 1 To Len(ALLTRIM(cCodigos)) Step 3
			// 			cVerbaCod := Subs(cCodigos,nFor,3)
			// 			//--Incluir Salario Base nos codigos a listar
			// 			Aadd(aTotais,{cVerbaCod,0,0,0,0,0,0,0,0,cAnoMesI," "," "," ",0,0,0,0,0})
			// 		Next
			// 	EndIf
			// Endif
			// cEmissao := dtoc(date()) + time()
			//oExcel:AddworkSheet("abs") //Não utilizar número junto com sinal de menos. Ex.: 1-

			cLinha := "Relatorio de Absenteísmo"
			FWrite(nCSV,cLinha+ CRLF+ CRLF)
			cLinha := "Período de " + DatDe + " Até " + DatAte
			FWrite(nCSV,cLinha+ CRLF+ CRLF)
			cLinha := "Emissão: " + Dtoc(Date()) + " - " + Time()
			FWrite(nCSV,cLinha+ CRLF+ CRLF)

			WHILE (cAliasTMP)->(!Eof())
				_cFilial := (cAliasTMP)->(RA_FILIAL)
				_cMatric := (cAliasTMP)->(RD_MAT)
				_cPeriod := SubStr((cAliasTMP)->(RD_PERIODO),5,2) + "-" + SubStr((cAliasTMP)->(RD_PERIODO),1,4)
				_cCentro := (cAliasTMP)->(RD_CC)
				_cNome  := AllTrim((cAliasTMP)->(RA_NOME))

				dDataDe  := FirstDate(StoD(DatDe + "01"))
				dDataAte := LastDate(StoD(DatAte + "01"))
				

				aPeriodos := Monta_per( dDataDe , dDataAte , _cFilial , (cAliasTMP)->(RD_MAT) , dDataDe , dDataAte )

				//-- Chamada a fTrocaTno() para identificar o turno correto a ser passado para retseq.
				fTrocaTno(aPeriodos[nX,1], aPeriodos[nX,2], @aTurnos)

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

				If lImp

					cLinha := "Perído" + Space(30)+ ";" + "Hrs. Prev" + ";" + "Hrs. Real" + ";" + "Hrs. N.Trab." + ";" + "Hrs.Abonad." + ";" + "Hrs. Afast." + ";" + "%Hrs. Afast.
					FWrite(nCSV,cLinha+ CRLF)

					cLinha := "Filial" + Space(30) + ";" + "Matricula" + ";" + "Nome" + ";" + "Centro Custo" + ";" + "Desc.C.Custo"
					FWrite(nCSV,cLinha+ CRLF+CRLF)

					cLinha := _cFilial + ";" + _cMatric + ";" + _cNome + ";" + _cCentro + ";" + Posicione('CTT',1,xFilial("CTT") + _cCentro,"CTT_DESC01")
					FWrite(nCSV,cLinha+ CRLF+ CRLF)
					cLinha := ""
					FWrite(nCSV,cLinha+ CRLF)

					lImp := .F.
				Endif
				While (cAliasTMP)->(!EOF()) .and. _cFilial == (cAliasTMP)->RA_FILIAL .and. _cMatric == (cAliasTMP)->RD_MAT .and. _cCentro == (cAliasTMP)->RD_CC

					If lImp1
						_cPeriod := SubStr((cAliasTMP)->(RD_PERIODO),5,2) + "-" + SubStr((cAliasTMP)->(RD_PERIODO),1,4)
						cLinha := _cPeriod + ";" + "180,00"+ ";" + "163,30" +";" + "90,83"
						FWrite(nCSV,cLinha+ CRLF)

						cLinha := "COD" + ";" + "Evento" + ";" + "Horas" + ";" + "%Horas" + "Abono" + ";" + "Motivo" + ";" + "Hrs. Abonadas" + ";" + "%Hrs. Abonadas" + ";" + "Afastamento" + ";" + "Descrição" + ";" + "Hrs. Afast." + ";" + "%Hrs. Afast."
						FWrite(nCSV,cLinha+ CRLF)

						cLinha := ""
						FWrite(nCSV,cLinha+ CRLF)

					Endif

					cLinha := (cAliasTMP)->RD_PD +";" + Posicione('SRV',1,xFilial('SRV') + (cAliasTMP)->RD_PD,"RV_DESC") +";" + cValToChar((cAliasTMP)->RD_HORAS)
					FWrite(nCSV,cLinha+ CRLF)
					lImp1 := .F.// 			aadd(aInfo,{(cAliasTMP)->RA_FILIAL,(cAliasTMP)->RD_MAT,(cAliasTMP)->RD_PD,(cAliasTMP)->RD_CC,(cAliasTMP)->RD_PERIODO,(cAliasTMP)->RD_VALOR})

					(cAliasTMP)->(DbSkip())
					If _cPeriod <> SubStr((cAliasTMP)->(RD_PERIODO),5,2) + "-" + SubStr((cAliasTMP)->(RD_PERIODO),1,4)
						lImp1 := .T.
						cLinha := ""
						FWrite(nCSV,cLinha+ CRLF)
					Endif
				Enddo
				lImp1 := .T.
				If _cFilial <> (cAliasTMP)->RA_FILIAL .or. _cMatric <> (cAliasTMP)->RD_MAT
					lImp := .T.
					cLinha := ""
					FWrite(nCSV,cLinha+ CRLF)
				Endif				//(cAliasTMP)->(DbSkip())
				Loop
			ENDDO

			//Ativando o arquivo e gerando o xml
			// oExcel:Activate()
			// oExcel:GetXMLFile(cArquivo)
			FClose(nCSV)
			//Abrindo o excel e abrindo o arquivo xml
			oExcel := MsExcel():New()             //Abre uma nova conexão com Excel
			oExcel:WorkBooks:Open(cDir+ cCSV)     //Abre uma planilha
			oExcel:SetVisible(.T.)                 //Visualiza a planilha
			oExcel:Destroy()                        //Encerra o processo do gerenciador de tarefas
		Endif
	Endif

Return
