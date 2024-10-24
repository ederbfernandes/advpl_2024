#include 'protheus.ch'
#include 'rwmake.ch'
#include 'parmtype.ch'
#include "msole.ch"

/*/{Protheus.doc} USAREL07
Gera declaração de cargo ou salário a partir de um modelo word.
    @author Leandro Pereira [Econsiste]
    @since 11/11/2020
    @type function
/*/
User Function USAREL07()

	Local cPatModelo    := GetNewPar("EC_GPER03A","\workflow\ModeloDeclaracao\")
	Local aModelos      := {"Salario","Cargo","Entrega de CTPS"}
	Local cMat          := ""
	Local cModelo       := ""
	Local aRet          := {}
	Local aParamBox     := {}

	Private cDiretorio  := ""
	Private cNomArq     := ""

	aAdd(aParamBox, { 1, "Matrícula", Space( TamSX3("RA_MAT")[1] ), "", ".T.", "SRA", "", 50, .T.})
	aAdd(aParamBox, { 2, "Modelo", 1, aModelos, 60, , .T. } )
	aAdd(aParamBox, { 1, "Diretorio para salvar", Space(75), "", ".T.", "HSSDIR", "", 100, .T.})
	aAdd(aParamBox, { 1, "Nome arquivo (sem extensão)", Space(20) , "", ".T.", "", "", 0,  .T.})

	If ParamBox(aParamBox,"Parâmetros...",@aRet)
		cMat        := &("MV_PAR01")
		cModelo     := AllTrim( Str( If( ValType( &("MV_PAR02") ) == "N", &("MV_PAR02"), aScan(aModelos, &("MV_PAR02") ) ) ) )
		cDiretorio  := AllTrim(&("MV_PAR03"))
		cNomArq     := Lower(AllTrim(&("MV_PAR04")) + ".docx")

		If !Empty(cModelo) .And. AllTrim(cModelo) $ "1/2/3"

			If cModelo == "1"
				cNomModel   := "modelo_declaracao_salario" + ".dotx"

			ElseIf cModelo == "2"
				cNomModel := "modelo_declaracao_cargo" + ".dotx"

			ElseIf cModelo == "3"
				cNomModel :=  "modelo_declaracao_entrega_ctps" + ".dotx"

			EndIf

			If File(cPatModelo + cNomModel)
				If ExistDir(cDiretorio)
					If File(cDiretorio + cNomModel)
						FErase(cDiretorio + cNomModel)
					Endif
					If CPYS2T(cPatModelo + cNomModel, cDiretorio,.F.)
						Processa({|| fGeraWord(cMat, cDiretorio + cNomModel, cModelo) },"Gerando declaração...","Aguarde...")
					Else
						MsgStop("Não foi possível copiar o arquivo de modelo.","USAREL07")
					EndIf
				Else
					MsgAlert("Diretório de gravação inválido.","USAREL07")
				EndIf
			Else
				MsgAlert("Modelo de declaração não encontrado.","USAREL07")
			EndIf
		Else
			MsgAlert("Modelo de declaração não selecionado.","USAREL07")

		Endif
	EndIf

Return (Nil)

//-----------------------------------
Static Function fGeraWord(cMat, cArquivo, cModelo)

	
	ProcRegua(000)

	dbSelectArea("SRA")
	dbSetOrder(1)
	If dbSeek(xFilial("SRA") + cMat)

		//Conecta ao word
		hWord	:= OLE_CreateLink()
		If Val(hWord) < 0
			ALERT("MS-WORD não encontrado nessa maquina!")
			lRet := .F.
			Return (lRet)
		Endif
		OLE_NewFile(hWord, cArquivo )

		// Exibe ou oculta a janela da aplicacao Word no momento em que estiver descarregando os valores.
		OLE_SetProperty( hWord, oleWdVisible, .F. )

		// Exibe ou oculta a aplicacao Word.
		OLE_SetProperty( hWord, oleWdWindowState, '1' )

		//Atribui valores às variáveis do modelo word
		OLE_SetDocumentVar(hWord, 'vDATA'        , DtExtenso(DDATABASE, .T.) )
		OLE_SetDocumentVar(hWord, 'vFUNCIONARIO' , AllTrim(SRA->RA_NOMECMP) )
		OLE_SetDocumentVar(hWord, 'vADMISSAO'    , DTOC(SRA->RA_ADMISSA) )


		If cModelo == "1"   //Com salário
			OLE_SetDocumentVar(hWord, 'vSALARIO', AllTrim(Transform( SRA->RA_XSALRPP, "@E 999,999,999.99") ) )
			OLE_SetDocumentVar(hWord, 'vSALARIO_EXTENSO', AllTrim(Capital( Extenso( SRA->RA_XSALRPP,.F.,1) ) ) )

		ElseIf cModelo == "2"   //Sem salário
			OLE_SetDocumentVar(hWord, 'vFUNCAO', AllTrim( Capital( Posicione("SQ3", 1, xFilial("SQ3") + SRA->RA_CARGO, "Q3_XDSCPOR") ) ) )

		ElseIf cModelo == "3" // entrega ctps
			OLE_SetDocumentVar(hWord, 'vCTPSNUM'    , AllTrim(SRA->RA_NUMCP ))
			OLE_SetDocumentVar(hWord, 'vCTPSSERIE'  , AllTrim(SRA->RA_SERCP ))
			OLE_SetDocumentVar(hWord, 'vCTPSUF'     , AllTrim(SRA->RA_UFCP  ))

			aSX5    := FWGetSX5("98",SRA->RA_XPOSTNU)
			cPosto  := Capital(AllTrim(aSx5[1,4])) + "-" + SRA->RA_XPOST

			//Tratativa para acentuação
			If AllTrim(cPosto) == "Sao Paulo-SP"
				cPosto := "São Paulo"
			ElseIf AllTrim(cPosto) == "Brasilia-DF"
				cPosto := "Brasília"
			Endif

			OLE_SetDocumentVar(hWord, 'vPOSTTRAB'   , AllTrim( cPosto))

		Endif

		// Atualizando as variaveis do documento do Word
		OLE_UpdateFields(hWord)

		If File(cDiretorio + cNomModel)
			FErase(cDiretorio + cNomModel)
		Endif
		OLE_SaveAsFile( hWord, cDiretorio + cNomArq )
		OLE_CloseFile( hWord )
		OLE_CloseLink( hWord )

		fErase(cArquivo)

		MsgInfo("O arquivo foi gerado no diretório " + cDiretorio + cNomArq,'Atenção')
	EndIf

Return (Nil)

//--------------------------------------------
Static Function DtExtenso(dDataAtual, lAbreviado)

	Local cRetorno := ""

	Default dDataAtual := dDataBase
	Default lAbreviado := .F.

	//Se for da forma abreviada, mostra números
	If lAbreviado
		cRetorno += cValToChar(Day(dDataAtual))
		cRetorno += " de "
		cRetorno += MesExtenso(dDataAtual)
		cRetorno += " de "
		cRetorno += cValToChar(Year(dDataAtual))

		//Senão for abreviado, mostra texto completo
	Else
		cRetorno += Capital(Extenso(Day(dDataAtual), .T.))
		cRetorno += " de "
		cRetorno += MesExtenso(dDataAtual)
		cRetorno += " de "
		cRetorno += Capital(Extenso(Year(dDataAtual), .T.))
	EndIf

Return (cRetorno)
