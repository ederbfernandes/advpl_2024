#include 'totvs.ch'



/*/{Protheus.doc} matr01
função teste de martizes
@type function
@version 12.1.23
@author eder.fernandes
@since 7/25/2024
@return logical, lret
/*/
user function matr01() as logical
	local aArray1 := {}  as array
	local lRet    := .f. as logical
	local nNum    := 0   as numeric
	local nX      := 0   as numeric
	local nA      := 0   as numeric
	local cArray  := ""  as character



	for nx := 1 to 5
		nNum++
		aadd(aArray1, "teste"+ cValToChar(nNum))

	next nx

	cArray := arrtokstr(aArray1, "-")

	MsgInfo(cArray,"Atenção")

	for nA := len(aArray1) to 1 step -1
		ADel(aArray1,nA)
		aSize(aArray1,len(aArray1)-1)
	next nA

	cArray := arrtokstr(aArray1,"-")

	MsgInfo(cArray, "Atenção")


Return lRet
