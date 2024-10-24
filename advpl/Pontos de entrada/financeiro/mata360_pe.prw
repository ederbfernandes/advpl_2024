#include "Totvs.ch"
#include "FWMVCDEF.CH"

/*/{Protheus.doc} MATA360
Ponto de entrada no cadastro de condições de pagamento
@type function
@version 1.0
@author Eder Fernandes
@since 22/10/2024
/*/
User Function MATA360()

	Local aParam    := PARAMIXB
	Local lIsGrid   := .F.
	Local cIDPonto  := ''
	Local cIDModel  := ''
	Local oObj      := NIL
	Local nOper		:= 0
	Local aDados    := {}
	Local aItensAux := {}
	Local aItens    := {}
	Local aRet      := {}
	Local aFilLogin := {"14","01"}
	Local  lRet     := .T.
	Local nI        := 0
	Local _oModel
	Local _oModelSE4
	Local _oModelSEC

	If aParam <> NIL
		oObj        := aParam[1]
		cIDPonto    := aParam[2]
		cIDModel    := aParam[3]
		lIsGrid     := (Len(aParam) > 3)

		//Antes da alteração de qualquer campo do formulário.
		If cIDPonto == 'FORMPRE'

			//Na validação total do formulário.
		ElseIf cIDPonto == 'FORMPOS'


			//Antes da gravação da tabela do formulário
		ElseIf cIDPonto == 'FORMCOMMITTTSPRE'

			//Após a gravação da tabela do formulário.
		ElseIf cIDPonto == 'FORMCOMMITTTSPOS'

			//Valida se pode acessar o cadastro de clientes
		ElseIf cIDPonto == 'MODELVLDACTIVE'

			//Antes da alteração de qualquer campo do Modelo.
		ElseIf cIDPonto == 'MODELPRE'

			//Antes da alteração de qualquer campo do Formulário.
		ElseIf cIDPonto == 'FORMPRE'

			//Adicionando um botão na barra de botões da rotina
		ElseIf cIDPonto == 'BUTTONBAR'

			//Chamada na validação total do modelo
		ElseIf  cIDPonto == 'MODELPOS'

			//Chamada antes da gravação da tabela do formulário
		ElseIf cIDPonto == 'FORMCOMMITTTSPRE'



			//Chamada após a gravação da tabela do formulário
		ElseIf cIDPonto == 'FORMCOMMITTTSPOS'

			//Chamada após a gravação total do modelo e dentro da transação
		ElseIf cIDPonto == 'MODELCOMMITTTS'


			//Chamada após a gravação total do modelo e fora da transação
		ElseIf cIDPonto == 'MODELCOMMITNTTS'

		
			nOper      := oobj:GetOperation()
			If lIsGrid
				xRet       := .F.
				_oModel    := FWModelActive()
				_oModelSE4 := _oModel:GetModel("SE4MASTER")
				_oModelSEC := _oModel:GetModel("SECDETAIL")

				aadd(aDados, {"E4_FILIAL" , _oModelSE4:GetValue("E4_FILIAL")})
				aadd(aDados, {"E4_CODIGO" , _oModelSE4:GetValue("E4_CODIGO")})
				aadd(aDados, {"E4_TIPO"   , _oModelSE4:GetValue("E4_TIPO")})
				aadd(aDados, {"E4_COND"   , _oModelSE4:GetValue("E4_COND")})
				aadd(aDados, {"E4_DESCRI" , _oModelSE4:GetValue("E4_DESCRI")})
				aadd(aDados, {"E4_IPI"    , _oModelSE4:GetValue("E4_IPI")})
				aadd(aDados, {"E4_DDD"    , _oModelSE4:GetValue("E4_DDD")})
				aadd(aDados, {"E4_DESCFIN", _oModelSE4:GetValue("E4_DESCFIN")})
				aadd(aDados, {"E4_DIADESC", _oModelSE4:GetValue("E4_DIADESC")})
				aadd(aDados, {"E4_FORMA"  , _oModelSE4:GetValue("E4_FORMA")})
				aadd(aDados, {"E4_ACRSFIN", _oModelSE4:GetValue("E4_ACRSFIN")})
				aadd(aDados, {"E4_SOLID"  , _oModelSE4:GetValue("E4_SOLID")})
				aadd(aDados, {"E4_ACRES"  , _oModelSE4:GetValue("E4_ACRES")})
				aadd(aDados, {"E4_PERCOM" , _oModelSE4:GetValue("E4_PERCOM")})
				aadd(aDados, {"E4_SUPER"  , _oModelSE4:GetValue("E4_SUPER")})
				aadd(aDados, {"E4_INFER"  , _oModelSE4:GetValue("E4_INFER")})
				//aadd(aDados, {"E4_FATOR"  , _oModelSE4:GetValue("E4_FATOR"),TAMSX3('E4_FATOR')[3],TAMSX3('E4_FATOR')[1],TAMSX3('E4_FATOR')[2]})
				aadd(aDados, {"E4_PLANO"  , _oModelSE4:GetValue("E4_PLANO")})
				aadd(aDados, {"E4_JURCART", _oModelSE4:GetValue("E4_JURCART")})
				aadd(aDados, {"E4_PALM"   , _oModelSE4:GetValue("E4_PALM")})
				//	aadd(aDados, {"E4_USERLGI", _oModelSE4:GetValue("E4_USERLGI")})
				//	aadd(aDados, {"E4_USERLGA", _oModelSE4:GetValue("E4_USERLGA")})
				aadd(aDados, {"E4_INDICE" , _oModelSE4:GetValue("E4_INDICE")})
				aadd(aDados, {"E4_CTRADT" , _oModelSE4:GetValue("E4_CTRADT")})
				aadd(aDados, {"E4_XPRZMED", _oModelSE4:GetValue("E4_XPRZMED")})
				aadd(aDados, {"E4_AGRACRS", _oModelSE4:GetValue("E4_AGRACRS")})
				aadd(aDados, {"E4_LIMACRS", _oModelSE4:GetValue("E4_LIMACRS")})
				aadd(aDados, {"E4_CCORREN", _oModelSE4:GetValue("E4_CCORREN")})
				aadd(aDados, {"E4_XTS"    , _oModelSE4:GetValue("E4_XTS")})
				aadd(aDados, {"E4_XBOLETO", _oModelSE4:GetValue("E4_XBOLETO")})
				aadd(aDados, {"E4_MSBLQL" , _oModelSE4:GetValue("E4_MSBLQL")})
				//	aadd(aDados, {"E4_TPAY"   , _oModelSE4:GetValue("E4_TPAY")})
				//	aadd(aDados, {"E4_PAGGRR" , _oModelSE4:GetValue("E4_PAGGRR")})
				//	aadd(aDados, {"E4_GRRNF"  , _oModelSE4:GetValue("E4_GRRNF")})
				aadd(aDados, {"E4_ATVWF"  , _oModelSE4:GetValue("E4_ATVWF")})

				If _oModelSEC:Length() >= 1


					For nI := 1 To _oModelSEC:Length()
						_oModelSEC:GoLine( nI )
						//---------------------------------------
						//Validacao dos dados da linha corrente
						//---------------------------------------
						If _oModelSEC:IsDeleted()
							Loop
						EndIf

						aadd(aItensAux, {"EC_FILIAL",  _oModelSEC:GetValue("EC_FILIAL")})
						aadd(aItensAux, {"EC_ITEM",  _oModelSEC:GetValue("EC_ITEM")})
						aadd(aItensAux, {"EC_TIPO"  ,  _oModelSEC:GetValue("EC_TIPO")})
						aadd(aItensAux, {"EC_COND"  ,  _oModelSEC:GetValue("EC_COND")})
						aadd(aItensAux, {"EC_IPI"   ,  _oModelSEC:GetValue("EC_IPI")})
						aadd(aItensAux, {"EC_DDD"   ,  _oModelSEC:GetValue("EC_DDD")})
						aadd(aItensAux, {"EC_SOLID" ,  _oModelSEC:GetValue("EC_SOLID")})
						aadd(aItensAux, {"EC_RATEIO",  _oModelSEC:GetValue("EC_RATEIO")})

						aadd(aItens,aItensAux)
						aItensAux := {}
					Next nI

				Endif
				Processa({|| aRet := fRecCondPg(nOper, aDados, aItens, aFilLogin),CursorArrow() },"Replicando Dados para empresa 14 - MELB...")

				If aRet[1]
					FwAlertSuccess("Dados replicados com sucesso para empresa: " + CRLF + "14 - MELB", "MATA360_PE")
				Else
					FwAlertError("Não foi possível replicar os Dados para empresa: " + CRLF + "14 = MELB" + CRLF +;
						aRet[2], "MATA360_PE")
					lRet := .F.
				Endif
			EndIf
			
			//Validação do botão cancelar
		ElseIf cIDPonto == 'MODELCANCEL'

		EndIf
	EndIf

Return lRet



Static Function fRecCondPg(nOper, aDados, aItens, aFilLogin)

	Local aReturn  := {}

	aReturn := StartJob("U_POOMSA67", GetEnvServer() , .T. , aDados, aItens, nOper, aFilLogin[1], aFilLogin[2])


Return aReturn





User Function POOMSA67(aDados, aItens, nOpcAuto, _pcEmp, _pcFil)

	Local nX                := 0
	Local aAutoErro         := {}
	Local cMsgAlert         := ""
	Local aRet              := {}

	private lMsErroAuto
	private	lMsHelpAuto
	private	lAutoErrNoFile

	If IsBlind()
		RPCSetType(3)
		RpcSetEnv(_pcEmp,_pcFil)
		SetHideInd(.T.) // evita problemas com índices temporários
		Sleep( 2000 )	// aguarda 2 segundos para que as jobs IPC subam.
		lAutoErrNoFile := .T.
	Endif

	FwVetByDic(aDados, "SE4")


	lMsErroAuto 	:= .F.
	lMsHelpAuto		:= .T.
	lAutoErrNoFile 	:= .T.


	MSExecAuto({|x,y,z|mata360(x,y,z)},aDados,aItens, nOpcAuto)

	If lMsErroAuto
		aAutoErro   := GetAutoGRLog()
		cMsgAlert   := ""
		For nX := 1 to Len(aAutoErro)
			cMsgAlert += aAutoErro[nX] + CRLF
		Next nX
		aRet    := {.F., cMsgAlert}
	Else
		aRet    := {.T., aDados[2] + ' - ' + aDados[5]}
	EndIf



	If IsBlind()
		RpcClearEnv()
	EndIf

Return aRet
