#Include "Totvs.ch"
#Include "FWMVCDef.ch"
#Include "msole.ch"
#Include 'rwmake.ch'
#Include 'topconn.ch'
#Include 'FWEditPanel.ch'
#Include "TRYEXCEPTION.CH"
#Include "FWPrintSetUp.ch"
#Include "rptdef.ch"

//Vari�veis utilizadas no fonte inteiro
Static nPadLeft   := 0                                                                     //Alinhamento a Esquerda
Static nPadRight  := 1                                                                     //Alinhamento a Direita
Static nPadCenter := 2                                                                     //Alinhamento Centralizado
Static nPadJustif := 3                                                                     //Alinhamento Justificado
Static nPosCod    := 0000                                                                  //Posi��o Inicial da Coluna de C�digo do Produto
Static nPosDesc   := 0000                                                                  //Posi��o Inicial da Coluna de Descri��o
Static nPosUnid   := 0000                                                                  //Posi��o Inicial da Coluna de Unidade de Medida
Static nPosQuan   := 0000                                                                  //Posi��o Inicial da Coluna de Quantidade
Static nPosVUni   := 0000                                                                  //Posi��o Inicial da Coluna de Valor Unitario
Static nPosVTot   := 0000                                                                  //Posi��o Inicial da Coluna de Valor Total
Static nPosBIcm   := 0000                                                                  //Posi��o Inicial da Coluna de Base Calculo ICMS
Static nPosVIcm   := 0000                                                                  //Posi��o Inicial da Coluna de Valor ICMS
Static nPosVIPI   := 0000                                                                  //Posi��o Inicial da Coluna de Valor Ipi
Static nPosAIcm   := 0000                                                                  //Posi��o Inicial da Coluna de Aliquota ICMS
Static nPosAIpi   := 0000                                                                  //Posi��o Inicial da Coluna de Aliquota IPI
Static nPosSTUn   := 0000                                                                  //Posi��o Inicial da Coluna de Valor Unit�rio ST
Static nPosSTVl   := 0000                                                                  //Posi��o Inicial da Coluna de Valor Unit�rio + ST
Static nPosSTBa   := 0000                                                                  //Posi��o Inicial da Coluna de Base do ST
Static nPosSTTo   := 0000                                                                  //Posi��o Inicial da Coluna de Valor Total ST
Static nTamFundo  := 15                                                                    //Altura de fundo dos blocos com t�tulo
//Static cEmpEmail  := Alltrim(SuperGetMV("MV_X_EMAIL", .F., "email@empresa.com.br"))        //Par�metro com o e-Mail da empresa
//Static cEmpSite   := Alltrim(SuperGetMV("MV_X_HPAGE", .F., "http://www.empresa.com.br"))   //Par�metro com o site da empresa
Static nCorAzul   := RGB(062, 179, 206)                                                    //Cor Azul usada nos T�tulos
Static cNomeFont  := "Tahoma"                                                               //Nome da Fonte Padr�o
Static oFontTit   := Nil                                                                   //Fonte utilizada no T�tulo das se��es
Static cMaskPad   := "@E 999,999.99"                                                       //M�scara padr�o de valor
Static cMaskTel   := "@R (99) 99999999"                                                    //M�scara de telefone / fax
Static cMaskCNPJ  := "@R 99.999.999/9999-99"                                               //M�scara de CNPJ
Static cMaskCEP   := "@R 99999-999"                                                        //M�scara de CEP

/*/{Protheus.doc} User Function AFINOTI
Fun��o para notifica��o de d�bitos
@author Eder Fernandes
@since 28/06/2022
@version 1.0
@type function
/*/
User Function AFINOTI()
	Local aArea     := FWGetArea()
	Local aPergs    := {}
	Local xPar0     := sToD("")
	Local xPar1     := 000
	Local xPar2     := 000
	Local xPar3     := (Space(6))
	Local xPar4     := (Space(6))
	Local xPar5     := (Space(4))
	Local xPar6     := (Space(4))
	Local xPar7     := (Space(100))
	Local xPar8     := 2
	Local xPar9     := 2
	Local xPar10     := 2
	Local xPar11     := (Space(15))
	Local xPar12    := (Space(100))
	Local aCampos   := {}
	Local aSeek     := {}
	Private dVenctoI
	Private dVenctoF
	Private aEstrut := {}
	Private oTempTable
	Private _cAlias := GetNextAlias()
	Private oMark

	If oTempTable <> Nil
		oTempTable:Delete()
		oTempTable := Nil
	Endif

	//Adicionando os parametros do ParamBox
	aadd(aPergs, {1, "Data Base"             , xPar0    , ""                          , ".T."       , ""     , ".T.", 55 , .F.})   //MV_PAR01
	aadd(aPergs, {1, "Dias Vencidos De"      , xPar1    , "@E 999"                    , "Positivo()", ""     , ".T.", 15 , .F.})   //MV_PAR02
	aadd(aPergs, {1, "Dias Vencidos Ate"     , xPar2    , "@E 999"                    , "Positivo()", ""     , ".T.", 15 , .F.})   //MV_PAR03
	aadd(aPergs, {1, "Cliente de "           , xPar3    , ""                          , ".T."       , "SA1"  , ".T.", 25 , .F.})   //MV_PAR04
	aadd(aPergs, {1, "Cliente At�"           , xPar4    , ""                          , ".T."       , "SA1"  , ".T.", 15 , .F.})   //MV_PAR05
	aadd(aPergs, {1, "Loja de"               , xPar5    , ""                          , ".T."       , ""     , ".T.", 15 , .F.})   //MV_PAR06
	aadd(aPergs, {1, "Loja At�"              , xPar6    , ""                          , ".T."       , ""     , ".T.", 15 , .F.})   //MV_PAR07
	aadd(aPergs, {1, "Raz�o Social"          , xPar7    , ""                          , ".T."       , ""     , ".T.", 100 , .F.})  //MV_PAR08
	aadd(aPergs, {2, "Notifica��o Gerada"    , xPar8    , {"1=Sim" ,"2=N�o","3=Ambos"}, 50          , ".T."  , .F.})			   //MV_PAR09
	aadd(aPergs, {2, "Cliente Exce��o"       , xPar9    , {"1=Sim" ,"2=N�o","3=Ambos"}, 50          , ".T."  , .F.})               //MV_PAR10
	aadd(aPergs, {2, "T�tulo em Contesta��o" , xPar10    , {"1=Sim" ,"2=N�o","3=Ambos"}, 50          , ".T."  , .F.})			   //MV_PAR11
	aadd(aPergs, {1, "Nr. Ctr. Licita��o"    , xPar11   , "@!"                        , ".T."       , ""     , ".T.", 55 , .F.})   //MV_PAR12
	aadd(aPergs, {1, "Contrato ADC"          , xPar12   , "@!"                        , ".T."       ,"TITADX", ".T.",100 , .F.})   //MV_PAR13
	aadd(aPergs ,{1, "Diret�rio para Salvar" , Space(75),""                           , ".T."       ,"HSSDIR",""    ,80  , .T.})   //MV_PAR14

	//Se a pergunta for confirmada, chama a tela
	If ParamBox(aPergs, "Informe os parametros",,,,,,,,,,.T.)

		Private dBase      := MV_PAR01
		Private nRetroI	   := MV_PAR02
		Private nRetroF    := MV_PAR03
		Private cCliIni    := MV_PAR04
		Private cCliFin    := MV_PAR05
		Private cLojaIni   := MV_PAR06
		Private cLojaFin   := MV_PAR07
		Private cRazao     := MV_PAR08
		Private nGerado    := MV_PAR09
		Private nExcecao   := MV_PAR10
		Private nContesta  := MV_PAR11
		Private cCtrParam  := MV_PAR12
		Private cCtrADc    := MV_PAR13
		Private cCamArq    := MV_PAR14

		If ValType(nGerado) == "C"
			nGerado := Val(nGerado)
		Endif
		If ValType(nExcecao) == "C"
			nExcecao := Val(nExcecao)
		Endif
		If ValType(nContesta) == "C"
			nContesta := Val(nContesta)
		Endif
		If Valtype(cCtrParam) <> "C"
			cCtrParam := cValToChar(cCtrParam)
		Endif

		//trata o retorno do numero de contrato retirando o ; do final
		cCtrADc :=  If(Right(AllTrim(MV_PAR13),1)== ';', SubStr(AllTrim(MV_PAR13),1, Len(AllTrim(MV_PAR13))-1),AllTrim(MV_PAR13))

		aEstrut := Retcmpstru()
		aCampos := Retcpo(aEstrut)


		If oTempTable <> Nil
			oTempTable:Delete()
			oTempTable := Nil
		Endif

		//Cria a tabela tempor�ria
		oTempTable:= FWTemporaryTable():New(_cAlias)
		oTempTable:SetFields( aEstrut )
		oTempTable:AddIndex("01", {"E1_FILIAL","E1_CLIENTE","E1_LOJA","E1_PREFIXO","E1_NUM","E1_PARCELA"} )  //E1_FILIAL + E1_CLIENTE + E1_LOJA + E1_PREFIXO + E1_NUM + E1_PARCELA + E1_TIPO
		oTempTable:Create()

		//Dou carga na tabela temporaria
		fTabtmp(.F.,.F.)

	/* Aadd(aSeek  ,{"Filial + Cliente + Loja"	, {{"", TamSX3("E1_FILIAL")[3], TamSX3("E1_FILIAL")[1] + TamSX3("E1_CLIENTE")[1] + TamSX3("E1_LOJA")[1], 00, "E1_FILIAL",""}}, 1, .T. } )
	Aadd(aSeek  ,{"Nro Pedido"	 	, {{"", TamSX3("C5_NUM")[3], TamSX3("C5_NUM")[1], TamSX3("C5_NUM")[2], "C5_NUM",""}}, 2, .T. } )
	Aadd(aSeek  ,{"Codigo Cliente"	, {{"", TamSX3("C5_CLIENTE")[3], TamSX3("C5_CLIENTE")[1], TamSX3("C5_CLIENTE")[2], "C5_CLIENTE",""}}, 3, .T. } )
	Aadd(aSeek  ,{"Codigo Vendedor"	, {{"", TamSX3("C5_VEND1")[3], TamSX3("C5_VEND1")[1], TamSX3("C5_VEND1")[2], "C5_VEND1",""}}, 4, .T. } )
	Aadd(aSeek  ,{"Codigo Gerente"	, {{"", TamSX3("A3_SUPER")[3], TamSX3("A3_SUPER")[1], TamSX3("A3_SUPER")[2], "A3_SUPER",""	}}, 5, .T. } )

 */

		oMark := FWMarkBrowse():New()
		oMark:SetDescription('CONTAS A RECEBER - NOTIFICA��O DE D�BITOS')
		oMark:SetAlias(_cAlias)
		oMark:SetFields(aCampos)
		oMark:SetSeek(.T.,aSeek)
		oMark:SetUseFilter(.T.)
		oMark:SetTemporary(.T.)
		oMark:SetFieldMark( 'OK' )
		oMark:SetMenuDef("")

		//Bot�es do browse
		oMark:AddButton("Gerar Notifica��o"  , {|oMark| Processa({|| u_AFINOTIO() }) })
		oMark:AddButton("Observa��o"		 , {|oMark| u_cadobserv()})
		oMark:AddButton("Contrato Licita��o" , {|oMark| u_GrvCtrLi() })
		oMark:AddButton("Refaz Consulta"     , {|oMark| u_Afinoti()})
		oMark:AddButton("Atualiza Dados"     , {|oMark| fTabtmp(.T., .T.)})

		oMark:AddLegend("ZA_NOTIFIC == '          '","GREEN","Sem Notifica��o Gerada")
		oMark:AddLegend("ZA_NOTIFIC <> '          '","GRAY","Notifica��es Geradas")

		SetKey (VK_F12,{||u_afinoti()})
		oMark:Activate()
	Else
		MsgAlert("Cancelado pelo usu�rio","Aten��o")
	EndIf
	If oTempTable <> Nil
		oTempTable:Delete()
		oTempTable := Nil
	Endif

	//fMonta()
	FWRestArea(aArea)


Return

/*/{Protheus.doc} Retcmpstru
Fun�ao para retornar campos da estrutura
@type function
@version 1.0
@author eder.fernandes
@since 26/09/2022
/*/
Static Function Retcmpstru()

	Local _aRetorno := {}

	//Adiciona Estrutura da tabela tempor�ria
	aadd(_aRetorno, {'OK'     , 'C'                      , 2                        , 0}) //Flag para marca��o
	aadd(_aRetorno, {'E1_FILIAL' , TamSx3( 'E1_FILIAL' )[3] , TamSx3( 'E1_FILIAL' )[1] , 0}) //Filial
	aadd(_aRetorno, {'E1_NUM' , TamSx3( 'E1_NUM' )[3]    , TamSx3( 'E1_NUM' )[1]    , 0}) //Nr. Titulo
	aadd(_aRetorno, {'E1_PARCELA', TamSx3( 'E1_PARCELA' )[3], TamSx3( 'E1_PARCELA' )[1], 0}) //Parcela
	aadd(_aRetorno, {'E1_VALOR'  , TamSx3( 'E1_VALOR' )[3]  , TamSx3( 'E1_VALOR' )[1]  , TamSx3( 'E1_VALOR' )[2]}) //Valor Titulo
	aadd(_aRetorno, {'E1_SALDO'  , TamSx3( 'E1_SALDO' )[3]  , TamSx3( 'E1_SALDO' )[1]  , TamSx3( 'E1_SALDO' )[2]}) //Saldo Atual
	aadd(_aRetorno, {'E1_EMISSAO', TamSx3( 'E1_EMISSAO' )[3], TamSx3( 'E1_EMISSAO' )[1], 0}) //Emissao
	aadd(_aRetorno, {'E1_PREFIXO', TamSx3( 'E1_PREFIXO' )[3], TamSx3( 'E1_PREFIXO' )[1], 0}) //Prefixo
	aadd(_aRetorno, {'E1_CLIENTE', TamSx3( 'E1_CLIENTE' )[3], TamSx3( 'E1_CLIENTE' )[1], 0}) //Cliente
	aadd(_aRetorno, {'E1_LOJA'   , TamSx3( 'E1_LOJA' )[3]   , TamSx3( 'E1_LOJA' )[1]   , 0}) //Loja
	aadd(_aRetorno, {'E1_XCTRADC' , TamSx3( 'E1_XCTRADC' )[3], TamSx3( 'E1_XCTRADC' )[1], 0}) //Contrato ADC
	aadd(_aRetorno, {'E1_RAZAO'  , TamSx3( 'E1_RAZAO' )[3]  , TamSx3( 'E1_RAZAO' )[1]  , 0}) //Razao Social
	aadd(_aRetorno, {'E1_VENCORI' , TamSx3( 'E1_VENCORI' )[3], TamSx3( 'E1_VENCORI' )[1], 0}) // Vencimento
	aadd(_aRetorno, {'E1_XNRONF'  , TamSx3( 'E1_XNRONF' )[3] , TamSx3( 'E1_XNRONF' )[1] , 0}) //Numero NF
	aadd(_aRetorno, {'ZA_OBS'    , TamSx3( 'ZA_OBS' )[3]    , TamSx3( 'ZA_OBS' )[1]    , 0}) //Observa�ao
	aadd(_aRetorno, {'E1_XINIPER' , TamSx3( 'E1_XINIPER' )[3], TamSx3( 'E1_XINIPER' )[1], 0}) //Inicio Periodo
	aadd(_aRetorno, {'E1_XFIMPER' , TamSx3( 'E1_XFIMPER' )[3], TamSx3( 'E1_XFIMPER' )[1], 0}) //Fim Periodo
	aadd(_aRetorno, {'E1_TIPO'   , TamSx3( 'E1_TIPO' )[3]   , TamSx3( 'E1_TIPO' )[1]   , 0}) //Tipo
	aadd(_aRetorno, {'ZA_CTRLICI' , TamSx3( 'ZA_CTRLICI' )[3], TamSx3( 'ZA_CTRLICI' )[1], 0}) //Contrato Licita��o
	aadd(_aRetorno, {'ZA_NOTIFIC' , TamSx3( 'ZA_NOTIFIC' )[3], TamSx3( 'ZA_NOTIFIC' )[1], 0}) //Tipo Notifica��o
	aadd(_aRetorno, {'ZA_DTGERA' , TamSx3( 'ZA_DTGERA' )[3], TamSx3( 'ZA_DTGERA' )[1], 0}) //Tipo Notifica��o


Return _aRetorno



/*/{Protheus.doc} Retcpo
Retorna estrutura da tabela temporaria
@type function
@version 1.0	
@author eder.fernandes
@since 25/10/2022
/*/
Static Function Retcpo(_paStru)

	Local _aArea    := GetArea()
	Local _aRetorno := {}
	Local _iCpo     := 0
	Local cAliasSX3 := GetNextAlias()

	OpenSxs(,,,,,cAliasSX3,"SX3",,.F.)
	DbSelectArea(cAliasSX3)
	(cAliasSX3)->(DbSetOrder(2))

	For _iCpo := 1 to Len(_paStru)
		If (cAliasSX3)->(MsSeek(_paStru[_iCpo][1]) ) .And. !(AllTrim(_paStru[_iCpo][1]) $ "OK")

			If AllTrim(_paStru[_iCpo][1]) == "ZA_OBS"
				aAdd(_aRetorno, { "Observa��o", _paStru[_iCpo][1], _paStru[_iCpo][2], Eval({||_paStru[_iCpo][3]}), _paStru[_iCpo][4], (cAliasSX3)->&("X3_PICTURE") })
			Else
				aAdd(_aRetorno, { (cAliasSX3)->&("X3_TITULO"), _paStru[_iCpo][1], _paStru[_iCpo][2], Eval({||_paStru[_iCpo][3]}), _paStru[_iCpo][4], (cAliasSX3)->&("X3_PICTURE") })
			Endif
		EndIf
	Next _iCpo

	(cAliasSX3)->(dbCloseArea())

	RestArea(_aArea)

Return(_aRetorno)


/*/{Protheus.doc} fTabtmp
Fun�ao para dar carga na tabela temporaria
@type function
@version 1.0
@author eder.fernandes
@since 25/10/2022
/*/
Static Function fTabtmp(lRecarrega, lMsg)


	Local cQuery     := RetQry()
	Local cDelete    := ""
	Local cCliente   := ""
	Local cLoja      := ""
	Local nJ         := 0
	Local nI         := 0
	Local nH         := 0
	Local nG         := 0
	Local nAtual	 := 0
	Local nTotal     := 0
	Local nSaldo     := 0
	Local nSalTot    := 0
	Local aRegs      := {}
	Local aRegsTot   := {}
	Local aRegsFil   := {}
	Local lRet       := .T.
	Local dDtGera
	Private _cTable  := oTempTable:GetRealName()

	If lRecarrega
		cDelete := "DELETE " + _cTable
		If (TCSQLEXEC(cDelete) < 0 )
			MsgAlert("Erro ao limpar tabela tempor�ria. ", "Afinotif")
			Return (Nil)
		Endif
	Endif
	SqlToTrb(cQuery, aEstrut, _cAlias)


	//Definindo o tamanho da r�gua
	DbSelectArea(_cAlias)
	Count to nTotal
	ProcRegua(nTotal)
	(_cAlias)->(DbGoTop())

	If ! (_cAlias)->(Eof())
		//Enquanto houver registros, adiciona na tempor�ria
		While ! (_cAlias)->(EoF())
			//	cCliente := _cTable->E1_CLIENTE
			//	cLoja    := _cTable->E1_LOJA
			nSalTot  := 0
			cObs     := ""
			cCtrLic  := ""
			cNotif   := ""
			lRet     := .T.
			nAtual++
			IncProc('Analisando registro ' + cValToChar(nAtual) + ' de ' + cValToChar(nTotal) + '...')
			DbSelectArea('SE1')
			SE1->(DbSetOrder(2))
			If SE1->(DbSeek((_cAlias)->(E1_FILIAL + E1_CLIENTE + E1_LOJA + E1_PREFIXO + E1_NUM + E1_PARCELA + E1_TIPO)))
				nSaldo := SaldoTit(SE1->E1_PREFIXO,SE1->E1_NUM,SE1->E1_PARCELA,SE1->E1_TIPO,SE1->E1_NATUREZ,"R",SE1->E1_CLIENTE,1,,,SE1->E1_LOJA,,0/*nTxMoeda*/)
			Endif
			DbSelectArea('SZA')
			SZA->(DbSetOrder(1))
			If SZA->(DbSeek((_cAlias)->(E1_FILIAL + E1_CLIENTE + E1_LOJA + E1_PREFIXO + E1_NUM + E1_PARCELA + E1_TIPO + '1')))
				cObs    := SZA->ZA_OBS
				cCtrLic := SZA->ZA_CTRLICI
				cNotif  := SZA->ZA_NOTIFIC
				dDtGera := SZA->ZA_DTGERA
				If !Empty(SZA->ZA_NOTIFIC)
					IF AllTrim(SZA->ZA_NOTIFIC) <> 'JURIDICO'
						IF  nGerado == 2
							lRet := .F.
						Endif
					Endif
				Else
					If  nGerado == 1
						lRet := .F.
					Endif
				Endif
			Endif
			// If !lRet
			// 	(_cAlias)->(DbSkip())
			// 	Loop
			// Endif

			If nSaldo > ((_cAlias)->E1_VALOR * 0.11)
				aadd(aRegs, {(_cAlias)->E1_FILIAL,; 	//[1]
				(_cAlias)->E1_NUM,; 					//[2]
				(_cAlias)->E1_PARCELA,;					//[3]
				(_cAlias)->E1_VALOR,;					//[4]
				nSaldo,;								//[5]
				(_cAlias)->E1_EMISSAO,;					//[6]
				(_cAlias)->E1_PREFIXO,;					//[7]
				(_cAlias)->E1_CLIENTE,;					//[8]
				(_cAlias)->E1_LOJA,;					//[9]
				(_cAlias)->E1_XCTRADC,;					//[10]
				IIF (EMPTY((_cAlias)->E1_RAZAO),POSICIONE('SA1',1,xFilial('SA1')+(_cAlias)->E1_CLIENTE+(_cAlias)->E1_LOJA,"A1_NOME"),(_cAlias)->E1_RAZAO),;					          //[11]
				(_cAlias)->E1_VENCORI,;					//[12]
				(_cAlias)->E1_XNRONF,;					//[13]
				cObs,;			  	    	            //[14]
				(_cAlias)->E1_XINIPER,;					//[15]
				(_cAlias)->E1_XFIMPER,;					//[16]
				(_cAlias)->E1_TIPO,;					//[17]
				cCtrLic,;                           	//[18]
				cNotif,;    	          	            //[19]
				dDtGera,;    	          	            //[20]
				lRet})    	          	                //[21]
			Endif
			(_cAlias)->(DbSkip())

		EndDo
		For nI := 1 to Len(aRegs)
			cCliente := aRegs[nI][8]
			cLoja    := aRegs[nI][9]
			aRegsFil := {}
			nSalTot  := 0
			For nJ := 1 to Len(aRegs)
				If  IIF(Empty(cCtrParam),cCliente == aRegs[nJ][8] .And. cLoja == aRegs[nJ][9], cCliente == aRegs[nJ][8] .And. cLoja == aRegs[nJ][9] .And. cCtrParam == aRegs[nJ][18])
					//cChave := aRegs[nJ][1] + aRegs[nJ][8] + aRegs[nJ][9] + aRegs[nJ][7] + aRegs[nJ][2] + aRegs[nJ][3] + aRegs[nJ][17]
					nPos   := aScan(aRegsFil,{|x| x[1] + x[8] +;
						x[9] + x[7] + x[2] +;
						x[3] + x[17] == aRegs[nJ][1] +;
						aRegs[nJ][8] + aRegs[nJ][9] +;
						aRegs[nJ][7] + aRegs[nJ][2] +;
						aRegs[nJ][3] + aRegs[nJ][17]})
					If nPos <= 0
						aadd(aRegsFil,aRegs[nJ])
						nSalTot += aRegs[nJ][5]
						nI++
					Endif
				Endif
			Next nJ
			If nSalTot > GetNewPar("VL_VLRNOTI",500)
				aadd(aRegsTot,aRegsFil)
			Endif
			If Len(aRegsFil) > 0
				nI--
			Endif
		Next nI
	Endif

	If Len(aRegsTot) > 0

		cDelete := "DELETE " + _cTable
		If (TCSQLEXEC(cDelete) < 0 )
			MsgAlert("Erro ao limpar tabela tempor�ria. ", "Afinotif")
			Return (Nil)
		Endif

		For nG := 1 To Len(aRegsTot)
			For nH := 1 To Len(aRegsTot[nG])
				if aRegsTot[nG][nH][21]
					RecLock(_cAlias, .T.)
					(_cAlias)->OK         := Space(2)
					(_cAlias)->E1_FILIAL  := aRegsTot[nG][nH][1]
					(_cAlias)->E1_NUM     := aRegsTot[nG][nH][2]
					(_cAlias)->E1_PARCELA := aRegsTot[nG][nH][3]
					(_cAlias)->E1_VALOR   := aRegsTot[nG][nH][4]
					(_cAlias)->E1_SALDO   := aRegsTot[nG][nH][5]
					(_cAlias)->E1_EMISSAO := aRegsTot[nG][nH][6]
					(_cAlias)->E1_PREFIXO := aRegsTot[nG][nH][7]
					(_cAlias)->E1_CLIENTE := aRegsTot[nG][nH][8]
					(_cAlias)->E1_LOJA    := aRegsTot[nG][nH][9]
					(_cAlias)->E1_XCTRADC := aRegsTot[nG][nH][10]
					(_cAlias)->E1_RAZAO   := aRegsTot[nG][nH][11]
					(_cAlias)->E1_VENCORI := aRegsTot[nG][nH][12]
					(_cAlias)->E1_XNRONF  := aRegsTot[nG][nH][13]
					(_cAlias)->ZA_OBS     := aRegsTot[nG][nH][14]
					(_cAlias)->E1_XINIPER := aRegsTot[nG][nH][15]
					(_cAlias)->E1_XFIMPER := aRegsTot[nG][nH][16]
					(_cAlias)->E1_TIPO    := aRegsTot[nG][nH][17]
					(_cAlias)->ZA_CTRLICI := aRegsTot[nG][nH][18]
					(_cAlias)->ZA_NOTIFIC := aRegsTot[nG][nH][19]
					(_cAlias)->ZA_DTGERA  := aRegsTot[nG][nH][20]
					(_cAlias)->(MsUnlock())
				Endif
			Next nH

		Next nG
	Else
		FwAlertInfo("N�o foram encontrados registros para os parametros informados","ATEN��O")
		cDelete := "DELETE " + _cTable
		If (TCSQLEXEC(cDelete) < 0 )
			MsgAlert("Erro ao limpar tabela tempor�ria. ", "Afinotif")
			Return (Nil)
		Endif
	Endif

	SZA->(dbCloseArea())

	(_cAlias)->(DbGoTop())

	If lRecarrega .And. lMsg
		FwAlertSuccess("Dados atualziados com sucesso !", "OK!")
		oMark:Refresh(.T.)
	ElseIf lRecarrega .And. !lMsg
		oMark:Refresh(.T.)
	Endif

Return

Static Function RetQry()
	Local dVenctoI     := dBase - nRetroI
	Local dVenctoF     := dBase - nRetroF
	Local cQryDados   := ""
	Local cCampos     := " E1.E1_FILIAL, E1.E1_NUM, E1.E1_EMISSAO, E1.E1_VENCREA, E1.E1_VALOR, E1.E1_PREFIXO, E1.E1_CLIENTE, E1.E1_LOJA, E1.E1_XNRONF, E1.E1_RAZAO, E1.E1_PARCELA, E1.E1_NATUREZ, E1.E1_TIPO, E1.E1_XCTRADC, E1.E1_XINIPER, E1.E1_XFIMPER, E1.E1_XNRONF, E1.E1_VENCORI "

	//Monta a consulta
	cQryDados += " SELECT DISTINCT " + cCampos
	cQryDados += " FROM " + RETSQLNAME ('SE1') + " E1 "                                            										+ CRLF
	cQryDados += " INNER JOIN " + RETSQLNAME ('ADY') + " ADY ON ADY_FILIAL = E1_FILIAL AND "       										+ CRLF
	cQryDados += " ADY_CODIGO = E1_CLIENTE AND ADY_LOJA = E1_LOJA AND ADY_CTRADC = E1_XCTRADC  "   										+ CRLF
	cQryDados += " AND E1.D_E_L_E_T_ = ADY.D_E_L_E_T_   "                                          										+ CRLF
	cQryDados += " INNER JOIN " + RETSQLNAME ('SA1') + " A1 ON "                                  										+ CRLF
	cQryDados += " A1_COD = E1_CLIENTE AND A1_LOJA = E1_LOJA  "   		                                 								+ CRLF
	cQryDados += " AND A1.D_E_L_E_T_ = E1.D_E_L_E_T_   " 							   													+ CRLF
	cQryDados += " WHERE E1.D_E_L_E_T_ = ' ' AND E1_TIPO = 'NF' AND A1_LICITAD = 'S' AND E1_SALDO > 0 "									+ CRLF
	cQryDados += " AND E1_CLIENTE BETWEEN '" + cCliIni + "' AND '" + cCliFin + "' "														+ CRLF
	cQryDados += " AND E1_LOJA BETWEEN '" + cLojaIni + "' AND '" + cLojaFin + "' "														+ CRLF

	If dVenctoI <> dBase
		cQryDados += " AND E1_VENCORI BETWEEN '" + DTOS(dVenctoF) + "' AND '" + DTOS(dVenctoI) + "'"                       				+ CRLF
	Else
		cQryDados += " AND E1_VENCORI BETWEEN '" + DToS(date() - GetNewPar("VL_RTRONTF",180)) + "' AND  '" + DTOS( Date() - GetNewPar("VL_R1RONTF",15)) + "'"  	+ CRLF
	Endif
	If !Empty(cRazao)
		cqryDados += " AND A1_NOME LIKE '%" + AllTrim(cRazao) + "%' "                                                   				+ CRLF
	Endif
	If nExcecao == 1
		cQryDados += " AND ADY_XEXCES = '1' "     												   										+ CRLF
	ElseIf nExcecao == 2
		cQryDados += " AND ADY_XEXCES <> '1' "     												  										+ CRLF
	Endif
	If nContesta == 1
		cQryDados += " AND E1_PORTADO = 'DUV' "                                                    										+ CRLF
	ElseIf nContesta == 2
		cQryDados += " AND E1_PORTADO <> 'DUV' "									               										+ CRLF
	Endif
	If !Empty(cCtrADc)
		cQryDados += " AND ADY_CTRADC IN " + FORMATIN(cCtrADc,";") 							        									+ CRLF
	Endif
	cQryDados += " ORDER BY E1_CLIENTE, E1_LOJA, E1_NUM, E1_PARCELA "                              										+ CRLF

Return  cQryDados


/*/{Protheus.doc} User Function AFINOTIO
Fun��o acionada pelo bot�o continuar da rotina
@author Eder Fernandes
@since 28/06/2022
@version 1.0
@type function
/*/

User Function AFINOTIO()

	Local aPergs    := {}
	Local cTiposNot := Space(55)
	Local cTiposRet := ""

	aAdd(aPergs, {1, "Tipos de Notifica��o",     cTiposNot, "", ".T.", "TPNOTI",   ".T.", 120, .T.})


	If ParamBox(aPergs, "Informe os Tipos de Notifica��o",,,,,,,,,,.T.)
		cTiposRet := MV_PAR01
	EndIf

	Processa({|| fProcessa(cTiposRet)}, 'Aguarde...')
	fTabtmp(.T., .F.)
	oMark:Refresh(.T.)
Return

/*/{Protheus.doc} fProcessa
Fun��o que percorre os registros da tela
@author Eder Fernandes
@since 28/06/2022
@version 1.0
@type function
/*/

Static Function fProcessa(cTiposRet)
	Local aArea     := FWGetArea()
	Local cMarca    := oMark:Mark()
	Local nAtual    := 0
	Local nTotal    := 0
	Local nTotMarc  := 0
	Local nG        := 0
	Local aPdf      := {}
	Local aGera     := {}
	Local aExcel    := {}
	Local aNotifica := {}
	Local lRet      := .T.
	Local cCliente  := ""
	Local cLoja     := ""
	Local cCtrLic   := ""
	Local cObs      := ""
	Private cInicio := Time()

	//Define o tamanho da r�gua
	DbSelectArea(_cAlias)
	(_cAlias)->(DbGoTop())
	Count To nTotal
	ProcRegua(nTotal)

	Begin Transaction
		TRYEXCEPTION
		//Percorrendo os registros
		(_cAlias)->(DbGoTop())
		While ! (_cAlias)->(EoF())
			cCliente := (_cAlias)->E1_CLIENTE
			cLoja    := (_cAlias)->E1_LOJA
			cCtrLic  := AllTrim((_cAlias)->ZA_CTRLICI)

			nAtual++
			IncProc('Analisando registro ' + cValToChar(nAtual) + ' de ' + cValToChar(nTotal) + '...')

			//Caso esteja marcado
			If oMark:IsMark(cMarca)
				nTotMarc++
				cVerAnt := ""
				cObs    := ""

				If cCliente == (_cAlias)->E1_CLIENTE .AND. cLoja == (_cAlias)->E1_LOJA  .AND. cCtrLic == AllTrim((_cAlias)->ZA_CTRLICI)
					dbSelectArea('SZA')
					SZA->(dbSetOrder(1))
					If SZA->(DbSeek((_cAlias)->(E1_FILIAL + E1_CLIENTE + E1_LOJA + E1_PREFIXO + E1_NUM + E1_PARCELA + E1_TIPO + '1')))
						cVerAnt := SZA->ZA_VERSAO
						cObs    := SZA->ZA_OBS
						If RecLock('SZA',.F.)
							SZA->ZA_ATIVO := '2'
							SZA->(MsUnlock())
						Else
							lRet := .F.
							u_myconout('Nao foi possivel alterar o status do registro na SZA')
						EndIf

					Endif

					If lRet

						aadd(aNotifica, {(_cAlias)->E1_FILIAL,;  //[1]
						(_cAlias)->E1_NUM,; 				//[2]
						(_cAlias)->E1_PARCELA,;				//[3]
						(_cAlias)->E1_VALOR,;				//[4]
						(_cAlias)->E1_SALDO,;				//[5]
						(_cAlias)->E1_EMISSAO,;				//[6]
						(_cAlias)->E1_PREFIXO,;				//[7]
						(_cAlias)->E1_CLIENTE,;				//[8]
						(_cAlias)->E1_LOJA,;		    	//[9]
						(_cAlias)->E1_XCTRADC,;				//[10]
						(_cAlias)->E1_RAZAO,;				//[11]
						(_cAlias)->E1_VENCORI,;				//[12]
						(_cAlias)->E1_XNRONF,;				//[13]
						(_cAlias)->E1_TIPO,;				//[14]
						(_cAlias)->E1_XINIPER,;				//[15]
						(_cAlias)->E1_XFIMPER,;				//[16]
						cTiposRet,; 						//[17]
						cVerAnt ,;							//[18]
						cCtrLic,;							//[19]
						cObs,;   	    					//[20]
						Date()})   	    					//[21]

					EndIf
				EndIf

			Endif

			(_cAlias)->(DbSkip())
		EndDo

		If Len(aNotifica) > 0

			For nG := 1 to Len(aNotifica)

				If RecLock('SZA',.T.)
					SZA->ZA_FILIAL  := aNotifica[nG][1]                	//[1]
					SZA->ZA_VERSAO  := GETSXENUM('SZA','ZA_VERSAO')	   	//[2]
					SZA->ZA_TITULO  := aNotifica[nG][2]					//[3]
					SZA->ZA_PARCELA := aNotifica[nG][3]					//[4]
					SZA->ZA_VALOR   := aNotifica[nG][4]					//[5]
					SZA->ZA_SALDO   := aNotifica[nG][5]					//[6]
					SZA->ZA_EMISSAO := aNotifica[nG][6]					//[7]
					SZA->ZA_PREFIXO := aNotifica[nG][7]					//[8]
					SZA->ZA_CLIENTE := aNotifica[nG][8]					//[9]
					SZA->ZA_LOJA    := aNotifica[nG][9]					//[10]
					SZA->ZA_CTRADC  := aNotifica[nG][10]				//[11]
					SZA->ZA_NOME    := aNotifica[nG][11]				//[12]
					SZA->ZA_VENCTO  := aNotifica[nG][12]				//[13]
					SZA->ZA_NFISCAL := strzero(val(aNotifica[nG][13]),9)//[14]
					SZA->ZA_TIPO    := aNotifica[nG][14]				//[15]
					SZA->ZA_INIPER  := aNotifica[nG][15]				//[16]
					SZA->ZA_FIMPER  := aNotifica[nG][16]				//[17]
					SZA->ZA_NOTIFIC := aNotifica[nG][17]				//[18]
					SZA->ZA_VERANT  := aNotifica[nG][18]				//[19]
					SZA->ZA_ATIVO   := '1'								//[20]
					SZA->ZA_CTRLICI := AllTrim(aNotifica[nG][19])		//[21]
					SZA->ZA_OBS     := aNotifica[nG][20]				//[22]
					SZA->ZA_DTGERA  := aNotifica[nG][21]    			//[23]
					ConfirmSX8()
					SZA->(MsUnlock())
					AADD(aGera, aNotifica[nG])
				Else
					u_myconout('Nao foi posivel gravar a notificacao!')
					lRet := .F.
				Endif

			Next nG

			If Len(aGera) > 0

				aPDF := fPreenPDF(aGera)

				If Len(aPDF) > 0
					aExcel := fGeraExcel(aPDF)
				Else
					MsgAlert("N�o foi poss�vel gerar a notifica��o!")
					lRet := .F.
				Endif

				If Len(aExcel) > 0
					If Len(aExcel) <> nTotMarc
						FwAlertInfo("Registros marcados [ " + cValToChar(nTotMarc) + " ]" + " ||  Processados [ " + cValToChar(Len(aExcel)) + "]","Aten��o")
					Else
						FwAlertInfo("Todos os registros marcados, foram processados [ " + cValToChar(nTotMarc) + " ]" + ELAPTIME( cInicio, time() ))
					Endif

				Endif

			Else
				FwAlertInfo("N�o foi possivel gerar o arquivo Word!","Aten��o")
				lRet := .F.
			Endif
		Else
			MsgAlert('N�o foi poss�vel gerar as notifica��es!','Aten��o')
			lRet := .F.
		Endif
		If !lRet
			DisarmTransaction()
		Endif
		CATCHEXCEPTION USING oException
		MsgStop( AllTrim(oException:description), "ERRO")
		U_Myconout('Mensagem de erro: ' + AllTrim(oException:description))
		DisarmTransaction()
		ENDEXCEPTION
	End Transaction

	RestArea(aArea)
Return

/*/{Protheus.doc} AMULTIOP
fun��o para selecionar os tipos de notifica��o
@type function
@version 1.0 
@author eder.fernandes
@since 10/08/2022
/*/
User Function AMULTIOP(cTabela,cTitulo,l1Elem,lTipoRet)

	Local MvPar
	Local MvParDef   := ""
	Local nCount     := 0
	Private aCat     := {}

	Default cTitulo  := "" //O titulo n�o � obrigat�rio pois pode ser pegar o titulo da tabela SX5
	Default lTipoRet := .T.

	cCadastro        := "Tipos de Notifica��o"

	If(Empty(cTabela))
		MsgStop("Informe a tabela a ser pesquisada na SX5!"+CRLF+CRLF+"Avise ao Administrador do sistema. Fun��o: AMULTIOP()","ERRO")
		Return
	Endif

	l1Elem := If (l1Elem = Nil , .F. , .T.)

	cAliasbkp := Alias() // Salva Alias Anterior

	IF lTipoRet
		MvPar:=&(Alltrim(ReadVar()))	// Carrega Nome da Variavel do Get em Questao
		mvRet:=Alltrim(ReadVar())		// Iguala Nome da Variavel ao Nome variavel de Retorno
	EndIF

	dbSelectArea("SX5")

	If dbSeek(xFilial("SX5") + "00"  +cTabela)
		cTitulo := Alltrim(Left(X5Descri(),20))
	Endif

	If dbSeek(xFilial("SX5") + cTabela)
		CursorWait()
		aCat := {}
		While SX5->(!Eof()) /*.AND. SX5->X5_FILIAL == XFilial("SX5")*/ .AND. SX5->X5_Tabela == cTabela
			Aadd(aCat,Left(SX5->X5_Chave,2) + " - " + Alltrim(X5Descri()))
			MvParDef+=Left(SX5->X5_Chave,2)
			nCount++
			dbSkip()
		EndDo
		CursorArrow()
	Else
		Help('',1,'AMULTIOP',,'As op��es n�o foram inseridas!',1,0)
	Endif

	IF lTipoRet

		IF f_Opcoes(@MvPar,cTitulo,aCat,MvParDef,12,49,l1Elem,2,nCount)  // Chama funcao f_Opcoes (padr�o Protheus)
			&MvRet := mvpar										 // Devolve Resultado
		EndIF
	EndIF

	dbSelectArea(cAliasbkp) // Retorna Alias
Return( IF( lTipoRet , .T. , MvParDef ) )


/*/{Protheus.doc} fPreenPDF
Relatorio de notifica��es
@author Eder Fernandes
@since 06/10/2022
@version 1.0
@type function
/*/
Static Function fPreenPDF(aGera)

	Local aArea         := GetArea()
	Local aTipo         := {}
	Local aPDF          := {}
	Local cTipo         := ""
	Local aCorpoDoc     := ""
	Local nJ            := 0
	Local nG            := 0
	Local nTamTipo      := 0
	Local nItens        := 0
	Local nTotVlr       := 0
	Local nTotSld       := 0
	Local cOrNotif      := "RC"
	Local cAssina       := GetNewPar("VL_IMGASSI","\notificacoes\assinatura1.png")
	Local cAssina2      := GetNewPar("VL_IMGASS2","\notificacoes\assinatura2.png")
	Local cData         := DtExtenso(DDATABASE, .T.)
	Local cCliRazao     :=  ""
	Local cCliBairro    := ""
	Local cCliEnd       := ""
	Local cCliNumEnd    := ""
	Local cCliCidade    := ""
	Local cCliUF        := ""
	Local cCliCep       := ""
	Local cCtrLic       := ""
	Local nI            := 0
	Local cNomeRel      := ""
	Private cNomArq   	:= ""
	Private cLogoEmp 	:= fLogoEmp()
	Private oPrintNot
	Private nPagAtu   	:= 1
	//Linhas e colunas
	Private nLinAtu     := 0
	Private nLinFin     := 770
	Private nColIni     := 010
	Private nColFin     := 550
	Private nColCtr     := (nColFin-nColIni)/2
	Private nColTit     := (nColFin-nColIni)/2
	Private nColVenc    := (nColFin-nColIni)/2
	Private nColVal     := (nColFin-nColIni)/2
	Private nColSaldo   := (nColFin-nColIni)/2
	//fontes
	Private cFontCab    := "Arial"
	Private oFontCab    := TFont():New(cFontCab, , -14)
	Private oFontCabN   := TFont():New(cFontCab, , -14, , .T.)
	Private oFontRod    := TFont():New(cFontCab, , -14, , .T.)
	Private oFontRodN   := TFont():New(cFontCab, , -14, , .T.)
	Private oFontDet    := TFont():New(cFontCab, , -13, , .F.)
	Private oFontDetN   := TFont():New(cFontCab, , -13, , .T.)
	Private oFontVlrN   := TFont():New(cFontCab, , -12, , .T.)
	Private oFontDetNS  := TFont():New(cFontCab, , -13, , .T.,,,,,.T.)
	Private oFontPag    := TFont():New(cFontCab, , -08, , .F.)


	//Identifico os tipos de notifica��o
	For nTamTipo := 1 to Len(AllTrim(aGera[1][17]))
		If Substr(AllTrim(aGera[1][17]),nTamTipo,2) <> "**"
			AADD(aTipo, AllTrim(Substr(AllTrim(aGera[1][17]),nTamTipo,2)))
		EndIF
		nTamTipo += 1
	Next

	For nJ :=1 to Len(aTipo)

		cTipo  := aTipo[nJ]


		For nG := 1 to Len(aGera)

			cCliente := aGera[nG][8]
			cLoja    := aGera[nG][9]
			nPagAtu  := 1
			cNomeRel    := "notificacao_"+cCliente+"_"+cLoja+"_"+RetCodUsr()+"_"+dToS(Date())+"_"+StrTran(Time(), ":", "-")+"TP-"+cTipo
			If Empty(cCamArq)
				cCamArq := GetTempPath()
			Endif

			//Criando o objeto de impress�o
			oPrintNot := FWMSPrinter():New(ALLTRIM(cNomeRel),IMP_PDF,.F.,AllTrim(cCamArq),.T.,,,,.F.,.F.,,.F.,)
			oPrintNot:cPathPDF := AllTrim(cCamArq)
			oPrintNot:SetResolution(72)
			oPrintNot:SetPortrait()
			oPrintNot:SetPaperSize(DMPAPER_A4)
			oPrintNot:SetMargin(60, 60, 60, 60)

			//Imprime o cabe�alho do arquivo
			fImpCab(/*aGera[nG],cNotifica*/)
			cCliRazao   := AllTrim(aGera[nG][11])
			cCliBairro  := Alltrim(Posicione('SA1', 1, xFilial('SA1') + aGera[nG][8] + aGera[nG][9],"A1_BAIRRO"))
			cCliEnd     := AllTrim(Posicione('SA1', 1, xFilial('SA1') + aGera[nG][8] + aGera[nG][9],"A1_END"))
			cCliNumEnd  := AllTrim(Posicione('SA1', 1, xFilial('SA1') + aGera[nG][8] + aGera[nG][9],"A1_XNUM"))
			cCliCidade  := AllTrim(Posicione('SA1', 1, xFilial('SA1') + aGera[nG][8] + aGera[nG][9],"A1_MUN"))
			cCliUF      := AllTrim(Posicione('SA1', 1, xFilial('SA1') + aGera[nG][8] + aGera[nG][9],"A1_EST"))
			cCliCep     := AllTrim(Transform(Posicione('SA1', 1, xFilial('SA1') + aGera[nG][8] + aGera[nG][9],"A1_CEP"),cMaskCEP))
			cCtrLic     := AllTrim(aGera[nG][19])

			nTotVlr  := 0
			nTotSld  := 0


			cNotifica := U_zUltNum("SZA","ZA_NRNOTIR",.T.) + "/"+ cOrNotif


			nLinAtu += 60
			oPrintNot:SayAlign(nLinAtu, nColIni+250, "Uberl�ndida, " +  cData, oFontCab, 200, 07, , nPadRight, )
			nLinAtu += 60
			oPrintNot:SayAlign(nLinAtu    , nColIni+35, cCliRazao     , oFontCabN, 300, 07, , nPadLeft, )
			nLinAtu += 15
			oPrintNot:SayAlign(nLinAtu  , nColini+35, cCliEnd + "  " + cCliNumEnd + " Bairro: " +  cCliBairro     , oFontCab, 250, 07, , nPadLeft, )
			nLinAtu += 15
			oPrintNot:SayAlign(nLinAtu  , nColini+35, cCliCidade + " - "  + cCliUF , oFontCab, 100, 07, , nPadLeft, )
			nLinAtu += 15
			oPrintNot:SayAlign(nLinAtu  , nColini+35, "CEP: " +   cCliCep    , oFontCab, 90, 07, , nPadLeft, )

			nLinAtu += 30

			oPrintNot:SayAlign(nLinAtu, nColini + 280, " Ref. Notifica��o: " + cNotifica, oFontCab,200, 07, , nPadLeft)
			nLinAtu += 15
			oPrintNot:SayAlign(nLinAtu, nColini + 280, "CONTRATO N� :  " + cCtrLic, oFontCab, 200, 07,, nPadLeft )


			//Atualizando a linha inicial do relat�rio
			nLinAtu := nLinAtu + 20



			//		fDadosCli()

			//chamo fun�ao para gerar o texto a partir do tipo de documento
			aCorpoDoc := fCriaTexto(cTipo,'1')

			If Len(aCorpoDoc) > 0
				//Imprime o corpo do arquivo
				For nI := 1 to len(aCorpoDoc)

					nLinAtu += 15

					//Se por acaso atingiu o limite da p�gina, finaliza, e come�a uma nova p�gina
					If nLinAtu >= nLinFin
						oPrintNot:SayBitmap(nLinAtu-(nLinAtu - 730), nColFin-60, cAssina, 60, 60)
						fImpRod()
						fImpCab()
						nLinIni := 60
						nLinAtu := 60

					EndIf
					oprintNot:SayAlign(nLinAtu , nColIni +  35, aCorpoDoc[nI]   , oFontDet, 700, 07, nPadJustif)
				Next nI
				nLinAtu += 05

			EndIF
			//Se por acaso atingiu o limite da p�gina, finaliza, e come�a uma nova p�gina
			If nLinAtu >= nLinFin
				fImpRod()
				fImpCab()
				nLinAtu := 60

			EndIf
			nLinAtu += 20

			oprintNot:box(nLinAtu  ,nColIni + 35,nLinAtu + 20,nColFin - 60)
			oPrintNot:Line(nLinAtu , nColIni + 110, nLinAtu + 20, nColIni + 110)
			oPrintNot:Line(nLinAtu , nColIni + 180, nLinAtu + 20, nColIni + 180)
			oPrintNot:Line(nLinAtu , nColIni + 255, nLinAtu + 20, nColIni + 255)
			oPrintNot:Line(nLinAtu , nColIni + 333, nLinAtu + 20, nColIni + 333)
			oPrintNot:Line(nLinAtu , nColIni + 410, nLinAtu + 20, nColIni + 410)

			//oPrintNot:SayAlign(nLinAtu, nColIni + 35,aCorpoDoc[1]   ,oFontDet, 430, 330, , nPadJustif, )

			oprintNot:SayAlign(nLinAtu + 05, nColIni + 40 , "Contrato Adc", oFontDetN, 80, 07, nPadCenter)
			oprintNot:SayAlign(nLinAtu + 05, nColIni + 128, "T�tulo"      , oFontDetN, 80, 07, nPadCenter)
			oprintNot:SayAlign(nLinAtu + 05, nColIni + 187, "Vencimento"  , oFontDetN, 80, 07, nPadCenter)
			oprintNot:SayAlign(nLinAtu + 05, nColIni + 278, "Valor"       , oFontDetN, 80, 07, nPadCenter)
			oprintNot:SayAlign(nLinAtu + 05, nColIni + 347, "Saldo"       , oFontDetN, 80, 07, nPadCenter)
			oprintNot:SayAlign(nLinAtu + 05, nColIni + 435, "NF"          , oFontDetN, 80, 07, nPadCenter)

			nLinAtu +=  20
			nTamanho := Len(aGera) - nG + 1
			nItens := 1
			While nItens <= nTamanho .and. cCliente == aGera[nG][8] .and. cLoja == aGera[nG][9] .and. cCtrLic ==  AllTrim(aGera[nG][19])
				_cFilial := aGera[nG][1]
				cPrefixo := aGera[nG][7]
				_cTitulo := aGera[nG][2]
				cParcela := aGera[nG][3]
				_cTipo   := aGera[nG][14]

				//Se por acaso atingiu o limite da p�gina, finaliza, e come�a uma nova p�gina
				If nLinAtu >= nLinFin
					oPrintNot:SayBitmap(nLinAtu-(nLinAtu - 730), nColFin-60, cAssina, 60, 60)
					fImpRod()
					fImpCab()
					nLinAtu := 60

				EndIf
				//nLinAtu += 20

				// incremento a tabela com as informa��es dos registros

				oprintNot:box(nLinAtu ,nColIni + 35,nLinAtu + 20,nColFin - 60)
				oPrintNot:Line(nLinAtu , nColIni + 110, nLinAtu + 20, nColIni + 110)
				oPrintNot:Line(nLinAtu , nColIni + 180, nLinAtu + 20, nColIni + 180)
				oPrintNot:Line(nLinAtu , nColIni + 255, nLinAtu + 20, nColIni + 255)
				oPrintNot:Line(nLinAtu , nColIni + 333, nLinAtu + 20, nColIni + 333)
				oPrintNot:Line(nLinAtu , nColIni + 410, nLinAtu + 20, nColIni + 410)



				oprintNot:SayAlign(nLinAtu + 05, nColIni +  50, AllTrim(aGera[nG][10])                                   , oFontDetN, 80, 07, nPadCenter)  // CONTRATO ADC
				oprintNot:SayAlign(nLinAtu + 05, nColIni + 125, aGera[nG][2]                                             , oFontDetN, 80, 07, nPadCenter) // NR. TITULO
				oprintNot:SayAlign(nLinAtu + 05, nColIni + 190, DtoC(aGera[nG][12])                                      , oFontDetN, 80, 07, nPadCenter) // VENCIMENTO
				oprintNot:SayAlign(nLinAtu + 05, nColIni + 270, "R$" + AllTrim(Transform(aGera[nG][4],"@E 999,999,999.99"))       , oFontVlrN, 80, 07, nPadRight) // VALOR DO TITULO
				oprintNot:SayAlign(nLinAtu + 05, nColIni + 345, "R$" + AllTrim(Transform(aGera[nG][5],"@E 999,999,999.99"))       , oFontVlrN, 80, 07, nPadRight) // SALDO DO TITULO
				oprintNot:SayAlign(nLinAtu + 05, nColIni + 428, aGera[nG][13]                                            , oFontDetN, 80, 07, nPadCenter)  // NR. NOTA FISCAL

				dbSelectArea('SZA')
				SZA->(dbSetOrder(1)) //ZA_FILIAL + ZA_CLIENTE + ZA_LOJA + ZA_PREFIXO + ZA_TITULO + ZA_PARCELA + ZA_TIPO + ZA_ATIVO
				If SZA->(dbSeek(_cFilial + cCliente + cLoja + cPrefixo + _cTitulo + cParcela + _cTipo + '1'))
					If RecLock('SZA',.F.)
						SZA->ZA_NRNOTIR := Substr(cNotifica,1,6)
						MsUnlock()
					Endif
				Endif

				nTotVlr += aGera[nG][4]
				nTotSld += aGera[nG][5]

				nPos   := aScan(aPDF,{|x| x[1] + x[8] +;
					x[9] + x[7] + x[2] +;
					x[3] + x[17] == aGera[nG][1] +;
					aGera[nG][8] + aGera[nG][9] +;
					aGera[nG][7] + aGera[nG][2] +;
					aGera[nG][3] + aGera[nG][17]})

				If nPos <= 0
					aadd(aPDF,aGera[nG])
				Endif
				nG++
				nLinAtu += 20
				nItens ++
				dbSkip()
			EndDo

			If nLinAtu >= nLinFin
				oPrintNot:SayBitmap(nLinAtu-(nLinAtu - 730), nColFin-60, cAssina, 60, 60)
				fImpRod()
				fImpCab()

				nLinAtu := 60
			EndIf

			oprintNot:box(nLinAtu ,nColIni + 180,nLinAtu + 20,nColIni + 410)
			oPrintNot:Line(nLinAtu , nColIni + 255, nLinAtu + 20, nColIni + 255)
			oPrintNot:Line(nLinAtu , nColIni + 333, nLinAtu + 20, nColIni + 333)
			oPrintNot:Line(nLinAtu , nColIni + 410, nLinAtu + 20, nColIni + 410)
			oPrintNot:SayAlign(nLinAtu + 5 , nColIni+ 187, "Total : ", oFontDetN,80,07,nPadLeft)
			oprintNot:SayAlign(nLinAtu + 5, nColIni + 270, "R$" + AllTrim(Transform(nTotVlr,"@E 999,999,999.99"))       , oFontVlrN, 80, 07, nPadRight)
			oprintNot:SayAlign(nLinAtu + 5, nColIni + 345, "R$" + AllTrim(Transform(nTotSld,"@E 999,999,999.99"))       , oFontVlrN, 80, 07, nPadRight)


			If Len(aPDF) > 0
				nG --
			Endif
			nLinAtu += 30
			aCorpoDoc := {}
			aCorpoDoc := fCriaTexto(cTipo,'2')

			If Len(aCorpoDoc) > 0
				For nI := 1 to len(aCorpoDoc)

					nLinAtu += 15

					//Se por acaso atingiu o limite da p�gina, finaliza, e come�a uma nova p�gina
					If nLinAtu >= nLinFin .or. nI == Len(aCorpoDoc) -2 .and. nLinAtu >= 710
						oPrintNot:SayBitmap(nLinAtu-(nLinAtu - 730), nColFin-60, cAssina, 60, 60)
						fImpRod()
						fImpCab()

						nLinAtu := 60
					EndIf
					oprintNot:SayAlign(nLinAtu , nColIni +  35, aCorpoDoc[nI]   , oFontDet, 700, 07, nPadJustif)
				Next nI
				nLinAtu += 05

			Endif

			//Se por acaso atingiu o limite da p�gina, finaliza, e come�a uma nova p�gina
			If nLinAtu >= nLinFin -60
				oPrintNot:SayBitmap(nLinAtu-(nLinAtu - 730), nColFin-60, cAssina, 60, 60)
				fImpRod()
				fImpCab()
				nLinAtu := 60

			EndIf

			// nLinAtu += 40
			// If nLinAtu >= nLinFin
			// 	oPrintNot:SayBitmap(nLinAtu-(nLinAtu - 730), nColFin-60, cAssina, 60, 60)
			// 	fImpRod()
			// 	fImpCab()
			// 	nLinAtu := 60

			//  EndIf
			nLinAtu += 10
			oPrintNot:SayBitmap(nLinAtu, nColIni + 200, cAssina2, 130, 80)

			fImprod()

			oPrintNot:Preview()
			nLinAtu := 0
		Next nG
	Next nJ

	RestArea(aArea)
Return aPDF


/*/{Protheus.doc} fGeraExcel
Criacao do arquivo Excel
@author Eder Fernandes
@since 30/06/2022
@version 1.0
@type function
/*/

Static Function fGeraExcel(aNotifica)

	Local oFWMsExcel
	Local oExcel
	Local cArquivo  := ""
	Local cWorkSheet := "Notificacoes  " + strtran(dtoc(date()),"/","-")
	Local cTitulo    := "Contas a Receber Notificacoes"
	Local nAtual     := 0
	Local nTotal     := 0
	Local nR         := 0
	Local lRetMail   := .F.
	Local lJob       := .F.

	If ProcName(1) == 'U_JOBNOTIF'
		lJob := .T.
		cArquivo := GetNewPar('VL_JOBDIRN','\spool\') + "AFINEXCEL_" + StrTran(dtoc(date()),"/","") + StrTran(Time(),":","") + ".xlsx"
		cTitulo  := "Titulos vencidos h� " + cValtoChar(GetNewPar("VL_DIASNOT",13)) + " dias"
	Else
		cArquivo   := GetTempPath() + "AFINEXCEL_" + StrTran(dtoc(date()),"/","") + StrTran(Time(),":","") + ".xlsx"
	Endif

	//Cria a planilha do excel
	oFWMsExcel := FwMsExcelXlsx():New()

	//Criando a aba da planilha
	oFWMsExcel:AddworkSheet(cWorkSheet)

	//Criando a Tabela e as colunas
	oFWMsExcel:AddTable(cWorkSheet, cTitulo)
	oFWMsExcel:AddColumn(cWorkSheet, cTitulo, "Filial", 1, 1, .F.)           	//[1]
	oFWMsExcel:AddColumn(cWorkSheet, cTitulo, "Titulo", 1, 1, .F.)				//[2]
	oFWMsExcel:AddColumn(cWorkSheet, cTitulo, "Parcela", 1, 1, .F.)				//[3]
	oFWMsExcel:AddColumn(cWorkSheet, cTitulo, "Valor", 1, 1, .F.)				//[4]
	oFWMsExcel:AddColumn(cWorkSheet, cTitulo, "Saldo", 1, 1, .F.)				//[5]
	oFWMsExcel:AddColumn(cWorkSheet, cTitulo, "Emissao", 1, 1, .F.)				//[6]
	oFWMsExcel:AddColumn(cWorkSheet, cTitulo, "Prefixo", 1, 1, .F.)				//[7]
	oFWMsExcel:AddColumn(cWorkSheet, cTitulo, "Cliente", 1, 1, .F.)				//[8]
	oFWMsExcel:AddColumn(cWorkSheet, cTitulo, "Loja", 1, 1, .F.)				//[9]
	oFWMsExcel:AddColumn(cWorkSheet, cTitulo, "Contrado ADC", 1, 1, .F.)		//[10]
	oFWMsExcel:AddColumn(cWorkSheet, cTitulo, "Razao Social", 1, 1, .F.)		//[11]
	oFWMsExcel:AddColumn(cWorkSheet, cTitulo, "Vencimento", 1, 1, .F.)			//[12]
	oFWMsExcel:AddColumn(cWorkSheet, cTitulo, "Nota Fiscal", 1, 1, .F.)			//[13]
	oFWMsExcel:AddColumn(cWorkSheet, cTitulo, "Inicio Periodo", 1, 1, .F.)		//[14]
	oFWMsExcel:AddColumn(cWorkSheet, cTitulo, "Fim Periodo", 1, 1, .F.)			//[15]
	oFWMsExcel:AddColumn(cWorkSheet, cTitulo, "Tipo Titulo", 1, 1, .F.)			//[16]
	oFWMsExcel:AddColumn(cWorkSheet, cTitulo, "Tipo Notificacao", 1, 1, .F.)	//[17]
	oFWMsExcel:AddColumn(cWorkSheet, cTitulo, "Contrato Licitacao", 1, 1, .F.)	//[18]
	oFWMsExcel:AddColumn(cWorkSheet, cTitulo, "Observa��o", 1, 1, .F.) 			//[19]
	oFWMsExcel:AddColumn(cWorkSheet, cTitulo, "Data Gera��o", 1, 1, .F.) 		//[20]
	oFWMsExcel:AddColumn(cWorkSheet, cTitulo, "Dias de Vencto.", 3, 1, .F.) 	//[21]



	//Definindo o tamanho da regua
	nTotal := Len(aNotifica)
	ProcRegua(nTotal)


	For nR := 1 to nTotal

		//Incrementando a regua
		nAtual++
		IncProc("Adicionando registro " + cValToChar(nAtual) + " de " + cValToChar(nTotal) + "...")

		//Adicionando uma nova linha
		oFWMsExcel:AddRow(cWorkSheet, cTitulo, {;
			aNotifica[nR][1],;  //Filial
		aNotifica[nR][2],;  //Titulo
		aNotifica[nR][3],;  //Parcela
		Transform(aNotifica[nR][4],"@E 999,999,999.99"),;  //Valor
		Transform(aNotifica[nR][5],"@E 999,999,999.99"),;  //Saldo
		aNotifica[nR][6],;  //Emissao
		aNotifica[nR][7],;  //Prefixo
		aNotifica[nR][8],;  //Cliente
		aNotifica[nR][9],;  //Loja
		aNotifica[nR][10],; //Contrado ADC
		aNotifica[nR][11],; //Razao Social
		aNotifica[nR][12],; //Vencimento
		aNotifica[nR][13],; //Nota Fiscal
		aNotifica[nR][15],; //Inicio Periodo
		aNotifica[nR][16],; //Fim Periodo
		aNotifica[nR][14],; //Tipo Titulo
		Transform(aNotifica[nR][17],"@R 99|99|99"),; //Tipo Notificacao
		aNotifica[nR][19],; //Contrato Licita��o
		aNotifica[nR][20],; //Observa��o
		aNotifica[nR][21],; //Emiss�o
		DatediffDay(aNotifica[nR][12],date())}) //dias vencidos
	Next nR

	//Ativando o arquivo e gerando o xml
	oFWMsExcel:Activate()
	oFWMsExcel:GetXMLFile(cArquivo)

	//Abrindo o excel e abrindo o arquivo xml
	If !lJob
		oExcel := MsExcel():New()
		oExcel:WorkBooks:Open(cArquivo)
		oExcel:SetVisible(.T.)
		oExcel:Destroy()
	Endif


	_cEmail := GetNewPar("VL_AUTNOT", "recuperacao01@cscresult.com.br")
	If !lJob
		cSubj   := "Rela��o de Notifica��es Geradas"
		cBody   := "<p> Segue em anexo a planilha contendo a rela��o de notifica�oes geradas</p><br><br><br><br><br>"
		cBody   += "<p><b>Automatiza��o de Notifica��es</b></p>"
	Else
		If nTotal > 0
			cSubj   := "Rela��o de Titulos Vencidos"
			cBody   := "<p> Segue em anexo a planilha contendo a rela��o de titulos vencidos h� " + cValtoChar(GetNewPar("VL_DIASNOT",13))+ " dias</p>"
		Else
			cSubj   := "Rela��o de Titulos Vencidos"
			cBody   := "<p> N�o Foram encontrados t�tulos vencidos h� " + cValtoChar(GetNewPar("VL_DIASNOT",13))+ " dias</p>"
		Endif
	Endif

	lRetMail := U_SetMail( _cEmail, cSubj, cBody, {cArquivo},.F.,.F.,.T.,.F.,""  )

Return aNotifica

/*/{Protheus.doc} DtExtenso
fun��o para gerar a data por extenso 
@type function
@version 1.0 		
@author eder.fernandes
@since 10/08/2022
/*/
Static Function DtExtenso(dDataAtual, lAbreviado)

	Local cRetorno := ""

	Default dDataAtual := dDataBase
	Default lAbreviado := .F.

	//Se for da forma abreviada, mostra n�meros
	If lAbreviado
		cRetorno += cValToChar(Day(dDataAtual))
		cRetorno += " de "
		cRetorno += MesExtenso(dDataAtual)
		cRetorno += " de "
		cRetorno += cValToChar(Year(dDataAtual))

		//Sen�o for abreviado, mostra texto completo
	Else
		cRetorno += Capital(Extenso(Day(dDataAtual), .T.))
		cRetorno += " de "
		cRetorno += MesExtenso(dDataAtual)
		cRetorno += " de "
		cRetorno += Capital(Extenso(Year(dDataAtual), .T.))
	EndIf

Return (cRetorno)


/*/{Protheus.doc} zUltNum
Fun��o para incrementar o numero das notifica�oes ordenadas por ano
@type function
@version  1.0
@author eder.fernandes
@since 25/07/2022
/*/
User Function zUltNum(cTab, cCampo, lSoma1)
	Local aArea       := GetArea()
	Local cCodFull    := ""
	//Local cCodAux     := PadL(cValtoChar(year(date())), TamSX3(cCampo)[01], "")
	Local cQuery      := ""
	//Local nTamCampo   := 0
	Local cParCtrl    := GetNewPar("VL_NRCTRL",'2022')
	Default lSoma1    := .T.

	//Definindo o c�digo atual
	//nTamCampo := TamSX3(cCampo)[01]
	cCodAux   := '000000'

	//Fa�o a consulta para pegar as informa��es
	cQuery := " SELECT "
	cQuery += "   NVL(MAX("+cCampo+"), '"+cCodAux+"') AS MAXIMO "
	cQuery += " FROM "
	cQuery += "   "+RetSQLName(cTab)+" TAB "
	cQuery := ChangeQuery(cQuery)
	TCQuery cQuery New Alias "QRY_TAB"

	//Se n�o tiver em branco
	If !Empty(QRY_TAB->MAXIMO)
		cCodAux := QRY_TAB->MAXIMO
	EndIf

	//Se for para atualizar, soma 1 na vari�vel
	If lSoma1
		If cParCtrl <> cValtoChar(year(date()))  .Or. cCodAux == "000000"
			cCodAux := '000001'
			PutMv("VL_NRCTRL",cValtoChar(year(date())))
		Else
			cCodAux := Soma1(cCodAux)
		Endif
	EndIf

	//Definindo o c�digo de retorno
	cCodFull := cCodAux + "/" + cValtoChar(year(date()))

	QRY_TAB->(DbCloseArea())
	RestArea(aArea)
Return cCodFull

/*/{Protheus.doc} JOBNOTIF
Job de notifica��o registros vencids ha um determinado numero de dias
@type function
@version 1.0
@author eder.fernandes
@since 25/07/2022
/*/
User Function JOBNOTIF()

	Local cQryDados := ''
	Local cIDLog    := ''
	Local nTotal    := 0
	Local nAtual    := 0
	Local nSaldo    := 0
	Local nSalTot   := 0
	Local cCliente  := ""
	Local cLoja     := ""
	Local aRegs     := {}
	Local aRegsFil  := {}
	Local aRegsTot  := {}
	Local aRet      := {}
	Local nI        := 0
	Local nJ        := 0
	Local nT        := 0
	Local lRet      := .T.


	If Select("SX6") == 0
		RpcSetType(3)
		RpcSetEnv("01","010101",,,"SIGAFIN")

	Endif

	//Monta a consulta
	cQryDados += " SELECT DISTINCT E1_FILIAL, E1_NUM, E1_EMISSAO, E1_VENCREA, E1_VALOR, E1_PREFIXO, "       	+ CRLF
	cQryDados += " E1_CLIENTE, E1_LOJA, E1_XNRONF, E1_RAZAO, E1_PARCELA, E1_NATUREZ, E1_TIPO, "   				+ CRLF
	cQryDados += " E1_XCTRADC, E1_XINIPER, E1_XFIMPER, E1_XNRONF, E1_VENCORI "                    				+ CRLF
	cQryDados += " FROM " + RETSQLNAME ('SE1') + " E1 "                                            				+ CRLF
	cQryDados += " INNER JOIN " + RETSQLNAME ('ADY') + " ADY ON "                                  				+ CRLF
	cQryDados += " ADY_CODIGO = E1_CLIENTE AND ADY_LOJA = E1_LOJA AND ADY_CTRADC = E1_XCTRADC  "   				+ CRLF
	cQryDados += " AND E1.D_E_L_E_T_ = ADY.D_E_L_E_T_   "                                          				+ CRLF
	cQryDados += " INNER JOIN " + RETSQLNAME ('SA1') + " A1 ON "                                  				+ CRLF
	cQryDados += " A1_COD = E1_CLIENTE AND A1_LOJA = E1_LOJA  "   		                                 		+ CRLF
	cQryDados += " AND A1.D_E_L_E_T_ = E1.D_E_L_E_T_   " 							   							+ CRLF
	cQryDados += " WHERE E1.D_E_L_E_T_ = ' ' AND E1_TIPO = 'NF' AND A1_LICITAD = 'S' AND E1_SALDO > 0 "      	+ CRLF
	cQryDados += " AND E1_VENCORI BETWEEN '" +DTOS(DATE() - GetNewPar("VL_DIASJBN",180)) + "' AND '" + DTOS(DATE() - GetNewPar("VL_DIASNOT",13)) + "'" 	+ CRLF
	cQryDados += " AND E1_PORTADO <> 'DUV' AND ADY.ADY_XEXCES <> '1' "    				     	 				+ CRLF
	cQryDados += " ORDER BY E1_CLIENTE, E1_LOJA, E1_NUM, E1_PARCELA "                          	 				+ CRLF
	PLSQuery(cQryDados, 'QRYDADTMP')

	DbSelectArea('QRYDADTMP')
	Count to nTotal
	//Monitor de Jobs
	cIDLog := U_VALAM20A("JOB NOTIFICACOES DE DEBITO",nTotal,"1") //Inicio do LOG
	U_VALAM20D(cIdLog, nTotal)

	QRYDADTMP->(DbGoTop())

	If !QRYDADTMP->(EoF())

		//Enquanto houver registros, adiciona na tempor�ria
		While ! QRYDADTMP->(EoF())

			nSalTot  := 0
			nAtual++
			//	IncProc('Analisando registro ' + cValToChar(nAtual) + ' de ' + cValToChar(nTotal) + '...')
			DbSelectArea('SE1')
			SE1->(DbSetOrder(2))
			If SE1->(DbSeek(QRYDADTMP->(E1_FILIAL + E1_CLIENTE + E1_LOJA + E1_PREFIXO + E1_NUM + E1_PARCELA + E1_TIPO)))
				nSaldo := SaldoTit(SE1->E1_PREFIXO,SE1->E1_NUM,SE1->E1_PARCELA,SE1->E1_TIPO,SE1->E1_NATUREZ,"R",SE1->E1_CLIENTE,1,,,SE1->E1_LOJA,,0/*nTxMoeda*/)
			Endif
			DbSelectArea('SZA')
			SZA->(DbSetOrder(1))
			If SZA->(DbSeek(QRYDADTMP->(E1_FILIAL + E1_CLIENTE + E1_LOJA + E1_PREFIXO + E1_NUM + E1_PARCELA + E1_TIPO + '1')))

				If !Empty(SZA->ZA_NOTIFIC) .AND. AllTrim(SZA->ZA_NOTIFIC) <> 'JURIDICO'
					lRet := .F.
				Endif

			Endif

			If !lRet
				QRYDADTMP->(DbSkip())
				Loop
			Endif

			If nSaldo > (QRYDADTMP->E1_VALOR * 0.11)

				aadd(aRegs, {QRYDADTMP->E1_FILIAL,;         //[1]
				QRYDADTMP->E1_NUM,; 				//[2]
				QRYDADTMP->E1_PARCELA,;				//[3]
				QRYDADTMP->E1_VALOR,;				//[4]
				nSaldo,;	             			//[5]
				QRYDADTMP->E1_EMISSAO,;				//[6]
				QRYDADTMP->E1_PREFIXO,;				//[7]
				QRYDADTMP->E1_CLIENTE,;				//[8]
				QRYDADTMP->E1_LOJA,;		    	//[9]
				QRYDADTMP->E1_XCTRADC,;				//[10]
				QRYDADTMP->E1_RAZAO,;				//[11]
				QRYDADTMP->E1_VENCORI,;				//[12]
				QRYDADTMP->E1_XNRONF,;				//[13]
				QRYDADTMP->E1_TIPO,;				//[14]
				QRYDADTMP->E1_XINIPER,;				//[15]
				QRYDADTMP->E1_XFIMPER,;				//[16]
				"****",; 							//[17]
				"******" ,;							//[18]
				"**********",;						//[19]
				"**********",;     					//[20]
				Date()})   	    					//[21]

			Endif
			QRYDADTMP->(DbSkip())
		EndDo

		For nI := 1 to Len(aRegs)
			cCliente := aRegs[nI][8]
			cLoja    := aRegs[nI][9]
			aRegsFil := {}
			nSalTot  := 0
			For nJ := 1 to Len(aRegs)
				If  cCliente == aRegs[nJ][8] .And. cLoja == aRegs[nJ][9]
					//cChave := aRegs[nJ][1] + aRegs[nJ][8] + aRegs[nJ][9] + aRegs[nJ][7] + aRegs[nJ][2] + aRegs[nJ][3] + aRegs[nJ][17]

					nPos   := aScan(aRegsFil,{|x| x[1] + x[8] +;
						x[9] + x[7] + x[2] +;
						x[3] + x[17] == aRegs[nJ][1] +;
						aRegs[nJ][8] + aRegs[nJ][9] +;
						aRegs[nJ][7] + aRegs[nJ][2] +;
						aRegs[nJ][3] + aRegs[nJ][17]})
					If nPos <= 0
						aadd(aRegsFil,aRegs[nJ])
						nSalTot += aRegs[nJ][5]
						nI++
					Endif
				Endif
			Next nJ
			If nSalTot > 500
				For nT := 1 to Len(aRegsFil)
					aadd(aRegsTot,aRegsFil[nT])
				Next nT
			Endif
			If Len(aRegsFil) > 0
				nI--
			Endif
		Next nI
	Else
		U_VALAM20B(cIDLog,"","","2","NAO FORAM ENCONTRADOS TITULOS VENCIDOS H� " + cValToChar(GetNewPar("VL_DIASNOT",13)))
	Endif

	aRet := fGeraExcel(aRegsTot)
	U_VALAM20B(cIDLog,"","","2","RELATORIO GERADO COM SUCESSO!!")
	U_VALAM20E(cIDLog,Len(aRet))

	SZA->(DBCloseArea())
	SE1->(DBCloseArea())
	QRYDADTMP->(DbCloseArea())

	U_VALAM20C(cIDLog)

Return



User Function cadobserv()

	Local nAtual	:= 0
	Local nTotMarc  := 0
	Local lRet      := .T.
	Local cMarca    := oMark:Mark()
	Local aArea     := FWGetArea()

	Private oSayTitulo, oGetTiulo, cGetTitulo,  oSayParcela, oGetParcela, cGetParcela, oSayValor, oGetValor, cGetValor, oSayLic, oGetLic,cGetLic
	Private oSaySaldo, oGetSaldo, cGetSaldo, oSayEmissao, oGetEmissao, cGetEmissao, oSayPrefixo, oGetPrefixo, cGetPrefixo, oSayCliente, oGetCliente, cGetCliente
	Private oSayLoja, oGetLoja, cGetLoja, oSayCtradc, oGetCtradc, cGetCtradc, oSayRazao, oGetRazao, cGetRazao, oSayVencto, oGetVencto, cGetVencto
	Private oSayNrnf, oGetNrnf, cGetNrnf, oSayTipo, oGetTipo, cGetTipo, oSayIniper, oGetIniper, cGetIniper, oSayFimper, oGetFimper, cGetFimper, oSayObs, oGetObs, cGetObs
	Private oButtonSalvar, oButtonFechar,oSayUltAlt, oGetUltAlt, cGetUltAlt
	Private oDlg, cGetVersao, cGetNotific
	Private aScrRes := {}
	Private cGetFilial := ""
	//Cabe�alho
	Private oSayModulo, cSayModulo := 'FIN'
	Private oSayTitJan, cSayTitJan := 'Automatiza��o de Notifica��es'
	Private oSaySubTit, cSaySubTit := 'Cadastro de Observa��o'
	//Fontes
	Private cFontUti    := "Tahoma"
	Private oFontMod    := TFont():New(cFontUti, , -38)
	Private oFontSub    := TFont():New(cFontUti, , -20)
	Private oFontSubN   := TFont():New(cFontUti, , -15, , .T.)
	Private oFontBtn    := TFont():New(cFontUti, , -14)
	Private oFontSay    := TFont():New(cFontUti, , -12)


	DbSelectArea(_cAlias)
	(_cAlias)->(DbGoTop())

	While ! (_cAlias)->(EoF())

		nAtual++

		//Caso esteja marcado
		If oMark:IsMark(cMarca)
			nTotMarc++
			If nTotMarc > 1
				MsgStop("Para visualiar a Observa��o somente 1(um) registro deve ser selecionado.")
				Return
			Endif

			dbSelectArea('SZA')
			SZA->(dbSetOrder(1))
			If SZA->(DbSeek((_cAlias)->(E1_FILIAL + E1_CLIENTE + E1_LOJA + E1_PREFIXO + E1_NUM + E1_PARCELA + E1_TIPO + '1')))
				cGetObs     := SZA->ZA_OBS
				cGetVersao  := SZA->ZA_VERSAO
				cGetNotific := SZA->ZA_NOTIFIC
				cGetUltAlt  := SZA->ZA_ULTALT
				cGetLic     := SZA->ZA_CTRLICI

			Endif

			cGetFilial  := (_cAlias)->E1_FILIAL
			cGetTitulo  := (_cAlias)->E1_NUM
			cGetParcela := (_cAlias)->E1_PARCELA
			cGetValor   := (_cAlias)->E1_VALOR
			cGetSaldo   := (_cAlias)->E1_SALDO
			cGetEmissao := (_cAlias)->E1_EMISSAO
			cGetPrefixo := (_cAlias)->E1_PREFIXO
			cGetCliente := (_cAlias)->E1_CLIENTE
			cGetLoja    := (_cAlias)->E1_LOJA
			cGetCtradc  := (_cAlias)->E1_XCTRADC
			cGetRazao   := (_cAlias)->E1_RAZAO
			cGetVencto  := (_cAlias)->E1_VENCORI
			cGetNrnf    := (_cAlias)->E1_XNRONF
			cGetTipo    := (_cAlias)->E1_TIPO
			cGetIniper  := (_cAlias)->E1_XINIPER
			cGetFimper  := (_cAlias)->E1_XFIMPER

		Endif

		(_cAlias)->(dbSkip())
	End

	If nTotMarc == 0
		MsgAlert("N�o foi selecionado um registro para cadastrar observa��o!", "Aten��o!!")
		lRet := .F.
	Endif

	If lRet
		aScrRes    := MsAdvSize(.T.,.F.,nil)
		oDlg       := TDialog():New(aScrRes[7], 0 , aScrRes[6], aScrRes[5], "Notifica��o de D�bitos", , , ,nOr(WS_VISIBLE,WS_POPUP)  , CLR_BLACK, CLR_WHITE, , , .T.,,,,,,.F.)

		//T�tulos e SubT�tulos
		oSayModulo := TSay():New(004, 003, {|| cSayModulo}, oDlg, "", oFontMod,  , , , .T., RGB(149, 179, 215), , 200, 30, , , , , , .F., , )
		oSayTitJan := TSay():New(004, 045, {|| cSayTitJan}, oDlg, "", oFontSub,  , , , .T., RGB(031, 073, 125), , 200, 30, , , , , , .F., , )
		oSaySubTit := TSay():New(015, 045, {|| cSaySubTit}, oDlg, "", oFontSubN, , , , .T., RGB(031, 073, 125), , 300, 30, , , , , , .F., , )


		oSayTitulo  := TSay():New(40 , 05 , {|| 'Titulo' }                                        , oDlg,    ,    ,                                 , ,  , .T., CLR_BLACK, CLR_WHITE, 300, 20)
		oGetTitulo  := TGet():New(50 , 05 , {|u| IIF(Pcount()>0,cGetTitulo:=u,cGetTitulo)}        , oDlg, 50 , 013, PesqPict( 'SE1' , 'E1_NUM' )    , , 0,    ,          , .F.      ,    , .T., , .F., , .F., .F., , .T., .F., , cGetTitulo           , , , ,)

		oSayParcela := TSay():New(40 , 80 , {|| 'Parcela' }                                       , oDlg,    ,    ,                                 , ,  , .T., CLR_BLACK, CLR_WHITE, 300, 20)
		oGetParcela := TGet():New(50 , 80 , {|u| IIF(Pcount()>0,cGetParcela:=u,cGetParcela)}      , oDlg, 30 , 013, PesqPict( 'SE1' , 'E1_PARCELA' ), , 0,    ,          , .F.      ,    , .T., , .F., , .F., .F., , .T., .F., , cGetParcela          , , , ,)

		oSayValor   := TSay():New(40 , 150, {|| 'Valor' }                                         , oDlg,    ,    ,                                 , ,  , .T., CLR_BLACK, CLR_WHITE, 300, 20)
		oGetValor   := TGet():New(50 , 150, {|u| IIF(Pcount()>0,cGetValor:=u,cGetValor)}          , oDlg, 50 , 013, PesqPict( 'SE1' , 'E1_VALOR' )  , , 0,    ,          , .F.      ,    , .T., , .F., , .F., .F., , .T., .F., , cValtoChar(cGetValor), , , ,)

		oSaySaldo   := TSay():New(40 , 230, {|| 'Saldo' }                                         , oDlg,    ,    ,                                 , ,  , .T., CLR_BLACK, CLR_WHITE, 300, 20)
		oGetSaldo   := TGet():New(50 , 230, {|u| IIF(Pcount()>0,cGetSaldo:=u,cGetSaldo)}          , oDlg, 50 , 013, PesqPict( 'SE1' , 'E1_SALDO' )  , , 0,    ,          , .F.      ,    , .T., , .F., , .F., .F., , .T., .F., , cValToChar(cGetSaldo), , , ,)

		oSayEmissao := TSay():New(40 , 310, {|| 'Emiss�o' }                                       , oDlg,    ,    ,                                 , ,  , .T., CLR_BLACK, CLR_WHITE, 300, 20)
		oGetEmissao := TGet():New(50 , 310, {|u| IIF(Pcount()>0,cGetEmissao:=u,dToC(cGetEmissao))}, oDlg, 40 , 013, PesqPict( 'SE1' , 'E1_EMISSAO' ), , 0,    ,          , .F.      ,    , .T., , .F., , .F., .F., , .T., .F., , DtoC(cGetEmissao)    , , , ,)

		oSayPrefixo := TSay():New(40 , 370, {|| 'Prefixo' }                                       , oDlg,    ,    ,                                 , ,  , .T., CLR_BLACK, CLR_WHITE, 300, 20)
		oGetPrefixo := TGet():New(50 , 370, {|u| IIF(Pcount()>0,cGetPrefixo:=u,cGetPrefixo)}      , oDlg, 40 , 013, PesqPict( 'SE1' , 'E1_PREFIXO' ), , 0,    ,          , .F.      ,    , .T., , .F., , .F., .F., , .T., .F., , cGetPrefixo          , , , ,)

		oSayCliente := TSay():New(40 , 430, {|| 'Cliente' }                                       , oDlg,    ,    ,                                 , ,  , .T., CLR_BLACK, CLR_WHITE, 300, 20)
		oGetCliente := TGet():New(50 , 430, {|u| IIF(Pcount()>0,cGetCliente:=u,cGetCliente)}      , oDlg, 40 , 013, PesqPict( 'SE1' , 'E1_CLIENTE' ), , 0,    ,          , .F.      ,    , .T., , .F., , .F., .F., , .T., .F., , cGetCliente          , , , ,)

		oSayLoja    := TSay():New(40 , 480, {|| 'Loja' }                                          , oDlg,    ,    ,                                 , ,  , .T., CLR_BLACK, CLR_WHITE, 300, 20)
		oGetLoja    := TGet():New(50 , 480, {|u| IIF(Pcount()>0,cGetLoja:=u,cGetLoja)}            , oDlg, 40 , 013, PesqPict( 'SE1' , 'E1_LOJA' )   , , 0,    ,          , .F.      ,    , .T., , .F., , .F., .F., , .T., .F., , cGetLoja             , , , ,)

		oSayCtradc  := TSay():New(40 , 530, {|| 'Ctr.ADC' }                                       , oDlg,    ,    ,                                 , ,  , .T., CLR_BLACK, CLR_WHITE, 300, 20)
		oGetCtradc  := TGet():New(50 , 530, {|u| IIF(Pcount()>0,cGetCtradc:=u,cGetCtradc)}        , oDlg, 35 , 013, PesqPict( 'SE1' , 'E1_XCTRADC' ), , 0,    ,          , .F.      ,    , .T., , .F., , .F., .F., , .T., .F., , cGetCtradc           , , , ,)

		oSayRazao   := TSay():New(75 , 05 , {|| 'Raz�o Social' }                                  , oDlg,    ,    ,                                 , ,  , .T., CLR_BLACK, CLR_WHITE, 300, 20)
		oGetRazao   := TGet():New(85 , 05 , {|u| IIF(Pcount()>0,cGetRazao:=u,cGetRazao)}          , oDlg, 200, 013, PesqPict( 'SE1' , 'E1_RAZAO' )  , , 0,    ,          , .F.      ,    , .T., , .F., , .F., .F., , .T., .F., , cGetRazao            , , , ,)


		oSayVencto  := TSay():New(75 , 230, {|| 'Vencimento' }                                    , oDlg,    ,    ,                                 , ,  , .T., CLR_BLACK, CLR_WHITE, 300, 20)
		oGetVencto  := TGet():New(85 , 230, {|u| IIF(Pcount()>0,cGetVencto:=u,cGetVencto)}        , oDlg, 40 , 013, PesqPict( 'SE1' , 'E1_VENCORI' ), , 0,    ,          , .F.      ,    , .T., , .F., , .F., .F., , .T., .F., , DtoC(cGetVencto)     , , , ,)

		oSayNrnf    := TSay():New(75 , 310, {|| 'Nota Fiscal' }                                   , oDlg,    ,    ,                                 , ,  , .T., CLR_BLACK, CLR_WHITE, 300, 20)
		oGetNrnf    := TGet():New(85 , 310, {|u| IIF(Pcount()>0,cGetNrnf:=u,cGetNrnf)}            , oDlg, 40 , 013, PesqPict( 'SE1' , 'E1_XNRONF' ) , , 0,    ,          , .F.      ,    , .T., , .F., , .F., .F., , .T., .F., , cGetNrnf             , , , ,)

		oSayTipo    := TSay():New(75 , 370, {|| 'Tipo' }                                          , oDlg,    ,    ,                                 , ,  , .T., CLR_BLACK, CLR_WHITE, 300, 20)
		oGetTipo    := TGet():New(85 , 370, {|u| IIF(Pcount()>0,cGetTipo:=u,cGetTipo)}            , oDlg, 40 , 013, PesqPict( 'SE1' , 'E1_TIPO' )   , , 0,    ,          , .F.      ,    , .T., , .F., , .F., .F., , .T., .F., , cGetTipo             , , , ,)

		oSayIniper  := TSay():New(75 , 430, {|| 'In�cio Periodo' }                                , oDlg,    ,    ,                                 , ,  , .T., CLR_BLACK, CLR_WHITE, 300, 20)
		oGetIniper  := TGet():New(85 , 430, {|u| IIF(Pcount()>0,cGetIniper:=u,dToC(cGetIniper))}  , oDlg, 40 , 013, PesqPict( 'SE1' , 'E1_XINIPER' ), , 0,    ,          , .F.      ,    , .T., , .F., , .F., .F., , .T., .F., , DtoC(cGetIniper)     , , , ,)

		oSayFimper  := TSay():New(75 , 480, {|| 'Fim Per�odo' }                                   , oDlg,    ,    ,                                 , ,  , .T., CLR_BLACK, CLR_WHITE, 300, 20)
		oGetFimper  := TGet():New(85 , 480, {|u| IIF(Pcount()>0,cGetFimper:=u,dToC(cGetFimper))}  , oDlg, 40 , 013, PesqPict( 'SE1' , 'E1_XFIMPER' ), , 0,    ,          , .F.      ,    , .T., , .F., , .F., .F., , .T., .F., , DtoC(cGetFimper)     , , , ,)

		oSayUltAlt := TSay():New(115, 310, {|| 'Ult.Atualiza��o' }                       , oDlg,   ,    ,                                 , ,  , .T., CLR_BLACK, CLR_WHITE, 300, 20)
		oGetUltAlt := TGet():New(125, 310, {|u| IIF(Pcount()>0,cGetUltAlt:=u,cGetUltAlt)}, oDlg, 80, 013, PesqPict( 'SZA' , 'ZA_ULTALT' ) , , 0,    ,          , .F.      ,    , .T., , .F., , .F., .F., , .T., .F., , cGetUltAlt, , , ,)

		oSayLic    := TSay():New(75 , 530, {|| 'Ctr.Licita��o' }                         , oDlg,   ,    ,                                 , ,  , .T., CLR_BLACK, CLR_WHITE, 300, 20)
		oGetLic    := TGet():New(85, 530, {|u| IIF(Pcount()>0,cGetLic:=u,cGetLic)}      , oDlg, 80, 013, PesqPict( 'SZA' , 'ZA_CTRLICI' ) , , 0,    ,          , .F.      ,    , .T., , .F., , .F., .F., , .T., .F., , cGetLic, , , ,)

		oSayObs     := TSay():New(115, 05 , {|| 'Oberva��o' }                            , oDlg,    ,    ,                                 , ,  , .T., CLR_BLACK, CLR_WHITE, 300, 20)

		//          TMultiGet():New( [ nRow ], [ nCol ], [ bSetGet ], [ oWnd ], [ nWidth ], [ nHeight ], [ oFont ], [ uParam8 ], [ uParam9 ], [ uParam10 ], [ uParam11 ], [ lPixel ], [ uParam13 ], [ uParam14 ], [ bWhen ], [ uParam16 ], [ uParam17 ], [ lReadOnly ], [ bValid ], [ uParam20 ], [ uParam21 ], [ lNoBorder ], [ lVScroll ], [ cLabelText ], [ nLabelPos ], [ oLabelFont ], [ nLabelColor ] )
		oCpoMGet      := tMultiget():New(125, 05 , {|u| IIF(Pcount()>0,cGetObs:=u,cGetObs)}, oDlg, 260            , 92,   , , ,    ,    , .T.)
		oButtonFechar := TButton()  :New(200, 400, "Fechar"                                , oDlg, {|| oDlg:End()}, 40, 15, , , .F., .T., .F., , .F., , , .F.)
		oButtonSalvar := TButton()  :New(200, 470, "Salvar"                                , oDlg, {|| SalvaReg()}, 40, 15, , , .F., .T., .F., , .F., , , .F.)
	EndIf
	If lRet
		oDlg:Activate(,,,.T.)
	Endif
	FWRestArea(aArea)

	fTabtmp(.T., .F.)
	oMark:Refresh(.T.)

Return

Static Function SalvaReg()
	Local aAreaSZA  := GetArea()

	dbSelectArea('SZA')
	SZA->(dbSetOrder(1))
	BEGIN TRANSACTION
		If !SZA->(DbSeek(cGetFilial+ cGetCliente + cGetLoja + cGetPrefixo + cGetTitulo + cGetParcela + cGetTipo + '1'))
			If RecLock('SZA',.T.)
				SZA->ZA_FILIAL  := cGetFilial
				SZA->ZA_VERSAO  := GETSXENUM('SZA','ZA_VERSAO')
				SZA->ZA_TITULO  := cGetTitulo
				SZA->ZA_PARCELA := cGetParcela
				SZA->ZA_VALOR   := cGetValor
				SZA->ZA_SALDO   := cGetSaldo
				SZA->ZA_EMISSAO := cGetEmissao
				SZA->ZA_PREFIXO := cGetPrefixo
				SZA->ZA_CLIENTE := cGetCliente
				SZA->ZA_LOJA    := cGetLoja
				SZA->ZA_CTRADC  := cGetCtradc
				SZA->ZA_NOME    := cGetRazao
				SZA->ZA_VENCTO  := cGetVencto
				SZA->ZA_NFISCAL := cGetNrnf
				SZA->ZA_TIPO    := cGetTipo
				SZA->ZA_INIPER  := cGetIniper
				SZA->ZA_FIMPER  := cGetFimper
				SZA->ZA_NOTIFIC := cGetNotific
				SZA->ZA_VERANT  := cGetVersao
				SZA->ZA_OBS     := cGetObs
				SZA->ZA_ATIVO   := '1'
				SZA->ZA_ULTALT  := DTOC(DATE()) + " " + TIME() + " " + __CUSERID
				SZA->ZA_CTRLICI := cGetLic
				ConfirmSX8()
				SZA->(MsUnlock())
				FwAlertSuccess("Registro gravado com sucesso!","OK!")
			Else
				MsgAlert("N�o foi poss�vel gravar o arquivo")
				DisarmTransaction()
			EndIf
		Else
			If RecLock("SZA",.F.)

				SZA->ZA_OBS    := cGetObs
				SZA->ZA_ULTALT := DTOC(DATE()) + " " + TIME() + " " + __CUSERID
				SZA->ZA_CTRLICI := cGetLic

				MsUnlock("SZA")
				FwAlertSuccess("Registro alterado com sucesso!","OK!")
			Endif
		Endif
	End Transaction
	SZA->(dbCloseArea())
	RestArea(aAreaSZA)
	oDlg:End()

Return


User Function GrvCtrLi()

	Local aArea     := FWGetArea()

	Private oSayTitJan, cSayTitJan := 'Adiciona Contrato Licita��o'
	Private cGetLic
	Private oDlg, oSayLic
	Private cFontUti    := "Tahoma"
	Private oFontMod    := TFont():New(cFontUti, , -38)
	Private oFontSub    := TFont():New(cFontUti, , -15)
	Private oFontSubN   := TFont():New(cFontUti, , -15, , .T.)
	Private oFontBtn    := TFont():New(cFontUti, , -14)
	Private oFontSay    := TFont():New(cFontUti, , -12)


	oDlg       :=  MSDialog():New(180,180,400,550,'Contrato Licita��o',,,,,CLR_BLACK,CLR_WHITE,,,.T.)

	//T�tulos e SubT�tulos
	oSayTitJan := TSay()   :New(004, 020, {|| cSayTitJan}                         , oDlg, ""                   , oFontSub,                                 , ,  , .T., RGB(031, 073, 125),          , 200, 30 , ,    ,    ,    ,    , .F.,    ,)
	oSayLic    := TSay()   :New(025, 020, {|| 'Nr.Contrato Licita��o' }           , oDlg,                      ,         ,                                 , ,  , .T., CLR_BLACK         , CLR_WHITE, 300, 20)
	cGetLic    :=  Space(TamSX3("ZA_CTRLICI")[1])
	oGetLic    := TGet()   :New(035, 020, {|u| IIF(Pcount()>0,cGetLic:=u,cGetLic)}, oDlg, 80                   , 013     , PesqPict( 'SZA' , 'ZA_CTRLICI' ), , 0,    ,                   , .F.      ,    , .T., , .F.,    , .F., .F.,    , .F., .F., , cGetLic, , , ,)
	oButton1   := TButton():New(080, 020, "Fechar"                                , oDlg, {||  oDlg:End()}      , 40      , 15                              , ,  , .F., .T.               , .F.      ,    , .F., ,    , .F.)
	oButton2   := TButton():New(080, 120, "Salvar"                                , oDlg, {|| SalvCtr(AllTrim(cGetLic))}, 40      , 15                              , ,  , .F., .T.               , .F.      ,    , .F., ,    , .F.)

	oDlg:Refresh()
	oDlg:Activate(,,,.T.)

	FWRestArea(aArea)

	fTabtmp(.T.,.F.)
	oMark:Refresh(.T.)
Return



/*/{Protheus.doc} SalvCtr
Fun��o para gravar o numero do contrato licitatorio na tabela sza
@type function
@version 12.1.23
@author eder.fernandes
@since 04/10/2022
/*/
Static Function SalvCtr(cGetLic)

	Local nAtual	:= 0
	Local nTotMarc  := 0
	Local lRet      := .T.
	Local cMarca    := oMark:Mark()
	Local aArea     := FWGetArea()
	Local cVerAnt   := ""
	Local cGetNotific := ""

	Begin Transaction

		DbSelectArea(_cAlias)
		(_cAlias)->(DbGoTop())

		While ! (_cAlias)->(EoF())

			nAtual++

			//Caso esteja marcado
			If oMark:IsMark(cMarca)
				nTotMarc++
				cVerAnt     := ""
				cGetNotific := ""
				cGetObs     := ""

				dbSelectArea('SZA')
				SZA->(dbSetOrder(1))
				If SZA->(DbSeek((_cAlias)->(E1_FILIAL + E1_CLIENTE + E1_LOJA + E1_PREFIXO + E1_NUM + E1_PARCELA + E1_TIPO + '1')))
					cVerAnt     := SZA->ZA_VERSAO
					cGetNotific := SZA->ZA_NOTIFIC
					cGetObs     := SZA->ZA_OBS
					If RecLock('SZA',.F.)
						SZA->ZA_ATIVO := '2'
						SZA->(MsUnlock())
					Else
						lRet := .F.
						u_myconout('Nao foi possivel alterar o status do registro na SZA')
					EndIf


				Endif

				If RecLock('SZA',.T.)
					SZA->ZA_FILIAL  := (_cAlias)->E1_FILIAL
					SZA->ZA_VERSAO  := GETSXENUM('SZA','ZA_VERSAO')
					SZA->ZA_TITULO  := (_cAlias)->E1_NUM
					SZA->ZA_PARCELA := (_cAlias)->E1_PARCELA
					SZA->ZA_VALOR   := (_cAlias)->E1_VALOR
					SZA->ZA_SALDO   := (_cAlias)->E1_SALDO
					SZA->ZA_EMISSAO := (_cAlias)->E1_EMISSAO
					SZA->ZA_PREFIXO := (_cAlias)->E1_PREFIXO
					SZA->ZA_CLIENTE := (_cAlias)->E1_CLIENTE
					SZA->ZA_LOJA    := (_cAlias)->E1_LOJA
					SZA->ZA_CTRADC  := (_cAlias)->E1_XCTRADC
					SZA->ZA_NOME    := (_cAlias)->E1_RAZAO
					SZA->ZA_VENCTO  := (_cAlias)->E1_VENCORI
					SZA->ZA_NFISCAL := (_cAlias)->E1_XNRONF
					SZA->ZA_TIPO    := (_cAlias)->E1_TIPO
					SZA->ZA_INIPER  := (_cAlias)->E1_XINIPER
					SZA->ZA_FIMPER  := (_cAlias)->E1_XFIMPER
					SZA->ZA_NOTIFIC := cGetNotific
					SZA->ZA_OBS     := cGetObs
					SZA->ZA_ULTALT  := DTOC(DATE()) + " " + TIME() + " " + __CUSERID
					SZA->ZA_VERANT  := cVerAnt
					SZA->ZA_ATIVO   := '1'
					SZA->ZA_CTRLICI := AllTrim(cGetLic)
					ConfirmSX8()
					SZA->(MsUnlock())

				Else
					u_myconout('Nao foi posivel gravar o Numero do contrato!')
					lRet := .F.
				Endif


			Endif

			(_cAlias)->(dbSkip())
		End

		If nTotMarc == 0
			MsgAlert("N�o foi selecionado um registro para inserir o numero do contrato!", "Aten��o!!")
			lRet := .F.
		Endif
		If !lRet
			DisarmTransaction()
		Endif
	End Transaction
	If lRet
		FwAlertSuccess("Registros gravados com sucesso!!","OK!")
	Endif
	cGetLic := ""

	FWRestArea(aArea)
	oDlg:End()

Return



Static Function fImpCab(/*aCliente,cNotifica*/)

	Local nLinCab     := 005
	Local cBarrSup    := GetNewPar("VL_BARSUPN","\notificacoes\barra_superior.png")
	//Iniciando P�gina
	oPrintNot:StartPage()
	oPrintNot:SayBitmap(nLinCab, nColIni-27,cBarrSup, 270, 025)

	nLinAtu := nLinCab


Return



/*/{Protheus.doc} fImpRod
fun��o para impressao do rodape
@type function
@version 1.0 
@author eder.fernandes
@since 06/10/2022
/*/
Static Function fImpRod()

	Local nLinRod:= nLinFin + 15
	Local cPagina := ""


	//Dados da Esquerda
	oprintNot:SayAlign(nLinRod, nColIni     ,    GetNewPar("VL_RODNFL1","55| 34 32390500 www.valecard.com.br "), oFontRod, 400, 07,CLR_BLUE , nPadLeft, )
	oprintNot:SayAlign(nLinRod + 15 , nColIni,    GetNewPar("VL_RODNFL2","Avenida Jacarand�, 200. Jaragu�, Uberl�ndia - MG - CEP 38413069 "), oFontRod, 400, 07,CLR_BLUE , nPadLeft, )
	oprintNot:SayAlign(nLinRod + 30, nColIni,    GetNewPar("VL_RODNFL3","CNPJ 00.604.122/0001-97"), oFontRod, 400, 07,CLR_BLUE , nPadLeft, )

	//Direita
	cLogoEmp  := GetNewPar("VL_LGRODNO","\logo\LGMID01010101.png")
	cCarimbo  := GetNewPar("VL_CARNOTI","\notificacoes\carimbo.png")
	cBarrInf  := GetNewPar("VL_BARINFN","\notificacoes\barra_inferior.png")
	cPagina   := "P�gina "+cValToChar(nPagAtu)
	oPrintNot:SayAlign(nLinRod+50, nColFin-40, cPagina, oFontPag, 040, 07, , nPadRight, )
	oPrintNot:SayBitmap(nLinRod, nColFin-100, cLogoEmp, 070, 60)
	oPrintNot:SayBitmap(nLinRod+3, nColFin-180, cCarimbo, 054, 054)
	oPrintNot:SayBitmap(nLinRod+70, nColIni-27, cBarrInf, 290, 005)

	//Finalizando a p�gina e somando mais um
	oPrintNot:EndPage()
	nPagAtu++
Return



/*/{Protheus.doc} fCriaTexto
Fun��o para criar o texto a ser inserido no corpo do documento
@type function
@version  1.0
@author eder.fernandes
@since 05/10/2022
/*/
Static Function fCriaTexto(cTipo,cBody)

	Local aTexto    := {}
	Local cEmailRec  := GetNewPar("VL_NOTMREC","recuperacaodecredito@valecard.com.br")

	If cBody == '1'

		IF cTipo == '01' //notifica��o de empenho

			aadd(aTexto, space(6) + "	A  par  de  cumpriment�-lo,  vimos  pela  presente  expor  e requerer o que segue:")
			aadd(aTexto, "" )
			aadd(aTexto, space(6) + "1.   Inicialmente   insta   salientar   que   existem   faturas   em   aberto pertinentes   a   servi�os   e ")
			aadd(aTexto," consumos  realizados   por   este   ente,   que   embora  em   tese   estejam  em  conson�ncia  com  o  ")
			aadd(aTexto,"prazo legal de 90 dias para quita��o conforme  a  Lei  de  Licita��es e Contratos  Administrativos, tem ")
			aadd(aTexto,"causado in�meros transtornos a  empresa  Oficiante, pois obriga a  mesma a literalmente financiar  as  ")
			aadd(aTexto,"atividades p�blicas.")
			aadd(aTexto,"")
			aadd(aTexto,  space(6) + "2.	Desta  forma,  tendo   em   vista   os  princ�pios  que  regem  a  administra��o  p�blica,  � saber,")
			aadd(aTexto,"continuidade,   publicidade   moralidade   e   efici�ncia,   a  Oficiantesolicita   formalmente  que  sejam   ")
			aadd(aTexto,"encaminhadas   ao  nosso  escrit�rio   matriz  (cujo   endere�o   consta   na   nota   de  rodap�)   e/ou  ")
			aadd(aTexto,"pelo   e-mail: " + cEmailRec + " , em   prazo  n�o   superior   a  24 horas, c�pia")
			aadd(aTexto," das  notas  de  empenho  pertinentes  as  Notas  Fiscais  de  servi�os prestados  e  suas respectivas ")
			aadd(aTexto,"liquida��es, sejam  vencidas  ou  vincendas at�  o  ano  de, " +cValtoChar(Year(Date())) + " , que  n�o foram(em)  devidamente ")
			aadd(aTexto,"quitadas, � saber: " )

		ElseIf cTipo == '02' //notifica�ao de debitos

			aadd(aTexto,"1.	" + space(6) + "A  par   de   cumpriment�-lo,  vimos    pela   presente  informar   a   exist�ncia   de  d�bitos  de")
			aadd(aTexto,"responsabilidade deste �rg�o para com  nossa  empresa,  decorrente   do   contrato   em   ep�grafe.")
			aadd(aTexto,"")
			aadd(aTexto,"2.	" +  space(6) + "	Nos   termos    do    contrato    supra,    po    �bvio,  uma  das  obriga��es  do   Contratante   � ")
			aadd(aTexto,"efetuar   o   pagamento   �   Contratada.   Contudo,   existem   em  aberto,  valores   a serem  pagos ")
			aadd(aTexto," por   esse   �rg�o   �   Notificante,  referentes   �s  notas   fiscais   abaixo   relacionadas:")


		ElseIf cTipo == '03'  // notifica��o sem citar bloqueio

			aadd(aTexto,"1.	" + space(6) + "A  par   de   cumpriment�-lo,  vimos    pela   presente  informar   a   exist�ncia   de  d�bitos  de")
			aadd(aTexto,"responsabilidade deste �rg�o para com  nossa  empresa,  decorrente   do   contrato   em   ep�grafe.")
			aadd(aTexto,"")
			aadd(aTexto,"2.	" +  space(6) + "	Nos   termos    do    contrato    supra,    po    �bvio,  uma  das  obriga��es  do   Contratante   � ")
			aadd(aTexto,"efetuar   o   pagamento   �   Contratada.   Contudo,   existem   em  aberto,  valores   a serem  pagos ")
			aadd(aTexto," por   esse   �rg�o   �   Notificante,  referentes   �s  notas   fiscais   abaixo   relacionadas:")


		Endif

	ElseIf cBody == '2'

		IF cTipo == '01' //notifica�ao de empenho

			aadd(aTexto, space(6) + "3. Como  se  sabe, o  empenho �  o  primeiro  est�gio  de  um  processo  de   pagamento  da " )
			aadd(aTexto, "Administra��o P�blica, pelo qual � feita a reserva de dota��o or�ament�ria para um determinado" )
			aadd(aTexto, "fim,  criando  a  obriga��o  de  pagamento  para  o  Estado. �  uma  garantia   para  o  contratado" )
			aadd(aTexto, "de que existe recurso or�ament�rio para liquidar aquela despesa." )
			aadd(aTexto, "" )
			aadd(aTexto, space(6) + "4. O art. 58 da Lei n� 4.320/1964, que  trata  do or�amento p�blico, assim  define o empenho:" )
			aadd(aTexto, "" )
			aadd(aTexto, space(45) + "Art. 58. O  empenho  de  despesa  �  o  ato  emanado de  autoridade" )
			aadd(aTexto, space(45) + "competente   que   cria   para   o  Estado  obriga��o   de  pagamento" )
			aadd(aTexto, space(45) + "pendente ou n�o de implemento de condi��o." )
			aadd(aTexto, "" )
			aadd(aTexto,  space(45) + "Quando � feito o empenho, � deduzido aquele valor da respectiva" )
			aadd(aTexto,  space(45) + "dota��o   or�ament�ria,  impedindo  que  aquele   montante  fique" )
			aadd(aTexto,  space(45) + "dispon�vel para outra finalidade.")
			aadd(aTexto, "" )
			aadd(aTexto, space(6) + "5.O  documento  que  materializa  o  empenho  �  a Nota de Empenho. Para que fique bem" )
			aadd(aTexto, "claro:  �Empenho�  � um ato, enquanto a  �Nota  de  Empenho�  �  um   documento.  Para cada  " )
			aadd(aTexto, "empenho dever�  ser  emitida   uma   Nota  de  Empenho,  por  determina��o  do  artigo 61 da" )
			aadd(aTexto, "Lei  n� 4.320/1964:" )
			aadd(aTexto, "" )
			aadd(aTexto,  space(45) + "Art. 61.  Para   cada   empenho   ser�   extra�do   um   documento" )
			aadd(aTexto,  space(45) + "denominado �nota de empenho� que indicar� o nome do credor, a" )
			aadd(aTexto,  space(45) + "representa��o e  a import�ncia da despesa bem como a dedu��o")
			aadd(aTexto,  space(45) + "desta do saldo da dota��o pr�pria.")
			aadd(aTexto, "" )
			aadd(aTexto, space(6) + "6. A Nota  de  Empenho  dever�   ser  emitida  ap�s homologado  o resultado  da licita��o" )
			aadd(aTexto, "e antes da assinatura do contrato. Em alguns casos a Nota  de Empenho substitui  o  pr�prio" )
			aadd(aTexto, " instrumento contratual, como estabelece o artigo 62 da Lei n� 8.666/1993:" )
			aadd(aTexto, "" )
			aadd(aTexto,  space(45) + "Art. 62. O instrumento  de   contrato   �   obrigat�rio  nos  caso  de" )
			aadd(aTexto,  space(45) + "concorr�ncia e de tomada de pre�os, bem como nas dispensas  e " )
			aadd(aTexto,  space(45) + "inexigibilidades cujos pre�os  estejam compreendidos  nos  limites")
			aadd(aTexto,  space(45) + "destas duas modalidades de  licita��o,  e  facultativo  nos  demais ")
			aadd(aTexto,  space(45) + "em que a Administra��o puder substitu�-lo por outros instrumentos")
			aadd(aTexto,  space(45) + "h�beis,  tais  como  carta-contrato,  nota de empenho de despesa,")
			aadd(aTexto,  space(45) + "autoriza��o de compra ou ordem de execu��o de servi�o.")
			aadd(aTexto, "" )
			aadd(aTexto,  space(45) + "[�]")
			aadd(aTexto, "" )
			aadd(aTexto,  space(45) + "� 2� Em carta contrato, nota de empenho de despesa, autoriza��o")
			aadd(aTexto,  space(45) + "de compra, ordem de execu��o de servi�o ou outros instrumentos")
			aadd(aTexto,  space(45) + "h�beis aplica-se, no que  couber, o disposto no art. 55  desta lei.")
			aadd(aTexto, "" )
			aadd(aTexto, space(6) + "7. Dessa forma, eventual inadimplemento futuro do que tiver sido  empenhado  e  liquidado" )
			aadd(aTexto, "gera direito adquirido ao recebimento, que dever� ocorrer de acordo com a  ordem cronol�gica" )
			aadd(aTexto, "de apresenta��o das faturas ao ente p�blico. O descumprimento  dessa  sistem�tica  ensejar�" )
			aadd(aTexto, "a   responsabilidade   penal   do  servidor   respons�vel   pela  quebra  injustificada   da  ordem ")
			aadd(aTexto, "cronol�gica e a possibilidade de ser proposta a��o de execu��o contra o ente p�blico, inclusive " )
			aadd(aTexto, "com penhora judicial do  dinheiro p�blico reservado para aquele pagamento, podendo ainda na " )
			aadd(aTexto, "fase  preliminar  ser  considerada  como  quebra  unilateral  das  obriga��es  contratadas, o que ")
			aadd(aTexto, "poder� ensejar  a paralisa��o dos servi�os prestados pela Oficiante." )
			aadd(aTexto, "" )
			aadd(aTexto, space(6) + "8. Essa   sistem�tica   acabar�   por  implementar  tamb�m  o  artigo 5� da Lei de Licita��es " )
			aadd(aTexto, "(Lei 8666/93), que estabelece a necessidade de obedi�ncia �" )
			aadd(aTexto, "" )
			aadd(aTexto,  space(45) + "estrita  ordem  cronol�gica  das  datas  de  suas  exigibilidades, salvo")
			aadd(aTexto,  space(45) + "quando presentes relevantes raz�es de interesse p�blico e mediante")
			aadd(aTexto,  space(45) + "pr�via justificativa da autoridade competente, devidamente publicada.")
			aadd(aTexto, "" )
			aadd(aTexto, space(6) + "9. Ainda  atrair�   as  puni��es  do  artigo  92,  em  caso  de  descumprimento  desta ordem " )
			aadd(aTexto, "cronol�gica, estabelecida em  deten��o  de  dois a quatro anos, al�m de multa,  o  que alcan�a" )
			aadd(aTexto, "inclusive as pessoas/empresas benefici�rias desse ato." )
			aadd(aTexto, "" )
			aadd(aTexto, space(6) + "10. Esse  � mais  um  dos  v�rios  argumentos que justifica  o  procedimento �tico  e  jur�dico" )
			aadd(aTexto, "em tela propiciando a empresa Oficiante, caso ocorra inadimplemento, a execu��o, com penhora" )
			aadd(aTexto, "dos  valores  empenhados, e n�o processo  ordin�rio  de cobran�a,  que  acaba  por  colocar   os " )
			aadd(aTexto, "cr�ditos  em  uma  penosae  tortuosa  via  judicial sem fim e que culmina  na  tortura q ue �  o uso " )
			aadd(aTexto, "deturpado do sistema de precat�rios." )
			aadd(aTexto, "" )
			aadd(aTexto, space(6) + "11. Dentro  desse  contexto  conv�m  destacar  norma  jur�dica   encartada  no  caput do art. " )
			aadd(aTexto, "5� da Lei n� 8.666/93, servindo de instrumento  para compelir, mesmo  que  de  maneira obl�qua," )
			aadd(aTexto, "a Administra��o a honrar os seus compromissos contratuais." )
			aadd(aTexto, "" )
			aadd(aTexto, space(6) + "12. Assim, apenas estamos solictando o cumprimento das normas de execu��o de despesas " )
			aadd(aTexto, " previstas na Lei n� 4.320/64 e as normas da Lei de Responsabilidade Fiscal (Lei Complementar" )
			aadd(aTexto, " n� 101/00). Como  apontado,  em  linha  de  s�ntese  final,  o contrato deve  ser  antecedido  de" )
			aadd(aTexto, "  previs�o or�ament�ria  e do respectivo  empenho  e  liquida��o (arts.  58, 60  e  61   da  Lei   n� " )
			aadd(aTexto, " 4.320/64)." )
			aadd(aTexto, "" )
			aadd(aTexto, space(6) + "13.  Ou  seja,   em    princ�pio,    o   recurso   or�ament�rio   fica  vinculado   ao  contrato,  n�o" )
			aadd(aTexto, "podendo  ser  empregado para outras coisas (par�grafo  �nico do art. 8�  da  Lei   Complementar" )
			aadd(aTexto, "n� 101/00). Assim  a  Administra��o  dever� dispor dos recursos para pagar a empresa  Oficiante." )
			aadd(aTexto, "Se n�o dispor, � porque ocorreu algo  de  excepcional , o que precisa ser justificado." )
			aadd(aTexto, "" )
			aadd(aTexto, space(6) + "14. A doutriana e a jurisprud�ncia  s�o  unanimes  em  sinalizar  que a  empresas  privadas" )
			aadd(aTexto, "e os �rg�os de controle podem e devem acompanhar esse tr�mite or�ament�rio, para fiscalizar-" )
			aadd(aTexto, "lhe e, eventualmente, constatando  alguma  irregularidade,   tomar   as   provid�ncias   cab�veis." )
			aadd(aTexto, "Ainda   tal   solicta��o   encontra   guarida   na  Lei   de  Transpar�ncia  e Acesso  a Informa��o." )
			aadd(aTexto, "" )
			aadd(aTexto, space(6) + "15. De toda sorte, ao final do exerc�cio, se n�o houver recursos para quitar  as  obriga��es" )
			aadd(aTexto, "contratuais, a Administra��o deve inscrever os valores em aberto em restos a pagar (art. 36 da" )
			aadd(aTexto, "Lei n� 4.320/64). E, na mesma linha, fazer  previs�es  or�ament�rias   para  que  o  valor   seja" )
			aadd(aTexto, "pago no exerc�cio seguinte (art. 36 da Lei n� 4.320/64). " )
			aadd(aTexto, "" )
			aadd(aTexto, space(6) + "16. Infelizmente, n�o  �  raro  que  os  pedidos  administrativos  como  o e m tela,  sejam" )
			aadd(aTexto, "ignorados pela Administra��o, que, pura  e  simplesmente, n�o os responde. Desta forma,  o" )
			aadd(aTexto, "Oficiante  j�  deixa  consignado  que  caso  n�o receba tais documentos, no prazo apontado," )
			aadd(aTexto, "tomar�  as  medidas  cautelares  visando  a  prote��o   de  seus  direitos,  inclusive  vindo  a" )
			aadd(aTexto, "considerar  a  quebra  unilateral   das  obriga��es   contratadas,  o  que  poder�   ensejar   a  " )
			aadd(aTexto, "paralisa��o dos servi�os prestados pela Oficiante." )
			aadd(aTexto, "" )
			aadd(aTexto, space(6) + "17. Certo de quer seremos devidamente atendidos em  nosso  pleito, tudo conforme  a  lei" )
			aadd(aTexto, "determina, aproveitamos o ensejo para reiterar votos de eleva estima." )
			aadd(aTexto, "" )


		ElseIf cTipo == '02'  //notifica�ao de debitos

			aadd(aTexto, "3." +   space(6)+ " A     manuten��o     do     equil�brio      entre     as     partes     e   entre   as   presta��es     e" )
			aadd(aTexto, "contrapresta��es   �   requisito   essencial   para   o   alcance   da   fun��o   social   dos   contratos,  " )
			aadd(aTexto, "impedindo    que     sejam     transformados    em     instrumentos   par    as   atividades    abusivas," )
			aadd(aTexto, "causando   danos  �  parte contr�ria  ou  a   terceiros." )
			aadd(aTexto, "" )
			aadd(aTexto, "4." +   space(6) + " A preocupa��o  do legislador   no   que   tange   ao   exerc�cio  da  justi�a  nos pagamentos" )
			aadd(aTexto, "�   t�o   evidente   que,    ao    dispor    sobre    a     aplica��o     da    Lei    8.666,    ressalva-se  a" )
			aadd(aTexto, "necessidade   de   efetuar   o   acerto com base  na ordem  temporal, raz�o pela qual esse �rg�o" )
			aadd(aTexto, "dever�   quitar   o   montante   devido   �   Valecard,   de   acordo   com   a  ordem cronol�gica da" )
			aadd(aTexto, "d�vida,   sob   pena   de    ferir    expressamente  o  artigo   5�   da  lei 8.666  e  incorrer  no  crime" )
			aadd(aTexto, "previsto no Art. 337-H, do C�digo Penal." )
			aadd(aTexto, "" )
			aadd(aTexto, "5. " +  space(6) + " Desta  forma, considerando  os valores  em  aberto,  e  a  presente  para NOTIFICAR este" )
			aadd(aTexto, "�rg�o a efetuar o pagamento  em   at�   48  ( quarenta  e  oito )   horas,   contadas  a   partir   do" )
			aadd(aTexto, "recebimento  desta,  sob  pena   de  n�o  disponibiliza��o  de  novos   cr�ditos,  tendo   em  vista" )
			aadd(aTexto, "que  a  rede  j�  foi  paga, ou seja, mesmo sob as  diversas situa��es  de  inadimpl�ncia    desse" )
			aadd(aTexto, "�rg�o,  esta  empresa  em   nenhum    momento   deixou   de  efetuar   o   pagamento   �    rede" )
			aadd(aTexto, "credenciada." )
			aadd(aTexto, "" )
			aadd(aTexto, "6. " +  space(6) + " H�  que   se   destacar  que  n�o  est� compreendido no objeto do contrato a outorga de " )
			aadd(aTexto, "cr�dito  ao  �rg�o, mas apenas  e   t�o-somente  o  servi�o   de   gest�o  de  frota   como  meio" )
			aadd(aTexto, "de  pagamento." )
			aadd(aTexto, "" )
			aadd(aTexto, "7. " +  space(6) + "  Al�m  disso   devemos   destacar   que   a  empresa   Trivale  Institui��o de Pagamentos " )
			aadd(aTexto, "Ltda.  �,  em  sua  ess�ncia,   uma   institui��o   de  arranjo  de  pagamento   conforme  a  novel" )
			aadd(aTexto, "denomina��o  prevista  na  Lei n. 12.865/13,  arts.  6�   e  ss.,  que alterou as regras do Sistema" )
			aadd(aTexto, "de  Pagamentos  Brasileiro." )
			aadd(aTexto, "" )
			aadd(aTexto, "8. " + space(6) + " Tais  institui��es   se   tratam  das   pessoas   jur�dicas   respons�veis  pelos  chamados  " )
			aadd(aTexto, "arranjos   de   pagamentos,   que,   por   sua   vez,   s�o  a  sequ�ncia  de  procedimentos  que" )
			aadd(aTexto, "envolvem  a oferta de servi�os  de  circula��o   de  moeda   ao   p�blico,   como   s�o  os casos" )
			aadd(aTexto, "de cart�es de cr�dito, cart�o de d�bito  e  moedas eletr�nicas,  bem  como  �  o caso  da desta" )
			aadd(aTexto, "empresa. " )
			aadd(aTexto, "" )
			aadd(aTexto, "9. " +  space(6) + " O  artigo  12,   inciso   I ,  da  Lei n.  12.865/13  �  expl�cito quanto � evidente separa��o   " )
			aadd(aTexto, "entre  os  patrim�nios   das   empresas   de   arranjos  de   pagamentos   e  o   patrim�nio  dos" )
			aadd(aTexto, "�rg�os  P�blicos,  raz�o  pela  qual  temos  que  o  contrato  n�o  compreende  a  outorga  de " )
			aadd(aTexto, "cr�dito   como   tamb�m   a   legisla��o   de   reg�ncia   pro�be   expressamente   a    confus�o " )
			aadd(aTexto, "patrimonial  entre  os  valores  em  tr�nsito  na  rede  e  aqueles  das  presta��es  de  servi�os. " )
			aadd(aTexto, "" )
			aadd(aTexto, "10. " +  space(6) + " Cumpre  salientar  que  as  suspens�es  decorrentes  da  n�o  observ�ncia  ao prazo " )
			aadd(aTexto, "para  pagamento   ora   concedido   correspondem   apenas  ao   consumo  dos  ve�culos,  ou " )
			aadd(aTexto, "seja,  ao  tr�fego  de valores, posto que as  demais  atividades  inerentes  as  presta��es   de " )
			aadd(aTexto, "servi�os  da  Contratada,   como   disponibiliza��o   do   sistema   e   do   site,  permanecer�o  " )
			aadd(aTexto, "ativas,  mesmo   diante   do   inadimplemento  do  Contratante,  observando a  regrado  legal. " )
			aadd(aTexto, "de 90 (noventa) dias. " )
			aadd(aTexto, "" )
			aadd(aTexto, "11. " +  space(6) + " Ressaltamos  por  oportuno  que,  caso  o  pagamento   n�o  seja  efetuado  no  prazo " )
			aadd(aTexto, "estabelecido,  acionaremos     os   �rg�os   de   Controle    competentes,    para   que    sejam" )
			aadd(aTexto, "apuradas as ofensas ao artigo 5�  da Lei  8.666/93  e  artigo  337-H   do C�digo  Penal,  sendo" )
			aadd(aTexto, "tomadas  todas  as  medidas  judiciais  cab�veis  ao  caso  concreto." )
			aadd(aTexto, "" )
			aadd(aTexto, "12. " +  space(6)+ " Informamos  que  caso  queira  apresentar  resposta  a   essa  notifica��o,   deve ser " )
			aadd(aTexto, "direcionada  aos  cuidados   do   Setor   de   Recupera��o de Cr�dito  desta   empresa,   cujo " )
			aadd(aTexto, "endere�o � Avenida Jacarand�, n� 200. Bairro Jaragu�, Uberl�ndia � MG,  CEP  38.413-069." )
			aadd(aTexto, "" )
			aadd(aTexto, "13. " + space(6) + " Caso    j�    tenha    efetuado    o    pagamento,    favor   desconsiderar    a    presente  " )
			aadd(aTexto, "correspond�ncia. " )


		ElseIf cTipo == '03'  //notifcia�ao sem citar bloqueio

			aadd(aTexto, "3." +   space(6)+ " A     manuten��o     do     equil�brio      entre     as     partes     e   entre   as   presta��es     e" )
			aadd(aTexto, "contrapresta��es   �   requisito   essencial   para   o   alcance   da   fun��o   social   dos   contratos,  " )
			aadd(aTexto, "impedindo    que     sejam     transformados    em     instrumentos   par    as   atividades    abusivas," )
			aadd(aTexto, "causando   danos  �  parte contr�ria  ou  a   terceiros." )
			aadd(aTexto, "" )
			aadd(aTexto, "4." +   space(6) + " A preocupa��o  do legislador   no   que   tange   ao   exerc�cio  da  justi�a  nos pagamentos" )
			aadd(aTexto, "�   t�o   evidente   que,    ao    dispor    sobre    a     aplica��o     da    Lei    8.666,    ressalva-se  a" )
			aadd(aTexto, "necessidade   de   efetuar   o   acerto com base  na ordem  temporal, raz�o pela qual esse �rg�o" )
			aadd(aTexto, "dever�   quitar   o   montante   devido   �   Valecard,   de   acordo   com   a  ordem cronol�gica  da" )
			aadd(aTexto, "d�vida,   sob   pena   de    ferir    expressamente  o  artigo   5�   da  lei 8.666  e  incorrer  no  crime" )
			aadd(aTexto, "previsto no Art. 337-H, do C�digo Penal." )
			aadd(aTexto, "" )
			aadd(aTexto, "5. " +  space(6) + " Desta  forma,  considerando   os   valores  em  aberto,   e   a  presente   para  NOTIFICAR" )
			aadd(aTexto, "este  �rg�o   a informar as programa��es  de  pagamentos  para  quita��o  do  d�bito." )
			aadd(aTexto, "" )
			aadd(aTexto, "6. " +  space(6) + " H�  que   se   destacar  que  n�o  est� compreendido no objeto do contrato a outorga de " )
			aadd(aTexto, "cr�dito  ao  �rg�o, mas apenas  e   t�o-somente  o  servi�o   de   gest�o  de  frota   como  meio" )
			aadd(aTexto, "de  pagamento." )
			aadd(aTexto, "" )
			aadd(aTexto, "7. " +  space(6) + "  Al�m  disso   devemos   destacar   que   a  empresa   Trivale  Institui��o de Pagamentos " )
			aadd(aTexto, "Ltda.  �,  em  sua  ess�ncia,   uma   institui��o   de  arranjo  de  pagamento   conforme  a  novel" )
			aadd(aTexto, "denomina��o  prevista  na  Lei n. 12.865/13,  arts.  6�   e  ss.,  que alterou as regras do Sistema" )
			aadd(aTexto, "de  Pagamentos  Brasileiro." )
			aadd(aTexto, "" )
			aadd(aTexto, "8. " + space(6) + " Tais  institui��es   se   tratam  das   pessoas   jur�dicas   respons�veis  pelos  chamados  " )
			aadd(aTexto, "arranjos   de   pagamentos,   que,   por   sua   vez,   s�o  a  sequ�ncia  de  procedimentos  que" )
			aadd(aTexto, "envolvem  a oferta de servi�os  de  circula��o   de  moeda   ao   p�blico,   como   s�o  os casos" )
			aadd(aTexto, "de cart�es de cr�dito, cart�o de d�bito  e  moedas eletr�nicas,  bem  como  �  o caso  da desta" )
			aadd(aTexto, "empresa. " )
			aadd(aTexto, "" )
			aadd(aTexto, "9. " +  space(6) + " O  artigo  12,   inciso   I ,  da  Lei n.  12.865/13  �  expl�cito quanto � evidente separa��o   " )
			aadd(aTexto, "entre  os  patrim�nios   das   empresas   de   arranjos  de   pagamentos   e  o   patrim�nio  dos" )
			aadd(aTexto, "�rg�os  P�blicos,  raz�o  pela  qual  temos  que  o  contrato  n�o  compreende  a  outorga  de " )
			aadd(aTexto, "cr�dito   como   tamb�m   a   legisla��o   de   reg�ncia   pro�be   expressamente   a    confus�o " )
			aadd(aTexto, "patrimonial  entre  os  valores  em  tr�nsito  na  rede  e  aqueles  das  presta��es  de  servi�os. " )
			aadd(aTexto, "" )
			aadd(aTexto, "10. " +  space(6) + " Informamos   que  caso  queira   apresentar resposta  a  essa  notifica��o,  deve  ser " )
			aadd(aTexto, "direcionada  aos  cuidados  do  Setor  de   Recupera��o   de  Cr�dito  desta   empresa,  cujo " )
			aadd(aTexto, "endere�o � Avenida Jacarand�, n� 200, Bairro Jaragu�, Uberl�ndia � MG, CEP: 38.413-069. " )
			aadd(aTexto, "servi�os  da  Contratada,  como  disponibiliza��o   do   sistema   e   do   site,  permanecer�o  " )
			aadd(aTexto, "ativas,  mesmo  diante  do  inadimplemento  do  Contratante,  observando  a  regrado  legal. " )
			aadd(aTexto, "de 90 (noventa) dias. " )
			aadd(aTexto, "" )
			aadd(aTexto, "11. " +  space(6) + "Caso j� tenha efetuado o pagamento, favor desconsiderar a presente correspond�ncia" )
		Endif

	Endif

Return aTexto
