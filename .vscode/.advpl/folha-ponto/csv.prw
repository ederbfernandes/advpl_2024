#INCLUDE "PROTHEUS.CH"
#INCLUDE "FWCOMMAND.CH"
#include "msgraphi.ch"
#include "FWBROWSE.ch"
                                               
 
#Define BMPFILTRO	  	"FILTRO.PNG"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMPCO008     บAutor  ณWanderson Liberdadeบ Data ณ30/09/14    บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณPrograma faz a conferencia dos lan็amentos no pco com os    บฑฑ
ฑฑบ          ณ outros m๓dulos                                             บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Valecard                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function MPCO008()
	Local aSays			:= {}
	
	Private cPerg		:=	"MPCO008"
	Private cCadastro 	:= "Importacao de Lancamentos para o PCO"
	Private aButtons    := {}
	Private aErros		:= {}
	Private nOpca		:= 0 
	Private nOp			:= 0 	                   
	Private cErros		:= "" 
	Private dInicio		
	Private dFinal
	Private cAlias		:=""
	Private aXLista		:= {}
	Private aWLista		:= {}
	Private aBKPLista	:= {}
	Private nAjustFil	:= 0
	Private oListBox
	Public nRecAKD		:=0 
	
	ValidPerg()
	
	Pergunte(cPerg ,.f. )
	
	AADD(aSays,"Este programa tem como funcionalidade: Conferencia dos ") 
	AADD(aSays,"Lancamentos no PCO com os outros m๓dulos.")

	
	AADD(aButtons, { 5,.T.,{|| Pergunte(cPerg ,.T. ) } } )
	AADD(aButtons, { 1,.T.,{|o| nOp:= 1,o:oWnd:End()}} )
	AADD(aButtons, { 2,.T.,{|o| o:oWnd:End() }} )
	
	FormBatch( cCadastro, aSays, aButtons ) 
	nOpca:= mv_par04
	If nOp == 1
		MPCO8TELA()	
   EndIf
Return()


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMPCO8FIS  บAutor  ณWanderson Liberdade บ Data ณ  11/08/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณTela principal dos lan็amentos                              บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Valecard                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function MPCO8TELA(cTGet,cCampo,cModulo)
	Local cTitulo     := "Lista de Tarefas "
	Local aPosObj     := {} 
	Local aObjects    := {}                        
	Local aSize       := MsAdvSize( .F. ) 

	Local oFntBut	:= Nil							// Objeto da fonte dos botoes
	Private 	oDlgPrinc
	PRIVATE cCadastro  := "Confer๊ncia PCO"
		
	Private cFilFil		:=""
	Private cFilNum		:=""
	Private cFilCO		:=""
	Private cFilCC		:="" 
	Private cValor1		:=0
	
	 
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Selcionando registros		                                           ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	DO CASE
		Case mv_par03 == 1
			Processa( {|lEnd| MPCO8FIS(@lEnd)}, "Aguarde...","Selecionando Registros Documento Entrada...", .T. )
    	Case mv_par03 == 2
			Processa( {|lEnd| MPCO8ARM(@lEnd)}, "Aguarde...","Selecionando Registros Solicita็ใo Armaz้m...", .T. )
		Case mv_par03 == 3
			Processa( {|lEnd| MPCO8COM(@lEnd)}, "Aguarde...","Selecionando Registros Compras...", .T. )
		Case mv_par03 == 4
			Processa( {|lEnd| MPCO8CAP(@lEnd)}, "Aguarde...","Selecionando Registros Contas a Pagar...", .T. )
			Processa( {|lEnd| MPCO8CAX(@lEnd)}, "Aguarde...","Selecionando Registros Caixinha...", .T. )
		Case mv_par03 == 5
			Processa( {|lEnd| MPCO8CAP1(@lEnd)}, "Aguarde...","Selecionando Registros Fin. Contas a Pagar...", .T. ) 
			Processa( {|lEnd| MPCO8CAR(@lEnd)}, "Aguarde...","Selecionando Registros Fin. Contas a Receber...", .T. ) 
			Processa( {|lEnd| MPCO8MVB(@lEnd)}, "Aguarde...","Selecionando Registros Fin. Movimenta็ใo Bancแria...", .T. )
			Processa( {|lEnd| MPCO8MVB1(@lEnd)}, "Aguarde...","Selecionando Registros Fin. Movimenta็ใo Bancแria...", .T. )
			Processa( {|lEnd| MPCO8COM1(@lEnd)}, "Aguarde...","Selecionando Registros Fin. Compras...", .T. )
		OTHERWISE
			Alert("Selecione um M๓dulo")
		EndCase
		
		If Empty(aXLista)
			MSGAlert('Nenhum Registro encontrado')
			if !Empty(aBKPLista)
				aXLista:=aClone(aBKPLista)
			Else
				aXLista:=aClone(aWLista)
			EndIf
			Return
		EndIf    
		
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Efetua os calculos de Auto Size                                       ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	aObjects := {} 
	AAdd( aObjects, { 100, 100, .T., .T., .T. } )
	AAdd( aObjects, {  94, 100, .F., .T. } )
	
	aInfo := { aSize[ 1 ], aSize[ 2 ], aSize[ 3 ], aSize[ 4 ], 3, 3 } 
	aPosObj := MsObjSize( aInfo, aObjects, , .T. )
                              
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Efetua os calculos de Auto Size ( direita da tela )                    ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

	aObjects := {}                                
	AAdd( aObjects, { 100,  10, .T., .F. } )	
	AAdd( aObjects, { 100, 100, .T., .T., .T. } )
	AAdd( aObjects, { 100, 100, .T., .T., .T. } )	
	AAdd( aObjects, { 100,  35, .T., .F. } )
	
	aInfo    := { aPosObj[ 2, 2 ], aPosObj[ 2, 1 ], aPosObj[ 2, 4 ], aPosObj[ 2, 3 ], 3, 3 } 
	aPosObj2 := MsObjSize( aInfo, aObjects )
		
	DEFINE MSDIALOG oDlgPrinc FROM aSize[7],00 TO aSize[6],aSize[5] TITLE cTitulo OF oMainWnd PIXEL
	
 	                               
	nLinIni := aPosObj[2,1] 
	nRight  := aSize[5]/2
	
	oFont:= TFont():New('Courier New',,-14,.T.,.T.) 
	
	oMainPanel:= tPanel():New(012+nAjustFil,020,"",oDlgPrinc,,,,,,oDlgPrinc:NCLIENTWIDTH/2-23,oDlgPrinc:nClientHeight/2-45-nAjustFil)

	DEFINE FWBROWSE oListBox DATA ARRAY ARRAY aXLista NO CONFIG  NO REPORT  OF oMainPanel
	
		//-------------------------------------------------------------------
		// Adiciona as colunas do Browse
		//-------------------------------------------------------------------
		ADD STATUSCOLUMN oColumn DATA { || If(aXLista[oListbox:At(),22]=="Registro nใo encontrado PCO",'BR_VERMELHO', If(aXLista[oListbox:At(),22]!="",'BR_AMARELO', 'BR_VERDE')) } DOUBLECLICK { |oBrowse| /* Fun็ใo executada no duplo clique na coluna*/ } OF oListBox		

		ADD COLUMN oColumn DATA { || aXLista[oListBox:At(),02] } TITLE "MODULO" SIZE 10 HEADERCLICK {||.F.} OF oListBox
		ADD COLUMN oColumn DATA { || aXLista[oListBox:At(),03] } TITLE "FILIAL " SIZE 06 HEADERCLICK {||.F.} OF oListBox
		ADD COLUMN oColumn DATA { || aXLista[oListBox:At(),04] } TITLE "DOCUMENTO" SIZE 08 HEADERCLICK {||.F.} OF oListBox
		ADD COLUMN oColumn DATA { || aXLista[oListBox:At(),07] } TITLE "VALOR " SIZE 9 HEADERCLICK {||.F.} OF oListBox
		ADD COLUMN oColumn DATA { || aXLista[oListBox:At(),06] } TITLE "C.O." SIZE 09 HEADERCLICK {||.F.} OF oListBox
		ADD COLUMN oColumn DATA { || aXLista[oListBox:At(),05] } TITLE "C.C." SIZE 09 HEADERCLICK {||.F.} OF oListBox
		ADD COLUMN oColumn DATA { || aXLista[oListBox:At(),22] } TITLE "DIVERGENCIAS" SIZE 30 HEADERCLICK {||.F.} OF oListBox         
		ADD COLUMN oColumn DATA { || aXLista[oListBox:At(),08] } TITLE "MODULO" SIZE 3 HEADERCLICK {||.F.} OF oListBox
		ADD COLUMN oColumn DATA { || aXLista[oListBox:At(),27] } TITLE "FILIAL" SIZE 06 HEADERCLICK {||.F.} OF oListBox
		ADD COLUMN oColumn DATA { || aXLista[oListBox:At(),10] } TITLE "DOCUMENTO" SIZE 08 HEADERCLICK {||.F.} OF oListBox
		ADD COLUMN oColumn DATA { || aXLista[oListBox:At(),13] } TITLE "VALOR PCO " SIZE 9 HEADERCLICK {||.F.} OF oListBox
		ADD COLUMN oColumn DATA { || aXLista[oListBox:At(),12] } TITLE "C.O." SIZE 08 HEADERCLICK {||.F.} OF oListBox
		ADD COLUMN oColumn DATA { || aXLista[oListBox:At(),28] } TITLE "DESC. C.O." SIZE 20 HEADERCLICK {||.F.} OF oListBox
		ADD COLUMN oColumn DATA { || aXLista[oListBox:At(),11] } TITLE "C.C." SIZE 08 HEADERCLICK {||.F.} OF oListBox
		ADD COLUMN oColumn DATA { || aXLista[oListBox:At(),29] } TITLE "DESC. C.C." SIZE 20 HEADERCLICK {||.F.} OF oListBox
		ADD COLUMN oColumn DATA { || aXLista[oListBox:At(),09] } TITLE "CLASSE" SIZE 06 HEADERCLICK {||.F.} OF oListBox
		oListBox:ACOLUMNS[14]:NALIGN := 2
		
		
		oListBox:SetBlkBackColor( 	{ || CLR_WHITE } )
	 	oListBox:SetBlkColor( { || IIF(aXLista[oListBox:At(),02] == "PCO" , CLR_RED,CLR_BLUE  ) } )
	 
  
	ACTIVATE FWBROWSE oListBox
	
//	Private lSortOrd := .F. // Ordena Descrescente ou crescente, sempre invertendo o valor a cada clique no cabe็alho do listbox.
  //	oListBox:bHeaderClick := {|| nColPos :=oListBox:ColPos,lSortOrd := !lSortOrd, aSort(aXLista,,,{|x,y| Iif(lSortOrd,x[nColPos] > y[nColPos],x[nColPos] < y[nColPos]) }),oListBox:Refresh()} 

    nPos:=2         
  	//BOTีES LATERAL ESQUERDA
	//oBtn01 := TBtnBmp2():New(020,nPos,35,35,"COMPTITL",,,,{|| },oDlgPrinc,"",Nil,.T.)
	//oBtn02:= TBtnBmp2():New(060,nPos,35,35,"TABPRICE",,,,{|| },oDlgPrinc,"",Nil,.T.)
	If(!EMPTY(aXLista[oListBox:At(),14]))
		oBtn03:= TBtnBmp2():New(100,nPos,35,35,"BMPVISUAL",,,,{|| U_AxVisual(aXLista[oListbox:At(),01],IIF(aXLista[oListbox:At(),01]!="AKD",aXLista[oListBox:At(),14],aXLista[oListBox:At(),14]),3)},oDlgPrinc,"Visualizar Cadastro",Nil,.T.)
	Else
		MSGALERT( "Lan็amento nใo Encontrado no M๓dulo", "Lan็amento M๓dulo" )
		
	EndIf
	oBtn04:= TBtnBmp2():New(140,nPos,35,35,BMPFILTRO,,,,{|| U_FILWPCO()},oDlgPrinc,"Criar Filtro",Nil,.T.)
	oBtn05:= TBtnBmp2():New(180,nPos,35,35,"TK_REFRESH",,,,{|| u_ATUWTELA()},oDlgPrinc,"Atualizar lista",Nil,.T.)
	oBtn06:= TBtnBmp2():New(220,nPos,35,35,"PMSEXCEL",,,,{|| U_PCOIMPEX()},oDlgPrinc,"Exportar Excel",Nil,.T.)
	oBtn07:= TBtnBmp2():New(260,nPos,35,35,"UPDINFORMATION",,,,{|| U_PCOWLEGEN()},oDlgPrinc,"Legenda",Nil,.T.)
	oBtn08:= TBtnBmp2():New(300,nPos,35,35,"LOCALIZA",,,,{|| U_AFAT006C(10)},oDlgPrinc,"Localizar registro",Nil,.T.) 
	//oBtn08:= TBtnBmp2():New(340,nPos,35,35,"AREA",,,,{|| U_c(11)},oDlgPrinc,"Pipeline",Nil,.T.)
	
	nColun := 580
	oBtnSair := TBtnBmp2():New(oDlgPrinc:nClientHeight-65,nPos+nColun,35,35,"FINAL",,,,{|| oDlgPrinc:End()},oDlgPrinc,"Sair",Nil,.T.)
	
	
	//oListBox:bHeaderClick := {|| nColPos :=oListBox:ColPos,lSortOrd := !lSortOrd, aSort(aXLista,,,{|x,y| Iif(lSortOrd,x[nColPos] > y[nColPos],x[nColPos] < y[nColPos]) }),oListBox:Refresh()}
	bLDblClick := {|| IIF(aXLista[oListBox:At(),02] == "PCO",;
	  			   	u_A050DLG( "AKD", aXLista[oListBox:At(),14], 4, .F., { aXLista[oListBox:At(),14] }, , , .T. ),;
	  			   	AltAKD(aXLista[oListBox:At()]))}
	oListBox:SetDoubleClick (bLDblClick)

	ACTIVATE MSDIALOG oDlgPrinc
Return()


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMPCO8FIS   บAutor  ณWanderson Liberdadeบ Data ณ  11/08/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณSeleciona registro no Documento de Entrada				   ฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ ValeCard                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/    

Static Function MPCO8FIS()
	Local cQuery	:="" 
	Local cQuery1	:=""
	Local cObsCam	:=""
	Local cAlias	:="SD1"    

	cQuery:= " SELECT D1_FILIAL, D1_COD,D1_SERIE,D1_LOJA,D1_ITEM,D1_TIPO, B1_DESC, D1_FORNECE, A2_NOME, D1_EMISSAO, D1_DOC, D1_DTDIGIT,  "
	cQuery+= " D1_CC, CTT_DESC01, B1_CTAPCO, D1_TOTAL, D1_XOBS,D1.R_E_C_N_O_, B1.B1_DESC,D1.D1_USERLGI,D1.D1_PEDIDO "
	cQuery+= " FROM "+RETSQLNAME("SD1")+" D1   INNER JOIN "+RETSQLNAME("SB1")+" B1  ON (D1_COD = B1_COD  AND B1.D_E_L_E_T_ <> '*' )   "
	cQuery+= " INNER JOIN "+RETSQLNAME("SA2")+" A2 ON (D1_FORNECE = A2_COD  AND D1_LOJA = A2_LOJA  AND A2.D_E_L_E_T_ <> '*' ) "
	cQuery+= " LEFT OUTER JOIN "+RETSQLNAME("CTT")+" CTT  ON (CTT_CUSTO = D1_CC  AND CTT.D_E_L_E_T_ <> '*' ) "
	cQuery+= " WHERE 0=0 AND D1.D_E_L_E_T_ <> '*' AND D1.D1_TIPO = 'N' AND "
	cQuery+= " D1_DTDIGIT BETWEEN '"+DTOS(MV_par01)+"' AND '"+DTOS(MV_par02)+"' "
	If cFilFil != ""
		cQuery+= " AND D1.D1_FILIAL = '"+cFilFil+"' "
	EndIf
	If cFilNum != ""
		cQuery+= " AND D1.D1_DOC = '"+cFilNum+"' "
	EndIf
	If cFilCO != ""
		cQuery+= " AND B1.B1_CTAPCO = '"+cFilCO+"' "
	EndIf
	If cFilCC != ""
		cQuery+= " AND  D1.D1_CC = '"+cFilCC+"' "
	EndIf
	If cValor1 != 0
		cQuery+= " AND D1.D1_TOTAL = "+STRTRAN(Transform(cValor1,"@E 99999999.99"),",",".")+" "
	EndIf	 
	cQuery+= " UNION "
	cQuery+= " SELECT D1_FILIAL, D1_COD,D1_SERIE,D1_LOJA,D1_ITEM,D1_TIPO, B1_DESC, D1_FORNECE, A1_NOME, D1_EMISSAO, D1_DOC, D1_DTDIGIT,  "
	cQuery+= " D1_CC, CTT_DESC01, B1_CTAPCO, D1_TOTAL, D1_XOBS,D1.R_E_C_N_O_,B1.B1_DESC, D1.D1_USERLGI,D1.D1_PEDIDO " 
	cQuery+= " FROM "+RETSQLNAME("SD1")+" D1   INNER JOIN "+RETSQLNAME("SB1")+" B1 ON (D1_COD = B1_COD  AND B1.D_E_L_E_T_ <> '*' ) "
	cQuery+= " INNER JOIN "+RETSQLNAME("SA1")+" A1 ON (D1_FORNECE = A1_COD  AND D1_LOJA = A1_LOJA  AND A1.D_E_L_E_T_ <> '*' )  "
	cQuery+= " LEFT OUTER JOIN "+RETSQLNAME("CTT")+" CTT  ON (CTT_CUSTO = D1_CC  AND CTT.D_E_L_E_T_ <> '*' ) "
	cQuery+= " WHERE 0=0 AND D1.D_E_L_E_T_ <> '*' AND D1.D1_TIPO IN ('D','B')  "
	cQuery+= " AND D1_DTDIGIT BETWEEN '"+DTOS(MV_par01)+"' AND '"+DTOS(MV_par02)+"' "
	If cFilFil != ""
		cQuery+= " AND D1.D1_FILIAL = '"+cFilFil+"' "
	EndIf
	If cFilNum != ""
		cQuery+= " AND D1.D1_DOC = '"+cFilNum+"' "
	EndIf
	If cFilCO != ""
		cQuery+= " AND B1.B1_CTAPCO = '"+cFilCO+"' "
	EndIf
	If cFilCC != ""
		cQuery+= " AND  D1.D1_CC = '"+cFilCC+"' "
	EndIf
	If cValor1 != 0
		cQuery+= " AND D1.D1_TOTAL = "+STRTRAN(Transform(cValor1,"@E 99999999.99"),",",".")+" "
	EndIf	  
	cQuery+= " ORDER BY D1_FILIAL, D1_DTDIGIT, D1_TIPO  " 
	dbUseArea(.T.,"TOPCONN",TCGenQry(,,cQuery),'TRBSD1',.F.,.T.)
	cTipo:='COMPRAS NF'

	While !Eof()
		cQuery1:= " SELECT AKD_DATA,AKD_CLASSE,AKD_NUMDOC,AKD_CC,AKD_CO,AKD_VALOR1,AKD_XFILIA,R_E_C_N_O_,AKD_PEDIDO,AKD_INFOS1,AKD_DESCCO,AKD_DESCCC,AKD_PROCES,AKD_CHAVE,AKD_LOTE,AKD_ID  "
		cQuery1+= " FROM "+RETSQLNAME("AKD")+" WHERE AKD_FILIAL = '"+xFilial("AKD")+"' AND D_E_L_E_T_ <> '*' AND AKD_CHAVE = 'SD1"+TRBSD1->(D1_FILIAL+D1_DOC+D1_SERIE+D1_FORNECE+D1_LOJA+D1_COD+D1_ITEM)+"' "
		cQuery1+= " AND AKD_DATA BETWEEN '"+DTOS(MV_par01)+"' AND '"+DTOS(MV_par02)+"' AND AKD_STATUS <> '3' "
		dbUseArea(.T.,"TOPCONN",TCGenQry(,,cQuery1),'TRBPCO',.F.,.T.)
		DbSelectArea("TRBPCO")
		cObsCam:=""
		If !EOF()
			cObsCam := ValCampo("FIS")
			If nOpca == 1  
		   		cTipo:='COMPRAS NF'
				aadd(aXLista,{cAlias,cTipo,TRBSD1->D1_FILIAL,TRBSD1->D1_DOC,TRBSD1->D1_CC,TRBSD1->B1_CTAPCO,Transform(TRBSD1->D1_TOTAL,"@E 99,999,999.99"),"PCO",TRBPCO->AKD_CLASSE,TRBPCO->AKD_NUMDOC,TRBPCO->AKD_CC,TRBPCO->AKD_CO,Transform(TRBPCO->AKD_VALOR1,"@E 99,999,999.99"),TRBSD1->R_E_C_N_O_,"NOTA FISCAL DE ENTRADA","","",TRBSD1->D1_FORNECE,TRBSD1-> A2_NOME,USRRETNAME(SUBSTR(EMBARALHA(TRBSD1->D1_USERLGI,1),3,6)),ALLTRIM(TRBSD1->D1_COD)+" - "+ALLTRIM(TRBSD1->B1_DESC),LTRIM(cObsCam),TRBPCO->R_E_C_N_O_,TRBPCO->AKD_DATA,TRBPCO->AKD_PEDIDO,TRBPCO->AKD_INFOS1,TRBPCO->AKD_XFILIA,TRBPCO->AKD_DESCCO,TRBPCO->AKD_DESCCC,'SD1'+TRBSD1->(D1_FILIAL+D1_DOC+D1_SERIE+D1_FORNECE+D1_LOJA+D1_COD+D1_ITEM),"000054",TRBPCO->AKD_LOTE,TRBPCO->AKD_ID }) 
			EndIf
			If cObsCam != "" .AND. nOpca != 1 
				cTipo:='COMPRAS NF'
				aadd(aXLista,{cAlias,cTipo,TRBSD1->D1_FILIAL,TRBSD1->D1_DOC,TRBSD1->D1_CC,TRBSD1->B1_CTAPCO,Transform(TRBSD1->D1_TOTAL,"@E 99,999,999.99"),"PCO",TRBPCO->AKD_CLASSE,TRBPCO->AKD_NUMDOC,TRBPCO->AKD_CC,TRBPCO->AKD_CO,Transform(TRBPCO->AKD_VALOR1,"@E 99,999,999.99"),TRBSD1->R_E_C_N_O_,"NOTA FISCAL DE ENTRADA","","",TRBSD1->D1_FORNECE,TRBSD1-> A2_NOME,USRRETNAME(SUBSTR(EMBARALHA(TRBSD1->D1_USERLGI,1),3,6)),ALLTRIM(TRBSD1->D1_COD)+" - "+ALLTRIM(TRBSD1->B1_DESC),LTRIM(cObsCam),TRBPCO->R_E_C_N_O_,TRBPCO->AKD_DATA,TRBPCO->AKD_PEDIDO,TRBPCO->AKD_INFOS1,TRBPCO->AKD_XFILIA,TRBPCO->AKD_DESCCO,TRBPCO->AKD_DESCCC,'SD1'+TRBSD1->(D1_FILIAL+D1_DOC+D1_SERIE+D1_FORNECE+D1_LOJA+D1_COD+D1_ITEM),"000054",TRBPCO->AKD_LOTE,TRBPCO->AKD_ID}) 
			EndIf	
		Else
			cTipo:='COMPRAS NF'
			cObsCam+="Registro nใo encontrado PCO"
			aadd(aXLista,{cAlias,cTipo,TRBSD1->D1_FILIAL,TRBSD1->D1_DOC,TRBSD1->D1_CC,TRBSD1->B1_CTAPCO,Transform(TRBSD1->D1_TOTAL,"@E 99,999,999.99"),"|"," "," "," "," ",Transform(0,"@E 99,999,999.99"),TRBSD1->R_E_C_N_O_,"NOTA FISCAL DE ENTRADA","","",TRBSD1->D1_FORNECE,TRBSD1->A2_NOME,USRRETNAME(SUBSTR(EMBARALHA(TRBSD1->D1_USERLGI,1),3,6)),ALLTRIM(TRBSD1->D1_COD)+" - "+ALLTRIM(TRBSD1->B1_DESC),LTRIM(cObsCam),0,TRBSD1->D1_DTDIGIT,TRBSD1->D1_PEDIDO,TRBSD1->D1_XOBS,"","","",'SD1'+TRBSD1->(D1_FILIAL+D1_DOC+D1_SERIE+D1_FORNECE+D1_LOJA+D1_COD+D1_ITEM),"000054","",""}) 
		EndIf
		TRBPCO->(DbCloseArea())
		DbSelectArea("TRBSD1")
		DBSKIP()
	End    
	TRBSD1->(DbCloseArea())
	cQuery:= " SELECT * FROM "+RETSQLNAME("AKD")+" WHERE AKD_DATA BETWEEN '"+DTOS(MV_par01)+"' AND '"+DTOS(MV_par02)+"' AND AKD_TPSALD = 'RE' "
	cQuery+= " AND AKD_PROCES = '000054' AND D_E_L_E_T_ <> '*' AND AKD_STATUS <> '3' "
	If cFilFil != ""
		cQuery+= " AND AKD_XFILIA = '"+cFilFil+"' "
	EndIf
	If cFilNum != ""
		cQuery+= " AND SUBSTR(AKD_NUMDOC,1,9) = '"+cFilNum+"' "
	EndIf
	If cFilCO != ""
		cQuery+= " AND AKD_CO = '"+cFilCO+"' "
	EndIf
	If cFilCC != ""
		cQuery+= " AND  AKD_CC = '"+cFilCC+"' "
	EndIf
	If cValor1 != 0
		cQuery+= " AND AKD_VALOR1 = "+STRTRAN(Transform(cValor1,"@E 99999999.99"),",",".")+" "
	EndIf
	dbUseArea(.T.,"TOPCONN",TCGenQry(,,cQuery),'TRBPCO',.F.,.T.)
	While !Eof()
		cQuery1:= " SELECT D1_FILIAL, D1_COD,D1_SERIE,D1_LOJA,D1_ITEM,D1_TIPO, B1_DESC, D1_FORNECE, A2_NOME, D1_EMISSAO, D1_DOC, D1_DTDIGIT,   "
		cQuery1+= " D1_CC, CTT_DESC01, B1_CTAPCO, D1_TOTAL, D1_XOBS,D1.R_E_C_N_O_,B1.B1_DESC,D1.D1_USERLGI,D1.D1_PEDIDO "
		cQuery1+= " FROM "+RETSQLNAME("SD1")+" D1   INNER JOIN "+RETSQLNAME("SB1")+" B1 ON (D1_COD = B1_COD  AND B1.D_E_L_E_T_ <> '*' )   "
		cQuery1+= " INNER JOIN "+RETSQLNAME("SA2")+" A2 ON (D1_FORNECE = A2_COD  AND D1_LOJA = A2_LOJA  AND A2.D_E_L_E_T_ <> '*' ) "
		cQuery1+= " LEFT OUTER JOIN "+RETSQLNAME("CTT")+" CTT  ON (CTT_CUSTO = D1_CC  AND CTT.D_E_L_E_T_ <> '*' ) "
		cQuery1+= " WHERE 0=0 AND D1.D_E_L_E_T_ <> '*' AND D1.D1_TIPO = 'N' AND "
		cQuery1+= " D1_DTDIGIT BETWEEN '"+DTOS(MV_par01)+"' AND '"+DTOS(MV_par02)+"' "
		cQuery1+= " AND D1.D1_FILIAL = '"+ALLTRIM(TRBPCO->AKD_XFILIA)+"' AND D1.D1_DOC='"+SUBSTR(TRBPCO->AKD_NUMDOC,1,9)+"' AND D1.D1_SERIE = '"+SUBSTR(TRBPCO->AKD_CHAVE,19,3)+"' "
		cQuery1+= " AND D1.D1_FORNECE = '"+SUBSTR(TRBPCO->AKD_CODFOR,1,6)+"' AND D1.D1_LOJA = '"+SUBSTR(TRBPCO->AKD_CHAVE,28,4)+"' AND D1.D1_COD = '"+SUBSTR(TRBPCO->AKD_CHAVE,32,15)+"' AND D1.D1_ITEM = '"+SUBSTR(TRBPCO->AKD_CHAVE,47,4)+"' " 
		cQuery1+= " UNION "
		cQuery1+= " SELECT D1_FILIAL, D1_COD,D1_SERIE,D1_LOJA,D1_ITEM,D1_TIPO, B1_DESC, D1_FORNECE, A1_NOME, D1_EMISSAO, D1_DOC, D1_DTDIGIT,  "
		cQuery1+= " D1_CC, CTT_DESC01, B1_CTAPCO, D1_TOTAL, D1_XOBS,D1.R_E_C_N_O_,B1.B1_DESC,D1.D1_USERLGI,D1.D1_PEDIDO " 
		cQuery1+= " FROM "+RETSQLNAME("SD1")+" D1   INNER JOIN "+RETSQLNAME("SB1")+" B1 ON (D1_COD = B1_COD  AND B1.D_E_L_E_T_ <> '*' ) "
		cQuery1+= " INNER JOIN "+RETSQLNAME("SA1")+" A1 ON (D1_FORNECE = A1_COD  AND D1_LOJA = A1_LOJA  AND A1.D_E_L_E_T_ <> '*' )  "
		cQuery1+= " LEFT OUTER JOIN "+RETSQLNAME("CTT")+" CTT  ON (CTT_CUSTO = D1_CC  AND CTT.D_E_L_E_T_ <> '*' ) "
		cQuery1+= " WHERE 0=0 AND D1.D_E_L_E_T_ <> '*' AND D1.D1_TIPO IN ('D','B')  "
		cQuery1+= " AND D1_DTDIGIT BETWEEN '"+DTOS(MV_par01)+"' AND '"+DTOS(MV_par02)+"' "
		cQuery1+= " AND D1.D1_FILIAL = '"+ALLTRIM(TRBPCO->AKD_XFILIA)+"' AND D1.D1_DOC='"+SUBSTR(TRBPCO->AKD_NUMDOC,1,9)+"' AND D1.D1_SERIE = '"+SUBSTR(TRBPCO->AKD_CHAVE,19,3)+"' "
		cQuery1+= " AND D1.D1_FORNECE = '"+SUBSTR(TRBPCO->AKD_CODFOR,1,6)+"' AND D1.D1_LOJA = '"+SUBSTR(TRBPCO->AKD_CHAVE,28,4)+"' AND D1.D1_COD = '"+SUBSTR(TRBPCO->AKD_CHAVE,32,15)+"' AND D1.D1_ITEM = '"+SUBSTR(TRBPCO->AKD_CHAVE,47,4)+"' " 
		cQuery1+= " ORDER BY D1_FILIAL,D1_DTDIGIT, D1_TIPO  "  "
		dbUseArea(.T.,"TOPCONN",TCGenQry(,,cQuery1),'TRBSD1',.F.,.T.)
		DbSelectArea("TRBSD1")
		cObsCam:=""
		If !EOF()
			/*
			cObsCam := ValCampo("FIS")
			If nOpca == 1
				cTipo:='COMPRAS NF'
				aadd(aXLista,{cAlias,cTipo,TRBSD1->D1_FILIAL,TRBSD1->D1_DOC,TRBSD1->D1_CC,TRBSD1->B1_CTAPCO,Transform(TRBSD1->D1_TOTAL,"@E 99,999,999.99"),"PCO",TRBPCO->AKD_CLASSE,TRBPCO->AKD_NUMDOC,TRBPCO->AKD_CC,TRBPCO->AKD_CO,Transform(TRBPCO->AKD_VALOR1,"@E 99,999,999.99"),TRBSD1->R_E_C_N_O_,"NOTA FISCAL DE ENTRADA","","",TRBSD1->D1_FORNECE,TRBSD1-> A2_NOME,USRRETNAME(SUBSTR(EMBARALHA(TRBSD1->D1_USERLGI,1),3,6)),ALLTRIM(TRBSD1->D1_COD)+" - "+ALLTRIM(TRBSD1->B1_DESC),LTRIM(cObsCam),TRBPCO->R_E_C_N_O_,TRBPCO->AKD_DATA,TRBPCO->AKD_PEDIDO,TRBPCO->AKD_INFOS1,TRBPCO->AKD_XFILIA,TRBPCO->AKD_DESCCO,TRBPCO->AKD_DESCCC,'SD1'+TRBSD1->(D1_FILIAL+D1_DOC+D1_SERIE+D1_FORNECE+D1_LOJA+D1_COD+D1_ITEM),"000054",TRBPCO->AKD_LOTE,TRBPCO->AKD_ID}) 
			EndIf
			If cObsCam != "" .AND. nOpca != 1 
				cTipo:='COMPRAS NF'
				aadd(aXLista,{cAlias,cTipo,TRBSD1->D1_FILIAL,TRBSD1->D1_DOC,TRBSD1->D1_CC,TRBSD1->B1_CTAPCO,Transform(TRBSD1->D1_TOTAL,"@E 99,999,999.99"),"PCO",TRBPCO->AKD_CLASSE,TRBPCO->AKD_NUMDOC,TRBPCO->AKD_CC,TRBPCO->AKD_CO,Transform(TRBPCO->AKD_VALOR1,"@E 99,999,999.99"),TRBSD1->R_E_C_N_O_,"NOTA FISCAL DE ENTRADA","","",TRBSD1->D1_FORNECE,TRBSD1-> A2_NOME,USRRETNAME(SUBSTR(EMBARALHA(TRBSD1->D1_USERLGI,1),3,6)),ALLTRIM(TRBSD1->D1_COD)+" - "+ALLTRIM(TRBSD1->B1_DESC),LTRIM(cObsCam),TRBPCO->R_E_C_N_O_,TRBPCO->AKD_DATA,TRBPCO->AKD_PEDIDO,TRBPCO->AKD_INFOS1,TRBPCO->AKD_XFILIA,TRBPCO->AKD_DESCCO,TRBPCO->AKD_DESCCC,'SD1'+TRBSD1->(D1_FILIAL+D1_DOC+D1_SERIE+D1_FORNECE+D1_LOJA+D1_COD+D1_ITEM),"000054",TRBPCO->AKD_LOTE,TRBPCO->AKD_ID}) 
			EndIf
			*/
		Else
			cTipo:="PCO"
			cObsCam+="Registro nใo encontrado Fiscal"
			aadd(aXLista,{"AKD",cTipo,"","","","",0,"PCO",TRBPCO->AKD_CLASSE,TRBPCO->AKD_NUMDOC,TRBPCO->AKD_CC,TRBPCO->AKD_CO,Transform(TRBPCO->AKD_VALOR1,"@E 99,999,999.99"),TRBPCO->R_E_C_N_O_,TRBPCO->AKD_HIST,TRBPCO->AKD_DESCCO,TRBPCO->AKD_DESCCC,TRBPCO->AKD_CODFOR,TRBPCO->AKD_DESCCF,TRBPCO->AKD_XUSER, TRBPCO->AKD_XITEM,LTRIM(cObsCam),TRBPCO->R_E_C_N_O_,TRBPCO->AKD_DATA,TRBPCO->AKD_PEDIDO,TRBPCO->AKD_INFOS1,TRBPCO->AKD_XFILIA,TRBPCO->AKD_DESCCO,TRBPCO->AKD_DESCCC,TRBPCO->AKD_CHAVE,TRBPCO->AKD_PROCES,TRBPCO->AKD_LOTE,TRBPCO->AKD_ID})
		EndIf
		TRBSD1->(DbCloseArea())
		DbSelectArea("TRBPCO")
		DBSKIP()
	End 
	TRBPCO->(DbCloseArea())

Return()   


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMPCO8FIS   บAutor  ณWanderson Liberdadeบ Data ณ  12/08/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณSeleciona registro no Requisi็ใo ao Armaz้m				   ฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ ValeCard                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/    

Static Function MPCO8ARM()
	Local cQuery:="" 
	Local cQuery1:=""   
	Local cObsCam	:="" 
	Local cAlias	:="SD3"

	cQuery:= " SELECT D3_FILIAL,D3_TM,D3_COD,D3_LOCAL,D3_NUMSEQ,D3_CF,B1_DESC,D3_DOC,D3_QUANT,D3_CUSTO1,  "
	cQuery+= " D3_CONTA,D3_EMISSAO,D3_CC,B1_CTAPCO,D3_USUARIO,"+RETSQLNAME("SD3")+".R_E_C_N_O_,B1_DESC   " 
	cQuery+= " FROM "+RETSQLNAME("SD3")+" ,"+RETSQLNAME("SB1")+"    "
	cQuery+= " WHERE 0=0 and D3_TM = '600' AND SD3010.D_E_L_E_T_ <> '*' AND SB1010.D_E_L_E_T_ <> '*' "
	cQuery+= " AND D3_EMISSAO BETWEEN '"+DTOS(MV_par01)+"' AND '"+DTOS(MV_par02)+"' AND D3_COD = B1_COD "
	If cFilFil != ""
		cQuery+= " AND D3_FILIAL = '"+cFilFil+"' "
	EndIf
	If cFilNum != ""
		cQuery+= " AND D3_DOC = '"+cFilNum+"' "
	EndIf
	If cFilCO != ""
		cQuery+= " AND SB1010.B1_CTAPCO = '"+cFilCO+"' "
	EndIf
	If cFilCC != ""
		cQuery+= " AND  D3_CC = '"+cFilCC+"' "
	EndIf
	If cValor1 != 0
		cQuery+= " AND D3_CUSTO1 = "+STRTRAN(Transform(cValor1,"@E 99999999.99"),",",".")+" "
	EndIf
	dbUseArea(.T.,"TOPCONN",TCGenQry(,,cQuery),'TRBSD1',.F.,.T.)
	cTipo:='ARMAZEM'

	While !Eof()
		cQuery1:= " SELECT AKD_DATA,AKD_CLASSE,AKD_NUMDOC,AKD_CC,AKD_CO,AKD_VALOR1,AKD_XFILIA,R_E_C_N_O_,AKD_PEDIDO,AKD_INFOS1,AKD_DESCCO,AKD_DESCCC,AKD_PROCES,AKD_CHAVE,AKD_LOTE,AKD_ID   "
		cQuery1+= " FROM "+RETSQLNAME("AKD")+" WHERE AKD_FILIAL = '"+xFilial("AKD")+"' AND D_E_L_E_T_ <> '*' AND AKD_CHAVE = 'SD3"+TRBSD1->(D3_FILIAL+D3_COD+D3_LOCAL+D3_NUMSEQ+D3_CF)+"' "
		cQuery1+= " AND AKD_DATA BETWEEN '"+DTOS(MV_par01)+"' AND '"+DTOS(MV_par02)+"' AND AKD_STATUS <> '3' "
		dbUseArea(.T.,"TOPCONN",TCGenQry(,,cQuery1),'TRBPCO',.F.,.T.)
		DbSelectArea("TRBPCO")
		cObsCam:=""
		If !EOF()
			cObsCam := ValCampo("ARM")
			If nOpca == 1
		   		cTipo:='ARMAZEM'
				aadd(aXLista,{cAlias,cTipo,TRBSD1->D3_FILIAL,TRBSD1->D3_DOC,TRBSD1->D3_CC,TRBSD1->B1_CTAPCO,Transform(TRBSD1->D3_CUSTO1,"@E 99,999,999.99"),"PCO",TRBPCO->AKD_CLASSE,TRBPCO->AKD_NUMDOC,TRBPCO->AKD_CC,TRBPCO->AKD_CO,Transform(TRBPCO->AKD_VALOR1,"@E 99,999,999.99"),TRBSD1->R_E_C_N_O_,"MOVIMENTOS INTERNOS - REQUISICAO","","","","",ALLTRIM(TRBSD1->D3_USUARIO),ALLTRIM(TRBSD1->D3_COD) + " - "+ALLTRIM(TRBSD1->B1_DESC),LTRIM(cObsCam),TRBPCO->R_E_C_N_O_,TRBPCO->AKD_DATA,TRBPCO->AKD_PEDIDO,TRBPCO->AKD_INFOS1,TRBPCO->AKD_XFILIA,TRBPCO->AKD_DESCCO,TRBPCO->AKD_DESCCC,'SD3'+TRBSD1->(D3_FILIAL+D3_COD+D3_LOCAL+D3_NUMSEQ+D3_CF),TRBPCO->AKD_PROCES,TRBPCO->AKD_LOTE,TRBPCO->AKD_ID}) 
			EndIf
			If cObsCam != "" .AND. nOpca != 1 
				cTipo:='ARMAZEM'
				aadd(aXLista,{cAlias,cTipo,TRBSD1->D3_FILIAL,TRBSD1->D3_DOC,TRBSD1->D3_CC,TRBSD1->B1_CTAPCO,Transform(TRBSD1->D3_CUSTO1,"@E 99,999,999.99"),"PCO",TRBPCO->AKD_CLASSE,TRBPCO->AKD_NUMDOC,TRBPCO->AKD_CC,TRBPCO->AKD_CO,Transform(TRBPCO->AKD_VALOR1,"@E 99,999,999.99"),TRBSD1->R_E_C_N_O_,"MOVIMENTOS INTERNOS - REQUISICAO","","","","",ALLTRIM(TRBSD1->D3_USUARIO),ALLTRIM(TRBSD1->D3_COD) + " - "+ALLTRIM(TRBSD1->B1_DESC),LTRIM(cObsCam),TRBPCO->R_E_C_N_O_,TRBPCO->AKD_DATA,TRBPCO->AKD_PEDIDO,TRBPCO->AKD_INFOS1,TRBPCO->AKD_XFILIA,TRBPCO->AKD_DESCCO,TRBPCO->AKD_DESCCC,'SD3'+TRBSD1->(D3_FILIAL+D3_COD+D3_LOCAL+D3_NUMSEQ+D3_CF),TRBPCO->AKD_PROCES,TRBPCO->AKD_LOTE,TRBPCO->AKD_ID}) 
			EndIf
		Else
			cTipo:='ARMAZEM'
			cObsCam+="Registro nใo encontrado PCO"
			aadd(aXLista,{cAlias,cTipo,TRBSD1->D3_FILIAL,TRBSD1->D3_DOC,TRBSD1->D3_CC,TRBSD1->B1_CTAPCO,Transform(TRBSD1->D3_CUSTO1,"@E 99,999,999.99"),"|"," "," "," "," ",Transform(0,"@E 99,999,999.99"),TRBSD1->R_E_C_N_O_,"MOVIMENTOS INTERNOS - REQUISICAO","","","","",ALLTRIM(TRBSD1->D3_USUARIO),ALLTRIM(TRBSD1->D3_COD)+" - "+ALLTRIM(TRBSD1->B1_DESC),LTRIM(cObsCam),0,TRBSD1->D3_EMISSAO,"","FIL: " +TRBSD1->D3_FILIAL + "MOV. INTERNO NUM: " + TRBSD1->D3_NUMSEQ + " PRODUTO: "+TRBSD1->D3_COD,"","","",'SD3'+TRBSD1->(D3_FILIAL+D3_COD+D3_LOCAL+D3_NUMSEQ+D3_CF),"000151","",""})  
		EndIf
		TRBPCO->(DbCloseArea())
		DbSelectArea("TRBSD1")
		DBSKIP()
	End    
	TRBSD1->(DbCloseArea())
	cQuery:= " SELECT * FROM "+RETSQLNAME("AKD")+" WHERE AKD_DATA BETWEEN '"+DTOS(MV_par01)+"' AND '"+DTOS(MV_par02)+"' AND AKD_TPSALD = 'RE' "
	cQuery+= " AND AKD_PROCES = '000151' AND D_E_L_E_T_ <> '*'  AND AKD_STATUS <> '3' "
	If cFilFil != ""
		cQuery+= " AND AKD_XFILIA = '"+cFilFil+"' "
	EndIf
	If cFilNum != ""
		cQuery+= " AND SUBSTR(AKD_NUMDOC,1,9) = '"+cFilNum+"' "
	EndIf
	If cFilCO != ""
		cQuery+= " AND AKD_CO = '"+cFilCO+"' "
	EndIf
	If cFilCC != ""
		cQuery+= " AND  AKD_CC = '"+cFilCC+"' "
	EndIf
	If cValor1 != 0
		cQuery+= " AND AKD_VALOR1 = "+STRTRAN(Transform(cValor1,"@E 99999999.99"),",",".")+" "
	EndIf
	dbUseArea(.T.,"TOPCONN",TCGenQry(,,cQuery),'TRBPCO',.F.,.T.)
	While !Eof()
		cQuery1:= " SELECT D3_FILIAL,D3_TM,D3_COD,D3_LOCAL,D3_NUMSEQ,D3_CF,B1_DESC,D3_DOC,D3_QUANT,D3_CUSTO1,   "
		cQuery1+= " D3_CONTA,D3_EMISSAO,D3_CC,B1_CTAPCO,D3_USUARIO,"+RETSQLNAME("SD3")+".R_E_C_N_O_,B1_DESC     "
		cQuery1+= " FROM "+RETSQLNAME("SD3")+" ,  "+RETSQLNAME("SB1")+"  "
		cQuery1+= " WHERE 0=0 and D3_TM = '600' AND SD3010.D_E_L_E_T_ <> '*' AND SB1010.D_E_L_E_T_ <> '*'  "
		cQuery1+= " AND D3_EMISSAO BETWEEN '"+DTOS(MV_par01)+"' AND '"+DTOS(MV_par02)+"' AND D3_COD = B1_COD "
		cQuery1+= " AND D3_FILIAL = '"+ALLTRIM(TRBPCO->AKD_XFILIA)+"' AND D3_COD = '"+ALLTRIM(SUBSTR(AKD_CHAVE,10,15))+"'  "
		cQuery1+= " AND D3_LOCAL  = '"+SUBSTR(AKD_CHAVE,25,2)+"'   AND D3_NUMSEQ  = '"+SUBSTR(AKD_CHAVE,27,6)+"' AND D3_CF =  '"+SUBSTR(AKD_CHAVE,33,3)+"' " 
		dbUseArea(.T.,"TOPCONN",TCGenQry(,,cQuery1),'TRBSD1',.F.,.T.)
		DbSelectArea("TRBSD1")
		cObsCam:=""
		If !EOF()
			/*
			cObsCam := ValCampo("ARM")
			If nOpca == 1
				cTipo:='ARMAZEM'
				aadd(aXLista,{cAlias,cTipo,TRBSD1->D3_FILIAL,TRBSD1->D3_DOC,TRBSD1->D3_CC,TRBSD1->B1_CTAPCO,Transform(TRBSD1->D3_CUSTO1,"@E 99,999,999.99"),"PCO",TRBPCO->AKD_CLASSE,TRBPCO->AKD_NUMDOC,TRBPCO->AKD_CC,TRBPCO->AKD_CO,Transform(TRBPCO->AKD_VALOR1,"@E 99,999,999.99"),TRBSD1->R_E_C_N_O_,"MOVIMENTOS INTERNOS - REQUISICAO","","","","",ALLTRIM(TRBSD1->D3_USUARIO),ALLTRIM(TRBSD1->D3_COD)+" - "+ALLTRIM(TRBSD1->B1_DESC),,LTRIM(cObsCam),TRBPCO->R_E_C_N_O_,TRBPCO->AKD_DATA,TRBPCO->AKD_PEDIDO,TRBPCO->AKD_INFOS1,TRBPCO->AKD_XFILIA,TRBPCO->AKD_DESCCO,TRBPCO->AKD_DESCCC,'SD3'+TRBSD1->(D3_FILIAL+D3_COD+D3_LOCAL+D3_NUMSEQ+D3_CF),TRBPCO->AKD_PROCES,TRBPCO->AKD_LOTE,TRBPCO->AKD_ID}) 
			EndIf
			If cObsCam != "" .AND. nOpca != 1 
				cTipo:='ARMAZEM'
				aadd(aXLista,{cAlias,cTipo,TRBSD1->D3_FILIAL,TRBSD1->D3_DOC,TRBSD1->D3_CC,TRBSD1->B1_CTAPCO,Transform(TRBSD1->D3_CUSTO1,"@E 99,999,999.99"),"PCO",TRBPCO->AKD_CLASSE,TRBPCO->AKD_NUMDOC,TRBPCO->AKD_CC,TRBPCO->AKD_CO,Transform(TRBPCO->AKD_VALOR1,"@E 99,999,999.99"),TRBSD1->R_E_C_N_O_,"MOVIMENTOS INTERNOS - REQUISICAO","","","","",ALLTRIM(TRBSD1->D3_USUARIO),ALLTRIM(TRBSD1->D3_COD) + " - "+ALLTRIM(TRBSD1->B1_DESC),LTRIM(cObsCam),TRBPCO->R_E_C_N_O_,TRBPCO->AKD_DATA,TRBPCO->AKD_PEDIDO,TRBPCO->AKD_INFOS1,TRBPCO->AKD_XFILIA,TRBPCO->AKD_DESCCO,TRBPCO->AKD_DESCCC,'SD3'+TRBSD1->(D3_FILIAL+D3_COD+D3_LOCAL+D3_NUMSEQ+D3_CF),TRBPCO->AKD_PROCES,TRBPCO->AKD_LOTE,TRBPCO->AKD_ID}) 
			EndIf
			*/
		Else
			cTipo:="PCO"
			cObsCam+="Registro nใo encontrado Fiscal"
			aadd(aXLista,{"AKD",cTipo,"","","","",0,"PCO",TRBPCO->AKD_CLASSE,TRBPCO->AKD_NUMDOC,TRBPCO->AKD_CC,TRBPCO->AKD_CO,Transform(TRBPCO->AKD_VALOR1,"@E 99,999,999.99"),TRBPCO->R_E_C_N_O_,,TRBPCO->AKD_HIST,TRBPCO->AKD_DESCCO,TRBPCO->AKD_DESCCC,TRBPCO->AKD_CODFOR,TRBPCO->AKD_DESCCF,TRBPCO->AKD_XUSER,TRBPCO->AKD_XITEM,RTRIM(cObsCam),TRBPCO->R_E_C_N_O_,TRBPCO->AKD_DATA,TRBPCO->AKD_PEDIDO,TRBPCO->AKD_INFOS1,,TRBPCO->AKD_XFILIA,TRBPCO->AKD_DESCCO,TRBPCO->AKD_DESCCC,TRBPCO->AKD_CHAVE,TRBPCO->AKD_PROCES,TRBPCO->AKD_LOTE,TRBPCO->AKD_ID})
		EndIf
		TRBSD1->(DbCloseArea())
		DbSelectArea("TRBPCO")
		DBSKIP()
	End 
	TRBPCO->(DbCloseArea())

Return()



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMPCO8COM   บAutor  ณWanderson Liberdadeบ Data ณ  18/08/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณSeleciona registro no Compras				   				   ฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ ValeCard                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/    

Static Function MPCO8COM()
	Local cQuery:="" 
	Local cQuery1:="" 
	Local cObsCam	:=""
	Local cAlias	:="SC7"   

	cQuery:= " SELECT C7_FILIAL, C7_NUM,C7_ITEM,C7_SEQUEN, C7_PRODUTO,C7_DESCRI, B1_DESC, C7_FORNECE, A2_NOME, C7_CC, C7_EMISSAO, C7_QUANT, C7_QUJE,   "
	cQuery+= " C7_TOTAL, B1_CTAPCO, C7_OBS,C7.R_E_C_N_O_ ,C7.C7_USERLGI "
	cQuery+= " FROM "+RETSQLNAME("SC7")+" C7 , "+RETSQLNAME("SB1")+" B1 , "+RETSQLNAME("SA2")+" A2    "
	cQuery+= " WHERE 0=0 AND B1.D_E_L_E_T_ <> '*' AND A2.D_E_L_E_T_ <> '*' AND C7.D_E_L_E_T_ <> '*'   "
	cQuery+= " AND C7_EMISSAO BETWEEN '"+DTOS(MV_par01)+"' AND '"+DTOS(MV_par02)+"' AND B1_COD = C7_PRODUTO AND C7_RESIDUO <> 'S' "
	cQuery+= " AND C7_FORNECE = A2_COD AND C7_LOJA = A2_LOJA "
	If cFilFil != ""
		cQuery+= " AND C7.C7_FILIAL = '"+cFilFil+"' "
	EndIf
	If cFilNum != ""
		cQuery+= " AND C7.C7_NUM = '"+cFilNum+"' "
	EndIf
	If cFilCO != ""
		cQuery+= " AND B1.B1_CTAPCO = '"+cFilCO+"' "
	EndIf
	If cFilCC != ""
		cQuery+= " AND  C7.C7_CC = '"+cFilCC+"' "
	EndIf
	If cValor1 != 0
		cQuery+= " AND C7.C7_TOTAL = "+STRTRAN(Transform(cValor1,"@E 99999999.99"),",",".")+" "
	EndIf
	cQuery+= " ORDER BY C7.C7_FILIAL " 
	dbUseArea(.T.,"TOPCONN",TCGenQry(,,cQuery),'TRBSD1',.F.,.T.)
	cTipo:='PEDIDO'
	cObsCam	:=""
	While !Eof()
		cQuery1:= " SELECT AKD_DATA,AKD_CLASSE,AKD_NUMDOC,AKD_CC,AKD_CO,AKD_VALOR1,AKD_XFILIA,R_E_C_N_O_,AKD_PEDIDO,AKD_INFOS1,AKD_DESCCO,AKD_DESCCC,AKD_PROCES,AKD_CHAVE,AKD_LOTE,AKD_ID    "
		cQuery1+= " FROM "+RETSQLNAME("AKD")+" WHERE AKD_FILIAL = '"+xFilial("AKD")+"' AND D_E_L_E_T_ <> '*' AND AKD_CHAVE = 'SC7"+TRBSD1->(C7_FILIAL+C7_NUM+C7_ITEM+C7_SEQUEN)+"' "
		cQuery1+= " AND AKD_DATA BETWEEN '"+DTOS(MV_par01)+"' AND '"+DTOS(MV_par02)+"' AND AKD_STATUS <> '3' "
		dbUseArea(.T.,"TOPCONN",TCGenQry(,,cQuery1),'TRBPCO',.F.,.T.)
		DbSelectArea("TRBPCO")
		cObsCam	:=""
		If !EOF()
			//Fun็ใo valida campos
			cObsCam := ValCampo("COM")
			If nOpca == 1
		   		cTipo:='PEDIDO'
				aadd(aXLista,{cAlias,cTipo,TRBSD1->C7_FILIAL,TRBSD1->C7_NUM,TRBSD1->C7_CC,TRBSD1->B1_CTAPCO,Transform(TRBSD1->C7_TOTAL,"@E 99,999,999.99"),"PCO",TRBPCO->AKD_CLASSE,TRBPCO->AKD_NUMDOC,TRBPCO->AKD_CC,TRBPCO->AKD_CO,Transform(TRBPCO->AKD_VALOR1,"@E 99,999,999.99"),TRBSD1->R_E_C_N_O_,"PEDIDO COMPRAS","","",TRBSD1->C7_FORNECE,TRBSD1->A2_NOME,USRRETNAME(SUBSTR(EMBARALHA(TRBSD1->C7_USERLGI,1),3,6)),ALLTRIM(TRBSD1->C7_PRODUTO)+" - "+ALLTRIM(TRBSD1->C7_DESCRI),LTRIM(cObsCam),TRBPCO->R_E_C_N_O_,TRBPCO->AKD_DATA,TRBPCO->AKD_PEDIDO,TRBPCO->AKD_INFOS1,TRBPCO->AKD_XFILIA,TRBPCO->AKD_DESCCO,TRBPCO->AKD_DESCCC,'SC7'+TRBSD1->(C7_FILIAL+C7_NUM+C7_ITEM+C7_SEQUEN),TRBPCO->AKD_PROCES,TRBPCO->AKD_LOTE,TRBPCO->AKD_ID}) 
			EndIf
			If cObsCam != "" .AND. nOpca != 1 
				cTipo:='PEDIDO'
				aadd(aXLista,{cAlias,cTipo,TRBSD1->C7_FILIAL,TRBSD1->C7_NUM,TRBSD1->C7_CC,TRBSD1->B1_CTAPCO,Transform(TRBSD1->C7_TOTAL,"@E 99,999,999.99"),"PCO",TRBPCO->AKD_CLASSE,TRBPCO->AKD_NUMDOC,TRBPCO->AKD_CC,TRBPCO->AKD_CO,Transform(TRBPCO->AKD_VALOR1,"@E 99,999,999.99"),TRBSD1->R_E_C_N_O_,"PEDIDO COMPRAS","","",TRBSD1->C7_FORNECE,TRBSD1->A2_NOME,USRRETNAME(SUBSTR(EMBARALHA(TRBSD1->C7_USERLGI,1),3,6)),ALLTRIM(TRBSD1->C7_PRODUTO)+" - "+ALLTRIM(TRBSD1->C7_DESCRI),LTRIM(cObsCam),TRBPCO->R_E_C_N_O_,TRBPCO->AKD_DATA,TRBPCO->AKD_PEDIDO,TRBPCO->AKD_INFOS1,TRBPCO->AKD_XFILIA,TRBPCO->AKD_DESCCO,TRBPCO->AKD_DESCCC,'SC7'+TRBSD1->(C7_FILIAL+C7_NUM+C7_ITEM+C7_SEQUEN),TRBPCO->AKD_PROCES,TRBPCO->AKD_LOTE,TRBPCO->AKD_ID}) 
			EndIf
		Else
			cTipo:='PEDIDO'
			cObsCam+="Registro nใo encontrado PCO"
			aadd(aXLista,{cAlias,cTipo,TRBSD1->C7_FILIAL,TRBSD1->C7_NUM,TRBSD1->C7_CC,TRBSD1->B1_CTAPCO,Transform(TRBSD1->C7_TOTAL,"@E 99,999,999.99"),"|"," "," "," "," ",Transform(0,"@E 99,999,999.99"),TRBSD1->R_E_C_N_O_,"PEDIDO COMPRAS","","",TRBSD1->C7_FORNECE,TRBSD1->A2_NOME,USRRETNAME(SUBSTR(EMBARALHA(TRBSD1->C7_USERLGI,1),3,6)),ALLTRIM(TRBSD1->C7_PRODUTO)+" - "+ALLTRIM(TRBSD1->C7_DESCRI),LTRIM(cObsCam),0,TRBSD1->C7_EMISSAO,"",SUBSTR(TRBSD1->C7_OBS,1,200),"","","",'SC7'+TRBSD1->(C7_FILIAL+C7_NUM+C7_ITEM+C7_SEQUEN),'000052',"",""})  
		EndIf
		TRBPCO->(DbCloseArea())
		DbSelectArea("TRBSD1")
		DBSKIP()
	End    
	TRBSD1->(DbCloseArea())
	cQuery:= " SELECT * FROM "+RETSQLNAME("AKD")+" WHERE AKD_DATA BETWEEN '"+DTOS(MV_par01)+"' AND '"+DTOS(MV_par02)+"' "
	cQuery+= " AND AKD_PROCES = '000052' AND D_E_L_E_T_ <> '*'  AND AKD_STATUS <> '3' "
	If cFilFil != ""
		cQuery+= " AND AKD_XFILIA = '"+cFilFil+"' "
	EndIf
	If cFilNum != ""
		cQuery+= " AND SUBSTR(AKD_NUMDOC,1,9) = '"+cFilNum+"' "
	EndIf
	If cFilCO != ""
		cQuery+= " AND AKD_CO = '"+cFilCO+"' "
	EndIf
	If cFilCC != ""
		cQuery+= " AND  AKD_CC = '"+cFilCC+"' "
	EndIf
	If cValor1 != 0
		cQuery+= " AND AKD_VALOR1 = "+STRTRAN(Transform(cValor1,"@E 99999999.99"),",",".")+" "
	EndIf
	dbUseArea(.T.,"TOPCONN",TCGenQry(,,cQuery),'TRBPCO',.F.,.T.)
	While !Eof()
		cQuery1:= " SELECT C7_FILIAL, C7_NUM,C7_ITEM,C7_SEQUEN, C7_PRODUTO,C7_DESCRI, B1_DESC, C7_FORNECE, A2_NOME, C7_CC, C7_EMISSAO, C7_QUANT, C7_QUJE,   "
		cQuery1+= " C7_TOTAL, B1_CTAPCO, C7_OBS,C7.R_E_C_N_O_,C7.C7_USERLGI  "
		cQuery1+= " FROM "+RETSQLNAME("SC7")+" C7 , "+RETSQLNAME("SB1")+" B1 , "+RETSQLNAME("SA2")+" A2    "
		cQuery1+= " WHERE 0=0 AND B1.D_E_L_E_T_ <> '*' AND A2.D_E_L_E_T_ <> '*' AND C7.D_E_L_E_T_ <> '*'   "
		cQuery1+= " AND C7_EMISSAO BETWEEN '"+DTOS(MV_par01)+"' AND '"+DTOS(MV_par02)+"' AND B1_COD = C7_PRODUTO AND C7_RESIDUO <> 'S' "
		cQuery1+= " AND C7_FORNECE = A2_COD AND C7_LOJA = A2_LOJA AND C7_FILIAL = '"+ALLTRIM(TRBPCO->AKD_XFILIA)+"' "
		cQuery1+= "	AND C7_NUM = '"+ALLTRIM(TRBPCO->AKD_NUMDOC)+"' AND C7_ITEM = '"+SUBSTR(TRBPCO->AKD_CHAVE,16,4)+"' AND C7_SEQUEN = '"+SUBSTR(TRBPCO->AKD_CHAVE,20,4)+"'
		cQuery1+= " ORDER BY C7_FILIAL " 
		dbUseArea(.T.,"TOPCONN",TCGenQry(,,cQuery1),'TRBSD1',.F.,.T.)
		DbSelectArea("TRBSD1") 
		cObsCam	:=""
		If !EOF()
			/*
			cObsCam := ValCampo("COM")
			If nOpca == 1
		   		cTipo:='PEDIDO'
				aadd(aXLista,{cAlias,cTipo,TRBSD1->C7_FILIAL,TRBSD1->C7_NUM,TRBSD1->C7_CC,TRBSD1->B1_CTAPCO,Transform(TRBSD1->C7_TOTAL,"@E 99,999,999.99"),"PCO",TRBPCO->AKD_CLASSE,TRBPCO->AKD_NUMDOC,TRBPCO->AKD_CC,TRBPCO->AKD_CO,Transform(TRBPCO->AKD_VALOR1,"@E 99,999,999.99"),TRBSD1->R_E_C_N_O_,"PEDIDO COMPRAS","","",TRBSD1->C7_FORNECE,TRBSD1->A2_NOME,USRRETNAME(SUBSTR(EMBARALHA(TRBSD1->C7_USERLGI,1),3,6)),ALLTRIM(TRBSD1->C7_PRODUTO)+" - "+ALLTRIM(TRBSD1->C7_DESCRI),LTRIM(cObsCam),TRBPCO->R_E_C_N_O_,TRBPCO->AKD_DATA,TRBPCO->AKD_PEDIDO,TRBPCO->AKD_INFOS1,TRBPCO->AKD_XFILIA,TRBPCO->AKD_DESCCO,TRBPCO->AKD_DESCCC,'SC7'+TRBSD1->(C7_FILIAL+C7_NUM+C7_ITEM+C7_SEQUEN),TRBPCO->AKD_PROCES,TRBPCO->AKD_LOTE,TRBPCO->AKD_ID}) 
			EndIf
			If cObsCam != "" .AND. nOpca != 1 
				cTipo:='PEDIDO'
				aadd(aXLista,{cAlias,cTipo,TRBSD1->C7_FILIAL,TRBSD1->C7_NUM,TRBSD1->C7_CC,TRBSD1->B1_CTAPCO,Transform(TRBSD1->C7_TOTAL,"@E 99,999,999.99"),"PCO",TRBPCO->AKD_CLASSE,TRBPCO->AKD_NUMDOC,TRBPCO->AKD_CC,TRBPCO->AKD_CO,Transform(TRBPCO->AKD_VALOR1,"@E 99,999,999.99"),TRBSD1->R_E_C_N_O_,"PEDIDO COMPRAS","","",TRBSD1->C7_FORNECE,TRBSD1->A2_NOME,USRRETNAME(SUBSTR(EMBARALHA(TRBSD1->C7_USERLGI,1),3,6)),ALLTRIM(TRBSD1->C7_PRODUTO)+" - "+ALLTRIM(TRBSD1->C7_DESCRI),LTRIM(cObsCam),TRBPCO->R_E_C_N_O_,TRBPCO->AKD_DATA,TRBPCO->AKD_PEDIDO,TRBPCO->AKD_INFOS1,TRBPCO->AKD_XFILIA,TRBPCO->AKD_DESCCO,TRBPCO->AKD_DESCCC,'SC7'+TRBSD1->(C7_FILIAL+C7_NUM+C7_ITEM+C7_SEQUEN),TRBPCO->AKD_PROCES,TRBPCO->AKD_LOTE,TRBPCO->AKD_ID}) 
			EndIf
			*/
		Else
			cTipo:='PCO'
			cObsCam+="Registro nใo encontrado Compras"
			aadd(aXLista,{"AKD",cTipo,"","","","",0,"PCO",TRBPCO->AKD_CLASSE,TRBPCO->AKD_NUMDOC,TRBPCO->AKD_CC,TRBPCO->AKD_CO,Transform(TRBPCO->AKD_VALOR1,"@E 99,999,999.99"),TRBPCO->R_E_C_N_O_,TRBPCO->AKD_HIST,TRBPCO->AKD_DESCCO,TRBPCO->AKD_DESCCC,TRBPCO->AKD_CODFOR,TRBPCO->AKD_DESCCF,TRBPCO->AKD_XUSER, TRBPCO->AKD_XITEM,RTRIM(cObsCam),TRBPCO->R_E_C_N_O_,TRBPCO->AKD_DATA,TRBPCO->AKD_PEDIDO,TRBPCO->AKD_INFOS1,TRBPCO->AKD_XFILIA,TRBPCO->AKD_DESCCO,TRBPCO->AKD_DESCCC,TRBPCO->AKD_CHAVE,TRBPCO->AKD_PROCES,TRBPCO->AKD_LOTE,TRBPCO->AKD_ID})
		EndIf
		TRBSD1->(DbCloseArea())
		DbSelectArea("TRBPCO")
		DBSKIP()
	End 
	TRBPCO->(DbCloseArea())

Return()



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMPCO8CAP   บAutor  ณWanderson Liberdadeบ Data ณ  19/08/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณSeleciona registro no Contas a Pagar		   				   ฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ ValeCard                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/    

Static Function MPCO8CAP()
	Local cQuery:="" 
	Local cQuery1:="" 
	Local cObsCam	:=""  
	Local cAlias	:="SE2" 
	Local cPconat	:= GetMV("VL_PCOFNAT") 

	cQuery:= " SELECT E2_FILIAL, E2_NUM, E2_PARCELA, E2_TIPO,E2_PREFIXO, E2_FORNECE, E2_LOJA, E2_NOMFOR, E2_CCD, CTT_DESC01,    "
	cQuery+= " ED_CTAPCO, E2_NATUREZ, ED_DESCRIC, E2_EMISSAO, E2_EMIS1, E2_VALOR, E2_ORIGEM, E2_XORIGEM, E2_HIST, E2.R_E_C_N_O_,E2.E2_USERLGI  "
	cQuery+= " FROM "+RETSQLNAME("SE2")+" E2    "
	cQuery+= " LEFT OUTER JOIN "+RETSQLNAME("CTT")+" CTT  ON (CTT_CUSTO = E2_CCD  AND CTT.D_E_L_E_T_ <> '*' )  "
	cQuery+= " INNER JOIN "+RETSQLNAME("SED")+" ED  ON (   E2_NATUREZ = ED_CODIGO  AND ED.D_E_L_E_T_ <> '*' )  "
	cQuery+= " WHERE 0=0 AND E2.D_E_L_E_T_ <> '*' AND E2.E2_ORIGEM = 'FINA050' AND E2.E2_NATUREZ NOT IN ("+GetMV("VL_PCOFNAT")+") "
	cQuery+= " AND E2.E2_EMIS1 BETWEEN '"+DTOS(MV_par01)+"' AND '"+DTOS(MV_par02)+"' AND E2_XORIGEM = 'P' "
	If cFilFil != ""
		cQuery+= " AND E2.E2_FILIAL = '"+cFilFil+"' "
	EndIf
	If cFilNum != ""
		cQuery+= " AND E2.E2_NUM = '"+cFilNum+"' "
	EndIf
	If cFilCO != ""
		cQuery+= " AND ED.ED_CTAPCO = '"+cFilCO+"' "
	EndIf
	If cFilCC != ""
		cQuery+= " AND  E2.E2_CCD = '"+cFilCC+"' "
	EndIf
	If cValor1 != 0
		cQuery+= " AND E2.E2_VALOR = "+STRTRAN(Transform(cValor1,"@E 99999999.99"),",",".")+" "
	EndIf	  
	cQuery+= " ORDER BY E2_FILIAL,E2_NUM " 
	dbUseArea(.T.,"TOPCONN",TCGenQry(,,cQuery),'TRBSD1',.F.,.T.)
	cTipo:='C. A PAGAR'
	cObsCam	:=""
	While !Eof()
		cQuery1:= " SELECT AKD_DATA,AKD_CLASSE,AKD_NUMDOC,AKD_CC,AKD_CO,AKD_VALOR1,AKD_XFILIA,R_E_C_N_O_,AKD_PEDIDO,AKD_INFOS1,AKD_DESCCO,AKD_DESCCC,AKD_PROCES,AKD_CHAVE,AKD_LOTE,AKD_ID   "
		cQuery1+= " FROM "+RETSQLNAME("AKD")+" WHERE AKD_FILIAL = '"+xFilial("AKD")+"' AND D_E_L_E_T_ <> '*' AND AKD_CHAVE = 'SE2"+TRBSD1->(E2_FILIAL+E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO+E2_FORNECE+E2_LOJA)+"' "
		cQuery1+= " AND AKD_DATA BETWEEN '"+DTOS(MV_par01)+"' AND '"+DTOS(MV_par02)+"' AND AKD_STATUS <> '3' "
		dbUseArea(.T.,"TOPCONN",TCGenQry(,,cQuery1),'TRBPCO',.F.,.T.)
		DbSelectArea("TRBPCO")
		cObsCam	:=""
		If !EOF()
			//Fun็ใo valida campos
			cObsCam := ValCampo("CAP")
			If nOpca == 1
		   		cTipo:='C. A PAGAR'
				aadd(aXLista,{cAlias,cTipo,TRBSD1->E2_FILIAL,TRBSD1->E2_NUM,TRBSD1->E2_CCD,TRBSD1->ED_CTAPCO,Transform(TRBSD1->E2_VALOR,"@E 99,999,999.99"),"PCO",TRBPCO->AKD_CLASSE,TRBPCO->AKD_NUMDOC,TRBPCO->AKD_CC,TRBPCO->AKD_CO,Transform(TRBPCO->AKD_VALOR1,"@E 99,999,999.99"),TRBSD1->R_E_C_N_O_,"CONTAS A PAGAR","","",TRBSD1->E2_FORNECE,TRBSD1->E2_NOMFOR,USRRETNAME(SUBSTR(EMBARALHA(TRBSD1->E2_USERLGI,1),3,6)),ALLTRIM(TRBSD1->E2_NATUREZ)+" - "+ALLTRIM(TRBSD1->ED_DESCRIC),LTRIM(cObsCam),TRBPCO->R_E_C_N_O_,TRBPCO->AKD_DATA,TRBPCO->AKD_PEDIDO,TRBPCO->AKD_INFOS1,TRBPCO->AKD_XFILIA,TRBPCO->AKD_DESCCO,TRBPCO->AKD_DESCCC,'SE2'+TRBSD1->(E2_FILIAL+E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO+E2_FORNECE+E2_LOJA),TRBPCO->AKD_PROCES,TRBPCO->AKD_LOTE,TRBPCO->AKD_ID})
			EndIf
			If cObsCam != "" .AND. nOpca != 1 
				cTipo:='C. A PAGAR'
				aadd(aXLista,{cAlias,cTipo,TRBSD1->E2_FILIAL,TRBSD1->E2_NUM,TRBSD1->E2_CCD,TRBSD1->ED_CTAPCO,Transform(TRBSD1->E2_VALOR,"@E 99,999,999.99"),"PCO",TRBPCO->AKD_CLASSE,TRBPCO->AKD_NUMDOC,TRBPCO->AKD_CC,TRBPCO->AKD_CO,Transform(TRBPCO->AKD_VALOR1,"@E 99,999,999.99"),TRBSD1->R_E_C_N_O_,"CONTAS A PAGAR","","",TRBSD1->E2_FORNECE,TRBSD1->E2_NOMFOR,USRRETNAME(SUBSTR(EMBARALHA(TRBSD1->E2_USERLGI,1),3,6)),ALLTRIM(TRBSD1->E2_NATUREZ)+" - "+ALLTRIM(TRBSD1->ED_DESCRIC),LTRIM(cObsCam),TRBPCO->R_E_C_N_O_,TRBPCO->AKD_DATA,TRBPCO->AKD_PEDIDO,TRBPCO->AKD_INFOS1,TRBPCO->AKD_XFILIA,TRBPCO->AKD_DESCCO,TRBPCO->AKD_DESCCC,'SE2'+TRBSD1->(E2_FILIAL+E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO+E2_FORNECE+E2_LOJA),TRBPCO->AKD_PROCES,TRBPCO->AKD_LOTE,TRBPCO->AKD_ID}) 
			EndIf
		Else
			cTipo:='C. A PAGAR'
			cObsCam+="Registro nใo encontrado PCO"
			aadd(aXLista,{cAlias,cTipo,TRBSD1->E2_FILIAL,TRBSD1->E2_NUM,TRBSD1->E2_CCD,TRBSD1->ED_CTAPCO,Transform(TRBSD1->E2_VALOR,"@E 99,999,999.99"),"|"," "," "," "," ",Transform(0,"@E 99,999,999.99"),TRBSD1->R_E_C_N_O_,"CONTAS A PAGAR","","",TRBSD1->E2_FORNECE,TRBSD1->E2_NOMFOR,USRRETNAME(SUBSTR(EMBARALHA(TRBSD1->E2_USERLGI,1),3,6)),ALLTRIM(TRBSD1->E2_NATUREZ)+" - "+ALLTRIM(TRBSD1->ED_DESCRIC),LTRIM(cObsCam),0,TRBSD1->E2_EMISSAO,"",TRBSD1->E2_HIST,"","","",'SE2'+TRBSD1->(E2_FILIAL+E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO+E2_FORNECE+E2_LOJA),'000002',"",""}) 
		EndIf
		TRBPCO->(DbCloseArea())
		DbSelectArea("TRBSD1")
		DBSKIP()
	End    
	TRBSD1->(DbCloseArea())
	cQuery:= " SELECT * FROM "+RETSQLNAME("AKD")+" WHERE AKD_DATA BETWEEN '"+DTOS(MV_par01)+"' AND '"+DTOS(MV_par02)+"' "
	cQuery+= " AND AKD_PROCES = '000002' AND D_E_L_E_T_ <> '*'  AND AKD_STATUS <> '3' "
		If cFilFil != ""
		cQuery+= " AND AKD_XFILIA = '"+cFilFil+"' "
	EndIf
	If cFilNum != ""
		cQuery+= " AND SUBSTR(AKD_NUMDOC,1,9) = '"+cFilNum+"' "
	EndIf
	If cFilCO != ""
		cQuery+= " AND AKD_CO = '"+cFilCO+"' "
	EndIf
	If cFilCC != ""
		cQuery+= " AND  AKD_CC = '"+cFilCC+"' "
	EndIf
	If cValor1 != 0
		cQuery+= " AND AKD_VALOR1 = "+STRTRAN(Transform(cValor1,"@E 99999999.99"),",",".")+" "
	EndIf
	dbUseArea(.T.,"TOPCONN",TCGenQry(,,cQuery),'TRBPCO',.F.,.T.)
	While !Eof()
		cQuery1:= " SELECT E2_FILIAL, E2_NUM, E2_PARCELA, E2_TIPO,E2_PREFIXO, E2_FORNECE, E2_LOJA, E2_NOMFOR, E2_CCD, CTT_DESC01,    "
		cQuery1+= " ED_CTAPCO, E2_NATUREZ, ED_DESCRIC, E2_EMISSAO, E2_EMIS1, E2_VALOR, E2_ORIGEM, E2_XORIGEM, E2_HIST, E2.R_E_C_N_O_,E2_USERLGI  "
		cQuery1+= " FROM "+RETSQLNAME("SE2")+" E2    "
		cQuery1+= " LEFT OUTER JOIN "+RETSQLNAME("CTT")+" CTT  ON (CTT_CUSTO = E2_CCD  AND CTT.D_E_L_E_T_ <> '*' )  "
		cQuery1+= " INNER JOIN "+RETSQLNAME("SEd")+" ED  ON (   E2_NATUREZ = ED_CODIGO  AND ED.D_E_L_E_T_ <> '*' )  "
		cQuery1+= " WHERE 0=0 AND E2.D_E_L_E_T_ <> '*' AND E2.E2_ORIGEM = 'FINA050' AND E2.E2_NATUREZ NOT IN ("+cPconat+") "
		cQuery1+= " AND E2.E2_EMIS1 BETWEEN '"+DTOS(MV_par01)+"' AND '"+DTOS(MV_par02)+"' AND E2_XORIGEM = 'P' "
		cQuery1+= " AND E2.E2_FILIAL = '"+ALLTRIM(AKD_XFILIA)+"' AND E2.E2_PREFIXO = '"+SUBSTR(AKD_CHAVE,10,3)+"' AND E2.E2_NUM = '"+SUBSTR(AKD_CHAVE,13,9)+"'  " 
		cQuery1+= " AND E2.E2_PARCELA = '"+SUBSTR(AKD_CHAVE,22,2)+"' AND E2.E2_TIPO =  '"+SUBSTR(AKD_CHAVE,24,3)+"'  "
		cQuery1+= " AND E2.E2_FORNECE = '"+SUBSTR(AKD_CHAVE,27,6)+"' AND E2.E2_LOJA = '"+SUBSTR(AKD_CHAVE,33,4)+"'  " 
		cQuery1+= " ORDER BY E2_FILIAL " 
		dbUseArea(.T.,"TOPCONN",TCGenQry(,,cQuery1),'TRBSD1',.F.,.T.)
		DbSelectArea("TRBSD1")
		cObsCam:=""
		If !EOF()
			/*
			cObsCam := ValCampo("CAP")
			If nOpca == 1
		   		cTipo:='C. A PAGAR'
				aadd(aXLista,{cAlias,cTipo,TRBSD1->E2_FILIAL,TRBSD1->E2_NUM,TRBSD1->E2_CCD,TRBSD1->ED_CTAPCO,Transform(TRBSD1->E2_VALOR,"@E 99,999,999.99"),"PCO",TRBPCO->AKD_CLASSE,TRBPCO->AKD_NUMDOC,TRBPCO->AKD_CC,TRBPCO->AKD_CO,Transform(TRBPCO->AKD_VALOR1,"@E 99,999,999.99"),TRBSD1->R_E_C_N_O_,"CONTAS A PAGAR","","",TRBSD1->E2_FORNECE,TRBSD1->E2_NOMFOR,USRRETNAME(SUBSTR(EMBARALHA(TRBSD1->E2_USERLGI,1),3,6)),ALLTRIM(TRBSD1->E2_NATUREZ)+" - "+ALLTRIM(TRBSD1->ED_DESCRIC),LTRIM(cObsCam),TRBPCO->R_E_C_N_O_,TRBPCO->AKD_DATA,TRBPCO->AKD_PEDIDO,TRBPCO->AKD_INFOS1,TRBPCO->AKD_XFILIA,TRBPCO->AKD_DESCCO,TRBPCO->AKD_DESCCC,'SE2'+TRBSD1->(E2_FILIAL+E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO+E2_FORNECE+E2_LOJA),TRBPCO->AKD_PROCES,TRBPCO->AKD_LOTE,TRBPCO->AKD_ID})
			EndIf
			If cObsCam != "" .AND. nOpca != 1 
				cTipo:='C. A PAGAR'
				aadd(aXLista,{cAlias,cTipo,TRBSD1->E2_FILIAL,TRBSD1->E2_NUM,TRBSD1->E2_CCD,TRBSD1->ED_CTAPCO,Transform(TRBSD1->E2_VALOR,"@E 99,999,999.99"),"PCO",TRBPCO->AKD_CLASSE,TRBPCO->AKD_NUMDOC,TRBPCO->AKD_CC,TRBPCO->AKD_CO,Transform(TRBPCO->AKD_VALOR1,"@E 99,999,999.99"),TRBSD1->R_E_C_N_O_,"CONTAS A PAGAR","","",TRBSD1->E2_FORNECE,TRBSD1->E2_NOMFOR,USRRETNAME(SUBSTR(EMBARALHA(TRBSD1->E2_USERLGI,1),3,6)),ALLTRIM(TRBSD1->E2_NATUREZ)+" - "+ALLTRIM(TRBSD1->ED_DESCRIC),LTRIM(cObsCam),TRBPCO->R_E_C_N_O_,TRBPCO->AKD_DATA,TRBPCO->AKD_PEDIDO,TRBPCO->AKD_INFOS1,TRBPCO->AKD_XFILIA,TRBPCO->AKD_DESCCO,TRBPCO->AKD_DESCCC,'SE2'+TRBSD1->(E2_FILIAL+E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO+E2_FORNECE+E2_LOJA),TRBPCO->AKD_PROCES,TRBPCO->AKD_LOTE,TRBPCO->AKD_ID}) 
			EndIf 
			*/
		Else
			cTipo:='PCO'
			cObsCam+="Registro nใo encontrado Contas a Pagar"
			aadd(aXLista,{"AKD",cTipo,"","","","",0,"PCO",TRBPCO->AKD_CLASSE,TRBPCO->AKD_NUMDOC,TRBPCO->AKD_CC,TRBPCO->AKD_CO,Transform(TRBPCO->AKD_VALOR1,"@E 99,999,999.99"),TRBPCO->R_E_C_N_O_,TRBPCO->AKD_HIST,TRBPCO->AKD_DESCCO,TRBPCO->AKD_DESCCC,TRBPCO->AKD_CODFOR,TRBPCO->AKD_DESCCF,TRBPCO->AKD_XUSER, TRBPCO->AKD_XITEM,RTRIM(cObsCam),TRBPCO->R_E_C_N_O_,TRBPCO->AKD_DATA,TRBPCO->AKD_PEDIDO,TRBPCO->AKD_INFOS1,TRBPCO->AKD_XFILIA,TRBPCO->AKD_DESCCO,TRBPCO->AKD_DESCCC,TRBPCO->AKD_CHAVE,TRBPCO->AKD_PROCES,TRBPCO->AKD_LOTE,TRBPCO->AKD_ID})
		EndIf
		TRBSD1->(DbCloseArea())
		DbSelectArea("TRBPCO")
		DBSKIP()
	End 
	TRBPCO->(DbCloseArea())

Return()


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMPCO8CAP   บAutor  ณWanderson Liberdadeบ Data ณ  19/08/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณSeleciona registro no Contas a Pagar		   				   ฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ ValeCard                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/    

Static Function MPCO8CAX()
	Local cQuery:="" 
	Local cQuery1:="" 
	Local cObsCam	:=""  
	Local cAlias	:="SEU"  

	cQuery:= " SELECT EU.EU_FILIAL,EU.EU_NUM,EU.EU_CAIXA,EU.EU_TIPO,EU.EU_HISTOR,EU.EU_VALOR,EU.EU_FORNECE,EU.EU_BENEF,   "
	cQuery+= " EU.EU_EMISSAO,EU.EU_CCC,EU.EU_PRODUTO,B1.B1_CTAPCO,B1.B1_DESC,EU.R_E_C_N_O_,EU.EU_LOJA,EU.EU_USERLGI  "
	cQuery+= " FROM "+RETSQLNAME("SEU")+" EU ,"+RETSQLNAME("SB1")+" B1     "
	cQuery+= " WHERE  EU.EU_PRODUTO = B1.B1_COD AND EU.D_E_L_E_T_ <> '*' AND B1.D_E_L_E_T_ <> '*'  "
	cQuery+= " AND EU.EU_EMISSAO BETWEEN '"+DTOS(MV_par01)+"' AND '"+DTOS(MV_par02)+"' "
	If cFilFil != ""
		cQuery+= " AND EU.EU_FILIAL = '"+cFilFil+"' "
	EndIf
	If cFilNum != ""
		cQuery+= " AND EU.EU_NUM = '"+cFilNum+"' "
	EndIf
	If cFilCO != ""
		cQuery+= " AND B1.B1_CTAPCO = '"+cFilCO+"' "
	EndIf
	If cFilCC != ""
		cQuery+= " AND  EU.EU_CCC = '"+cFilCC+"' "
	EndIf
	If cValor1 != 0
		cQuery+= " AND EU.EU_VALOR = "+STRTRAN(Transform(cValor1,"@E 99999999.99"),",",".")+" "
	EndIf	  
	cQuery+= " ORDER BY EU.EU_FILIAL,EU.EU_NUM " 
	dbUseArea(.T.,"TOPCONN",TCGenQry(,,cQuery),'TRBSD1',.F.,.T.)
	cTipo:='CAIXINHA'
	cObsCam	:=""
	While !Eof()
		cQuery1:= " SELECT AKD_DATA,AKD_CLASSE,AKD_NUMDOC,AKD_CC,AKD_CO,AKD_VALOR1,AKD_XFILIA,R_E_C_N_O_,AKD_PEDIDO,AKD_INFOS1,AKD_DESCCO,AKD_DESCCC,AKD_PROCES,AKD_CHAVE,AKD_LOTE,AKD_ID   "
		cQuery1+= " FROM "+RETSQLNAME("AKD")+" WHERE AKD_FILIAL = '"+xFilial("AKD")+"' AND D_E_L_E_T_ <> '*' AND AKD_CHAVE = 'SEU"+TRBSD1->(EU_FILIAL+EU_NUM)+"' "
		cQuery1+= " AND AKD_DATA BETWEEN '"+DTOS(MV_par01)+"' AND '"+DTOS(MV_par02)+"' AND AKD_STATUS <> '3' "
		dbUseArea(.T.,"TOPCONN",TCGenQry(,,cQuery1),'TRBPCO',.F.,.T.)
		DbSelectArea("TRBPCO")
		cObsCam	:=""
		If !EOF()
			//Fun็ใo valida campos
			cObsCam := ValCampo("CAX")
			If nOpca == 1
		   		cTipo:='CAIXINHA'
				aadd(aXLista,{cAlias,cTipo,TRBSD1->EU_FILIAL,TRBSD1->EU_NUM,TRBSD1->EU_CCC,TRBSD1->B1_CTAPCO,Transform(TRBSD1->EU_VALOR,"@E 99,999,999.99"),"PCO",TRBPCO->AKD_CLASSE,TRBPCO->AKD_NUMDOC,TRBPCO->AKD_CC,TRBPCO->AKD_CO,Transform(TRBPCO->AKD_VALOR1,"@E 99,999,999.99"),TRBSD1->R_E_C_N_O_,"LCTO. CAIXINHA:","","",TRBSD1->EU_FORNECE,TRBSD1->EU_BENEF,USRRETNAME(SUBSTR(EMBARALHA(TRBSD1->EU_USERLGI,1),3,6)),ALLTRIM(TRBSD1->EU_PRODUTO)+" - "+ALLTRIM(TRBSD1->B1_DESC),LTRIM(cObsCam),TRBPCO->R_E_C_N_O_,TRBPCO->AKD_DATA,TRBPCO->AKD_PEDIDO,TRBPCO->AKD_INFOS1,TRBPCO->AKD_XFILIA,TRBPCO->AKD_DESCCO,TRBPCO->AKD_DESCCC,'SEU'+TRBSD1->(EU_FILIAL+EU_NUM),TRBPCO->AKD_PROCES,TRBPCO->AKD_LOTE,TRBPCO->AKD_ID})
			EndIf
			If cObsCam != "" .AND. nOpca != 1 
				cTipo:='CAIXINHA'
				aadd(aXLista,{cAlias,cTipo,TRBSD1->EU_FILIAL,TRBSD1->EU_NUM,TRBSD1->EU_CCC,TRBSD1->B1_CTAPCO,Transform(TRBSD1->EU_VALOR,"@E 99,999,999.99"),"PCO",TRBPCO->AKD_CLASSE,TRBPCO->AKD_NUMDOC,TRBPCO->AKD_CC,TRBPCO->AKD_CO,Transform(TRBPCO->AKD_VALOR1,"@E 99,999,999.99"),TRBSD1->R_E_C_N_O_,"LCTO. CAIXINHA:","","",TRBSD1->EU_FORNECE,TRBSD1->EU_BENEF,USRRETNAME(SUBSTR(EMBARALHA(TRBSD1->EU_USERLGI,1),3,6)),ALLTRIM(TRBSD1->EU_PRODUTO)+" - "+ALLTRIM(TRBSD1->B1_DESC),LTRIM(cObsCam),TRBPCO->R_E_C_N_O_,TRBPCO->AKD_DATA,TRBPCO->AKD_PEDIDO,TRBPCO->AKD_INFOS1,TRBPCO->AKD_XFILIA,TRBPCO->AKD_DESCCO,TRBPCO->AKD_DESCCC,'SEU'+TRBSD1->(EU_FILIAL+EU_NUM),TRBPCO->AKD_PROCES,TRBPCO->AKD_LOTE,TRBPCO->AKD_ID}) 
			EndIf
		Else
			cTipo:='CAIXINHA'
			cObsCam+="Registro nใo encontrado PCO"
			aadd(aXLista,{cAlias,cTipo,TRBSD1->EU_FILIAL,TRBSD1->EU_NUM,TRBSD1->EU_CCC,TRBSD1->B1_CTAPCO,Transform(TRBSD1->EU_VALOR,"@E 99,999,999.99"),"|"," "," "," "," ",Transform(0,"@E 99,999,999.99"),TRBSD1->R_E_C_N_O_,"LCTO. CAIXINHA:","","",TRBSD1->EU_FORNECE,TRBSD1->EU_BENEF,USRRETNAME(SUBSTR(EMBARALHA(TRBSD1->EU_USERLGI,1),3,6)),ALLTRIM(TRBSD1->EU_PRODUTO)+" - "+ALLTRIM(TRBSD1->B1_DESC),LTRIM(cObsCam),0,TRBSD1->EU_EMISSAO,"",TRBSD1->EU_CAIXA + " " +TRBSD1->EU_HISTOR,"","","",'SEU'+TRBSD1->(EU_FILIAL+EU_NUM),'000359',"",""}) 
		EndIf
		TRBPCO->(DbCloseArea())
		DbSelectArea("TRBSD1")
		DBSKIP()
	End    
	TRBSD1->(DbCloseArea())
	cQuery:= " SELECT * FROM "+RETSQLNAME("AKD")+" WHERE AKD_DATA BETWEEN '"+DTOS(MV_par01)+"' AND '"+DTOS(MV_par02)+"' "
	cQuery+= " AND AKD_PROCES = '000359' AND D_E_L_E_T_ <> '*'  AND AKD_STATUS <> '3' "
		If cFilFil != ""
		cQuery+= " AND AKD_XFILIA = '"+cFilFil+"' "
	EndIf
	If cFilNum != ""
		cQuery+= " AND SUBSTR(AKD_NUMDOC,1,9) = '"+cFilNum+"' "
	EndIf
	If cFilCO != ""
		cQuery+= " AND AKD_CO = '"+cFilCO+"' "
	EndIf
	If cFilCC != ""
		cQuery+= " AND  AKD_CC = '"+cFilCC+"' "
	EndIf
	If cValor1 != 0
		cQuery+= " AND AKD_VALOR1 = "+STRTRAN(Transform(cValor1,"@E 99999999.99"),",",".")+" "
	EndIf
	dbUseArea(.T.,"TOPCONN",TCGenQry(,,cQuery),'TRBPCO',.F.,.T.)
	While !Eof()
		cQuery1:= " SELECT EU.EU_FILIAL,EU.EU_NUM,EU.EU_CAIXA,EU.EU_TIPO,EU.EU_HISTOR,EU.EU_VALOR,EU.EU_FORNECE,EU.EU_BENEF,   "
		cQuery1+= " EU.EU_EMISSAO,EU.EU_CCC,EU.EU_PRODUTO,B1.B1_CTAPCO,B1.B1_DESC,EU.R_E_C_N_O_,EU.EU_LOJA,EU.EU_USERLGI "
		cQuery1+= " FROM "+RETSQLNAME("SEU")+" EU ,"+RETSQLNAME("SB1")+" B1     "
		cQuery1+= " WHERE  EU.EU_PRODUTO = B1.B1_COD AND EU.D_E_L_E_T_ <> '*' AND B1.D_E_L_E_T_ <> '*'  "
		cQuery1+= " AND EU.EU_EMISSAO BETWEEN '"+DTOS(MV_par01)+"' AND '"+DTOS(MV_par02)+"' "
		cQuery1+= " AND EU.EU_FILIAL = '"+ALLTRIM(AKD_XFILIA)+"' AND EU.EU_NUM = '"+(AKD_NUMDOC)+"' " 
		cQuery1+= " ORDER BY EU.EU_FILIAL,EU.EU_NUM " 
		dbUseArea(.T.,"TOPCONN",TCGenQry(,,cQuery1),'TRBSD1',.F.,.T.)
		DbSelectArea("TRBSD1")
		cObsCam:=""
		If !EOF()
		Else
			cTipo:='PCO'
			cObsCam+="Registro nใo encontrado Caixinha"
			aadd(aXLista,{"AKD",cTipo,"","","","",0,"PCO",TRBPCO->AKD_CLASSE,TRBPCO->AKD_NUMDOC,TRBPCO->AKD_CC,TRBPCO->AKD_CO,Transform(TRBPCO->AKD_VALOR1,"@E 99,999,999.99"),TRBPCO->R_E_C_N_O_,TRBPCO->AKD_HIST,TRBPCO->AKD_DESCCO,TRBPCO->AKD_DESCCC,TRBPCO->AKD_CODFOR,TRBPCO->AKD_DESCCF,TRBPCO->AKD_XUSER, TRBPCO->AKD_XITEM,RTRIM(cObsCam),TRBPCO->R_E_C_N_O_,TRBPCO->AKD_DATA,TRBPCO->AKD_PEDIDO,TRBPCO->AKD_INFOS1,TRBPCO->AKD_XFILIA,TRBPCO->AKD_DESCCO,TRBPCO->AKD_DESCCC,TRBPCO->AKD_CHAVE,TRBPCO->AKD_PROCES,TRBPCO->AKD_LOTE,TRBPCO->AKD_ID})
		EndIf
		TRBSD1->(DbCloseArea())
		DbSelectArea("TRBPCO")
		DBSKIP()
	End 
	TRBPCO->(DbCloseArea())

Return()





/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMPCO8CAP   บAutor  ณWanderson Liberdadeบ Data ณ  19/08/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณSeleciona registro no Financeiro - contas a pagar			   ฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ ValeCard                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/    

Static Function MPCO8CAP1()
	Local cQuery:="" 
	Local cQuery1:=""
	Local cObsCam	:="" 
	Local cAlias	:="SE2"    

	cQuery:=	" SELECT E2.E2_FILIAL,E2.E2_PREFIXO,E2.E2_NUM,E2.E2_PARCELA,E2.E2_LOJA,E2.E2_NATUREZ, E2.E2_ORIGEM, E2.E2_TIPO,E2.E2_EMISSAO,E2.E2_USERLGI, "
	cQuery+=    " E2.E2_FORNECE,E2.E2_NOMFOR,E2.E2_HIST,ED.ED_CODIGO,ED.ED_DESCRIC,ED.ED_CCD, ED.ED_CCC, ED.ED_CTAPCO, E2.E2_VALOR,E2.R_E_C_N_O_, "
	cQuery+=    " HM.ZHM_CLASSE,HN.ZHN_CCUSTO " 
	cQuery+=	" FROM "+RETSQLNAME("SE2")+" E2 , " +RETSQLNAME("SA2")+" A2 , " +RETSQLNAME("SED")+" ED ,  "
	cQuery+=	" "+RETSQLNAME("ZHN")+" HN ," +RETSQLNAME("ZHM")+" HM  "
	cQuery+=	" WHERE E2.E2_EMISSAO	>= '"+DtoS(MV_PAR01)+"' "
	cQuery+=	" AND E2.E2_EMISSAO 	<= '"+DtoS(MV_PAR02)+"' "
	cQuery+=	" AND E2.E2_FORNECE 	= A2.A2_COD" 
	cQuery+=	" AND E2.E2_LOJA 		= A2.A2_LOJA"
	cQuery+=	" AND E2.E2_NATUREZ		= ED.ED_CODIGO"
	cQuery+=	" AND E2.D_E_L_E_T_ 	= ' '"
	cQuery+=	" AND A2.D_E_L_E_T_ 	= ' '"
	cQuery+=	" AND ED.D_E_L_E_T_ 	= ' '"
	cQuery+=	" AND E2.E2_PREFIXO = 'ANT' AND E2.E2_TIPO <> 'TD-' "
   	cQuery+=	" AND HM.ZHM_FILCLA = E2.E2_FILIAL AND HM.ZHM_CLASSE = HN.ZHN_CLASSE AND HN.ZHN_NATURE = E2.E2_NATUREZ "
 	cQuery+=	" AND ZHN_CTAPCO = ED.ED_CTAPCO "
 	If cFilFil != ""
		cQuery+= " AND E2.E2_FILIAL = '"+cFilFil+"' "
	EndIf
	If cFilNum != ""
		cQuery+= " AND E2.E2_NUM = '"+cFilNum+"' "
	EndIf
	If cFilCO != ""
		cQuery+= " AND ED.ED_CTAPCO= '"+cFilCO+"' "
	EndIf
	If cFilCC != ""
		cQuery+= " AND  HN.ZHN_CCUSTO = '"+cFilCC+"' "
	EndIf
	If cValor1 != 0
		cQuery+= " AND E2.E2_VALOR = "+STRTRAN(Transform(cValor1,"@E 99999999.99"),",",".")+" "
	EndIf                                                                       
	dbUseArea(.T.,"TOPCONN",TCGenQry(,,cQuery),'TRBSD1',.F.,.T.)
	cTipo:='FIN - ANTECIPAวAO'
	cObsCam	:=""
	While !Eof()
		cQuery1:= " SELECT AKD_DATA,AKD_CLASSE,AKD_NUMDOC,AKD_CC,AKD_CO,AKD_VALOR1,AKD_XFILIA,R_E_C_N_O_,AKD_PEDIDO,AKD_INFOS1,AKD_DESCCO,AKD_DESCCC,AKD_PROCES,AKD_CHAVE,AKD_LOTE,AKD_ID    "
		cQuery1+= " FROM "+RETSQLNAME("AKD")+" WHERE AKD_FILIAL = '"+xFilial("AKD")+"' AND D_E_L_E_T_ <> '*' AND AKD_CHAVE = 'ZZGSE2"+TRBSD1->(PADR(cValToChar(R_E_C_N_O_),9,' ')+E2_FILIAL+E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO+E2_FORNECE+E2_LOJA)+"' "
		cQuery1+= " AND AKD_DATA BETWEEN '"+DTOS(MV_par01)+"' AND '"+DTOS(MV_par02)+"' AND AKD_STATUS <> '3' "
		dbUseArea(.T.,"TOPCONN",TCGenQry(,,cQuery1),'TRBPCO',.F.,.T.)
		DbSelectArea("TRBPCO")
		cObsCam	:=""
		If !EOF()
			//Fun็ใo valida campos
			cObsCam := ValCampo("FIN",TRBSD1->E2_FILIAL,TRBSD1->E2_NUM,TRBSD1->ZHN_CCUSTO,TRBSD1->ED_CTAPCO,TRBSD1->E2_VALOR)
			If nOpca == 1
		   		cTipo:='FIN - ANTECIPAวAO'
				aadd(aXLista,{cAlias,cTipo,TRBSD1->E2_FILIAL,TRBSD1->E2_NUM,TRBSD1->ZHN_CCUSTO,TRBSD1->ED_CTAPCO,Transform(TRBSD1->E2_VALOR,"@E 99,999,999.99"),"PCO",TRBPCO->AKD_CLASSE,TRBPCO->AKD_NUMDOC,TRBPCO->AKD_CC,TRBPCO->AKD_CO,Transform(TRBPCO->AKD_VALOR1,"@E 99,999,999.99"),TRBSD1->R_E_C_N_O_,"CONTAS A PAGAR","","",TRBSD1->E2_FORNECE,TRBSD1->E2_NOMFOR,USRRETNAME(SUBSTR(EMBARALHA(TRBSD1->E2_USERLGI,1),3,6)),ALLTRIM(TRBSD1->E2_NATUREZ)+" - "+ALLTRIM(TRBSD1->ED_DESCRIC),LTRIM(cObsCam),TRBPCO->R_E_C_N_O_,TRBPCO->AKD_DATA,TRBPCO->AKD_PEDIDO,TRBPCO->AKD_INFOS1,TRBPCO->AKD_XFILIA,TRBPCO->AKD_DESCCO,TRBPCO->AKD_DESCCC,'ZZGSE2'+TRBSD1->(PADR(cValToChar(R_E_C_N_O_),9,' ')+E2_FILIAL+E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO+E2_FORNECE+E2_LOJA),TRBPCO->AKD_PROCES,TRBPCO->AKD_LOTE,TRBPCO->AKD_ID})
			EndIf
			If cObsCam != "" .AND. nOpca != 1 
				cTipo:='FIN - ANTECIPAวAO'
				aadd(aXLista,{cAlias,cTipo,TRBSD1->E2_FILIAL,TRBSD1->E2_NUM,TRBSD1->ZHN_CCUSTO,TRBSD1->ED_CTAPCO,Transform(TRBSD1->E2_VALOR,"@E 99,999,999.99"),"PCO",TRBPCO->AKD_CLASSE,TRBPCO->AKD_NUMDOC,TRBPCO->AKD_CC,TRBPCO->AKD_CO,Transform(TRBPCO->AKD_VALOR1,"@E 99,999,999.99"),TRBSD1->R_E_C_N_O_,"CONTAS A PAGAR","","",TRBSD1->E2_FORNECE,TRBSD1->E2_NOMFOR,USRRETNAME(SUBSTR(EMBARALHA(TRBSD1->E2_USERLGI,1),3,6)),ALLTRIM(TRBSD1->E2_NATUREZ)+" - "+ALLTRIM(TRBSD1->ED_DESCRIC),LTRIM(cObsCam),TRBPCO->R_E_C_N_O_,TRBPCO->AKD_DATA,TRBPCO->AKD_PEDIDO,TRBPCO->AKD_INFOS1,TRBPCO->AKD_XFILIA,TRBPCO->AKD_DESCCO,TRBPCO->AKD_DESCCC,'ZZGSE2'+TRBSD1->(PADR(cValToChar(R_E_C_N_O_),9,' ')+E2_FILIAL+E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO+E2_FORNECE+E2_LOJA),TRBPCO->AKD_PROCES,TRBPCO->AKD_LOTE,TRBPCO->AKD_ID}) 
			EndIf
		Else
			cTipo:='FIN - ANTECIPAวAO'
			cObsCam+="Registro nใo encontrado PCO"
			aadd(aXLista,{cAlias,cTipo,TRBSD1->E2_FILIAL,TRBSD1->E2_NUM,TRBSD1->ZHN_CCUSTO,TRBSD1->ED_CTAPCO,Transform(TRBSD1->E2_VALOR,"@E 99,999,999.99"),"|"," "," "," "," ",Transform(0,"@E 99,999,999.99"),TRBSD1->R_E_C_N_O_,"CONTAS A PAGAR","","",TRBSD1->E2_FORNECE,TRBSD1->E2_NOMFOR,USRRETNAME(SUBSTR(EMBARALHA(TRBSD1->E2_USERLGI,1),3,6)),ALLTRIM(TRBSD1->E2_NATUREZ)+" - "+ALLTRIM(TRBSD1->ED_DESCRIC),LTRIM(cObsCam),0,TRBSD1->E2_EMISSAO,"",TRBSD1->E2_HIST,"","","",'ZZGSE2'+TRBSD1->(PADR(cValToChar(R_E_C_N_O_),9,' ')+E2_FILIAL+E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO+E2_FORNECE+E2_LOJA),'900014',"",""}) 
		EndIf 
		TRBPCO->(DbCloseArea())
		DbSelectArea("TRBSD1")
		DBSKIP()
	End    
	TRBSD1->(DbCloseArea())
	cQuery:= " SELECT * FROM "+RETSQLNAME("AKD")+" WHERE AKD_DATA BETWEEN '"+DTOS(MV_par01)+"' AND '"+DTOS(MV_par02)+"' "
	cQuery+= " AND AKD_PROCES = '900014' AND D_E_L_E_T_ <> '*'  AND AKD_STATUS <> '3' AND SUBSTR(AKD_CHAVE,4,3)= 'SE2' "
	If cFilFil != ""
		cQuery+= " AND AKD_XFILIA = '"+cFilFil+"' "
	EndIf
	If cFilNum != ""
		cQuery+= " AND SUBSTR(AKD_NUMDOC,1,9) = '"+cFilNum+"' "
	EndIf
	If cFilCO != ""
		cQuery+= " AND AKD_CO = '"+cFilCO+"' "
	EndIf
	If cFilCC != ""
		cQuery+= " AND  AKD_CC = '"+cFilCC+"' "
	EndIf
	If cValor1 != 0
		cQuery+= " AND AKD_VALOR1 = "+STRTRAN(Transform(cValor1,"@E 99999999.99"),",",".")+" "
	EndIf
	dbUseArea(.T.,"TOPCONN",TCGenQry(,,cQuery),'TRBPCO',.F.,.T.)
	While !Eof()
		cQuery1:= " SELECT E2.E2_FILIAL,E2.E2_PREFIXO,E2.E2_NUM,E2.E2_PARCELA,E2.E2_LOJA,E2.E2_NATUREZ, E2.E2_ORIGEM, E2.E2_TIPO,E2.E2_EMISSAO,E2.E2_USERLGI,  "
		cQuery1+= " E2.E2_FORNECE,E2.E2_NOMFOR,E2.E2_HIST,ED.ED_CODIGO,ED.ED_DESCRIC,ED.ED_CCD, ED.ED_CCC, ED.ED_CTAPCO, E2.E2_VALOR,E2.R_E_C_N_O_, "
		cQuery1+= " HM.ZHM_CLASSE,HN.ZHN_CCUSTO " 
		cQuery1+= " FROM "+RETSQLNAME("SE2")+" E2 , " +RETSQLNAME("SA2")+" A2 , " +RETSQLNAME("SED")+" ED , "
		cQuery1+= " "+RETSQLNAME("ZHN")+" HN ," +RETSQLNAME("ZHM")+" HM  "
		cQuery1+= " WHERE E2.E2_EMISSAO	>= '"+DtoS(MV_PAR01)+"' "
		cQuery1+= " AND E2.E2_EMISSAO 	<= '"+DtoS(MV_PAR02)+"' "
		cQuery1+= " AND E2.E2_FORNECE 	= A2.A2_COD AND E2.E2_LOJA 	= A2.A2_LOJA AND E2.E2_NATUREZ	= ED.ED_CODIGO" 
		cQuery1+= " AND E2.D_E_L_E_T_ <> '*' AND A2.D_E_L_E_T_ <> '*' AND ED.D_E_L_E_T_ <> '*'"
		cQuery1+= " AND E2.E2_PREFIXO = 'ANT'  AND E2.E2_TIPO <> 'TD-' "
		cQuery1+= " AND HM.ZHM_FILCLA = E2.E2_FILIAL AND HM.ZHM_CLASSE = HN.ZHN_CLASSE AND HN.ZHN_NATURE = E2.E2_NATUREZ "
 		cQuery1+= " AND ZHN_CTAPCO = ED.ED_CTAPCO "
   		cQuery1+= " AND E2.R_E_C_N_O_ = '"+SUBSTR(TRBPCO->AKD_CHAVE,7,9)+"' " 
		dbUseArea(.T.,"TOPCONN",TCGenQry(,,cQuery1),'TRBSD1',.F.,.T.)
		DbSelectArea("TRBSD1")
		If !EOF()
			/*
			cObsCam := ValCampo("FIN",TRBSD1->E2_FILIAL,TRBSD1->E2_NUM,TRBSD1->ZHN_CCUSTO,TRBSD1->ED_CTAPCO,TRBSD1->E2_VALOR)
			If nOpca == 1
		   		cTipo:='FIN - ANTECIPAวAO'
				aadd(aXLista,{cAlias,cTipo,TRBSD1->E2_FILIAL,TRBSD1->E2_NUM,TRBSD1->ZHN_CCUSTO,TRBSD1->ED_CTAPCO,Transform(TRBSD1->E2_VALOR,"@E 99,999,999.99"),"PCO",TRBPCO->AKD_CLASSE,TRBPCO->AKD_NUMDOC,TRBPCO->AKD_CC,TRBPCO->AKD_CO,Transform(TRBPCO->AKD_VALOR1,"@E 99,999,999.99"),TRBSD1->R_E_C_N_O_,"CONTAS A PAGAR","","",TRBSD1->E2_FORNECE,TRBSD1->E2_NOMFOR,USRRETNAME(SUBSTR(EMBARALHA(TRBSD1->E2_USERLGI,1),3,6)),ALLTRIM(TRBSD1->E2_NATUREZ)+" - "+ALLTRIM(TRBSD1->ED_DESCRIC),LTRIM(cObsCam),TRBPCO->R_E_C_N_O_,TRBPCO->AKD_DATA,TRBPCO->AKD_PEDIDO,TRBPCO->AKD_INFOS1,TRBPCO->AKD_XFILIA,TRBPCO->AKD_DESCCO,TRBPCO->AKD_DESCCC,'ZZGSE2'+TRBSD1->(PADR(cValToChar(R_E_C_N_O_),9,' ')+E2_FILIAL+E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO+E2_FORNECE+E2_LOJA),TRBPCO->AKD_PROCES,TRBPCO->AKD_LOTE,TRBPCO->AKD_ID})
			EndIf
			If cObsCam != "" .AND. nOpca != 1 
				cTipo:='FIN - ANTECIPAวAO'
				aadd(aXLista,{cAlias,cTipo,TRBSD1->E2_FILIAL,TRBSD1->E2_NUM,TRBSD1->ZHN_CCUSTO,TRBSD1->ED_CTAPCO,Transform(TRBSD1->E2_VALOR,"@E 99,999,999.99"),"PCO",TRBPCO->AKD_CLASSE,TRBPCO->AKD_NUMDOC,TRBPCO->AKD_CC,TRBPCO->AKD_CO,Transform(TRBPCO->AKD_VALOR1,"@E 99,999,999.99"),TRBSD1->R_E_C_N_O_,"CONTAS A PAGAR","","",TRBSD1->E2_FORNECE,TRBSD1->E2_NOMFOR,USRRETNAME(SUBSTR(EMBARALHA(TRBSD1->E2_USERLGI,1),3,6)),ALLTRIM(TRBSD1->E2_NATUREZ)+" - "+ALLTRIM(TRBSD1->ED_DESCRIC),LTRIM(cObsCam),TRBPCO->R_E_C_N_O_,TRBPCO->AKD_DATA,TRBPCO->AKD_PEDIDO,TRBPCO->AKD_INFOS1,TRBPCO->AKD_XFILIA,TRBPCO->AKD_DESCCO,TRBPCO->AKD_DESCCC,'ZZGSE2'+TRBSD1->(PADR(cValToChar(R_E_C_N_O_),9,' ')+E2_FILIAL+E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO+E2_FORNECE+E2_LOJA),TRBPCO->AKD_PROCES,TRBPCO->AKD_LOTE,TRBPCO->AKD_ID}) 
			EndIf
			*/
		Else
			cTipo:='PCO'
			cObsCam+="Registro nใo encontrado Contas a Pagar"
			aadd(aXLista,{"AKD",cTipo,"","","","",0,"PCO",TRBPCO->AKD_CLASSE,TRBPCO->AKD_NUMDOC,TRBPCO->AKD_CC,TRBPCO->AKD_CO,Transform(TRBPCO->AKD_VALOR1,"@E 99,999,999.99"),TRBPCO->R_E_C_N_O_,TRBPCO->AKD_HIST,TRBPCO->AKD_DESCCO,TRBPCO->AKD_DESCCC,TRBPCO->AKD_CODFOR,TRBPCO->AKD_DESCCF,TRBPCO->AKD_XUSER, TRBPCO->AKD_XITEM,RTRIM(cObsCam),TRBPCO->R_E_C_N_O_,TRBPCO->AKD_DATA,TRBPCO->AKD_PEDIDO,TRBPCO->AKD_INFOS1,TRBPCO->AKD_XFILIA,TRBPCO->AKD_DESCCO,TRBPCO->AKD_DESCCC,TRBPCO->AKD_CHAVE,TRBPCO->AKD_PROCES,TRBPCO->AKD_LOTE,TRBPCO->AKD_ID})
		EndIf
		TRBSD1->(DbCloseArea())
		DbSelectArea("TRBPCO")
		DBSKIP()
	End 
	TRBPCO->(DbCloseArea())

Return()


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMPCO8CAR   บAutor  ณWanderson Liberdadeบ Data ณ  19/08/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณSeleciona registro no Financeiro - Contas a Receber		   ฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ ValeCard                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/    

Static Function MPCO8CAR()
	Local cQuery	:="" 
	Local cQuery1	:=""
	Local cObsCam	:="" 
	Local cAlias	:="SE1"    

	cQuery:=	" SELECT E1.E1_FILIAL,E1.E1_BAIXA, E1.E1_MOVIMEN, E1.E1_NUM, E1.E1_NATUREZ, E1.E1_PARCELA, E1.E1_EMISSAO, E1.E1_EMIS1,E1.E1_USERLGI, "
	cQuery+=	" E1.E1_CLIENTE,E1.E1_RAZAO, E1.E1_LOJA,E1.E1_VALOR, E1.E1_TIPO, E1.E1_PREFIXO,E1.E1_HIST,ED.ED_CODIGO, ED.ED_DESCRIC,E1.R_E_C_N_O_, "
	cQuery+=	" ED.ED_CTAPCO,ED.ED_CCD,ED.ED_CCC,E1.E1_LA,E1.E1_NOMCLI,E1.R_E_C_N_O_ AS RECE1,HM.ZHM_CLASSE,HN.ZHN_CCUSTO  "
	cQuery+=	" FROM "+RETSQLNAME("SE1")+" E1 , " +RETSQLNAME("SED")+" ED ,"+RETSQLNAME("ZHN")+" HN ," +RETSQLNAME("ZHM")+" HM   "
	cQuery+=	" WHERE E1.E1_BAIXA 	>= '"+DtoS(MV_PAR01)+"'"
	cQuery+=	" AND E1.E1_BAIXA	 	<= '"+DtoS(MV_PAR02)+"'"
	cQuery+=	" AND E1.E1_NATUREZ 	= ED.ED_CODIGO "
	cQuery+=	" AND E1.D_E_L_E_T_ 	= ' ' "
	cQuery+=	" AND ED.D_E_L_E_T_ 	= ' ' "
	cQuery+=	" AND E1.E1_TIPO		= 'AB-' "
	cQuery+=	" AND HM.ZHM_FILCLA = E1.E1_FILIAL AND HM.ZHM_CLASSE = HN.ZHN_CLASSE AND HN.ZHN_NATURE = E1.E1_NATUREZ "
	cQuery+=	" AND ZHN_CTAPCO = ED.ED_CTAPCO AND HM.D_E_L_E_T_ <> '*' AND HN.D_E_L_E_T_ <> '*' "
	If cFilFil != ""
		cQuery+= " AND E1.E1_FILIAL = '"+cFilFil+"' "
	EndIf
	If cFilNum != ""
		cQuery+= " AND E1.E1_NUM = '"+cFilNum+"' "
	EndIf
	If cFilCO != ""
		cQuery+= " AND ED.ED_CTAPCO= '"+cFilCO+"' "
	EndIf
	If cFilCC != ""
		cQuery+= " AND  HN.ZHN_CCUSTO = '"+cFilCC+"' "
	EndIf
	If cValor1 != 0
		cQuery+= " AND E1.E1_VALOR = "+STRTRAN(Transform(cValor1,"@E 99999999.99"),",",".")+" "
	EndIf 
	cQuery+=	" ORDER BY E1.E1_MOVIMEN "
	dbUseArea(.T.,"TOPCONN",TCGenQry(,,cQuery),'TRBSD1',.F.,.T.)
	cTipo:='FIN - C.RECEBER AB-'
	cObsCam	:=""
	While !Eof()
		cQuery1:= " SELECT AKD_DATA,AKD_CLASSE,AKD_NUMDOC,AKD_CC,AKD_CO,AKD_VALOR1,AKD_XFILIA,R_E_C_N_O_,AKD_PEDIDO,AKD_INFOS1,AKD_DESCCO,AKD_DESCCC,AKD_PROCES,AKD_CHAVE,AKD_LOTE,AKD_ID    "
		cQuery1+= " FROM "+RETSQLNAME("AKD")+" WHERE AKD_FILIAL = '"+xFilial("AKD")+"' AND D_E_L_E_T_ <> '*' AND AKD_CHAVE = 'ZZGSE1"+TRBSD1->(PADR(cValToChar(R_E_C_N_O_),9,' ')+E1_FILIAL+E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO)+"' "
		cQuery1+= " AND AKD_DATA BETWEEN '"+DTOS(MV_par01)+"' AND '"+DTOS(MV_par02)+"' AND AKD_STATUS <> '3' "
		dbUseArea(.T.,"TOPCONN",TCGenQry(,,cQuery1),'TRBPCO',.F.,.T.)
		DbSelectArea("TRBPCO")
		cObsCam	:=""
		If !EOF()
			cObsCam := ValCampo("FIN",TRBSD1->E1_FILIAL,TRBSD1->E1_NUM,TRBSD1->ZHN_CCUSTO,TRBSD1->ED_CTAPCO,TRBSD1->E1_VALOR)
			If nOpca == 1
		   		cTipo:='FIN - C.RECEBER AB-'
				aadd(aXLista,{cAlias,cTipo,TRBSD1->E1_FILIAL,TRBSD1->E1_NUM,TRBSD1->ZHN_CCUSTO,TRBSD1->ED_CTAPCO,Transform(TRBSD1->E1_VALOR,"@E 99,999,999.99"),"PCO",TRBPCO->AKD_CLASSE,TRBPCO->AKD_NUMDOC,TRBPCO->AKD_CC,TRBPCO->AKD_CO,Transform(TRBPCO->AKD_VALOR1,"@E 99,999,999.99"),TRBSD1->R_E_C_N_O_,"CONTAS A RECEBER","","",TRBSD1->E1_CLIENTE,TRBSD1->E1_RAZAO,USRRETNAME(SUBSTR(EMBARALHA(TRBSD1->E1_USERLGI,1),3,6)),ALLTRIM(TRBSD1->E1_NATUREZ)+" - "+ALLTRIM(TRBSD1->ED_DESCRIC),LTRIM(cObsCam),TRBPCO->R_E_C_N_O_,TRBPCO->AKD_DATA,TRBPCO->AKD_PEDIDO,TRBPCO->AKD_INFOS1,TRBPCO->AKD_XFILIA,TRBPCO->AKD_DESCCO,TRBPCO->AKD_DESCCC,'ZZGSE1'+TRBSD1->(PADR(cValToChar(R_E_C_N_O_),9,' ')+E1_FILIAL+E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO),TRBPCO->AKD_PROCES,TRBPCO->AKD_LOTE,TRBPCO->AKD_ID}) 
			EndIf
			If cObsCam != "" .AND. nOpca != 1 
				cTipo:='FIN - C.RECEBER AB-'
				aadd(aXLista,{cAlias,cTipo,TRBSD1->E1_FILIAL,TRBSD1->E1_NUM,TRBSD1->ZHN_CCUSTO,TRBSD1->ED_CTAPCO,Transform(TRBSD1->E1_VALOR,"@E 99,999,999.99"),"PCO",TRBPCO->AKD_CLASSE,TRBPCO->AKD_NUMDOC,TRBPCO->AKD_CC,TRBPCO->AKD_CO,Transform(TRBPCO->AKD_VALOR1,"@E 99,999,999.99"),TRBSD1->R_E_C_N_O_,"CONTAS A RECEBER","","",TRBSD1->E1_CLIENTE,TRBSD1->E1_RAZAO,USRRETNAME(SUBSTR(EMBARALHA(TRBSD1->E1_USERLGI,1),3,6)),ALLTRIM(TRBSD1->E1_NATUREZ)+" - "+ALLTRIM(TRBSD1->ED_DESCRIC),LTRIM(cObsCam),TRBPCO->R_E_C_N_O_,TRBPCO->AKD_DATA,TRBPCO->AKD_PEDIDO,TRBPCO->AKD_INFOS1,TRBPCO->AKD_XFILIA,TRBPCO->AKD_DESCCO,TRBPCO->AKD_DESCCC,'ZZGSE1'+TRBSD1->(PADR(cValToChar(R_E_C_N_O_),9,' ')+E1_FILIAL+E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO),TRBPCO->AKD_PROCES,TRBPCO->AKD_LOTE,TRBPCO->AKD_ID}) 
			EndIf
		Else
			cTipo:='FIN - C.RECEBER AB-'                                                                                                                                                                                                                                                                                                                                                        
			cObsCam+="Registro nใo encontrado PCO"
			aadd(aXLista,{cAlias,cTipo,TRBSD1->E1_FILIAL,TRBSD1->E1_NUM,TRBSD1->ZHN_CCUSTO,TRBSD1->ED_CTAPCO,Transform(TRBSD1->E1_VALOR,"@E 99,999,999.99"),"|"," "," "," "," ",Transform(0,"@E 99,999,999.99"),TRBSD1->R_E_C_N_O_,"CONTAS A RECEBER","","",TRBSD1->E1_CLIENTE,TRBSD1->E1_RAZAO,USRRETNAME(SUBSTR(EMBARALHA(TRBSD1->E1_USERLGI,1),3,6)),ALLTRIM(TRBSD1->E1_NATUREZ)+" - "+ALLTRIM(TRBSD1->ED_DESCRIC),LTRIM(cObsCam),0,TRBSD1->E1_BAIXA,"",TRBSD1->E1_HIST,"","","",'ZZGSE1'+TRBSD1->(PADR(cValToChar(R_E_C_N_O_),9,' ')+E1_FILIAL+E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO),'900014',"",""})  
		EndIf
		TRBPCO->(DbCloseArea())
		DbSelectArea("TRBSD1")
		DBSKIP()
	End    
	TRBSD1->(DbCloseArea())
	cQuery:= " SELECT * FROM "+RETSQLNAME("AKD")+" WHERE AKD_DATA BETWEEN '"+DTOS(MV_par01)+"' AND '"+DTOS(MV_par02)+"' "
	cQuery+= " AND AKD_PROCES = '900014' AND D_E_L_E_T_ <> '*'  AND AKD_STATUS <> '3' AND SUBSTR(AKD_CHAVE,4,3)= 'SE1' "
	If cFilFil != ""
		cQuery+= " AND AKD_XFILIA = '"+cFilFil+"' "
	EndIf
	If cFilNum != ""
		cQuery+= " AND SUBSTR(AKD_NUMDOC,1,9) = '"+cFilNum+"' "
	EndIf
	If cFilCO != ""
		cQuery+= " AND AKD_CO = '"+cFilCO+"' "
	EndIf
	If cFilCC != ""
		cQuery+= " AND  AKD_CC = '"+cFilCC+"' "
	EndIf
	If cValor1 != 0
		cQuery+= " AND AKD_VALOR1 = "+STRTRAN(Transform(cValor1,"@E 99999999.99"),",",".")+" "
	EndIf
	dbUseArea(.T.,"TOPCONN",TCGenQry(,,cQuery),'TRBPCO',.F.,.T.) 

	While !Eof()
		cQuery1:= " SELECT E1.E1_FILIAL,E1.E1_BAIXA, E1.E1_MOVIMEN, E1.E1_NUM, E1.E1_NATUREZ, E1.E1_PARCELA, E1.E1_EMISSAO, E1.E1_EMIS1,E1.E1_USERLGI, "
		cQuery1+=	" E1.E1_CLIENTE,E1.E1_RAZAO, E1.E1_LOJA,E1.E1_VALOR, E1.E1_TIPO, E1.E1_PREFIXO, E1.E1_HIST,ED.ED_CODIGO, ED.ED_DESCRIC,E1.R_E_C_N_O_, "
		cQuery1+=	" ED.ED_CTAPCO,ED.ED_CCD,ED.ED_CCC,E1.E1_LA,E1.E1_NOMCLI,E1.R_E_C_N_O_ AS RECE1,HM.ZHM_CLASSE,HN.ZHN_CCUSTO  "
		cQuery1+=	" FROM "+RETSQLNAME("SE1")+" E1 , " +RETSQLNAME("SED")+" ED ,"+RETSQLNAME("ZHN")+" HN ," +RETSQLNAME("ZHM")+" HM   ""
		cQuery1+=	" WHERE E1.E1_BAIXA 	>= '"+DtoS(MV_PAR01)+"'"
		cQuery1+=	" AND E1.E1_BAIXA	 	<= '"+DtoS(MV_PAR02)+"'"
		cQuery1+=	" AND E1.E1_NATUREZ = ED.ED_CODIGO "
		cQuery1+=	" AND E1.D_E_L_E_T_ <> '*' AND ED.D_E_L_E_T_ 	= ' ' "
		cQuery1+=	" AND E1.E1_TIPO	= 'AB-' AND E1.R_E_C_N_O_ = '"+SUBSTR(TRBPCO->AKD_CHAVE,7,9)+"'  "
		cQuery1+=	" AND HM.ZHM_FILCLA = E1.E1_FILIAL AND HM.ZHM_CLASSE = HN.ZHN_CLASSE AND HN.ZHN_NATURE = E1.E1_NATUREZ "
		cQuery1+=	" AND ZHN_CTAPCO = ED.ED_CTAPCO AND HM.D_E_L_E_T_ <> '*' AND HN.D_E_L_E_T_ <> '*'   "
		cQuery1+=	" ORDER BY E1.E1_MOVIMEN " 
		dbUseArea(.T.,"TOPCONN",TCGenQry(,,cQuery1),'TRBSD1',.F.,.T.)
		DbSelectArea("TRBSD1")
		cObsCam	:=""
		If !EOF()
			/* 
			cObsCam := ValCampo("FIN",TRBSD1->E1_FILIAL,TRBSD1->E1_NUM,TRBSD1->ZHN_CCUSTO,TRBSD1->ED_CTAPCO,TRBSD1->E1_VALOR)
			If nOpca == 1
		   		cTipo:='FIN - C.RECEBER AB-'
				aadd(aXLista,{cAlias,cTipo,TRBSD1->E1_FILIAL,TRBSD1->E1_NUM,TRBSD1->ZHN_CCUSTO,TRBSD1->ED_CTAPCO,Transform(TRBSD1->E1_VALOR,"@E 99,999,999.99"),"PCO",TRBPCO->AKD_CLASSE,TRBPCO->AKD_NUMDOC,TRBPCO->AKD_CC,TRBPCO->AKD_CO,Transform(TRBPCO->AKD_VALOR1,"@E 99,999,999.99"),TRBSD1->R_E_C_N_O_,"CONTAS A RECEBER","","",TRBSD1->E1_CLIENTE,TRBSD1->E1_RAZAO,USRRETNAME(SUBSTR(EMBARALHA(TRBSD1->E1_USERLGI,1),3,6)),ALLTRIM(TRBSD1->E1_NATUREZ)+" - "+ALLTRIM(TRBSD1->ED_DESCRIC),LTRIM(cObsCam),TRBPCO->R_E_C_N_O_,TRBPCO->AKD_DATA,TRBPCO->AKD_PEDIDO,TRBPCO->AKD_INFOS1,TRBPCO->AKD_XFILIA,TRBPCO->AKD_DESCCO,TRBPCO->AKD_DESCCC,'ZZGSE1'+TRBSD1->(PADR(cValToChar(R_E_C_N_O_),9,' ')+E1_FILIAL+E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO),TRBPCO->AKD_PROCES,TRBPCO->AKD_LOTE,TRBPCO->AKD_ID}) 
			EndIf
			If cObsCam != "" .AND. nOpca != 1 
				cTipo:='FIN - C.RECEBER AB-'
				aadd(aXLista,{cAlias,cTipo,TRBSD1->E1_FILIAL,TRBSD1->E1_NUM,TRBSD1->ZHN_CCUSTO,TRBSD1->ED_CTAPCO,Transform(TRBSD1->E1_VALOR,"@E 99,999,999.99"),"PCO",TRBPCO->AKD_CLASSE,TRBPCO->AKD_NUMDOC,TRBPCO->AKD_CC,TRBPCO->AKD_CO,Transform(TRBPCO->AKD_VALOR1,"@E 99,999,999.99"),TRBSD1->R_E_C_N_O_,"CONTAS A RECEBER","","",TRBSD1->E1_CLIENTE,TRBSD1->E1_RAZAO,USRRETNAME(SUBSTR(EMBARALHA(TRBSD1->E1_USERLGI,1),3,6)),ALLTRIM(TRBSD1->E1_NATUREZ)+" - "+ALLTRIM(TRBSD1->ED_DESCRIC),LTRIM(cObsCam),TRBPCO->R_E_C_N_O_,TRBPCO->AKD_DATA,TRBPCO->AKD_PEDIDO,TRBPCO->AKD_INFOS1,TRBPCO->AKD_XFILIA,TRBPCO->AKD_DESCCO,TRBPCO->AKD_DESCCC,'ZZGSE1'+TRBSD1->(PADR(cValToChar(R_E_C_N_O_),9,' ')+E1_FILIAL+E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO),TRBPCO->AKD_PROCES,TRBPCO->AKD_LOTE,TRBPCO->AKD_ID}) 
			EndIf
			*/
		Else
			cTipo:='PCO'
			cObsCam+="Registro nใo encontrado Contas a Receber"
			aadd(aXLista,{"AKD",cTipo,"","","","",0,"PCO",TRBPCO->AKD_CLASSE,TRBPCO->AKD_NUMDOC,TRBPCO->AKD_CC,TRBPCO->AKD_CO,Transform(TRBPCO->AKD_VALOR1,"@E 99,999,999.99"),TRBPCO->R_E_C_N_O_,TRBPCO->AKD_HIST,TRBPCO->AKD_DESCCO,TRBPCO->AKD_DESCCC,TRBPCO->AKD_CODFOR,TRBPCO->AKD_DESCCF,TRBPCO->AKD_XUSER, TRBPCO->AKD_XITEM,RTRIM(cObsCam),TRBPCO->R_E_C_N_O_,TRBPCO->AKD_DATA,TRBPCO->AKD_PEDIDO,TRBPCO->AKD_INFOS1,TRBPCO->AKD_XFILIA,TRBPCO->AKD_DESCCO,TRBPCO->AKD_DESCCC,TRBPCO->AKD_CHAVE,TRBPCO->AKD_PROCES,TRBPCO->AKD_LOTE,TRBPCO->AKD_ID})
		EndIf
		TRBSD1->(DbCloseArea())
		DbSelectArea("TRBPCO")
		DBSKIP()
	End 
	TRBPCO->(DbCloseArea())

Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMPCO8MVB   บAutor  ณWanderson Liberdadeบ Data ณ  19/08/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณSeleciona registro no Financeiro - Movimenta็ใo Bancแria     ฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ ValeCard                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/    

Static Function MPCO8MVB()
	Local cQuery:="" 
	Local cQuery1:=""
	Local cNatFin	:= GetNewPar("VL_PCOFNAT",'')
	Local cObsCam	:=""
	Local cCC		:=""
	Local cClasse	:=""
	Local cAlias	:="SE5"     

	cQuery:=	" SELECT E5.E5_FILIAL, E5.E5_DTDISPO,E5.E5_VALOR, E5.E5_NATUREZ,E5.E5_RECPAG,E5.E5_CLIFOR,E5.E5_BENEF, E5.E5_NUMERO,E5.E5_VLJUROS, "
	cQuery+=	" E5.E5_VLMULTA, E5.E5_VLDESCO,E5.E5_HISTOR, ED.ED_CODIGO, ED.ED_DESCRIC, ED.ED_CTAPCO, ED.ED_CCC, ED.ED_CCD,E5.E5_USERLGI, "
	cQuery+=	" E5.R_E_C_N_O_ AS RECE5,E5.E5_TIPODOC,E5.E5_PREFIXO,E5.E5_PARCELA,E5.E5_TIPO,E5.E5_DATA,E5.E5_LOJA,E5.E5_SEQ,E5.R_E_C_N_O_ "
	cQuery+=	" FROM "+RETSQLNAME("SE5")+" E5 , " +RETSQLNAME("SED")+" ED  "
	cQuery+=	" WHERE E5.E5_DTDISPO >= '"+DtoS(MV_PAR01)+"'"
	cQuery+=	" AND E5.E5_DTDISPO	<= '"+DtoS(MV_PAR02)+"'"
	cQuery+=	" AND E5.E5_NATUREZ	= ED.ED_CODIGO "
	cQuery+=	" AND E5.E5_NATUREZ IN ("+cNatFin+") " 
	cQuery+=	" AND E5.D_E_L_E_T_	= ' '  "
	cQuery+=	" AND ED.D_E_L_E_T_	= ' '  "
	cQuery+=	" AND E5.E5_RECONC 	= 'x' "
	cQuery+=	" AND E5.E5_SITUACA <> 'C' "
	cQuery+=	" AND E5.E5_MOVCX   <> 'S' "           
	cQuery+=	" AND E5.E5_RECPAG IN ('P','R') "
	If cFilFil != ""
		cQuery+= " AND E5.E5_FILIAL = '"+cFilFil+"' "
	EndIf
	If cFilNum != ""
		cQuery+= " AND E5.E5_NUMERO = '"+cFilNum+"' "
	EndIf
	If cFilCO != ""
		cQuery+= " AND ED.ED_CTAPCO= '"+cFilCO+"' "
	EndIf
	If cValor1 != 0
		cQuery+= " AND E5.E5_VALOR = "+STRTRAN(Transform(cValor1,"@E 99999999.99"),",",".")+" "
	EndIf 
	cQuery+=	" ORDER BY E5.E5_FILIAL, E5.E5_DTDISPO, E5.R_E_C_N_O_ "
	dbUseArea(.T.,"TOPCONN",TCGenQry(,,cQuery),'TRBSD1',.F.,.T.)
	cTipo:='FIN - MOV. BANC.'
	cObsCam	:=""
	While !Eof()
		cQuery1:= " SELECT AKD_DATA,AKD_CLASSE,AKD_NUMDOC,AKD_CC,AKD_CO,AKD_VALOR1,AKD_XFILIA,R_E_C_N_O_,AKD_PEDIDO,AKD_INFOS1,AKD_DESCCO,AKD_DESCCC,AKD_PROCES,AKD_CHAVE,AKD_LOTE,AKD_ID    "
		cQuery1+= " FROM "+RETSQLNAME("AKD")+" WHERE AKD_FILIAL = '"+xFilial("AKD")+"' AND D_E_L_E_T_ <> '*' AND AKD_CHAVE = 'ZZGSE5"+TRBSD1->(PADR(cValToChar(RECE5),9,' ')+E5_FILIAL+E5_TIPODOC+E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_DATA+E5_CLIFOR+E5_LOJA+E5_SEQ)+"' "
		cQuery1+= " AND AKD_DATA BETWEEN '"+DTOS(MV_par01)+"' AND '"+DTOS(MV_par02)+"' AND AKD_STATUS <> '3' "
		dbUseArea(.T.,"TOPCONN",TCGenQry(,,cQuery1),'TRBPCO',.F.,.T.)
		DbSelectArea("TRBPCO")
		cObsCam	:=""
		//Encontra o centro de custo conforme regra Lin้ia passou
		cQry:=	"SELECT ZHM_CLASSE FROM "+RETSQLNAME("ZHM")+" WHERE D_E_L_E_T_ <> '*' AND ZHM_FILCLA= '"+ALLTRIM(TRBSD1->E5_FILIAL)+"' WHERE ROWNUM = 1 "
		dbUseArea(.T., "TOPCONN", TCGenQry(,,cQry), "LTRB2", .F., .T.)
		DbSelectArea("LTRB2")
		If !EOF()
			cClasse := LTRB2->ZHM_CLASSE
		Else
			cClasse:="      "
		EndIf
		LTRB2->(DbCloseArea())
		//Faz a busca da centro de custo na tabela de depara
		cQry:=	" SELECT ZHN_CCUSTO FROM "+RETSQLNAME("ZHN")+" WHERE D_E_L_E_T_ <> '*' AND ZHN_CLASSE = '"+ALLTRIM(cClasse)+"'  WHERE ROWNUM = 1 "
		cQry+=	" AND ZHN_NATURE = '"+ALLTRIM(TRBSD1->E5_NATUREZ)+"' AND ZHN_CTAPCO = '"+ALLTRIM(TRBSD1->ED_CTAPCO)+"'
		dbUseArea(.T., "TOPCONN", TCGenQry(,,cQry), "LTRB2", .F., .T.)
		DbSelectArea("LTRB2")
		If !EOF()
			cCCusto := LTRB2->ZHN_CCUSTO
		Else
			cCCusto:="           "
		EndIf
		LTRB2->(DbCloseArea())
		DbSelectArea("TRBPCO")
		If !EOF()
			If cFilCC != ""
				if ALLTRIM(cCCusto) != ALLTRIM(cFilCC)
					TRBPCO->(DbCloseArea())
					EXIT
				EndIf
			EndIf
			cObsCam := ValCampo("FIN",TRBSD1->E5_FILIAL,TRBSD1->E5_NUMERO,cCCusto,TRBSD1->ED_CTAPCO,TRBSD1->E5_VALOR)
			If nOpca == 1
		   		cTipo:='FIN - MOV. BANC.'
				aadd(aXLista,{cAlias,cTipo,TRBSD1->E5_FILIAL,TRBSD1->E5_NUMERO,cCCusto,TRBSD1->ED_CTAPCO,Transform(TRBSD1->E5_VALOR,"@E 99,999,999.99"),"PCO",TRBPCO->AKD_CLASSE,TRBPCO->AKD_NUMDOC,TRBPCO->AKD_CC,TRBPCO->AKD_CO,Transform(TRBPCO->AKD_VALOR1,"@E 99,999,999.99"),TRBSD1->R_E_C_N_O_,"MOVIMENTAวยO BANCARIA","","",TRBSD1->E5_CLIFOR,TRBSD1->E5_BENEF,USRRETNAME(SUBSTR(EMBARALHA(TRBSD1->E5_USERLGI,1),3,6)),ALLTRIM(TRBSD1->E5_NATUREZ)+" - "+ALLTRIM(TRBSD1->ED_DESCRIC),LTRIM(cObsCam),TRBPCO->R_E_C_N_O_,TRBPCO->AKD_DATA,TRBPCO->AKD_PEDIDO,TRBPCO->AKD_INFOS1,TRBPCO->AKD_XFILIA,TRBPCO->AKD_DESCCO,TRBPCO->AKD_DESCCC,'ZZGSE5'+TRBSD1->(PADR(cValToChar(RECE5),9,' ')+E5_FILIAL+E5_TIPODOC+E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_DATA+E5_CLIFOR+E5_LOJA+E5_SEQ),TRBPCO->AKD_PROCES,TRBPCO->AKD_LOTE,TRBPCO->AKD_ID})
			EndIf
			If cObsCam != "" .AND. nOpca != 1 
				cTipo:='FIN - MOV. BANC.'
				aadd(aXLista,{cAlias,cTipo,TRBSD1->E5_FILIAL,TRBSD1->E5_NUMERO,cCCusto,TRBSD1->ED_CTAPCO,Transform(TRBSD1->E5_VALOR,"@E 99,999,999.99"),"PCO",TRBPCO->AKD_CLASSE,TRBPCO->AKD_NUMDOC,TRBPCO->AKD_CC,TRBPCO->AKD_CO,Transform(TRBPCO->AKD_VALOR1,"@E 99,999,999.99"),TRBSD1->R_E_C_N_O_,"MOVIMENTAวยO BANCARIA","","",TRBSD1->E5_CLIFOR,TRBSD1->E5_BENEF,USRRETNAME(SUBSTR(EMBARALHA(TRBSD1->E5_USERLGI,1),3,6)),ALLTRIM(TRBSD1->E5_NATUREZ)+" - "+ALLTRIM(TRBSD1->ED_DESCRIC),LTRIM(cObsCam),TRBPCO->R_E_C_N_O_,TRBPCO->AKD_DATA,TRBPCO->AKD_PEDIDO,TRBPCO->AKD_INFOS1,TRBPCO->AKD_XFILIA,TRBPCO->AKD_DESCCO,TRBPCO->AKD_DESCCC,'ZZGSE5'+TRBSD1->(PADR(cValToChar(RECE5),9,' ')+E5_FILIAL+E5_TIPODOC+E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_DATA+E5_CLIFOR+E5_LOJA+E5_SEQ),TRBPCO->AKD_PROCES,TRBPCO->AKD_LOTE,TRBPCO->AKD_ID}) 
			EndIf
		Else
			cTipo:='FIN - MOV. BANC.'                                                                                                                                                                                                                                                          
			cObsCam+="Registro nใo encontrado PCO"
			aadd(aXLista,{cAlias,cTipo,TRBSD1->E5_FILIAL,TRBSD1->E5_NUMERO,cCCusto,TRBSD1->ED_CTAPCO,Transform(TRBSD1->E5_VALOR,"@E 99,999,999.99"),"|"," "," "," "," ",Transform(0,"@E 99,999,999.99"),TRBSD1->R_E_C_N_O_,"Mov. Banc.","","",TRBSD1->E5_CLIFOR,TRBSD1->E5_BENEF,USRRETNAME(SUBSTR(EMBARALHA(TRBSD1->E5_USERLGI,1),3,6)),ALLTRIM(TRBSD1->E5_NATUREZ)+" - "+ALLTRIM(TRBSD1->ED_DESCRIC),LTRIM(cObsCam),0,TRBSD1->E5_DTDISPO,"",TRBSD1->E5_HISTOR,"","","",'ZZGSE5'+TRBSD1->(PADR(cValToChar(RECE5),9,' ')+E5_FILIAL+E5_TIPODOC+E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_DATA+E5_CLIFOR+E5_LOJA+E5_SEQ),'900014',"",""}) 
		EndIf
		TRBPCO->(DbCloseArea())
		DbSelectArea("TRBSD1")
		DBSKIP()
	End    
	TRBSD1->(DbCloseArea())
	cQuery:= " SELECT * FROM "+RETSQLNAME("AKD")+" WHERE AKD_DATA BETWEEN '"+DTOS(MV_par01)+"' AND '"+DTOS(MV_par02)+"' "
	cQuery+= " AND AKD_PROCES = '900014' AND D_E_L_E_T_ <> '*'  AND AKD_STATUS <> '3' AND SUBSTR(AKD_CHAVE,4,3)= 'SE5' "
	If cFilFil != ""
		cQuery+= " AND AKD_XFILIA = '"+cFilFil+"' "
	EndIf
	If cFilNum != ""
		cQuery+= " AND SUBSTR(AKD_NUMDOC,1,9) = '"+cFilNum+"' "
	EndIf
	If cFilCO != ""
		cQuery+= " AND AKD_CO = '"+cFilCO+"' "
	EndIf
	If cFilCC != ""
		cQuery+= " AND  AKD_CC = '"+cFilCC+"' "
	EndIf
	If cValor1 != 0
		cQuery+= " AND AKD_VALOR1 = "+STRTRAN(Transform(cValor1,"@E 99999999.99"),",",".")+" "
	EndIf
	dbUseArea(.T.,"TOPCONN",TCGenQry(,,cQuery),'TRBPCO',.F.,.T.)
	While !Eof()
		cQuery1:=   " SELECT E5.E5_FILIAL, E5.E5_DTDISPO,E5.E5_VALOR, E5.E5_NATUREZ,E5.E5_RECPAG,E5.E5_CLIFOR,E5.E5_BENEF, E5.E5_NUMERO,E5.E5_VLJUROS, "
		cQuery1+=	" E5.E5_VLMULTA, E5.E5_VLDESCO,E5.E5_HISTOR, ED.ED_CODIGO, ED.ED_DESCRIC, ED.ED_CTAPCO, ED.ED_CCC, ED.ED_CCD,E5.E5_USERLGI, "
		cQuery1+=	" E5.R_E_C_N_O_ AS RECE5,E5.E5_TIPODOC,E5.E5_PREFIXO,E5.E5_PARCELA,E5.E5_TIPO,E5.E5_DATA,E5.E5_LOJA,E5.E5_SEQ,E5.R_E_C_N_O_ "
		cQuery1+=	" FROM "+RETSQLNAME("SE5")+" E5 , " +RETSQLNAME("SED")+" ED  "
		cQuery1+=	" WHERE E5.E5_DTDISPO >= '"+DtoS(MV_PAR01)+"'"
		cQuery1+=	" AND E5.E5_DTDISPO	<= '"+DtoS(MV_PAR02)+"'"
		cQuery1+=	" AND E5.E5_NATUREZ	= ED.ED_CODIGO "
		cQuery1+=	" AND E5.E5_NATUREZ IN ("+cNatFin+") " 
		cQuery1+=	" AND E5.D_E_L_E_T_	= ' '  "
		cQuery1+=	" AND ED.D_E_L_E_T_	= ' '  "
		cQuery1+=	" AND E5.E5_RECONC 	= 'x' "
		cQuery1+=	" AND E5.E5_SITUACA <> 'C' "
		cQuery1+=	" AND E5.E5_MOVCX   <> 'S' "           
		cQuery1+=	" AND E5.E5_RECPAG IN ('P','R') "
		cQuery1+=	" AND E5.R_E_C_N_O_ = '"+SUBSTR(TRBPCO->AKD_CHAVE,7,9)+"'  "
		cQuery1+=	" ORDER BY E5.E5_FILIAL, E5.E5_DTDISPO, E5.R_E_C_N_O_ " 
		dbUseArea(.T.,"TOPCONN",TCGenQry(,,cQuery1),'TRBSD1',.F.,.T.)
		DbSelectArea("TRBSD1")
		cObsCam	:=""
		/*
		//Encontra o centro de custo conforme regra Lin้ia passou
		cQry:=	"SELECT TOP 1 ZHM_CLASSE FROM "+RETSQLNAME("ZHM")+" WHERE D_E_L_E_T_ <> '*' AND ZHM_FILCLA= '"+ALLTRIM(TRBSD1->E5_FILIAL)+"' "
		dbUseArea(.T., "TOPCONN", TCGenQry(,,cQry), "LTRB2", .F., .T.)
		DbSelectArea("LTRB2")
		cClasse := LTRB2->ZHM_CLASSE
		LTRB2->(DbCloseArea())
		//Faz a busca da centro de custo na tabela de depara
		cQry:=	" SELECT TOP 1 ZHN_CCUSTO FROM "+RETSQLNAME("ZHN")+" WHERE D_E_L_E_T_ <> '*' AND ZHN_CLASSE = '"+ALLTRIM(cClasse)+"' "
		cQry+=	" AND ZHN_NATURE = '"+ALLTRIM(TRBSD1->E5_NATUREZ)+"' AND ZHN_CTAPCO = '"+ALLTRIM(TRBSD1->ED_CTAPCO)+"'
		dbUseArea(.T., "TOPCONN", TCGenQry(,,cQry), "LTRB2", .F., .T.)
		DbSelectArea("LTRB2")
		cCCusto := LTRB2->ZHN_CCUSTO
		LTRB2->(DbCloseArea())
		DbSelectArea("TRBSD1")
		*/
		If !EOF()
			/*
			cObsCam := ValCampo("FIN",TRBSD1->E5_FILIAL,TRBSD1->E5_NUMERO,cCCusto,TRBSD1->ED_CTAPCO,TRBSD1->E5_VALOR)
			If nOpca == 1
		   		cTipo:='FIN - MOV. BANC.'
				aadd(aXLista,{cAlias,cTipo,TRBSD1->E5_FILIAL,TRBSD1->E5_NUMERO,cCCusto,TRBSD1->ED_CTAPCO,Transform(TRBSD1->E5_VALOR,"@E 99,999,999.99"),"PCO",TRBPCO->AKD_CLASSE,TRBPCO->AKD_NUMDOC,TRBPCO->AKD_CC,TRBPCO->AKD_CO,Transform(TRBPCO->AKD_VALOR1,"@E 99,999,999.99"),TRBSD1->R_E_C_N_O_,"MOVIMENTAวยO BANCARIA","","",TRBSD1->E5_CLIFOR,TRBSD1->E5_BENEF,USRRETNAME(SUBSTR(EMBARALHA(TRBSD1->E5_USERLGI,1),3,6)),ALLTRIM(TRBSD1->E5_NATUREZ)+" - "+ALLTRIM(TRBSD1->ED_DESCRIC),LTRIM(cObsCam),TRBPCO->R_E_C_N_O_,TRBPCO->AKD_DATA,TRBPCO->AKD_PEDIDO,TRBPCO->AKD_INFOS1,TRBPCO->AKD_XFILIA,TRBPCO->AKD_DESCCO,TRBPCO->AKD_DESCCC,'ZZGSE5'+TRBSD1->(PADR(cValToChar(RECE5),9,' ')+E5_FILIAL+E5_TIPODOC+E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_DATA+E5_CLIFOR+E5_LOJA+E5_SEQ),TRBPCO->AKD_PROCES,TRBPCO->AKD_LOTE,TRBPCO->AKD_ID})
			EndIf
			If cObsCam != "" .AND. nOpca != 1 
				cTipo:='FIN - MOV. BANC.'
				aadd(aXLista,{cAlias,cTipo,TRBSD1->E5_FILIAL,TRBSD1->E5_NUMERO,cCCusto,TRBSD1->ED_CTAPCO,Transform(TRBSD1->E5_VALOR,"@E 99,999,999.99"),"PCO",TRBPCO->AKD_CLASSE,TRBPCO->AKD_NUMDOC,TRBPCO->AKD_CC,TRBPCO->AKD_CO,Transform(TRBPCO->AKD_VALOR1,"@E 99,999,999.99"),TRBSD1->R_E_C_N_O_,"MOVIMENTAวยO BANCARIA","","",TRBSD1->E5_CLIFOR,TRBSD1->E5_BENEF,USRRETNAME(SUBSTR(EMBARALHA(TRBSD1->E5_USERLGI,1),3,6)),ALLTRIM(TRBSD1->E5_NATUREZ)+" - "+ALLTRIM(TRBSD1->ED_DESCRIC),LTRIM(cObsCam),TRBPCO->R_E_C_N_O_,TRBPCO->AKD_DATA,TRBPCO->AKD_PEDIDO,TRBPCO->AKD_INFOS1,TRBPCO->AKD_XFILIA,TRBPCO->AKD_DESCCO,TRBPCO->AKD_DESCCC,'ZZGSE5'+TRBSD1->(PADR(cValToChar(RECE5),9,' ')+E5_FILIAL+E5_TIPODOC+E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_DATA+E5_CLIFOR+E5_LOJA+E5_SEQ),TRBPCO->AKD_PROCES,TRBPCO->AKD_LOTE,TRBPCO->AKD_ID}) 
			EndIf
			*/
		Else
			cTipo:='PCO'
			cObsCam+="Registro nใo encontrado Mov. Banc."
			aadd(aXLista,{"AKD",cTipo,"","","","",0,"PCO",TRBPCO->AKD_CLASSE,TRBPCO->AKD_NUMDOC,TRBPCO->AKD_CC,TRBPCO->AKD_CO,Transform(TRBPCO->AKD_VALOR1,"@E 99,999,999.99"),TRBPCO->R_E_C_N_O_,TRBPCO->AKD_HIST,TRBPCO->AKD_DESCCO,TRBPCO->AKD_DESCCC,TRBPCO->AKD_CODFOR,TRBPCO->AKD_DESCCF,TRBPCO->AKD_XUSER, TRBPCO->AKD_XITEM,RTRIM(cObsCam),TRBPCO->R_E_C_N_O_,TRBPCO->AKD_DATA,TRBPCO->AKD_PEDIDO,TRBPCO->AKD_INFOS1,TRBPCO->AKD_XFILIA,TRBPCO->AKD_DESCCO,TRBPCO->AKD_DESCCC,TRBPCO->AKD_CHAVE,TRBPCO->AKD_PROCES,TRBPCO->AKD_LOTE,TRBPCO->AKD_ID})
		EndIf
		TRBSD1->(DbCloseArea())
		DbSelectArea("TRBPCO")
		DBSKIP()
	End 
	TRBPCO->(DbCloseArea())

Return()


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMPCO8MVB   บAutor  ณWanderson Liberdadeบ Data ณ  28/08/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณSeleciona registro no Financeiro - Movimenta็ใo Bancแria     ฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ ValeCard                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/    

Static Function MPCO8MVB1()
	Local cQuery:="" 
	Local cQuery1:=""
	Local cObsCam	:=""
	Local cCC		:=""
	Local cClasse	:=""
	Local cAlias	:="SE5"    

	cQuery:=	" SELECT E5.E5_FILIAL, E5.E5_DTDISPO,E5.E5_VALOR, E5.E5_NATUREZ,E5.E5_RECPAG,E5.E5_CLIFOR,E5.E5_BENEF, E5.E5_NUMERO,E5.E5_VLJUROS, "
	cQuery+=	" E5.E5_VLMULTA, E5.E5_VLDESCO,E5.E5_HISTOR, ED.ED_CODIGO, ED.ED_DESCRIC, ED.ED_CTAPCO, ED.ED_CCC, ED.ED_CCD,E5.E5_USERLGI, "
	cQuery+=	" E5.R_E_C_N_O_ AS RECE5,E5.E5_TIPODOC,E5.E5_PREFIXO,E5.E5_PARCELA,E5.E5_TIPO,E5.E5_DATA,E5.E5_LOJA,E5.E5_SEQ,E5.R_E_C_N_O_ "
	cQuery+=	" FROM "+RETSQLNAME("SE5")+" E5 , " +RETSQLNAME("SED")+" ED  "
	cQuery+=	" WHERE E5.E5_DTDISPO		>= '"+DtoS(MV_PAR01)+"'"
	cQuery+=	" AND E5.E5_DTDISPO			<= '"+DtoS(MV_PAR02)+"'"
	cQuery+=	" AND E5.E5_NATUREZ		= ED.ED_CODIGO "
	cQuery+=	" AND E5.D_E_L_E_T_		= ' ' "
	cQuery+=	" AND ED.D_E_L_E_T_		= ' ' "
	cQuery+=	" AND (E5_VLJUROS > 0 OR E5_VLMULTA >0 OR E5_VLDESCO >0 ) "
	cQuery+=	" AND E5.E5_RECONC 		= 'x' "
	cQuery+=	" AND E5.E5_SITUACA 	<> 'C' "
	cQuery+=	" AND E5.E5_TIPO <> 'NCC' "           
	cQuery+=	" AND E5.E5_RECPAG IN ('P','R') "
	If cFilFil != ""
		cQuery+= " AND E5.E5_FILIAL = '"+cFilFil+"' "
	EndIf
	If cFilNum != ""
		cQuery+= " AND E5.E5_NUMERO = '"+cFilNum+"' "
	EndIf
	If cValor1 != 0
		cQuery+= " AND (E5_VLJUROS  = "+STRTRAN(Transform(cValor1,"@E 99999999.99"),",",".")+" " 
		cQuery+= " OR E5_VLMULTA = "+STRTRAN(Transform(cValor1,"@E 99999999.99"),",",".")+" "
		cQuery+= " OR E5_VLDESCO = "+STRTRAN(Transform(cValor1,"@E 99999999.99"),",",".")+" )  "
	EndIf 
	cQuery+=	" ORDER BY E5.E5_FILIAL, E5.E5_DTDISPO, E5.R_E_C_N_O_ "
	dbUseArea(.T.,"TOPCONN",TCGenQry(,,cQuery),'TRBSD1',.F.,.T.)
	cTipo:='FIN - MOV. BANC.'
	cObsCam	:=""
	
	While !Eof()
		//Encontra o centro de custo conforme regra Lin้ia passou
		cQry:=	"SELECT ZHM_CLASSE FROM "+RETSQLNAME("ZHM")+" WHERE D_E_L_E_T_ <> '*' AND ZHM_FILCLA= '"+ALLTRIM(TRBSD1->E5_FILIAL)+"'  WHERE ROWNUM = 1 "
		dbUseArea(.T., "TOPCONN", TCGenQry(,,cQry), "LTRB2", .F., .T.)
		DbSelectArea("LTRB2")
		cClasse := LTRB2->ZHM_CLASSE
		LTRB2->(DbCloseArea())
		DbSelectArea("TRBSD1")
		For _w:= 1 to 3
			cObsCam	:=""
			nValor :=	0
			cConta :=	""
			If TRBSD1->E5_RECPAG == "R"
				IF _w == 1 .And. TRBSD1->E5_VLJUROS <> 0
					nValor	:= TRBSD1->E5_VLJUROS
					cConta	:= "31107010104"
		        EndIf
		        IF _w == 2 .And. TRBSD1->E5_VLMULTA <> 0
					nValor	:= TRBSD1->E5_VLMULTA
					cConta	:= "31107010104"
		        EndIf
		        IF _w == 3 .And. TRBSD1->E5_VLDESCO <> 0
					nValor	:= TRBSD1->E5_VLDESCO
					cConta	:= "31107010203"
		        EndIf
		        cHistorico	:="MOVIMENTAวยO BANCARIA - RECEBER"
		   	EndIf 
		   	If TRBSD1->E5_RECPAG == "P"
				IF _w == 1 .And. TRBSD1->E5_VLJUROS <> 0
					nValor	:= TRBSD1->E5_VLJUROS
					cConta	:= "31107010204"
		        EndIf
		        IF _w == 2 .And. TRBSD1->E5_VLMULTA <> 0
					nValor	:= TRBSD1->E5_VLMULTA
					cConta	:= "31107010204"
		        EndIf
		        IF _w == 3 .And. TRBSD1->E5_VLDESCO <> 0
					nValor	:= TRBSD1->E5_VLDESCO
					cConta	:= "31107010102"
		        EndIf
		        cHistorico	:="MOVIMENTAวยO BANCARIA - PAGAR"
		   	EndIf
		   	cCCusto:="          "
		   	cCCusto:=u_PegaCC(cConta,cClasse)
		   	If cFilCC != ""
				if ALLTRIM(cCCusto) != ALLTRIM(cFilCC)
					EXIT
				EndIf
			EndIf
			If cFilCO != ""
				if ALLTRIM(cConta) != ALLTRIM(cFilCO)
					EXIT
				EndIf
			EndIf
			If nValor <> 0
			   	cQuery1:= " SELECT AKD_DATA,AKD_CLASSE,AKD_NUMDOC,AKD_CC,AKD_CO,AKD_VALOR1,AKD_XFILIA,R_E_C_N_O_,AKD_PEDIDO,AKD_INFOS1,AKD_DESCCO,AKD_DESCCC,AKD_PROCES,AKD_CHAVE,AKD_LOTE,AKD_ID    "
				cQuery1+= " FROM "+RETSQLNAME("AKD")+" WHERE AKD_FILIAL = '"+xFilial("AKD")+"' AND D_E_L_E_T_ <> '*' AND AKD_CHAVE = 'ZZG E5"+TRBSD1->(PADR(cValToChar(RECE5),9,' ')+E5_FILIAL+E5_TIPODOC+E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_DATA+E5_CLIFOR+E5_LOJA+E5_SEQ+cValToChar(_w))+"' "
				cQuery1+= " AND AKD_DATA BETWEEN '"+DTOS(MV_par01)+"' AND '"+DTOS(MV_par02)+"' AND AKD_STATUS <> '3' "
				dbUseArea(.T.,"TOPCONN",TCGenQry(,,cQuery1),'TRBPCO',.F.,.T.)
				DbSelectArea("TRBPCO")
				
				If !EOF()
					cObsCam := ValCampo("FIN",TRBSD1->E5_FILIAL,TRBSD1->E5_NUMERO,cCCusto,cConta,nValor)
					If nOpca == 1
				   		cTipo:='FIN - MOV. BANC.'
						aadd(aXLista,{cAlias,cTipo,TRBSD1->E5_FILIAL,TRBSD1->E5_NUMERO,cCCusto,cConta,Transform(nValor,"@E 99,999,999.99"),"PCO",TRBPCO->AKD_CLASSE,TRBPCO->AKD_NUMDOC,TRBPCO->AKD_CC,TRBPCO->AKD_CO,Transform(TRBPCO->AKD_VALOR1,"@E 99,999,999.99"),TRBSD1->R_E_C_N_O_,"MOVIMENTAวยO BANCARIA","","",TRBSD1->E5_CLIFOR,TRBSD1->E5_BENEF,USRRETNAME(SUBSTR(EMBARALHA(TRBSD1->E5_USERLGI,1),3,6)),ALLTRIM(TRBSD1->E5_NATUREZ)+" - "+ALLTRIM(TRBSD1->ED_DESCRIC),LTRIM(cObsCam),TRBPCO->R_E_C_N_O_,TRBPCO->AKD_DATA,TRBPCO->AKD_PEDIDO,TRBPCO->AKD_INFOS1,TRBPCO->AKD_XFILIA,TRBPCO->AKD_DESCCO,TRBPCO->AKD_DESCCC,'ZZG E5'+TRBSD1->(PADR(cValToChar(RECE5),9,' ')+E5_FILIAL+E5_TIPODOC+E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_DATA+E5_CLIFOR+E5_LOJA+E5_SEQ+cValToChar(_w)),TRBPCO->AKD_PROCES,TRBPCO->AKD_LOTE,TRBPCO->AKD_ID})
					EndIf
					If cObsCam != "" .AND. nOpca != 1 
						cTipo:='FIN - MOV. BANC.'
						aadd(aXLista,{cAlias,cTipo,TRBSD1->E5_FILIAL,TRBSD1->E5_NUMERO,cCCusto,cConta,Transform(nValor,"@E 99,999,999.99"),"PCO",TRBPCO->AKD_CLASSE,TRBPCO->AKD_NUMDOC,TRBPCO->AKD_CC,TRBPCO->AKD_CO,Transform(TRBPCO->AKD_VALOR1,"@E 99,999,999.99"),TRBSD1->R_E_C_N_O_,"MOVIMENTAวยO BANCARIA","","",TRBSD1->E5_CLIFOR,TRBSD1->E5_BENEF,USRRETNAME(SUBSTR(EMBARALHA(TRBSD1->E5_USERLGI,1),3,6)),ALLTRIM(TRBSD1->E5_NATUREZ)+" - "+ALLTRIM(TRBSD1->ED_DESCRIC),LTRIM(cObsCam),TRBPCO->R_E_C_N_O_,TRBPCO->AKD_DATA,TRBPCO->AKD_PEDIDO,TRBPCO->AKD_INFOS1,TRBPCO->AKD_XFILIA,TRBPCO->AKD_DESCCO,TRBPCO->AKD_DESCCC,'ZZG E5'+TRBSD1->(PADR(cValToChar(RECE5),9,' ')+E5_FILIAL+E5_TIPODOC+E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_DATA+E5_CLIFOR+E5_LOJA+E5_SEQ+cValToChar(_w)),TRBPCO->AKD_PROCES,TRBPCO->AKD_LOTE,TRBPCO->AKD_ID}) 
					EndIf
				Else
					cTipo:='FIN - MOV. BANC.'                                                                                                                                                                                                                                                          
					cObsCam+="Registro nใo encontrado PCO"
					aadd(aXLista,{cAlias,cTipo,TRBSD1->E5_FILIAL,TRBSD1->E5_NUMERO,cCCusto,cConta,Transform(nValor,"@E 99,999,999.99"),"|"," "," "," "," ",Transform(0,"@E 99,999,999.99"),TRBSD1->R_E_C_N_O_,"Mov. Banc.","","",TRBSD1->E5_CLIFOR,TRBSD1->E5_BENEF,USRRETNAME(SUBSTR(EMBARALHA(TRBSD1->E5_USERLGI,1),3,6)),ALLTRIM(TRBSD1->E5_NATUREZ)+" - "+ALLTRIM(TRBSD1->ED_DESCRIC),LTRIM(cObsCam),0,TRBSD1->E5_DTDISPO,"",TRBSD1->E5_HISTOR,"","","",'ZZG E5'+TRBSD1->(PADR(cValToChar(RECE5),9,' ')+E5_FILIAL+E5_TIPODOC+E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_DATA+E5_CLIFOR+E5_LOJA+E5_SEQ+cValToChar(_w)),'900014',"",""}) 
				EndIf
				TRBPCO->(DbCloseArea())
			EndIf
		Next _w
		DbSelectArea("TRBSD1")
		DBSKIP()
	End    
	TRBSD1->(DbCloseArea())
	cQuery:= " SELECT * FROM "+RETSQLNAME("AKD")+" WHERE AKD_DATA BETWEEN '"+DTOS(MV_par01)+"' AND '"+DTOS(MV_par02)+"' "
	cQuery+= " AND AKD_PROCES = '900014' AND D_E_L_E_T_ <> '*'  AND AKD_STATUS <> '3' AND SUBSTR(AKD_CHAVE,4,3)= ' E5'  "
		If cFilFil != ""
		cQuery+= " AND AKD_XFILIA = '"+cFilFil+"' "
	EndIf
	If cFilNum != ""
		cQuery+= " AND SUBSTR(AKD_NUMDOC,1,9) = '"+cFilNum+"' "
	EndIf
	If cFilCO != ""
		cQuery+= " AND AKD_CO = '"+cFilCO+"' "
	EndIf
	If cFilCC != ""
		cQuery+= " AND  AKD_CC = '"+cFilCC+"' "
	EndIf
	If cValor1 != 0
		cQuery+= " AND AKD_VALOR1 = "+STRTRAN(Transform(cValor1,"@E 99999999.99"),",",".")+" "
	EndIf
	dbUseArea(.T.,"TOPCONN",TCGenQry(,,cQuery),'TRBPCO',.F.,.T.)
	DBSELECTAREA("TRBPCO")
	DBGOTOP()
	While !Eof()
		nTipoW:=VAL(SUBSTR(TRBPCO->AKD_CHAVE,(LEN(ALLTRIM(TRBPCO->AKD_CHAVE))),1))
		
		cQuery1:=   " SELECT E5.E5_FILIAL, E5.E5_DTDISPO,E5.E5_VALOR, E5.E5_NATUREZ,E5.E5_RECPAG,E5.E5_CLIFOR,E5.E5_BENEF, E5.E5_NUMERO,E5.E5_VLJUROS, "
		cQuery1+=	" E5.E5_VLMULTA, E5.E5_VLDESCO,E5.E5_HISTOR, ED.ED_CODIGO, ED.ED_DESCRIC, ED.ED_CTAPCO, ED.ED_CCC, ED.ED_CCD,E5.E5_USERLGI, "
		cQuery1+=	" E5.R_E_C_N_O_ AS RECE5,E5.E5_TIPODOC,E5.E5_PREFIXO,E5.E5_PARCELA,E5.E5_TIPO,E5.E5_DATA,E5.E5_LOJA,E5.E5_SEQ,E5.R_E_C_N_O_ "
		cQuery1+=	" FROM "+RETSQLNAME("SE5")+" E5 , " +RETSQLNAME("SED")+" ED  "
		cQuery1+=	" WHERE E5.E5_DTDISPO >= '"+DtoS(MV_PAR01)+"'"
		cQuery1+=	" AND E5.E5_DTDISPO	<= '"+DtoS(MV_PAR02)+"'"
		cQuery1+=	" AND E5.E5_NATUREZ	= ED.ED_CODIGO "
		cQuery1+=	" AND E5.D_E_L_E_T_	= ' ' "
		cQuery1+=	" AND ED.D_E_L_E_T_	= ' ' "
		cQuery1+=	" AND (E5_VLJUROS > 0 OR E5_VLMULTA >0 OR E5_VLDESCO >0 ) "
		cQuery1+=	" AND E5.E5_RECONC 		= 'x' "
		cQuery1+=	" AND E5.E5_SITUACA 	<> 'C' "
		cQuery1+=	" AND E5.E5_TIPO <> 'NCC' "           
		cQuery1+=	" AND E5.E5_RECPAG IN ('P','R') "
		cQuery1+=	" AND E5.R_E_C_N_O_ = '"+SUBSTR(TRBPCO->AKD_CHAVE,7,9)+"'  "
		cQuery1+=	" ORDER BY E5.E5_FILIAL, E5.E5_DTDISPO, E5.R_E_C_N_O_ " 
		dbUseArea(.T.,"TOPCONN",TCGenQry(,,cQuery1),'TRBSD1',.F.,.T.)
		DbSelectArea("TRBSD1")
		cObsCam	:=""
		/*
		//Encontra o centro de custo conforme regra Lin้ia passou
		cQry:=	"SELECT TOP 1 ZHM_CLASSE FROM "+RETSQLNAME("ZHM")+" WHERE D_E_L_E_T_ <> '*' AND ZHM_FILCLA= '"+ALLTRIM(TRBSD1->E5_FILIAL)+"' "
		dbUseArea(.T., "TOPCONN", TCGenQry(,,cQry), "LTRB2", .F., .T.)
		DbSelectArea("LTRB2")
		cClasse := LTRB2->ZHM_CLASSE
		LTRB2->(DbCloseArea())
		DbSelectArea("TRBSD1")
		For _w:= 1 to 3
			cObsCam	:=""
			nValor :=	0
			cConta :=	""
		
			If TRBSD1->E5_RECPAG == "R"
				IF ntipoW == 1 .AND. _w== 1 .AND. TRBSD1->E5_VLJUROS <> 0
					nValor	:= TRBSD1->E5_VLJUROS
					cConta	:= "31107010104"
		        EndIf
		        IF ntipoW == 2  .AND. _w== 2 .And. TRBSD1->E5_VLMULTA <> 0
					nValor	:= TRBSD1->E5_VLMULTA
					cConta	:= "31107010104"
		        EndIf
		        IF ntipoW == 3 .AND. _w== 3 .And. TRBSD1->E5_VLDESCO <> 0
					nValor	:= TRBSD1->E5_VLDESCO
					cConta	:= "31107010203"
		        EndIf
		        cHistorico	:="MOVIMENTAวยO BANCARIA - RECEBER"
		   	EndIf 
		   	If TRBSD1->E5_RECPAG == "P"
				IF ntipoW == 1  .AND. _w== 1 .And. TRBSD1->E5_VLJUROS <> 0
					nValor	:= TRBSD1->E5_VLJUROS
					cConta	:= "31107010204"
		        EndIf
		        IF ntipoW == 2  .AND. _w== 2 .And. TRBSD1->E5_VLMULTA <> 0
					nValor	:= TRBSD1->E5_VLMULTA
					cConta	:= "31107010204"
		        EndIf
		        IF ntipoW == 3 .AND. _w== 3 .And. TRBSD1->E5_VLDESCO <> 0
					nValor	:= TRBSD1->E5_VLDESCO
					cConta	:= "31107010102"
		        EndIf
		        cHistorico	:="MOVIMENTAวยO BANCARIA - PAGAR"
		   	EndIf
		   	cCCusto:=u_PegaCC(cConta,cClasse)
			If nValor <> 0
			*/
			If !EOF()
			/*
				cObsCam := ValCampo("FIN",TRBSD1->E5_FILIAL,TRBSD1->E5_NUMERO,cCCusto,cConta,nValor)
				If nOpca == 1
			   		cTipo:='FIN - MOV. BANC.'
					aadd(aXLista,{cAlias,cTipo,TRBSD1->E5_FILIAL,TRBSD1->E5_NUMERO,cCCusto,cConta,Transform(nValor,"@E 99,999,999.99"),"PCO",TRBPCO->AKD_CLASSE,TRBPCO->AKD_NUMDOC,TRBPCO->AKD_CC,TRBPCO->AKD_CO,Transform(TRBPCO->AKD_VALOR1,"@E 99,999,999.99"),TRBSD1->R_E_C_N_O_,"MOVIMENTAวยO BANCARIA","","",TRBSD1->E5_CLIFOR,TRBSD1->E5_BENEF,USRRETNAME(SUBSTR(EMBARALHA(TRBSD1->E5_USERLGI,1),3,6)),ALLTRIM(TRBSD1->E5_NATUREZ)+" - "+ALLTRIM(TRBSD1->ED_DESCRIC),LTRIM(cObsCam),TRBPCO->R_E_C_N_O_,TRBPCO->AKD_DATA,TRBPCO->AKD_PEDIDO,TRBPCO->AKD_INFOS1,TRBPCO->AKD_XFILIA,TRBPCO->AKD_DESCCO,TRBPCO->AKD_DESCCC,'ZZG E5'+TRBSD1->(PADR(cValToChar(RECE5),9,' ')+E5_FILIAL+E5_TIPODOC+E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_DATA+E5_CLIFOR+E5_LOJA+E5_SEQ+cValToChar(_w)),TRBPCO->AKD_PROCES,TRBPCO->AKD_LOTE,TRBPCO->AKD_ID})
				EndIf
				If cObsCam != "" .AND. nOpca != 1 
					cTipo:='FIN - MOV. BANC.'
					aadd(aXLista,{cAlias,cTipo,TRBSD1->E5_FILIAL,TRBSD1->E5_NUMERO,cCCusto,cConta,Transform(nValor,"@E 99,999,999.99"),"PCO",TRBPCO->AKD_CLASSE,TRBPCO->AKD_NUMDOC,TRBPCO->AKD_CC,TRBPCO->AKD_CO,Transform(TRBPCO->AKD_VALOR1,"@E 99,999,999.99"),TRBSD1->R_E_C_N_O_,"MOVIMENTAวยO BANCARIA","","",TRBSD1->E5_CLIFOR,TRBSD1->E5_BENEF,USRRETNAME(SUBSTR(EMBARALHA(TRBSD1->E5_USERLGI,1),3,6)),ALLTRIM(TRBSD1->E5_NATUREZ)+" - "+ALLTRIM(TRBSD1->ED_DESCRIC),LTRIM(cObsCam),TRBPCO->R_E_C_N_O_,TRBPCO->AKD_DATA,TRBPCO->AKD_PEDIDO,TRBPCO->AKD_INFOS1,TRBPCO->AKD_XFILIA,TRBPCO->AKD_DESCCO,TRBPCO->AKD_DESCCC,'ZZG E5'+TRBSD1->(PADR(cValToChar(RECE5),9,' ')+E5_FILIAL+E5_TIPODOC+E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_DATA+E5_CLIFOR+E5_LOJA+E5_SEQ+cValToChar(_w)),TRBPCO->AKD_PROCES,TRBPCO->AKD_LOTE,TRBPCO->AKD_ID}) 
				EndIf
				*/
			Else
				cTipo:='PCO'
				cObsCam+="Registro nใo encontrado Mov. Banc."
				aadd(aXLista,{"AKD",cTipo,"","","","",0,"PCO",TRBPCO->AKD_CLASSE,TRBPCO->AKD_NUMDOC,TRBPCO->AKD_CC,TRBPCO->AKD_CO,Transform(TRBPCO->AKD_VALOR1,"@E 99,999,999.99"),TRBPCO->R_E_C_N_O_,TRBPCO->AKD_HIST,TRBPCO->AKD_DESCCO,TRBPCO->AKD_DESCCC,TRBPCO->AKD_CODFOR,TRBPCO->AKD_DESCCF,TRBPCO->AKD_XUSER, TRBPCO->AKD_XITEM,RTRIM(cObsCam),TRBPCO->R_E_C_N_O_,TRBPCO->AKD_DATA,TRBPCO->AKD_PEDIDO,TRBPCO->AKD_INFOS1,TRBPCO->AKD_XFILIA,TRBPCO->AKD_DESCCO,TRBPCO->AKD_DESCCC,TRBPCO->AKD_CHAVE,TRBPCO->AKD_PROCES,TRBPCO->AKD_LOTE,TRBPCO->AKD_ID})
			EndIf
			/* 
			EndIf 
	   	Next _w
	   	*/
		TRBSD1->(DbCloseArea())
		DbSelectArea("TRBPCO")
		DBSKIP()
	End 
	TRBPCO->(DbCloseArea())

Return()



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMPCO8MVB   บAutor  ณWanderson Liberdadeบ Data ณ  28/08/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณSeleciona registro no Financeiro - Movimenta็ใo Bancแria     ฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ ValeCard                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/    

Static Function MPCO8COM1()
	Local cQuery:="" 
	Local cQuery1:=""
	Local cObsCam	:=""
	Local cCC		:=""
	Local cClasse	:=""
	Local cAlias	:="SF1"    

	cQuery:=	" SELECT F1.F1_FILIAL,F1.F1_DOC,F1.F1_SERIE,F1.F1_FORNECE,A2.A2_NOME,F1.F1_LOJA,F1.F1_DESCONT,F1.F1_DTDIGIT,F1.F1_TIPO,F1.R_E_C_N_O_,F1.F1_USERLGI "
	cQuery+=	" FROM "+RETSQLNAME("SF1")+" F1 ,"+RETSQLNAME("SA2")+" A2  "
	cQuery+=	" WHERE F1.F1_DTDIGIT		>= '"+DtoS(MV_PAR01)+"'"
	cQuery+=	" AND F1.F1_DTDIGIT			<= '"+DtoS(MV_PAR02)+"'"
	cQuery+=	" AND F1.F1_DESCONT > 0 AND F1.F1_FORNECE = A2.A2_COD "
	cQuery+=	" AND F1.D_E_L_E_T_		= ' ' AND F1.F1_LOJA = A2.A2_LOJA "
	If cFilFil != ""
		cQuery+= " AND F1.F1_FILIAL = '"+cFilFil+"' "
	EndIf
	If cFilNum != ""
		cQuery+= " AND F1.F1_DOC = '"+cFilNum+"' "
	EndIf 
	If cValor1 != 0
		cQuery+= " AND F1.F1_DESCONT = "+STRTRAN(Transform(cValor1,"@E 99999999.99"),",",".")+" "
	EndIf
	dbUseArea(.T.,"TOPCONN",TCGenQry(,,cQuery),'TRBSD1',.F.,.T.)
	DbSelectArea("TRBSD1")
	cTipo:='FIN - COMPRAS'
	cObsCam	:=""
	
	While !Eof()
		nValor	:= TRBSD1->F1_DESCONT
		//Conforme pedido lin้ia - controladoria - pegar a conta para ir para o pco
		cConta	:= Posicione( "SED", 1, xFilial( "SED" ) + '11013', "ED_CTAPCO" )
		//Encontra o centro de custo conforme regra Lin้ia passou
		cQry:=	"SELECT ZHM_CLASSE FROM "+RETSQLNAME("ZHM")+" WHERE D_E_L_E_T_ <> '*' AND ZHM_FILCLA= '"+ALLTRIM(TRBSD1->F1_FILIAL)+"'  WHERE ROWNUM = 1 "
		dbUseArea(.T., "TOPCONN", TCGenQry(,,cQry), "LTRB2", .F., .T.)
		DbSelectArea("LTRB2")
		cClasse := LTRB2->ZHM_CLASSE
		LTRB2->(DbCloseArea())
		//Faz a busca da centro de custo na tabela de depara
		cQry:=	" SELECT ZHN_CCUSTO FROM "+RETSQLNAME("ZHN")+" WHERE D_E_L_E_T_ <> '*' AND ZHN_CLASSE = '"+ALLTRIM(cClasse)+"'  WHERE ROWNUM = 1 "
		cQry+=	" AND ZHN_NATURE = '"+ALLTRIM('11013')+"' AND ZHN_CTAPCO = '"+ALLTRIM(cConta)+"'
		dbUseArea(.T., "TOPCONN", TCGenQry(,,cQry), "LTRB2", .F., .T.)
		DbSelectArea("LTRB2")
		cCCusto := LTRB2->ZHN_CCUSTO
		LTRB2->(DbCloseArea())
		DbSelectArea("TRBSD1")
		If cFilCC != ""
			if ALLTRIM(cCCusto) != ALLTRIM(cFilCC)
				DBSKIP()
			EndIf
		EndIf
		If cFilCO != ""
			if ALLTRIM(cConta) != ALLTRIM(cFilCO)
				DBSKIP()
			EndIf
		EndIf
		If nValor <> 0
			cQuery1:= " SELECT AKD_DATA,AKD_CLASSE,AKD_NUMDOC,AKD_CC,AKD_CO,AKD_VALOR1,AKD_XFILIA,R_E_C_N_O_,AKD_PEDIDO,AKD_INFOS1,AKD_DESCCO,AKD_DESCCC,AKD_PROCES,AKD_CHAVE,AKD_LOTE,AKD_ID    "
			cQuery1+= " FROM "+RETSQLNAME("AKD")+" WHERE AKD_FILIAL = '"+xFilial("AKD")+"' AND D_E_L_E_T_ <> '*' AND AKD_CHAVE = 'ZZGSF1"+PADR(cValToChar(R_E_C_N_O_),9,' ')+F1_FILIAL+F1_DOC+F1_SERIE+F1_FORNECE+F1_LOJA+F1_TIPO+"' "
			cQuery1+= " AND AKD_DATA BETWEEN '"+DTOS(MV_par01)+"' AND '"+DTOS(MV_par02)+"' AND AKD_STATUS <> '3' "
			dbUseArea(.T.,"TOPCONN",TCGenQry(,,cQuery1),'TRBPCO',.F.,.T.)
			DbSelectArea("TRBPCO")
			cObsCam	:=""	
			If !EOF()
				cObsCam := ValCampo("FIN",TRBSD1->F1_FILIAL,TRBSD1->F1_DOC,cCCusto,cConta,nValor)
				If nOpca == 1
			   		cTipo:='FIN - COMPRAS'
					aadd(aXLista,{cAlias,cTipo,TRBSD1->F1_FILIAL,TRBSD1->F1_DOC,cCCusto,cConta,Transform(nValor,"@E 99,999,999.99"),"PCO",TRBPCO->AKD_CLASSE,TRBPCO->AKD_NUMDOC,TRBPCO->AKD_CC,TRBPCO->AKD_CO,Transform(TRBPCO->AKD_VALOR1,"@E 99,999,999.99"),TRBSD1->R_E_C_N_O_,"FIN. COMPRAS","","",TRBSD1->F1_FORNECE,TRBSD1->A2_NOME,USRRETNAME(SUBSTR(EMBARALHA(TRBSD1->F1_USERLGI,1),3,6)),"11013"+" - "+Posicione( "SED", 1, xFilial( "SED" ) + '11013', "ED_DESCRIC" ),LTRIM(cObsCam),TRBPCO->R_E_C_N_O_,TRBPCO->AKD_DATA,TRBPCO->AKD_PEDIDO,TRBPCO->AKD_INFOS1,TRBPCO->AKD_XFILIA,TRBPCO->AKD_DESCCO,TRBPCO->AKD_DESCCC,'ZZGSF1'+TRBSD1->(PADR(cValToChar(R_E_C_N_O_),9,' ')+F1_FILIAL+F1_DOC+F1_SERIE+F1_FORNECE+F1_LOJA+F1_TIPO),TRBPCO->AKD_PROCES,TRBPCO->AKD_LOTE,TRBPCO->AKD_ID})
				EndIf
				If cObsCam != "" .AND. nOpca != 1 
					cTipo:='FIN - COMPRAS'
					aadd(aXLista,{cAlias,cTipo,TRBSD1->F1_FILIAL,TRBSD1->F1_DOC,cCCusto,cConta,Transform(nValor,"@E 99,999,999.99"),"PCO",TRBPCO->AKD_CLASSE,TRBPCO->AKD_NUMDOC,TRBPCO->AKD_CC,TRBPCO->AKD_CO,Transform(TRBPCO->AKD_VALOR1,"@E 99,999,999.99"),TRBSD1->R_E_C_N_O_,"FIN. COMPRAS","","",TRBSD1->F1_FORNECE,TRBSD1->A2_NOME,USRRETNAME(SUBSTR(EMBARALHA(TRBSD1->F1_USERLGI,1),3,6)),"11013"+" - "+Posicione( "SED", 1, xFilial( "SED" ) + '11013', "ED_DESCRIC" ),LTRIM(cObsCam),TRBPCO->R_E_C_N_O_,TRBPCO->AKD_DATA,TRBPCO->AKD_PEDIDO,TRBPCO->AKD_INFOS1,TRBPCO->AKD_XFILIA,TRBPCO->AKD_DESCCO,TRBPCO->AKD_DESCCC,'ZZGSF1'+TRBSD1->(PADR(cValToChar(R_E_C_N_O_),9,' ')+F1_FILIAL+F1_DOC+F1_SERIE+F1_FORNECE+F1_LOJA+F1_TIPO),TRBPCO->AKD_PROCES,TRBPCO->AKD_LOTE,TRBPCO->AKD_ID}) 
				EndIf
			Else
				cTipo:='FIN - COMPRAS'                                                                                                                                                                                                                                                          
				cObsCam+="Registro nใo encontrado PCO"
				aadd(aXLista,{cAlias,cTipo,TRBSD1->F1_FILIAL,TRBSD1->F1_DOC,cCCusto,cConta,Transform(nValor,"@E 99,999,999.99"),"|"," "," "," "," ",Transform(0,"@E 99,999,999.99"),TRBSD1->R_E_C_N_O_,"FIN. COMPRAS","","",TRBSD1->F1_FORNECE,TRBSD1->A2_NOME,USRRETNAME(SUBSTR(EMBARALHA(TRBSD1->F1_USERLGI,1),3,6)),"11013"+" - "+Posicione( "SED", 1, xFilial( "SED" ) + '11013', "ED_DESCRIC" ),LTRIM(cObsCam),0,TRBSD1->F1_DTDIGIT,"","DESCONTO COMPRAS","","","",'ZZGSF1'+TRBSD1->(PADR(cValToChar(R_E_C_N_O_),9,' ')+F1_FILIAL+F1_DOC+F1_SERIE+F1_FORNECE+F1_LOJA+F1_TIPO),'900014',"",""}) 
			EndIf
			TRBPCO->(DbCloseArea())
		EndIf
		DbSelectArea("TRBSD1")
		DBSKIP()
	End    
	TRBSD1->(DbCloseArea())
	cQuery:= " SELECT * FROM "+RETSQLNAME("AKD")+" WHERE AKD_DATA BETWEEN '"+DTOS(MV_par01)+"' AND '"+DTOS(MV_par02)+"' "
	cQuery+= " AND AKD_PROCES = '900014' AND D_E_L_E_T_ <> '*'  AND AKD_STATUS <> '3' AND SUBSTR(AKD_CHAVE,4,3)= 'SF1'  "
	If cFilFil != ""
		cQuery+= " AND AKD_XFILIA = '"+cFilFil+"' "
	EndIf
	If cFilNum != ""
		cQuery+= " AND SUBSTR(AKD_NUMDOC,1,9) = '"+cFilNum+"' "
	EndIf
	If cFilCO != ""
		cQuery+= " AND AKD_CO = '"+cFilCO+"' "
	EndIf
	If cFilCC != ""
		cQuery+= " AND  AKD_CC = '"+cFilCC+"' "
	EndIf
	If cValor1 != 0
		cQuery+= " AND AKD_VALOR1 = "+STRTRAN(Transform(cValor1,"@E 99999999.99"),",",".")+" "
	EndIf
	dbUseArea(.T.,"TOPCONN",TCGenQry(,,cQuery),'TRBPCO',.F.,.T.)
	DBSELECTAREA("TRBPCO")
	DBGOTOP()
	While !Eof()		
		cQuery1:=	" SELECT F1.F1_FILIAL,F1.F1_DOC,F1.F1_SERIE,F1.F1_FORNECE,A2.A2_NOME,F1.F1_LOJA,F1.F1_DESCONT,F1.F1_DTDIGIT,F1.F1_TIPO,F1.R_E_C_N_O_,F1.F1_USERLGI "
		cQuery1+=	" FROM "+RETSQLNAME("SF1")+" F1 ,"+RETSQLNAME("SA2")+" A2  "
		cQuery1+=	" WHERE F1.F1_DTDIGIT		>= '"+DtoS(MV_PAR01)+"'"
		cQuery1+=	" AND F1.F1_DTDIGIT			<= '"+DtoS(MV_PAR02)+"'"
		cQuery1+=	" AND F1.F1_DESCONT > 0 AND F1.F1_FORNECE = A2.A2_COD "
		cQuery1+=	" AND F1.D_E_L_E_T_		= ' ' AND F1.F1_LOJA = A2.A2_LOJA " 
		dbUseArea(.T.,"TOPCONN",TCGenQry(,,cQuery1),'TRBSD1',.F.,.T.)
		DbSelectArea("TRBSD1")
		cObsCam	:=""

		If !EOF()
		Else
			cTipo:='PCO'
			cObsCam+="Registro nใo encontrado Fin. Compras"
			aadd(aXLista,{"AKD",cTipo,"","","","",0,"PCO",TRBPCO->AKD_CLASSE,TRBPCO->AKD_NUMDOC,TRBPCO->AKD_CC,TRBPCO->AKD_CO,Transform(TRBPCO->AKD_VALOR1,"@E 99,999,999.99"),TRBPCO->R_E_C_N_O_,TRBPCO->AKD_HIST,TRBPCO->AKD_DESCCO,TRBPCO->AKD_DESCCC,TRBPCO->AKD_CODFOR,TRBPCO->AKD_DESCCF,TRBPCO->AKD_XUSER, TRBPCO->AKD_XITEM,RTRIM(cObsCam),TRBPCO->R_E_C_N_O_,TRBPCO->AKD_DATA,TRBPCO->AKD_PEDIDO,TRBPCO->AKD_INFOS1,TRBPCO->AKD_XFILIA,TRBPCO->AKD_DESCCO,TRBPCO->AKD_DESCCC,TRBPCO->AKD_CHAVE,TRBPCO->AKD_PROCES,TRBPCO->AKD_LOTE,TRBPCO->AKD_ID})
		EndIf
		TRBSD1->(DbCloseArea())
		DbSelectArea("TRBPCO")
		DBSKIP()
	End 
	TRBPCO->(DbCloseArea())

Return()



Static Function ValidPerg()
//Ajuste devido migra็ใo dicionario para o banco de dados. 27/11/2019. 
//Com o dicionrio no banco de dados, alteraes nos grupos de perguntas
//devem ser feitas exclusivamente pelo configurador.
/*
	Local _sAlias := Alias()
	Local aRegs := {}
	Local i,j
	Local lGrava:=	.T.
	
	aHelpPor := {}
	aHelpEng := {}
	aHelpSpa := {}
	
	dbSelectArea("SX1")
	dbSetOrder(1)
	cPerg := PADR(cPerg,10)
	
	//Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05
	aAdd(aRegs,{cPerg,"01","Inicio Periodo Em?","","","mv_ch1","D",08,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","",""})
	aAdd(aRegs,{cPerg,"02","Final Periodo At้?","","","mv_ch2","D",08,0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","",""})
	aAdd(aRegs,{cPerg,"03","Selecionar M๓dulo : ","","","mv_ch3","N",01,0,0,"C","","mv_par04","COMPRAS NF","COMPRAS NF","COMPRAS NF","","","SOL. ARMAZษM","SOL. ARMAZษM","SOL. ARMAZษM","","","PEDIDO","PEDIDO","PEDIDO","","","C.PAGAR E CAIXINHA","C.PAGAR E CAIXINHA","C.PAGAR E CAIXINHA","","","FINANCEIRO","FINANCEIRO","FINANCEIRO","","",""})
	aAdd(aRegs,{cPerg,"04","Selecione Tipo    : ","","","mv_ch4","N",01,0,0,"C","","mv_par04","TODOS","TODOS","TODOS","","","DIFERENวAS","DIFERENวAS","DIFERENวAS","","","","","","","","","","","","","","","","","",""})
    

	For i:=1 to Len(aRegs)
		RecLock("SX1",!dbSeek(cPerg+aRegs[i,2]))
		For j:=1 to FCount()
			If j <= Len(aRegs[i])
				FieldPut(j,aRegs[i,j])
			Endif
		Next
		MsUnlock()
	Next
	
	dbSelectArea(_sAlias)
	*/
Return 





Static Function AltAKD(aRegAKD)
	Local cRecno	:=""
	Local cClasse	:=""
	Local aAkdReg	:={}
	Local aRecnos	:={}
	
	aAkdReg	:= AClone(aRegAKD)
	
	DbselectArea("ZHM")
	DbSetorder(1)
	if !Empty(aAkdReg[3]) .AND. DbSeek(xFilial("ZHM")+aAkdReg[3])
		cClasse	:= ZHM->ZHM_CLASSE
    	aAkdReg[3]:=cClasse 
   	Else
   		aAkdReg[3]:="      "
   	EndIf
   	ZHM->(DbCloseArea())
   	DbselectArea("AK5")
	DbSetorder(1)
	if !Empty(aAkdReg[6]) .AND. DbSeek(xFilial("AK5")+Alltrim(aAkdReg[6]))
    	AADD(aAkdReg,AK5->AK5_DESCRI)
 	Else
 		AADD(aAkdReg,"")
   	EndIf
   	AK5->(DbCloseArea())
   	DbselectArea("CTT")
	DbSetorder(1)
	if !Empty(aAkdReg[5]) .AND. DbSeek(xFilial("CTT")+Alltrim(aAkdReg[5]))
    	AADD(aAkdReg,CTT->CTT_DESC01) 
	Else
 		AADD(aAkdReg,"")
 	EndIf
   	CTT->(DbCloseArea())
   	
	if !Empty(aRegAKD[3])
		AADD(aAkdReg,ALLTRIM(aRegAKD[3])) 	 
    	AADD(aAkdReg,POSICIONE("SM0",1,"01"+aRegAKD[3],"M0_NOMECOM")) 
	Else
 		AADD(aAkdReg,"")
 		AADD(aAkdReg,"")
 	EndIf
 	AADD(aRecnos,aAkdReg[23])
	if(aXLista[oListBox:At(),08] == "PCO")
		lOk := u_A050DLG( "AKD", aAkdReg[23], 4, .F.,aRecnos, , , .T.,aAkdReg )
		u_ATUWPCO(lOk,(aXLista[oListBox:At(),30]),(aXLista[oListBox:At(),31]))
	Else
		lOk := u_A050DLG( "AKD", "", 3, .F.,"", , , .T.,aAkdReg )
		u_ATUWPCO(lOk,(aXLista[oListBox:At(),30]),(aXLista[oListBox:At(),31]))
	EndIf
Return()


Static Function ValCampo(cValtipo,cFiltab,cdoc,cCC,cCO,nValor)
	Local cObsCam:=""

	If cValTipo == ("FIS")
		If(ALLTRIM(TRBSD1->D1_FILIAL) != ALLTRIM(TRBPCO->AKD_XFILIA))
					cObsCam+="Filial,"
		EndIf
		If(ALLTRIM(TRBSD1->D1_DOC) != SUBSTR(TRBPCO->AKD_NUMDOC,1,9))
					cObsCam+=" Num. Documento,"
		EndIf
		If(ALLTRIM(TRBSD1->D1_CC) != ALLTRIM(TRBPCO->AKD_CC))
					cObsCam+=" Centro de Custo,"
		EndIf
		If(ALLTRIM(TRBSD1->B1_CTAPCO) != ALLTRIM(TRBPCO->AKD_CO))
					cObsCam+=" Conta Or็amentแria,"
		EndIf
		If(TRBSD1->D1_TOTAL != TRBPCO->AKD_VALOR1)
					cObsCam+=" Valor,"
		EndIf	
	EndIf
	//Valida็ใo consulta ao Armaz้m
	If cValTipo == ("ARM")
		If(ALLTRIM(TRBSD1->D3_FILIAL) != ALLTRIM(TRBPCO->AKD_XFILIA))
					cObsCam+="Filial,"
		EndIf
		If(ALLTRIM(TRBSD1->D3_DOC) != ALLTRIM(TRBPCO->AKD_NUMDOC))
					cObsCam+=" Num. Documento,"
		EndIf
		If(ALLTRIM(TRBSD1->D3_CC) != ALLTRIM(TRBPCO->AKD_CC))
					cObsCam+=" Centro de Custo,"
		EndIf
		If(ALLTRIM(TRBSD1->B1_CTAPCO) != ALLTRIM(TRBPCO->AKD_CO))
					cObsCam+=" Conta Or็amentแria,"
		EndIf
		If(TRBSD1->D3_CUSTO1 != TRBPCO->AKD_VALOR1)
					cObsCam+=" Valor,"
		EndIf
		
	EndIf    
	
	//Valida็ใo consulta ao Compras
	If cValTipo == ("COM")
		If(ALLTRIM(TRBSD1->C7_FILIAL) != ALLTRIM(TRBPCO->AKD_XFILIA))
					cObsCam+="Filial,"
		EndIf
		If(ALLTRIM(TRBSD1->C7_NUM) != ALLTRIM(SUBSTR(TRBPCO->AKD_NUMDOC,1,6)))
					cObsCam+=" Num. Documento,"
		EndIf
		If(ALLTRIM(TRBSD1->C7_CC) != ALLTRIM(TRBPCO->AKD_CC))
					cObsCam+=" Centro de Custo,"
		EndIf
		If(ALLTRIM(TRBSD1->B1_CTAPCO) != ALLTRIM(TRBPCO->AKD_CO))
					cObsCam+=" Conta Or็amentแria,"
		EndIf
		If(TRBSD1->C7_TOTAL != TRBPCO->AKD_VALOR1)
					cObsCam+=" Valor,"
		EndIf
	EndIf  
	
	//Valida็ใo consulta ao Contas a pagar
	If cValTipo == ("CAP")
		If(ALLTRIM(TRBSD1->E2_FILIAL) != ALLTRIM(TRBPCO->AKD_XFILIA))
					cObsCam+="Filial,"
		EndIf
		If(ALLTRIM(TRBSD1->E2_NUM) != SUBSTR(TRBPCO->AKD_NUMDOC,1,9))
					cObsCam+=" Num. Documento,"
		EndIf
		If(ALLTRIM(TRBSD1->E2_CCD) != ALLTRIM(TRBPCO->AKD_CC))
					cObsCam+=" Centro de Custo,"
		EndIf
		If(ALLTRIM(TRBSD1->ED_CTAPCO) != ALLTRIM(TRBPCO->AKD_CO))
					cObsCam+=" Conta Or็amentแria,"
		EndIf
		If(TRBSD1->E2_VALOR != TRBPCO->AKD_VALOR1)
					cObsCam+=" Valor,"
		EndIf
	EndIf
	
		//Valida็ใo consulta ao Contas a pagar
	If cValTipo == ("CAX")
		If(ALLTRIM(TRBSD1->EU_FILIAL) != ALLTRIM(TRBPCO->AKD_XFILIA))
					cObsCam+="Filial,"
		EndIf
		If(ALLTRIM(TRBSD1->EU_NUM) != SUBSTR(TRBPCO->AKD_NUMDOC,1,9))
					cObsCam+=" Num. Documento,"
		EndIf
		If(ALLTRIM(TRBSD1->EU_CCC) != ALLTRIM(TRBPCO->AKD_CC))
					cObsCam+=" Centro de Custo,"
		EndIf
		If(ALLTRIM(TRBSD1->B1_CTAPCO) != ALLTRIM(TRBPCO->AKD_CO))
					cObsCam+=" Conta Or็amentแria,"
		EndIf
		If(TRBSD1->EU_VALOR != TRBPCO->AKD_VALOR1)
					cObsCam+=" Valor,"
		EndIf
	EndIf
	
		//Valida็ใo consulta ao Financeiro
	If cValTipo == ("FIN")
		If(ALLTRIM(cFiltab) != ALLTRIM(TRBPCO->AKD_XFILIA))
					cObsCam+="Filial,"
		EndIf
		If(ALLTRIM(cdoc) != ALLTRIM(SUBSTR(TRBPCO->AKD_NUMDOC,1,9)))
					cObsCam+=" Num. Documento,"
		EndIf
		If(ALLTRIM(cCC) != ALLTRIM(TRBPCO->AKD_CC))
					cObsCam+=" Centro de Custo,"
		EndIf
		If(ALLTRIM(cCO) != ALLTRIM(TRBPCO->AKD_CO))
					cObsCam+=" Conta Or็amentแria,"
		EndIf
		If(nValor != TRBPCO->AKD_VALOR1)
					cObsCam+=" Valor,"
		EndIf	
	EndIf

Return(cObsCam)




/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณAxVisual   บAutor  ณWanderson Liberdadeบ Data ณ  05/09/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User FUNCTION AxVisual(cAlias,nReg,nOpc,aAcho,nColMens,cMensagem,cFunc,aButtons,lMaximized)

Local aArea    := GetArea()
Local aPosEnch := {}
Local nOpcA    := 3
Local nOpc	   :=3
Local cCpoFil := PrefixoCpo(cAlias)+"_FILIAL"
Local cMemo    := ""
LOcal nX       := 0
Local oDlg    
Local lVirtual:=.F. // Qdo .F. carrega inicializador padrao nos campos virtuais
Local nTop
Local nLeft
Local nBottom
Local nRight 
Local aHAcho:= GetaHeader(cAlias)
Local aAcho:={}

Private Altera :=.F.
Private Inclui :=.F.
Private aTELA[0][0]
Private aGETS[0]
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณVerIfica se esta' vizualizando um registro da mesma filial            ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
DbSelectArea(cAlias)
DbGoto(nReg)
IF !EOF() 


	  //ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
     //ณ Monta a o Acho com os campos                                 ณ
     //ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
     for n:=1 to Len(aHAcho)
         AADD(aAcho,aHAcho[n][2])
     Next n 
     //ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
     //ณ Monta a entrada de dados do arquivo                                   ณ
     //ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
     RegToMemory(cAlias, .F., .F. )
     //ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
     //ณ Inicializa variaveis para campos Memos Virtuais                               ณ
     //ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	 OpenSxs(,,,,,cAliasTMP,"SX3",,.F.) 
	 DbSelectArea(cAliasTMP)
     If Type("aMemos")=="A"
          For nX := 1 To Len(aMemos)
               cMemo := aMemos[nX][2]
               If ExistIni(cMemo)
                    &cMemo := InitPad((cAliasTMP)->&('X3_RELACAO'))
               Else
                    &cMemo := ""
               EndIf
          Next nX
     EndIf
     If cFunc != NIL
          lVirtual:=.T.
          &cFunc.()
     EndIf

     If SetMDIChild()
          nTop := 40
          nLeft := 30 
          nBottom := oMainWnd:nBottom-80
          nRight := oMainWnd:nRight-70          
     Else
          nTop := 135
          nLeft := 0
          nBottom := TranslateBottom(.T.,28)
          nRight := 632
     EndIf

     DEFINE MSDIALOG oDlg TITLE cCadastro FROM nTop,nLeft TO nBottom,nRight  PIXEL

     oDlg:lMaximized := .T.

     aPosEnch := {,,(oDlg:nClientHeight - 4)/2,600} // ocupa todo o espa็o da janela

     If nColMens != NIL
          EnChoice( cAlias, nReg, nOpc ,,,,aAcho,aPosEnch,,,nColMens,cMensagem,,,,.T.)
     Else
          EnChoice( cAlias, nReg, nOpc ,,,,aAcho,aPosEnch,,,,,,,,.T.)
     EndIf

     ACTIVATE MSDIALOG oDlg ON INIT EnchoiceBar(oDlg,{|| nOpcA := 1,oDlg:End()},{|| nOpcA := 2,oDlg:End()},,aButtons) CENTERED
Else
     Help(" ",1,"A000FI")
     nOpcA := 3
EndIf
RestArea(aArea)
Return(nOpcA)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPCOIMPEX   บAutor  ณWanderson liberdadeบ Data ณ  05/09/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Exporta para o excel a lista                               บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function PCOIMPEX()
	Local cSelOper   := ""
	Local nTotReg    := 0
	Local lOk        := .F. 
	Local cOperadQyr :=""
	Local i,j
	Local cCSV   := CriaTrab(Nil,.F.)+".CSV"              
	Local cType := OemToAnsi("Arquivos") + "(*.*) |*.*|"
	Local cDir     := cGetFile(cType, "Selecione o Diretorio",0,     , .F., GETF_LOCALHARD + GETF_NETWORKDRIVE + GETF_RETDIRECTORY)
	Local nCSV   := FCreate(cDir+cCSV)
	Local cLinha := ""
	Local aDados := {}
	
	If nCSV <= 0
		MsgAlert("Falha ao gerar o arquivo Excel no caminho: " + cDir)
		Return(Nil)
	EndIf
	
	cLinha :=  "CONFERENCIA DE RESULTADOS - MำDULO X PCO"
	FWrite(nCSV,cLinha+Chr(13)+Chr(10))
	cLinha := MesExtenso(MV_PAR02)+" ./ "+SUBSTR(DTOS(MV_PAR02),1,4)+";;;;"       
	FWrite(nCSV,cLinha+Chr(13)+Chr(10))
	cLinha :=  "TABELA"+";"+"MODULO"+";"+"FILIAL"+";"+"DOCUMENTO"+";"+"VALOR"+";"+"C.O.;"+"C.C."+";"+"DIVERGENCIAS"+";"+"MODULO"+";"+"LOTE"+";"+"ITEM"+";"+"FILIAL PCO"+";"+"DOCUMENTO PCO"+";"+"VALOR PCO"+";"+"C.O. PCO"+";"+"DESC. C.O. PCO"+";"+"C.C. PCO"+";"+"DESC. C.C. PCO"+";"+"CLASSE"+";"+"HISTORICO"+";"+"COD. FORNEC"+";"+"NOME FORN."+";"+"USUมRIO"+";"+"INFO ITEM"+";"+"DATA PCO"+";"+"PEDIDO"+";"+"INFORMAวรO;"        
	FWrite(nCSV,cLinha+Chr(13)+Chr(10))
	procregua(Len(aXlista))
	For i:=1 to Len(aXlista)
		IncProc("Exportando Lan็amentos   -->" + Transform((Len(aXlista)*100), "@e 999.99" )+"%" )

		cLinha := ""
		cLinha +=aXlista[i][1]+";"
		cLinha +=aXlista[i][2]
		cLinha +=";'"+AllTrim(aXlista[i][3])
		cLinha +=";'"+AllTrim(aXlista[i][4])
		cLinha +=";"+cValToChar(aXlista[i][7])
		cLinha +=";"+AllTrim(aXlista[i][6])
		cLinha +=";"+AllTrim(aXlista[i][5])
		cLinha +=";"+AllTrim(aXlista[i][22])
		cLinha +=";"+AllTrim(aXlista[i][8])
		cLinha +=";'"+AllTrim(aXlista[i][32])
		cLinha +=";'"+AllTrim(aXlista[i][33])
		cLinha +=";'"+AllTrim(aXlista[i][27])
		cLinha +=";'"+AllTrim(aXlista[i][10])
		cLinha +=";"+cValToChar(aXlista[i][13]) 
		cLinha +=";"+AllTrim(aXlista[i][12])                    
		cLinha +=";"+AllTrim(aXlista[i][28]) 
		cLinha +=";"+AllTrim(aXlista[i][11])
		cLinha +=";"+AllTrim(aXlista[i][29])
		cLinha +=";'"+AllTrim(aXlista[i][9])
		cLinha +=";"+AllTrim(aXlista[i][15])
		cLinha +=";"+AllTrim(aXlista[i][18])
		cLinha +=";"+AllTrim(aXlista[i][19])
		cLinha +=";"+AllTrim(aXlista[i][20])
		cLinha +=";"+AllTrim(aXlista[i][21])
		cLinha +=";"+aXlista[i][24]
		cLinha +=";'"+AllTrim(aXlista[i][23])
		cLinha +=";"+AllTrim(aXlista[i][26])
		
	
		FWrite(nCSV,cLinha+Chr(13)+Chr(10))
	Next i
	FWrite(nCSV,Chr(13)+Chr(10))
	FClose(nCSV)
	oExcel := MSExcel():New()

	oExcel:WorkBooks:Open(cDir+cCSV)
	oExcel:SetVisible(.T.)
	
return                  

User Function PCOWLEGEN() 

	aLegenda := { 	{ "BR_VERDE", "LANวAMENTO NORMAL" },;
		{ "BR_AMARELO", "COM DIVERGสNCIA" },;
		{ "BR_VERMELHO", "NรO ENCONTRADO PCO" } }
		
		BrwLegenda("Legenda", "Pend๊ncias", aLegenda) //"Legenda"
RETURN


User Function ATUWPCO(lOk,cChaveAKD,cProces)
	Local aAreaAKD	:= AKD->(GetArea())
    Local nPosAT	:= oListBox:At()
    Local cObsCam	:=""
	 
	if(lOk == .T.)
		DbSelectArea("AKD")
		DbGoTo(nRecAKD)
		Reclock("AKD",.F.)
		Replace AKD_CHAVE With cChaveAKD
		Replace AKD_PROCES With cProces
		MsUnlock()
		If(aXLista[nPosAT][2]!="PCO" .AND. aXLista[nPosAT][8]=="PCO" )
			
			If(ALLTRIM(aXLista[nPosAT][3]) != ALLTRIM(AKD->AKD_XFILIA))
						cObsCam+="Filial,"
			EndIf
			If(ALLTRIM(aXLista[nPosAT][4]) != SUBSTR(AKD->AKD_NUMDOC,1,9))
						cObsCam+=" Num. Documento,"
			EndIf
			If(ALLTRIM(aXLista[nPosAT][5]) != ALLTRIM(AKD->AKD_CC))
						cObsCam+=" Centro de Custo,"
			EndIf
			If(ALLTRIM(aXLista[nPosAT][6]) != ALLTRIM(AKD->AKD_CO))
						cObsCam+=" Conta Or็amentแria,"
			EndIf
			If(VAL(STRTRAN(STRTRAN(aXLista[nPosAT][7],".",""),",",".")) != AKD->AKD_VALOR1)
						cObsCam+=" Valor,"
			EndIf
			aXLista[nPosAT][22]:=cObsCam
		EndIf
		If aXLista[nPosAT][8]=="|"
			cObsCam:="Registro nใo encontrado PCO"
			aXLista[oListBox:At()][22]:= cObsCam
		EndIf
		if Empty(aXLista)
			aBKPLista	:= aClone(aXLista)
		EndIf
		oListBox:SetArray(aXLista)
		
		if Empty(cObsCam) .AND. aXLista[nPosAT][2]=="PCO" .AND. aXLista[nPosAT][8]=="|" 
			ADEL(aXLista, nPosAT)
			ASIZE(aXLista,Len(aXLista)-1)
		EndIf
		oListBox:SetArray(aXLista)
		oListBox:Refresh()
		SysRefresh()
		
	EndIf
	
	AKD->(RestArea(aAreaAKD))
return


User Function FILWPCO()                                                                  
	Local aItems2:= {'SELECIONE','FILIAL','DOCUMENTO','CONTA ORวAM.','CENTRO CUSTO','VALOR'}
	cTGet := Space(20)
		 
	DEFINE DIALOG oDlg TITLE "FILTRO CONFERECIA PCO" FROM 180,180 TO 350,650 PIXEL 
	
	oFont := TFont():New('Courier new',,-14,.T.)
	oSay:= TSay():Create(oDlg,{||'SELECIONE CAMPO'},2,01,,oFont,,,,.T.,CLR_BLACK,CLR_BLACK,200,20)
	oSay:= TSay():Create(oDlg,{||'DIGITE FILTRO:'},27,01,,oFont,,,,.T.,CLR_BLACK,CLR_BLACK,200,20)
	
	oTGet := TGet():Create( oDlg,{|u| if(PCount() > 0, cTGet := u, cTGet)},27,60,160,009,"@!",,0,,,.F.,,.T.,,.F.,,.F.,.F.,,.F.,.F.,,cTGet,,,, )               
 
  	// Usando Create    
  	cCombo2:= aItems2[1]    
  	oCombo2 :=  TComboBox():Create(oDlg,{|u|if(PCount()>0,cCombo2:=u,cCombo2)},10,05,; 
    aItems2,100,20,,{||u_MasTget(cCombo2)},,,,.T.,,,,,,,,,'cCombo2')
    oTGet:CtrlRefresh()
     
    oTBrowseButton1 := TBrowseButton():New( 50,10,'FILTRAR',oDlg,{||u_CRIAFIL(ALLTRIM(cTGet),ALLTRIM(cCombo2),aXLista)},70,20,,,.F.,.T.,.F.,,.F.,,,) 
    oTBrowseButton2 := TBrowseButton():New( 50,120,'CANCELAR',oDlg,{||oDlg:END()},70,20,,,.F.,.T.,.F.,,.F.,,,)
   	oBtn1 := TBtnBmp2():New( 110,25,26,26,BMPFILTRO,,,,{||U_FILTRAPCO()},oDlg,,,.T. )
   	oBtn2 := TBtnBmp2():New( 110,245,26,26,'CANCEL',,,,{||oDlg:END()},oDlg,,,.T. ) 
    
  ACTIVATE DIALOG oDlg CENTERED
Return

USER FUNCTION MasTget(cCombo2)
    
	IF cCombo2 =='VALOR'
		cTGet:= STRTRAN(TRANSFORM(0.00,"@E 999999.99"),",",".")
		oTGet:SetContentAlign(-1)
	ELSE
		cTGet := Space(20)
	EndIf

RETURN

USER FUNCTION CRIAFIL(cTGet,cCombo2,aXLista)
	Local cCampo	:= cCombo2
	if Empty(aWLista)
		aBKPLista	:= aClone(aXLista)
	EndIf
	aWLista		:= aClone(aXLista)
	
	
	cFilFil		:=""
	cFilNum		:=""
	cFilCO		:=""
	cFilCC		:="" 
	cValor1		:=0
	
	If !EMPTY(cCampo)
		Do Case
			Case cCampo == 'FILIAL'
		    	cFilFil	:= cTGet                
		 	Case cCampo == 'DOCUMENTO'
		 		cFilNum	:= cTGet	 		
		 	Case cCampo == 'CONTA ORวAM.'
		 	   	cFilCO	:= cTGet
		 	Case cCampo == 'CENTRO CUSTO'
		 		cFilCC	:= cTGet
		 	Case cCampo == 'VALOR'
		 		cValor1	:= Val(STRTRAN(cTGet,",","."))
		 EndCase
	 EndIf 
	 aXLista:={}
	 	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Selcionando registros		                                           ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	DO CASE
		Case mv_par03 == 1
			Processa( {|lEnd| MPCO8FIS(@lEnd)}, "Aguarde...","Selecionando Registros Documento Entrada...", .T. )
    	Case mv_par03 == 2
			Processa( {|lEnd| MPCO8ARM(@lEnd)}, "Aguarde...","Selecionando Registros Solicita็ใo Armaz้m...", .T. )
		Case mv_par03 == 3
			Processa( {|lEnd| MPCO8COM(@lEnd)}, "Aguarde...","Selecionando Registros Compras...", .T. )
		Case mv_par03 == 4
			Processa( {|lEnd| MPCO8CAP(@lEnd)}, "Aguarde...","Selecionando Registros Contas a Pagar...", .T. )
		Case mv_par03 == 5
			Processa( {|lEnd| MPCO8CAP1(@lEnd)}, "Aguarde...","Selecionando Registros Contas a Pagar...", .T. ) 
			Processa( {|lEnd| MPCO8CAR(@lEnd)}, "Aguarde...","Selecionando Registros Contas a Receber...", .T. ) 
			Processa( {|lEnd| MPCO8MVB(@lEnd)}, "Aguarde...","Selecionando Registros Movimenta็ใo Bancแria...", .T. )
			Processa( {|lEnd| MPCO8MVB1(@lEnd)}, "Aguarde...","Selecionando Registros Movimenta็ใo Bancแria...", .T. )
		OTHERWISE
			Alert("Selecione um M๓dulo")
		EndCase
		
	If Empty(aXLista)
		MSGAlert('Nenhum Registro encontrado')
		Return
		if !Empty(aBKPLista)
			aXLista:=asClone(aBKPLista)
		Else
			aXLista:=aClone(aWLista)
		EndIf
	EndIf  
	
	//MPCO8TELA(cTGet,cCombo2,cCombo1)
		 	
	oListBox:SetArray(aXLista)
	oListBox:Refresh()
	SysRefresh()
	oDlg:END()
RETURN


USER FUNCTION ATUWTELA()
	if !Empty(aBKPLista)
		aXLista:=aClone(aBKPLista)
	Else
		if !Empty(aWLista)
			aXLista:=aClone(aWLista)
		EndIf
	EndIf
	
	If Empty(aXLista)
		MSGAlert('Nenhum Registro encontrado')
		Return
	EndIf  		 	
	oListBox:SetArray(aXLista)
	oListBox:Refresh()
	SysRefresh()	
RETURN


User Function PegaCC(cConta,cClasse)
	Local cCCusto:=""
	If cConta == "31107010104" 
		DO CASE
			CASE(cClasse=='000001')			
				cCCusto := '1650201003'
			CASE(cClasse=='000002') 
				cCCusto:= '2650201003'
			CASE(cClasse=='000003') 
				cCCusto := '3650201003'
			CASE(cClasse=='000005') 
				cCCusto := '5110201001'
			CASE(cClasse=='000006') 
				cCCusto := '6110101001'
		OTHERWISE
			cCCusto := '1650201003'
		ENDCASE
	Else 
		DO CASE
			CASE(cClasse=='000001')			
				cCCusto := '1650201002'
			CASE(cClasse=='000002') 
				cCCusto:= '2650201002'
			CASE(cClasse=='000003') 
				cCCusto := '3650201002'
			CASE(cClasse=='000005') 
				cCCusto := '5110201001'
			CASE(cClasse=='000006') 
				cCCusto := '6110101001'
		OTHERWISE
			cCCusto := '1650201002'
		ENDCASE
	EndIf

Return(cCCusto)
