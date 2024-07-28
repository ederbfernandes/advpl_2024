#Include 'totvs.ch'



/*/{Protheus.doc} cnt260fil
Ponto de Entrada localizado na fun��o CN260Exc e utilizado para executar 
medi��es pendentes para os contratos autom�ticos. Ele permite que sejam 
adicionados filtros � query respons�vel por selecionar as parcelas de 
contratos autom�ticos pendentes para a data atual.
@type function
@version 12.1.23
@author Eder Fernandes
@since 14/01/2024
@return variant, retorna string com o filtro especificado 
@see https://tdn.totvs.com/pages/releaseview.action?pageId=185731669
/*/
User Function cnt260fil()

	Local cFilter  := ""

	If CNF->CNF_XLIBER == 'N'
	
		cFilter := " CNF.CNF_XLIBER <> 'N' "

	Endif


Return cFilter
