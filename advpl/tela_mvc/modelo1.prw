#include 'totvs.ch'
#include 'fwmvcdef.ch'




User Function Modelo1()

	Local aArea := FwGetArea()
	Local aPergs := {}
    Local xPar0  := TamSx3("RA_FILIAL")[3]
    Local xPar1  := TamSx3("RA_FILIAL")[3]
    Local xPar2  := TamSx3("RA_MAT")[3]
    Local xPar3  := TamSx3("RA_MAT")[3]
	Private aEstrut := {}
	Private _cAlias := GetNextAlias()
	Private oMark
	Private oTempTable

	If oTempTable <> Nil
		oTempTable:Delete()
		oTempTable := Nil
	Endif

    aadd(aPergs, {1, 'Filial de'    , xPar0, ""                                          , .T., "SM0", ".T.", 10   , .F.})
    aadd(aPergs, {1, 'Filial Até'   , xPar1, ""                                          , .T., "SM0", ".T.", 10   , .T.})
    aadd(aPergs, {1, 'Matrícula de' , xPar2, ""                                          , .T., "SRA", ".T.", 25   , .F.})
    aadd(aPergs, {1, 'Matrícula Até', xPar3, ""                                          , .T., "SRA", ".T.", 25   , .T.})
    aadd(aPergs, {2, 'Tipo de Aviso', xPar4, {"1-Aviso Indenizado", "2-Aviso Trabalhado"}, .T., ""   , 100  , ".T.", .F.})


    If ParamBox(aPergs, "Informe os Parâmetros",,,,,,,,,,.T.)

Return
