#INCLUDE 'TOTVS.CH'



/*/{Protheus.doc} LASARABS
relatorio de absenteísmo personalizado
@type function
@version  1.0
@author eder.fernandes
@since 6/05/2024
@return variant, nill
/*/
User Function LASARABS()


	Local cAliasTMP := GetNextAlias()
	Local nFor      := 0
	Local cPerg     := 'LASARABS'
	Local lLiquido  := .F.
	Private titulo
	Private AT_PRG 	:= "LASARABS"
	Private wCabec0
	Private wCabec1
	Private wCabec2
	Private CONTFL  := 1
	Private LI      := 0
	Private COLUNAS := 220
	Private nTamanho:= "G"
	Private nChar	:= 15
	Private cPict1	:=	If (MsDecimais(1)==2,"@E 99,999,999,999.99",TM( Val( Replicate( "9",13 - MsDecimais(1) ) ),17,MsDecimais(1) ) )  // "@E 99,999,999,999.99
	Private cPict2	:=	cPict1
	Private nNumLin := 9
	Private cQuebraDet := ""
	Private aReturn := { "Zebrado", 1,"Administraçäo", 2, 2, 1, "",1 }  // "Zebrado"###"Administra‡„o"
	Private aAC 	:= { "Abandona","Confirma" }  // "Abandona"###"Confirma"
	Private aLinha  := { },nLastKey := 0
	Private aInfo	:={}
	Private aTotais := {}
	Private cVerba, cCodigos, cVerbaCod, nCtSB, nCtcPd
	Private Nomeprog:="LASARABS"
	Private nOrdem


	If Pergunte(cPerg,.T., "Informe os Parametros")


		FilialDe  	:= mv_par01
		FilialAte 	:= mv_par02
		CcDe      	:= mv_par03
		CcAte     	:= mv_par04
		MatDe     	:= mv_par05
		MatAte    	:= mv_par06
		NomDe     	:= mv_par07
		NomAte    	:= mv_par08
		DatDe     	:= mv_par09
		DatAte    	:= mv_par10
		cSemanaDe 	:= mv_par11
		cSemanAte 	:= mv_par12
		nVerHor   	:= If(mv_par16=1,1,mv_par13)
		nValHor   	:= mv_par14
		nSinAna   	:= mv_par15
		lTodos    	:= If(Empty(mv_par20),.T.,If(mv_par16=1,.T.,.F.))
		lSalario  	:= If(mv_par17=1,.T.,.F.)
		cSituacao 	:= mv_par18
		cCategoria	:= mv_par19
		cCodigos  	:= AllTrim(mv_par20)
		cCodigos  	+= AllTrim(mv_par21)
		lTotais   	:= If(mv_par22=1,.T.,.F.)
		lLiquido  	:= If(mv_par23=1,.T.,.F.)
		lSitHist  	:= If(mv_par24=1,.T.,.F.)
		cAnoMesI	:=	SubStr(DatDe,3,4) + SubStr(DatDe,1,2)
		cAnoMesF 	:=	SubStr(DatAte,3,4)  + SubStr(DatAte,1,2)


//separa o codigo das verbas listadas
		cVerba := ""
		If nVerHor =  2
			If lLiquido
				cCodigos += "LIQ"
			EndIf
			If lTotais
				cCodigos += "TOT"
			EndIf
		EndIf

		cCodigos := Replace(cCodigos,"*","")
		If !Empty(cCodigos)
			For nFor := 1 To Len(ALLTRIM(cCodigos)) Step 3
				cVerba += "'"+Subs(cCodigos,nFor,3)+"'"
				If Len(ALLTRIM(cCodigos)) > ( nFor+3 )
					cVerba += ","
				EndIf
			Next nFor
		EndIf

		If nVerHor = 2   //Horizontal
			// Cria no vetor de totalizacao, as verbas solicitadas
			If !Empty(cCodigos)
				For nFor := 1 To Len(ALLTRIM(cCodigos)) Step 3
					cVerbaCod := Subs(cCodigos,nFor,3)
					//--Incluir Salario Base nos codigos a listar
					Aadd(aTotais,{cVerbaCod,0,0,0,0,0,0,0,0,cAnoMesI," "," "," ",0,0,0,0,0})
				Next
			EndIf
			//--Limite de Verbas Horizontal em Valor
			If Len(aTotais) > 10 .And. nValHor  = 1
				Help(" ",1,"R100MAIO8") // "Nao e possivel listar mais do que 8 codigos na horizontal, quando os mesmos forem solicitados em valores."
				Return
				//--Limite de Verbas Horizontal em Horas
			ElseIf Len(aTotais) > 16 .And. nValHor = 2
				Help(" ",1,"R100MAIO15") // "Nao e possivel listar mais do que 15 codigos na horizontal, quando os mesmos forem solicitados em horas."
				Return
			EndIf
			If (Len(aTotais) > 4 .AND. nValHor = 1) .OR. (Len(aTotais) > 6 .AND. nValHor = 2)
				cSize   	:= "G"
				nTamanho	:= "G"
				COLUNAS    	:= 220
				nChar		:= 15
				aReturn[4]	:= 2
			EndIf
		Else
			cSize   	:= "M"
			nTamanho	:= "M"
			COLUNAS    	:= 132
			nChar		:= 15
			aReturn[4]	:= 1
		EndIf

		TITULO := "VAL. ACUM. POR COMPET."+" "+aOrd[ aReturn[8] ]  //'VALORES ACUMULADOS POR COMPETENCIA
		wCabec0 := 2
		If nVerHor = 1
			wCabec1 := Space(50)+'Data'+Space(4)+'PROVENTO/DESCONTO' 		//'DATA'###'T T |- PROVENTO/DESCONTO -|'
			wCabec2 := 	'FIL.'+Space(09-Len('FIL.'))+;		//FIL.
			'MAT'+Space(06-Len('MAT.'))+;		//MAT.
			'NOME'+Space(34-Len('NOME'))+;		//NOME
			'REF.'+Space(8-Len('REF.'))+;			//REF.
			'1 2' +Space(1)+;						//1 2
			'COD'+Space(1)+;						//COD
			'DESCRIPC'+Space(24-Len('DESCRIPC'))+;       	//DESCRIPC.
			'HORAS'+Space(13-Len('HORAS'))+;		//HORAS
			'V A L O R'+Space(20-Len('V A L O R'))+;		//V A L O R
			'Dta Pagto'   								//Dta Pagto

		Else
			aTotais := aSort(aTotais,,,{ |x,y| x[10]+x[1] < y[10]+y[1] })
			wCabec1 :=	"FIL."+Space(1)+"MATR."+Space(2)+"NOME"+Space(35)+"DATA"+ Space(19-(Len('FIL.')+Len('MAT.') + Len('NOME')+ Len('DATA')))+Space(1)
			//"FI C.CUSTO   MATR.  NOME                           DATA  "
			wCabec2 := space(59)

		EndIf

		If	nLastKey = 27
			Return
		EndIf

		// Passa parametros de controle da impressora
		SetDefault(aReturn,cString,,,cSize)

		RptStatus({|lEnd| GR510Imp(@lEnd,wnRel,cString)},titulo)

		RestArea( aArea )


		BeginSql Alias cAliasTMP
		SELECT
			*
		FROM %Table:SRD% SRD 
		WHERE SRD.%notDel%
		AND SRD.RD_FILIAL BETWEEN %exp:MV_PAR01% AND %exp:MV_PAR02%
		ORDER BY %Order:SE2%
		EndSql

	Endif
Return
