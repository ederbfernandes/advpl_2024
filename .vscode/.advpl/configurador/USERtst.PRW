#INCLUDE 'TOTVS.CH'


USER FUNCTION usrteste()

	Local xPar00    := Space(6)
	Local cQry_Usr  := ""
	Local cAliasUsr := ""
	Local aParamBox := {}


	If Select ('SX6') == 0
		RpcSetEnv('99','01')
	Endif
	cAliasUsr := GetNextAlias()

	aAdd(aParamBox,{1,"Usuario de",xPar00,"","","","",0,.F.})
	aAdd(aParamBox,{1,"Usuario Ate",xPar00,"","","","",0,.F.})

	If  ParamBox(aParamBox,"Preencha os Parametros...",,,,,,,,,,.T.,.T.)
		cQry_Usr := Processa({|| fGeraRel(MV_PAR01,MV_PAR02)}, 'Aguarde, Consultando Usuários...')

		dbUseArea(.T., 'TOPCONN', TCGenQry(, , cQry_Usr), cAliasUsr, .F., .T.)
		While cAliasUsr->(!Eof())

			cUsr := cAliasUsr->USR_CODIGO


			cAliasUsr->(DbSkip())
		EndDo
		cAliasUsr->(DbCloseArea())


	else
		FWAlertInfo("Cancelado pelo Usuário","UserTeste")

	Endif

Return
