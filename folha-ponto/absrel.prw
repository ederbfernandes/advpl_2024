#include 'totvs.ch'















/*/{Protheus.doc} absrel
relatorio de absenteísmo
@type function
@version 1.0 
@author eder.fernandes
@since 6/14/2024
/*/
User Function absrel()

	Local oExcel  as objeto
	Local lRet    as logical
	Local cAliasSRD as character
	Local cAliasSR8 as character
	Local cAliasSPC as character
	Local cAliasSRA as character
	Local aArea := FWGetArea()
	Local aPergs   := {}
	Local xPar0 := Space(2)
	Local xPar1 := Space(2)
	Local xPar2 := Space(6)
	Local xPar3 := Space(6)
	Local xPar4 := Space(20)
	Local xPar5 := Space(20)

	//Adicionando os parametros do ParamBox
	aadd(aPergs, {1, "Filial de"                            , xPar0, "", ".T.", "SM0", ".T.", 80, .F.})
	aadd(aPergs, {1, "Filial Até"                           , xPar1, "", ".T.", "SM0", ".T.", 80, .T.})
	aadd(aPergs, {1, "Centro de Custo de"                   , xPar4, "", ".T.", "CTT", ".T.", 80, .F.})
	aadd(aPergs, {1, "Centro de Custo Até"                  , xPar5, "", ".T.", "CTT", ".T.", 80, .T.})
	aadd(aPergs, {1, "Matricula de"                         , xPar2, "", ".T.", "SRA", ".T.", 80, .F.})
	aadd(aPergs, {1, "Matrícula Até"                        , xPar3, "", ".T.", "SRA", ".T.", 80, .T.})
	aadd(aPergs, {1, "Nome de"                              , xPar2, "", ".T.", "SRA", ".T.", 80, .F.})
	aadd(aPergs, {1, "Nome Até"                             , xPar3, "", ".T.", "SRA", ".T.", 80, .T.})
	aadd(aPergs, {1, "Data de"                              , xPar2, "", ".T.", "SRA", ".T.", 80, .F.})
	aadd(aPergs, {1, "Data Até"                             , xPar3, "", ".T.", "SRA", ".T.", 80, .T.})
	aadd(aPergs, {1, "Numero da Semana de"                  , xPar2, "", ".T.", "SRA", ".T.", 80, .F.})
	aadd(aPergs, {1, "Numero da Semana Até"                 , xPar3, "", ".T.", "SRA", ".T.", 80, .T.})
	aadd(aPergs, {1, "Formato Vertical / Horizontal"        , xPar2, "", ".T.", "SRA", ".T.", 80, .F.})
	aadd(aPergs, {1, "Listar Horas / Valores"               , xPar3, "", ".T.", "SRA", ".T.", 80, .T.})
	aadd(aPergs, {1, "Relatório Analitico ou Sintetico"     , xPar2, "", ".T.", "SRA", ".T.", 80, .F.})
	aadd(aPergs, {1, "Se lista todos os codigos encontrados", xPar3, "", ".T.", "SRA", ".T.", 80, .T.})
	aadd(aPergs, {1, "Lista Salario do Cadastro"            , xPar2, "", ".T.", "SRA", ".T.", 80, .F.})
	aadd(aPergs, {1, "Imprimir Totais"                      , xPar3, "", ".T.", "SRA", ".T.", 80, .T.})
	aadd(aPergs, {1, "Imprimir Liquidos"                    , xPar2, "", ".T.", "SRA", ".T.", 80, .F.})
	aadd(aPergs, {1, "Situação Historica / Atual"           , xPar3, "", ".T.", "SRA", ".T.", 80, .T.})
	

	cAliasSRD := GetNextAlias()

	BeginSql Alias cAliasSRD
        SELECT
            RD_FILIAL, RD_PERIODO, RD_MAT, RD_VERBA
        FROM %table:SRD SRD,
        WHERE SRD.%notDel% AND  
        RD_PERIODO = '202401'
        ORDER BY RD_MAT
	EndSql



Return




//Bibliotecas
	#Include "Totvs.ch"

/*/{Protheus.doc} User Function teste

@author Eder Barbosa Fernandes
@since 15/06/2024
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

User Function teste()
	Local aArea := FWGetArea()
	Local aPergs   := {}
	Local xPar0 := Space(2)
	Local xPar1 := Space(2)
	Local xPar2 := Space(6)
	Local xPar3 := Space(6)
	Local xPar4 := Space(20)
	Local xPar5 := Space(20)

	//Adicionando os parametros do ParamBox
	aAdd(aPergs, {1, "Filial de", xPar0,  "", ".T.", "SM0", ".T.", 80,  .F.})
	aAdd(aPergs, {1, "Filial Até", xPar1,  "", ".T.", "SM0", ".T.", 80,  .T.})
	aAdd(aPergs, {1, "Matricula de", xPar2,  "", ".T.", "SRA", ".T.", 80,  .F.})
	aAdd(aPergs, {1, "Matrícula Até", xPar3,  "", ".T.", "SRA", ".T.", 80,  .T.})
	aAdd(aPergs, {1, "Centro de Custo de", xPar4,  "", ".T.", "CTT", ".T.", 80,  .F.})
	aAdd(aPergs, {1, "Centro de Custo Até", xPar5,  "", ".T.", "CTT", ".T.", 80,  .T.})

	//Se a pergunta for confirmada, chama o preenchimento dos dados do .dot
	If ParamBox(aPergs, 'Informe os parâmetros', /*aRet*/, /*bOk*/, /*aButtons*/, /*lCentered*/, /*nPosx*/, /*nPosy*/, /*oDlgWizard*/, /*cLoad*/, .F., .F.)
		Processa({|| fGeraExcel()})
	EndIf

	FWRestArea(aArea)
Return

/*/{Protheus.doc} fGeraExcel
Criacao do arquivo Excel na funcao teste
@author Eder Barbosa Fernandes
@since 15/06/2024
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

Static Function fGeraExcel()
	Local aArea       := FWGetArea()
	Local oPrintXlsx
	Local dData       := Date()
	Local cHora       := Time()
	Local cArquivo    := GetTempPath() + 'teste' + dToS(dData) + '_' + StrTran(cHora, ':', '-') + '.rel'
	Local cQryDad     := ''
	Local nAtual      := 0
	Local nTotal      := 0
	Local aColunas    := {}
	Local oExcel
	Local cFonte      := FwPrinterFont():Arial()
	Local nTamFonte   := 12
	Local lItalico    := .F.
	Local lNegrito    := .T.
	Local lSublinhado := .F.
	Local nCpoAtual   := 0
	Local oCellHoriz  := FwXlsxCellAlignment():Horizontal()
	Local oCellVerti  := FwXlsxCellAlignment():Vertical()
	Local cHorAlinha  := ''
	Local cVerAlinha  := ''
	Local lQuebrLin   := .F.
	Local nRotation   := 0
	Local cCustForma  := ''
	Local cCampoAtu   := ''
	Local cTipo       := ''
	Local cCorFundo   := ''
	Local cCorPreto   := '000000'
	Local cCorBranco  := 'FFFFFF'
	Local cCorTxtCab  := '22B14C'
	Local cCorFunPad  := 'EBF1DE'

	//Montando consulta de dados
	cQryDad += "SELECT * FROM SRD010 WHERE D_E_L_E_t_ = ' ' AND RD_MAT BETWEEN {mv_par03} and {mv_par04}"		+ CRLF

	//Executando consulta e setando o total da regua
	PlsQuery(cQryDad, "QRY_DAD")
	DbSelectArea("QRY_DAD")

	//Somente se houver dados
	If ! QRY_DAD->(EoF())

		//Definindo o tamanho da regua
		Count To nTotal
		ProcRegua(nTotal)
		QRY_DAD->(DbGoTop())

		//Vamos agora adicionar as colunas no Excel, sendo as posições:
		//  [1] Nome do Campo
		//  [2] Tipo do Campo
		//  [3] Título a ser exibido
		//  [4] Largura em pixels, sendo que o ideal é o tamanho do campo * 1.5 (se o campo for muito pequeno, considere o tamanho minimo como 10 * 1.5)
		//  [5] Alinhamento (0 = esquerda, 1 = direita, 2 = centralizado)
		//  [6] Máscara aplicada em campos numéricos
		aadd(aColunas, {'RD_MAT'    , 'C', 'Matrícula'      , Len(QRY_DAD->RD_MAT) * 1.5    , 0, ''})
		aadd(aColunas, {'RD_CC'     , 'C', 'Centro de Custo', Len(QRY_DAD->RD_CC) * 1.5     , 0, ''})
		aadd(aColunas, {'RD_FILIAL' , 'C', 'Filial'         , Len(QRY_DAD->RD_FILIAL) * 1.5 , 0, ''})
		aadd(aColunas, {'RD_PERIODO', 'C', 'Período'        , Len(QRY_DAD->RD_PERIODO) * 1.5, 0, ''})

		//Instancia a classe, e tenta criar o arquivo .rel
		oPrintXlsx := FwPrinterXlsx():New()
		If oPrintXlsx:Activate(cArquivo)

			//Adiciona uma worksheet
			oPrintXlsx:AddSheet('absenteismo')

			//Depois de imprimir os textos do cabeçalho, vamos colocar a fonte como normal
			nTamFonte := 10
			lNegrito  := .F.
			oPrintXlsx:SetFont(cFonte, nTamFonte, lItalico, lNegrito, lSublinhado)

			//Na primeira linha do cabeçalho, vamos definir como tudo centralizado, a cor do texto verde e de fundo branca
			cHorAlinha  := oCellHoriz:Center()
			cVerAlinha  := oCellVerti:Center()
			oPrintXlsx:SetCellsFormat(cHorAlinha, cVerAlinha, lQuebrLin, nRotation, cCorTxtCab, cCorBranco, cCustForma)

			//Percorre agora as colunas e vem setando o tamanho delas e colocando o nome
			nLinExcel := 1
			For nAtual := 1 To Len(aColunas)
				oPrintXlsx:SetColumnsWidth(nAtual, nAtual, aColunas[nAtual][4])
				oPrintXlsx:SetText(nLinExcel, nAtual, aColunas[nAtual][3])
			Next

			//Define que as colunas terão opção de filtrar (da coluna 1 até a quantidade de campos)
			oPrintXlsx:ApplyAutoFilter(nLinExcel, 1, nLinExcel, Len(aColunas))

			//Percorrendo os dados da query
			nAtual := 0
			While !(QRY_DAD->(EoF()))

				//Incrementando a regua
				nAtual++
				IncProc('Adicionando registro ' + cValToChar(nAtual) + ' de ' + cValToChar(nTotal) + '...')

				//Se for ímpar, o fundo vai ser verde claro, senão vai ser branco
				If nAtual % 2 != 0
					cCorFundo := cCorFunPad
				Else
					cCorFundo := cCorBranco
				EndIf

				//Incrementa a linha no Excel
				nLinExcel++

				//Percorre as colunas
				For nCpoAtual := 1 To Len(aColunas)
					cCampoAtu := aColunas[nCpoAtual][1]
					cTipo     := aColunas[nCpoAtual][2]
					xConteud  := &('QRY_DAD->' + cCampoAtu)

					//Se for data, vai ser centralizado
					If cTipo == 'D'
						xConteud := dToC(xConteud)

						//Se for numérico, vai ser a direita
					ElseIf cTipo == 'N'
						//Se tem máscara, aplica num transform
						If ! Empty(aColunas[nCpoAtual][6])
							xConteud := Alltrim(Transform(xConteud, aColunas[nCpoAtual][6]))

							//Senão converte de numérico para texto
						Else
							xConteud := cValToChar(xConteud)
						EndIf

						//Senão, apenas tira espaços do campo
					Else
						xConteud := Alltrim(xConteud)
					EndIf

					//Se o alinhamento for a direita
					If aColunas[nCpoAtual][5] == 1
						cHorAlinha := oCellHoriz:Right()

						//Se for centralizado
					ElseIf aColunas[nCpoAtual][5] == 2
						cHorAlinha := oCellHoriz:Center()

						//Senão, será a esquerda
					Else
						cHorAlinha := oCellHoriz:Left()
					EndIf

					//Reseta a formatação
					oPrintXlsx:ResetCellsFormat()

					//Em seguida, define a formatação da coluna, sendo que o texto será preto
					oPrintXlsx:SetCellsFormat(cHorAlinha, cVerAlinha, lQuebrLin, nRotation, cCorPreto, cCorFundo, cCustForma)

					//Adiciona a informação na linha do excel na coluna do campo
					oPrintXlsx:SetText(nLinExcel, nCpoAtual, xConteud)
				Next

				QRY_DAD->(DbSkip())
			EndDo

			//Vamos finalizar o arquivo
			oPrintXlsx:ToXlsx()
			oPrintXlsx:DeActivate()

			//E agora vamos abrir ele
			cArquivo := ChgFileExt(cArquivo, '.xlsx')
			If File(cArquivo)
				oExcel := MsExcel():New()
				oExcel:WorkBooks:Open(cArquivo)
				oExcel:SetVisible(.T.)
				oExcel:Destroy()
			EndIf
		EndIf

	Else
		FWAlertError('Não foi encontrado registros com os filtros informados!', 'Falha')
	EndIf
	QRY_DAD->(DbCloseArea())

	FWRestArea(aArea)
Return
