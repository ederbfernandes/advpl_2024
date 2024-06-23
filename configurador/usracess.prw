#Include "Totvs.ch"
#Include "tbiconn.ch"

/*/{Protheus.doc} User Function USRACESS
Relatorio Acessos de Usuarios
@author Eder Fernandes
@since 14/04/2023
@version 1.0
@type function
/*/

User Function USRACESS()
	Local aArea := FWGetArea()
	Local aPergs   := {}
	Local xPar0 := Space(6)
	Local xPar1 := Space(6)
	Local xPar2 := Space(70)
	Local xPar3 := Space(75)
	Local xPar4 := 2

	//Adicionando os parametros do ParamBox
	aadd(aPergs, {1, "Usuário De"           , xPar0, ""                                         , ".T.", "USR"   , ".T.", 80, .F.})
	aadd(aPergs, {1, "Usuário Até"          , xPar1, ""                                         , ".T.", "USR"   , ".T.", 80, .T.})
	aadd(aPergs, {1, "Nome"                 , xPar2, ""                                         , ".T.", ""      , ".T.", 80, .F.})
	aadd(aPergs, {1, "Diretório para Salvar", xPar3, ""                                         , ".T.", "HSSDIR", ""   , 80, .T.})
	aadd(aPergs, {2, "Situação Registro"    , xPar4, {"1=Bloqueado" ,"2=Desbloqueado","3=Ambos"}, 80   , ".T."   , .F.})
	//Se a pergunta for confirma, cria as definicoes do relatorio
	If ParamBox(aPergs, "Informe os parametros",,,,,,,,,.T.,.T.)
		Processa({|| fPreenArq()})
	EndIf

	FWRestArea(aArea)
Return
/*/{Protheus.doc} fPreenArq
Preenchimento de dados no arquivo - USRACESS
@author Eder Fernandes
@since 14/04/2023
@version 1.0
@type function
/*/

Static Function fPreenArq()
	Local aArea     := FWGetArea()
	Local nAtual    := 0
	Local nTotal    := 0
	Local cArquivo  := 'USRACESS_' + dToS(Date()) + '_' + StrTran(Time(), ':' , '-' ) + '.csv'
	Local cPasta    := ALLTRIM(MV_PAR04)
	Local oFWriter  := Nil
	Local cQryUser  := ""
	Local cRegra    := ""
	Local nX        := 0
	Local cSituacao := ""
	Local cDepto    := ""
	Local cCargo    := ""
	Local cNvlCmp   := ""
	Local cRegraDes := ""

	//Se o último caracter não for uma barra, adiciona uma barra
	If SubStr(cPasta, Len(cPasta), 1) != '\'
		cPasta += '\'
	EndIf

	//Montando consulta de dados
	cQryUser := fQueryUser()


	//Executando consulta de usuarios
	PlsQuery(cQryUser, "QRY_USR")
	DbSelectArea("QRY_USR")
	Count To nTotal
	QRY_USR->(DbGoTop())

	//Chama a criação do arquivo
	oFWriter := FWFileWriter():New(cPasta + cArquivo, .T.)


	//Se houve falha ao criar, mostra a mensagem
	If ! oFWriter:Create()
		MsgStop('Houve um erro ao gerar o arquivo: ' + CRLF + oFWriter:Error():Message, 'Atenção')
		Return()
		//Senão, continua com o processamento
	Else

		ProcRegua(nTotal)

		//Adiciona a linha de cabeçalho
		cLinha := ''
		cLinha += 'USR_ID;'
		cLinha += 'USR_CODIGO;'
		cLinha += 'USR_NOME;'
		cLinha += 'USR_BLOQUEADO;'
		cLinha += 'USR_DEPTO;'
		cLinha += 'USR_CARGO;'
		cLinha += 'GRUPO_USUARIO;'
		cLinha += 'GRUPO_PRIORIZA;'
		cLinha += 'USR_REGRA_DE_ACESSO_POR_GRUPO;'
		cLinha += 'MODULO_GRUPO;'
		cLinha += 'GRUPO_FILIAL;'
		//cLinha += 'USR_NIVEL_CAMPO;'
		cLinha += 'ACESSA_TODAS_EMPRESAS_GRP;'
		cLinha += 'ACESSO_GRUPO;'

		//Escreve a linha com a quebra do CRLF no fim
		oFWriter:Write(cLinha + CRLF)

		//Enquanto houver dados
		While !QRY_USR->(EoF())

			_cUser   := QRY_USR->USR_ID
			cUsrCod  := QRY_USR->USR_CODIGO
			cUsrNome := QRY_USR->USR_NOME
			cRegra   := QRY_USR->USR_GRPRULE
			cSituacao:= QRY_USR->USR_MSBLQL
			cDepto   := QRY_USR->USR_DEPTO
			cCargo   := QRY_USR->USR_CARGO
			cNvlCmp  := QRY_USR->USR_NIVELREAD

			//Incrementando a régua
			nAtual++
			IncProc('Adicionando registro ' + cValToChar(nAtual) + ' de ' + cValToChar(nTotal) + '...')


			aRetDados := fRetDados(_cUser,cUsrCod,cUsrNome,cSituacao,cDepto,cCargo,cNvlCmp,cRegra)

			cRegraDes := IIf(cRegra == '1' ,cRegra + '-' + 'PRIORIZA' ,IIF(cRegra == '2' ,cRegra + '-' + 'DESCONSIDERAR' ,cRegra + '-' + 'SOMAR' ))

			For nX := 1 to Len(aRetDados)

				//Monta a linha que será escrita
				cLinha := ''
				cLinha += aRetDados[nX,1] + ';'  							 //USR_ID
				cLinha += AllTrim(aRetDados[nX,2]) + ';'   					 //USR_CODIGO
				cLinha += AllTrim(aRetDados[nX,3]) + ';' 					 //USR_NOME
				cLinha += IIF(aRetDados[nX,4] == '1' , 'SIM' , 'NAO' ) + ';' //USR_BLOQUEADO
				cLinha += AllTrim(aRetDados[nX,5]) + ';'  					 //USR_DEPTO
				cLinha += AllTrim(aRetDados[nX,6]) + ';' 					 //USR_CARGO
				cLinha += aRetDados[nX,9] + ';'								 //GRUPO_USUARIO
				cLinha += aRetDados[nX,10] + ';'							 //GRUPO_PRIORIZA
				cLinha += cRegraDes + ';'									 //USR_REGRA
				cLinha += aRetDados[nX,11] + ';'							 //MODULOS
				cLinha += aRetDados[nX,12] + ';'							 //FILIAIS
				//cLinha += cValtoChar(aRetDados[nX,7]) + ';'				 //USR_NIVEL_CAMPO
				cLinha += IIF(aRetDados[nX,13] == '1' , 'SIM' , 'NAO' ) + ';' //ACESSA_TODAS_EMPRESAS
				cLinha += aRetDados[nX,14] + ';'							 //PERMISSOES
				//cLinha += aRetDados[nX,11] + ';'							 //MENU
				//cLinha += aRetDados[nX,12] + ';'							 //SUBMENU
				//cLinha += aRetDados[nX,14] + ';'							 //FUNCAO

				//Escreve a linha com a quebra do CRLF no fim
				oFWriter:Write(cLinha + CRLF)
			Next nX
			//aRetDados:= {}
			QRY_USR->(DbSkip())
		EndDo

		//Encerra o arquivo
		oFWriter:Close()

		//Pergunta se deseja abrir o arquivo
		If MsgYesNo('Arquivo gerado com sucesso (' + cPasta + cArquivo + ')!' + CRLF + 'Deseja abrir?', 'Atencao')
			ShellExecute('OPEN', cArquivo, '', cPasta, 1 )
		EndIf
	EndIf

	QRY_USR->(DbCloseArea())

	FWRestArea(aArea)
Return


Static Function fQueryUser()
	Local cQryUsr := ""

	cQryUsr += " SELECT USR_ID, " 														+ CRLF
	cQryUsr += "  	USR_CODIGO, "														+ CRLF
	cQryUsr += "  	USR_NOME, " 														+ CRLF
	cQryUsr += "  	USR_MSBLQL, " 														+ CRLF
	cQryUsr += "  	USR_DEPTO, " 														+ CRLF
	cQryUsr += "  	USR_CARGO, " 														+ CRLF
	cQryUsr += "    USR_GRPRULE, " 														+ CRLF
	cQryUsr += "  	USR_NIVELREAD " 													+ CRLF
	cQryUsr += " FROM SYS_USR " 														+ CRLF
	cQryUsr += "  WHERE  USR_ID  BETWEEN '" + MV_PAR01 + "' AND '" + MV_PAR02 + "' " 	+ CRLF
	cQryUsr += "  AND D_E_L_E_T_ = ' ' " 												+ CRLF
	If !Empty(MV_PAR03)
		cQryUsr +=  " AND USR_NOME LIKE '%" + AllTrim(MV_PAR03) + "%' "    		    	+ CRLF
	Endif
	If MV_PAR05 == 1
		cQryUsr += " AND USR_MSBLQL = '1' "  										 	+ CRLF
	Elseif MV_PAR05 == 2
		cQryUsr += " AND USR_MSBLQL = '2' "     					 				 	+ CRLF
	Endif
	cQryUsr += " ORDER BY USR_ID " 													 	+ CRLF

Return cQryUsr



Static Function fRetDados(_cUser,cUsrCod,cUsrNome,cSituacao,cDepto,cCargo,cNvlCmp,cRegra)

	Local aRet      := {}
	//Local lRet      := .T.
	Local cQryDados := ""
//	Local cGroupin  := ""
//	Local cRegraDes := ""
	Local cModulos   := ""

	// cQryDados += "   SELECT DISTINCT USR.USR_ID, " 																	+ CRLF
	// cQryDados += "                 (SELECT NVL (LISTAGG (SURGD.USR_GRUPO, ',') " 									+ CRLF
	// cQryDados += "                     WITHIN GROUP (ORDER BY SURGD.R_E_C_N_O_),' ') " 								+ CRLF
	// cQryDados += "        FROM TOTVS.SYS_USR_GROUPS SURGD " 														+ CRLF
	// cQryDados += "       WHERE     SURGD.D_E_L_E_T_ = ' ' " 														+ CRLF
	// cQryDados += "             AND SURGD.USR_ID = USR.USR_ID)    AS GRUPO_USUARIO , " 								+ CRLF
	// cQryDados += "             NVL((SELECT SURGE.USR_GRUPO " 														+ CRLF
	// cQryDados += "     FROM TOTVS.SYS_USR_GROUPS SURGE "															+ CRLF
	// cQryDados += " WHERE SURGE.D_E_L_E_T_ = ' ' " 																	+ CRLF
	// cQryDados += "	AND SURGE.USR_ID = USR.USR_ID AND SURGE.USR_PRIORIZA = '1'), ' ') AS GRUPO_PRIORIZA, " 			+ CRLF
	// cQryDados += "                 USR.USR_MSBLQL, USR.USR_DEPTO, USR.USR_CARGO, " 									+ CRLF

	// If cRegra == '1'

	// 	cQryDados += "	 LPAD (GRP_MODULE.GR__MODULO,2,'0') AS USR_MODULO, "                                        + CRLF
	// 	cQryDados += "	(	SELECT	USR_CODMOD " 																	+ CRLF
	// 	cQryDados += "	FROM " 																						+ CRLF
	// 	cQryDados += "	TOTVS.SYS_USR_MODULE " 																		+ CRLF
	// 	cQryDados += "	WHERE " 																					+ CRLF
	// 	cQryDados += "	D_E_L_E_T_ = ' ' " 																			+ CRLF
	// 	cQryDados += "	AND USR_ID = USR.USR_ID " 																	+ CRLF
	// 	cQryDados += "	AND USR_MODULO = GRP_MODULE.GR__MODULO) AS USR_CODMOD, " 									+ CRLF
	// 	cQryDados += "  USR_REGRA, "
	// 	cQryDados += "	GRP_MODULE.GR__NIVEL AS USR_NVLCMP, " 														+ CRLF
	// 	cQryDados += "	GRP_MODULE.GR__ARQMENU AS ARQ_MENU_USR, " 													+ CRLF
	// 	cQryDados += "		CASE " 																					+ CRLF
	// 	cQryDados += "		WHEN GRP_GROUP.GR__ALLEMP = '1' " 														+ CRLF
	// 	cQryDados += "      THEN  'TODAS EMPRESAS ' " 																+ CRLF
	// 	cQryDados += "		ELSE " 																					+ CRLF
	// 	cQryDados += "	        (	SELECT NVL ( LISTAGG (RTRIM (GRP_FILIAL.GR__FILIAL), " 				        	+ CRLF
	// 	cQryDados += "                                              ','), " 										+ CRLF
	// 	cQryDados += "                                     ' ') " 													+ CRLF
	// 	cQryDados += "                            FROM TOTVS.SYS_GRP_FILIAL GRP_FILIAL " 							+ CRLF
	// 	cQryDados += "                           WHERE GRP_FILIAL.D_E_L_E_T_ = ' ' AND GRP_FILIAL.GR__ACESSO = 'T' "+ CRLF
	// 	cQryDados += "                                 AND GRP_FILIAL.GR__ID IN (NVL((SELECT USR_GRUPO " 			+ CRLF
	// 	cQryDados += " 						       FROM TOTVS.SYS_USR_GROUPS  " 								    + CRLF
	// 	cQryDados += "  					    WHERE D_E_L_E_T_ = ' ' " 											+ CRLF
	// 	cQryDados += "  					    AND USR_ID = USR.USR_ID AND USR_PRIORIZA = '1'), ' '))) " 			+ CRLF
	// 	cQryDados += "		END AS USR_FILIAL, " 																	+ CRLF
	// 	cQryDados += " 	 (SELECT LISTAGG (ACESSO, ',') " 															+ CRLF
	// 	cQryDados += "   FROM (SELECT LPAD (GRACESSOS1.GR__CODACESSO, 3, '0')     AS ACESSO " 						+ CRLF
	// 	cQryDados += "           FROM TOTVS.SYS_GRP_ACCESS GRACESSOS1 " 											+ CRLF
	// 	cQryDados += "          WHERE     GRACESSOS1.D_E_L_E_T_ = ' ' " 											+ CRLF
	// 	cQryDados += "                AND GRACESSOS1.GR__ID IN (SELECT USR_GRUPO FROM TOTVS.SYS_USR_GROUPS "        + CRLF
	// 	cQryDados += "                WHERE D_E_L_E_T_ = ' ' AND USR_ID = USR.USR_ID " 	            	        	+ CRLF
	// 	cQryDados += "                AND GRACESSOS1.GR__ACESSO = 'T'))) AS USR_ACESSO " 							+ CRLF

	// Elseif cRegra == '2'

	// 	cQryDados += "                LPAD (USR_MODULE.USR_MODULO, 2, '0') AS USR_MODULO, " 							+ CRLF
	// 	cQryDados += "                USR_MODULE.USR_CODMOD, " 															+ CRLF
	// 	cQryDados += "                 USR.USR_GRPRULE AS USR_REGRA, " 													+ CRLF
	// 	cQryDados += "                 USR.USR_NIVELREAD AS USR_NVLCMP, " 												+ CRLF
	// 	cQryDados += "                 USR.USR_ALLEMP, " 																+ CRLF
	// 	cQryDados += "                 USR_MODULE.USR_ARQMENU                  AS ARQ_MENU_USR, " 						+ CRLF
	// 	cQryDados += "                 CASE " 																			+ CRLF
	// 	cQryDados += "                     WHEN USR.USR_ALLEMP = '1' " 													+ CRLF
	// 	cQryDados += "                     THEN " 																		+ CRLF
	// 	cQryDados += "                         'TODAS EMPRESAS' " 														+ CRLF
	// 	cQryDados += "                     ELSE " 																		+ CRLF
	// 	cQryDados += "	               (	SELECT NVL ( LISTAGG (RTRIM (USRFILIAL.USR_FILIAL), ','),' ') " 			+ CRLF
	// 	cQryDados += "			FROM " 																			    	+ CRLF
	// 	cQryDados += "	TOTVS.SYS_USR_FILIAL USRFILIAL " 														 	    + CRLF
	// 	cQryDados += "			WHERE " 																		    	+ CRLF
	// 	cQryDados += "	USRFILIAL.D_E_L_E_T_ = ' ' " 															 	    + CRLF
	// 	cQryDados += "	AND USRFILIAL.USR_ACESSO = 'T' " 														 	    + CRLF
	// 	cQryDados += "	AND USRFILIAL.USR_ID = USR.USR_ID) " 													    	+ CRLF
	// 	cQryDados += "                      END                                     AS USR_FILIAL, " 					+ CRLF
	// 	cQryDados += " 	 (SELECT LISTAGG (ACESSO, ',') " 																+ CRLF
	// 	cQryDados += "   FROM (SELECT LPAD (GRACESSOS1.USR_CODACESSO, 3, '0')     AS ACESSO " 							+ CRLF
	// 	cQryDados += "           FROM TOTVS.SYS_USR_ACCESS GRACESSOS1 " 												+ CRLF
	// 	cQryDados += "          WHERE     GRACESSOS1.D_E_L_E_T_ = ' ' " 												+ CRLF
	// 	cQryDados += "                AND GRACESSOS1.USR_ID = USR.USR_ID " 												+ CRLF
	// 	cQryDados += "                AND GRACESSOS1.USR_ACESSO = 'T')) AS USR_ACESSO " 								+ CRLF


	// ElseIf cRegra == '3'

	// 	cQryDados += "                LPAD (USR_MODULE.USR_MODULO, 2, '0') AS USR_MODULO, " 							+ CRLF
	// 	cQryDados += "                USR_MODULE.USR_CODMOD, " 															+ CRLF
	// 	cQryDados += "                 USR.USR_GRPRULE AS USR_REGRA, " 													+ CRLF
	// 	cQryDados += "                 USR.USR_GRPRULE AS USR_REGRA, " 													+ CRLF
	// 	cQryDados += "                 USR.USR_NIVELREAD AS USR_NVLCMP, " 												+ CRLF
	// 	cQryDados += "                 USR.USR_ALLEMP, " 																+ CRLF
	// 	cQryDados += "                 USR_MODULE.USR_ARQMENU                  AS ARQ_MENU_USR, " 						+ CRLF
	// 	cQryDados += "                 CASE " 																			+ CRLF
	// 	cQryDados += "                     WHEN USR.USR_ALLEMP = '1' " 													+ CRLF
	// 	cQryDados += "                     THEN " 																		+ CRLF
	// 	cQryDados += "                         'TODAS EMPRESAS' " 														+ CRLF
	// 	cQryDados += "                     ELSE " 																		+ CRLF
	// 	cQryDados += "	               (	SELECT NVL ( LISTAGG (RTRIM (USRFILIAL.USR_FILIAL), ','),' ') " 			+ CRLF
	// 	cQryDados += "			FROM " 																			    	+ CRLF
	// 	cQryDados += "	TOTVS.SYS_USR_FILIAL USRFILIAL " 														 	    + CRLF
	// 	cQryDados += "			WHERE " 																		    	+ CRLF
	// 	cQryDados += "	USRFILIAL.D_E_L_E_T_ = ' ' " 															 	    + CRLF
	// 	cQryDados += "	AND USRFILIAL.USR_ACESSO = 'T' " 														 	    + CRLF
	// 	cQryDados += "	AND USRFILIAL.USR_ID = USR.USR_ID) " 													    	+ CRLF
	// 	cQryDados += " UNION     " + CRLF
	// 	cQryDados += "	        (	SELECT NVL ( LISTAGG (RTRIM (GRP_FILIAL.GR__FILIAL), " 				        	+ CRLF
	// 	cQryDados += "                                              ','), " 										+ CRLF
	// 	cQryDados += "                                     ' ') " 													+ CRLF
	// 	cQryDados += "                            FROM TOTVS.SYS_GRP_FILIAL GRP_FILIAL " 							+ CRLF
	// 	cQryDados += "                           WHERE GRP_FILIAL.D_E_L_E_T_ = ' ' AND GRP_FILIAL.GR__ACESSO = 'T' "+ CRLF
	// 	cQryDados += "                                 AND GRP_FILIAL.GR__ID IN (NVL((SELECT USR_GRUPO " 			+ CRLF
	// 	cQryDados += " 						       FROM TOTVS.SYS_USR_GROUPS  " 								    + CRLF
	// 	cQryDados += "  					    WHERE D_E_L_E_T_ = ' ' " 											+ CRLF
	// 	cQryDados += "  					    AND USR_ID = USR.USR_ID ), ' '))) " 								+ CRLF
	// 	cQryDados += "                      END                                     AS USR_FILIAL, " 				+ CRLF
	// 	cQryDados += "	(SELECT LISTAGG (ACESSO, ',')  " + CRLF
	// 	cQryDados += " FROM (SELECT LPAD (GRACESSOS1.USR_CODACESSO, 3, '0')     AS ACESSO " + CRLF
	// 	cQryDados += " FROM TOTVS.SYS_USR_ACCESS GRACESSOS1  " + CRLF
	// 	cQryDados += " WHERE     GRACESSOS1.D_E_L_E_T_ = ' '  " + CRLF
	// 	cQryDados += "     AND GRACESSOS1.USR_ID = USR.USR_ID  " + CRLF
	// 	cQryDados += "     AND GRACESSOS1.USR_ACESSO = 'T'))  	" + CRLF
	// 	cQryDados += " UNION     " + CRLF
	// 	cQryDados += "	(SELECT  LISTAGG (ACESSO, ',') " + CRLF
	// 	cQryDados += " FROM (SELECT DISTINCT LPAD (GRACESSOS1.GR__CODACESSO, 3, '0')     AS ACESSO " + CRLF
	// 	cQryDados += " FROM TOTVS.SYS_GRP_ACCESS GRACESSOS1  " + CRLF
	// 	cQryDados += " WHERE     GRACESSOS1.D_E_L_E_T_ = ' '  	" + CRLF
	// 	cQryDados += "    AND GRACESSOS1.GR__ID IN (SELECT USR_GRUPO FROM TOTVS.SYS_USR_GROUPS USRG1  WHERE USRG1.D_E_L_E_T_ = ' ' AND USRG1.USR_ID = USR.USR_ID)  " + CRLF
	// 	cQryDados += "    AND GRACESSOS1.GR__ACESSO = 'T' )) 	" + CRLF

	// Endif

	// cQryDados += "   FROM TOTVS.SYS_USR USR " 																		+ CRLF
	// cQryDados += "        LEFT JOIN TOTVS.SYS_USR_MODULE USR_MODULE " 												+ CRLF
	// cQryDados += "              ON     USR_MODULE.D_E_L_E_T_ = USR.D_E_L_E_T_ " 									+ CRLF
	// cQryDados += "               AND USR_MODULE.USR_ID = USR.USR_ID " 												+ CRLF
	// cQryDados += "               AND USR_MODULE.USR_ACESSO = 'T' " 													+ CRLF
	// cQryDados += "        LEFT JOIN TOTVS.SYS_USR_GROUPS USR_GROUPS " 											    + CRLF
	// cQryDados += "            	ON     USR_GROUPS.D_E_L_E_T_ = USR.D_E_L_E_T_ "										+ CRLF
	// cQryDados += "              AND USR_GROUPS.USR_ID = USR.USR_ID " 												+ CRLF
	// cQryDados += "	LEFT JOIN TOTVS.SYS_GRP_GROUP GRP_GROUP ON " 													+ CRLF
	// cQryDados += "	GRP_GROUP.D_E_L_E_T_ = USR.D_E_L_E_T_ " 														+ CRLF
	// cQryDados += "	AND GRP_GROUP.GR__MSBLQL = '2' " 																+ CRLF

	If cRegra == '1'

		cQryDados := "   SELECT DISTINCT USR.USR_ID,  "
		cQryDados += "                  (SELECT NVL (LISTAGG (SURGD.USR_GRUPO, ',')  "
		cQryDados += "                      WITHIN GROUP (ORDER BY SURGD.R_E_C_N_O_),' ')  "
		cQryDados += "         FROM TOTVS.SYS_USR_GROUPS SURGD  "
		cQryDados += "        WHERE     SURGD.D_E_L_E_T_ = ' '  "
		cQryDados += "              AND SURGD.USR_ID = USR.USR_ID)    AS GRUPO_USUARIO ,  "
		cQryDados += "              NVL((SELECT SURGE.USR_GRUPO  "
		cQryDados += "      FROM TOTVS.SYS_USR_GROUPS SURGE  "
		cQryDados += "  WHERE SURGE.D_E_L_E_T_ = ' '  "
		cQryDados += " 	AND SURGE.USR_ID = USR.USR_ID AND SURGE.USR_PRIORIZA = '1'), ' ') AS GRUPO_PRIORIZA,  "
		cQryDados += "                  USR.USR_MSBLQL, USR.USR_DEPTO, USR.USR_CARGO,  "
		cQryDados += " 	 LPAD (GRP_MODULE.GR__MODULO,2,'0') AS USR_MODULO,  "
		cQryDados += " 	(	SELECT	USR_CODMOD  "
		cQryDados += " 	FROM  "
		cQryDados += " 	TOTVS.SYS_USR_MODULE  "
		cQryDados += " 	WHERE  "
		cQryDados += " 	D_E_L_E_T_ = ' '  "
		cQryDados += " 	AND USR_ID = USR.USR_ID  "
		cQryDados += " 	AND USR_MODULO = GRP_MODULE.GR__MODULO) AS USR_CODMOD,  "
		cQryDados += " 	GRP_MODULE.GR__NIVEL AS USR_NVLCMP,  "
		cQryDados += " 	GRP_GROUP.GR__ALLEMP AS USR_ALLEMP, "
		cQryDados += " 	GRP_MODULE.GR__ARQMENU AS ARQ_MENU_USR,  "
		cQryDados += " 		CASE  "
		cQryDados += " 		WHEN GRP_GROUP.GR__ALLEMP = '1'  "
		cQryDados += "       THEN  'TODAS EMPRESAS '  "
		cQryDados += " 		ELSE  "
		cQryDados += " 	        (	SELECT NVL ( LISTAGG (RTRIM (GRP_FILIAL.GR__FILIAL),  "
		cQryDados += "                                               ','),  "
		cQryDados += "                                      ' ')  "
		cQryDados += "                             FROM TOTVS.SYS_GRP_FILIAL GRP_FILIAL  "
		cQryDados += "                            WHERE GRP_FILIAL.D_E_L_E_T_ = ' ' AND GRP_FILIAL.GR__ACESSO = 'T'  "
		cQryDados += "                                  AND GRP_FILIAL.GR__ID IN (NVL((SELECT USR_GRUPO  "
		cQryDados += "  						       FROM TOTVS.SYS_USR_GROUPS   "
		cQryDados += "   					    WHERE D_E_L_E_T_ = ' '  "
		cQryDados += "   					    AND USR_ID = USR.USR_ID AND USR_PRIORIZA = '1'), ' ')))  "
		cQryDados += " 		END AS USR_FILIAL,  "
		cQryDados += "  	 (SELECT LISTAGG (ACESSO, ',')  "
		cQryDados += "    FROM (SELECT LPAD (GRACESSOS1.GR__CODACESSO, 3, '0')     AS ACESSO  "
		cQryDados += "            FROM TOTVS.SYS_GRP_ACCESS GRACESSOS1  "
		cQryDados += "           WHERE     GRACESSOS1.D_E_L_E_T_ = ' '  "
		cQryDados += "                 AND GRACESSOS1.GR__ID IN (SELECT USR_GRUPO FROM TOTVS.SYS_USR_GROUPS  "
		cQryDados += "                 WHERE D_E_L_E_T_ = ' ' AND USR_ID = USR.USR_ID  "
		cQryDados += "                 AND GRACESSOS1.GR__ACESSO = 'T'))) AS USR_ACESSO  "
		cQryDados += "    FROM TOTVS.SYS_USR USR  "
		cQryDados += "         LEFT JOIN TOTVS.SYS_USR_MODULE USR_MODULE  "
		cQryDados += "               ON     USR_MODULE.D_E_L_E_T_ = USR.D_E_L_E_T_  "
		cQryDados += "                AND USR_MODULE.USR_ID = USR.USR_ID  "
		cQryDados += "                AND USR_MODULE.USR_ACESSO = 'T'  "
		cQryDados += "         LEFT JOIN TOTVS.SYS_USR_GROUPS USR_GROUPS  "
		cQryDados += "             	ON     USR_GROUPS.D_E_L_E_T_ = USR.D_E_L_E_T_  "
		cQryDados += "               AND USR_GROUPS.USR_ID = USR.USR_ID  "
		cQryDados += " 	LEFT JOIN TOTVS.SYS_GRP_GROUP GRP_GROUP ON  "
		cQryDados += " 	GRP_GROUP.D_E_L_E_T_ = USR.D_E_L_E_T_  "
		cQryDados += " 	AND GRP_GROUP.GR__MSBLQL = '2'  "
		cQryDados += " 	AND GRP_GROUP.GR__ID IN NVL((SELECT USR_GRUPO  "
		cQryDados += " 	 FROM TOTVS.SYS_USR_GROUPS   "
		cQryDados += " 	WHERE D_E_L_E_T_ = ' '  "
		cQryDados += " 	AND USR_ID = USR.USR_ID AND USR_PRIORIZA = '1'), ' ')  "
		cQryDados += "   LEFT JOIN TOTVS.SYS_GRP_FILIAL GRP_FILIAL ON  "
		cQryDados += "   GRP_FILIAL.D_E_L_E_T_ = USR.D_E_L_E_T_ AND GRP_FILIAL.GR__ID IN (NVL((SELECT USR_GRUPO  "
		cQryDados += " 	FROM TOTVS.SYS_USR_GROUPS  "
		cQryDados += "   WHERE D_E_L_E_T_ = ' '  "
		cQryDados += "   AND USR_ID = USR.USR_ID AND USR_PRIORIZA = '1'), ' '))  "
		cQryDados += " 	LEFT JOIN TOTVS.SYS_GRP_MODULE GRP_MODULE ON  "
		cQryDados += " 	USR.D_E_L_E_T_ = GRP_MODULE.D_E_L_E_T_  "
		cQryDados += " 	AND GRP_MODULE.GR__ACESSO = 'T'  "
		cQryDados += " 	AND GRP_MODULE.GR__ID = NVL((SELECT SURGEH.USR_GRUPO  "
		cQryDados += " 	FROM TOTVS.SYS_USR_GROUPS SURGEH  "
		cQryDados += "   WHERE SURGEH.D_E_L_E_T_ = ' '  "
		cQryDados += "   AND SURGEH.USR_ID = USR.USR_ID AND SURGEH.USR_PRIORIZA = '1'), ' ')	 "
		cQryDados += "   WHERE  USR.USR_ID  = '002874'  "
		cQryDados += "   AND USR.D_E_L_E_T_ = ' '  "
		cQryDados += "   ORDER BY USR.USR_ID, USR_MODULO  "


	ElseIf cRegra == '2'

		cQryDados := "  SELECT DISTINCT USR.USR_ID,  "
		cQryDados += "                  (SELECT NVL (LISTAGG (SURGD.USR_GRUPO, ',')  "
		cQryDados += "                      WITHIN GROUP (ORDER BY SURGD.R_E_C_N_O_),' ')  "
		cQryDados += "         FROM TOTVS.SYS_USR_GROUPS SURGD  "
		cQryDados += "        WHERE     SURGD.D_E_L_E_T_ = ' '  "
		cQryDados += "              AND SURGD.USR_ID = USR.USR_ID)    AS GRUPO_USUARIO ,  "
		cQryDados += "              NVL((SELECT SURGE.USR_GRUPO  "
		cQryDados += "      FROM TOTVS.SYS_USR_GROUPS SURGE  "
		cQryDados += "  WHERE SURGE.D_E_L_E_T_ = ' '  "
		cQryDados += " 	AND SURGE.USR_ID = USR.USR_ID AND SURGE.USR_PRIORIZA = '1'), ' ') AS GRUPO_PRIORIZA,  "
		cQryDados += "                  USR.USR_MSBLQL, USR.USR_DEPTO, USR.USR_CARGO,  "
		cQryDados += "                 LPAD (USR_MODULE.USR_MODULO, 2, '0') AS USR_MODULO,  "
		cQryDados += "                 USR_MODULE.USR_CODMOD,  "
		cQryDados += "                  USR.USR_GRPRULE AS USR_REGRA,  "
		cQryDados += "                  USR.USR_NIVELREAD AS USR_NVLCMP,  "
		cQryDados += "                  USR.USR_ALLEMP,  "
		cQryDados += "                  USR_MODULE.USR_ARQMENU                  AS ARQ_MENU_USR,  "
		cQryDados += "                  CASE  "
		cQryDados += "                      WHEN USR.USR_ALLEMP = '1'  "
		cQryDados += "                      THEN  "
		cQryDados += "                          'TODAS EMPRESAS'  "
		cQryDados += "                      ELSE  "
		cQryDados += " 	               (	SELECT NVL ( LISTAGG (RTRIM (USRFILIAL.USR_FILIAL), ','),' ')  "
		cQryDados += " 			FROM  "
		cQryDados += " 	TOTVS.SYS_USR_FILIAL USRFILIAL  "
		cQryDados += " 			WHERE  "
		cQryDados += " 	USRFILIAL.D_E_L_E_T_ = ' '  "
		cQryDados += " 	AND USRFILIAL.USR_ACESSO = 'T'  "
		cQryDados += " 	AND USRFILIAL.USR_ID = USR.USR_ID)  "
		cQryDados += "                       END                                     AS USR_FILIAL,  "
		cQryDados += "  	 (SELECT LISTAGG (ACESSO, ',')  "
		cQryDados += "    FROM (SELECT LPAD (GRACESSOS1.USR_CODACESSO, 3, '0')     AS ACESSO  "
		cQryDados += "            FROM TOTVS.SYS_USR_ACCESS GRACESSOS1  "
		cQryDados += "           WHERE     GRACESSOS1.D_E_L_E_T_ = ' '  "
		cQryDados += "                 AND GRACESSOS1.USR_ID = USR.USR_ID  "
		cQryDados += "                 AND GRACESSOS1.USR_ACESSO = 'T')) AS USR_ACESSO  "
		cQryDados += "    FROM TOTVS.SYS_USR USR  "
		cQryDados += "         LEFT JOIN TOTVS.SYS_USR_MODULE USR_MODULE  "
		cQryDados += "               ON     USR_MODULE.D_E_L_E_T_ = USR.D_E_L_E_T_  "
		cQryDados += "                AND USR_MODULE.USR_ID = USR.USR_ID  "
		cQryDados += "                AND USR_MODULE.USR_ACESSO = 'T'  "
		cQryDados += "         LEFT JOIN TOTVS.SYS_USR_GROUPS USR_GROUPS  "
		cQryDados += "             	ON     USR_GROUPS.D_E_L_E_T_ = USR.D_E_L_E_T_  "
		cQryDados += "               AND USR_GROUPS.USR_ID = USR.USR_ID  "
		cQryDados += " 	LEFT JOIN TOTVS.SYS_GRP_GROUP GRP_GROUP ON  "
		cQryDados += " 	GRP_GROUP.D_E_L_E_T_ = USR.D_E_L_E_T_  "
		cQryDados += " 	AND GRP_GROUP.GR__MSBLQL = '2'  "
		cQryDados += " 	AND GRP_GROUP.GR__ID IN NVL((SELECT USR_GRUPO  "
		cQryDados += " 	 FROM TOTVS.SYS_USR_GROUPS   "
		cQryDados += " 	WHERE D_E_L_E_T_ = ' '  "
		cQryDados += " 	AND USR_ID = USR.USR_ID AND USR_PRIORIZA = '1'), ' ')  "
		cQryDados += " 	LEFT JOIN TOTVS.SYS_GRP_MODULE GRP_MODULE ON  "
		cQryDados += " 	USR.D_E_L_E_T_ = GRP_MODULE.D_E_L_E_T_  "
		cQryDados += " 	AND GRP_MODULE.GR__ACESSO = 'T'  "
		cQryDados += " 	AND GRP_MODULE.GR__ID = NVL((SELECT SURGEH.USR_GRUPO  "
		cQryDados += " 	FROM TOTVS.SYS_USR_GROUPS SURGEH  "
		cQryDados += "   WHERE SURGEH.D_E_L_E_T_ = ' '  "
		cQryDados += "   AND SURGEH.USR_ID = USR.USR_ID AND SURGEH.USR_PRIORIZA = '1'), ' ')	 "
		cQryDados += "   WHERE  USR.USR_ID  = '" + _cUser + "' "
		cQryDados += "   AND USR.D_E_L_E_T_ = ' '  "


	ElseIf cRegra == '3'

		cQryDados := "  SELECT DISTINCT USR.USR_ID,  "
		cQryDados += "                  (SELECT NVL (LISTAGG (SURGD.USR_GRUPO, ',')  "
		cQryDados += "                      WITHIN GROUP (ORDER BY SURGD.R_E_C_N_O_),' ')  "
		cQryDados += "         FROM TOTVS.SYS_USR_GROUPS SURGD  "
		cQryDados += "        WHERE     SURGD.D_E_L_E_T_ = ' '  "
		cQryDados += "              AND SURGD.USR_ID = USR.USR_ID)    AS GRUPO_USUARIO ,  "
		cQryDados += "              NVL((SELECT SURGE.USR_GRUPO  "
		cQryDados += "      FROM TOTVS.SYS_USR_GROUPS SURGE  "
		cQryDados += "  WHERE SURGE.D_E_L_E_T_ = ' '  "
		cQryDados += " 	AND SURGE.USR_ID = USR.USR_ID AND SURGE.USR_PRIORIZA = '1'), ' ') AS GRUPO_PRIORIZA,  "
		cQryDados += "                  USR.USR_MSBLQL, USR.USR_DEPTO, USR.USR_CARGO,  "
		cQryDados += "                 LPAD (USR_MODULE.USR_MODULO, 2, '0') AS USR_MODULO,  "
		cQryDados += "                 USR_MODULE.USR_CODMOD,  "
		cQryDados += "                  USR.USR_GRPRULE AS USR_REGRA,  "
		cQryDados += "                  USR.USR_NIVELREAD AS USR_NVLCMP,  "
		cQryDados += "                  USR.USR_ALLEMP AS USR_ALLEMP,  "
		cQryDados += "                  USR_MODULE.USR_ARQMENU                  AS ARQ_MENU_USR,  "
		cQryDados += "                  CASE  "
		cQryDados += "                      WHEN USR.USR_ALLEMP = '1'  "
		cQryDados += "                      THEN  "
		cQryDados += "                          'TODAS EMPRESAS'  "
		cQryDados += "                      ELSE  "
		cQryDados += " 	               (	SELECT NVL ( LISTAGG (RTRIM (USRFILIAL.USR_FILIAL), ','),' ')  "
		cQryDados += " 			FROM  "
		cQryDados += " 	TOTVS.SYS_USR_FILIAL USRFILIAL  "
		cQryDados += " 			WHERE  "
		cQryDados += " 	USRFILIAL.D_E_L_E_T_ = ' '  "
		cQryDados += " 	AND USRFILIAL.USR_ACESSO = 'T'  "
		cQryDados += " 	AND USRFILIAL.USR_ID = USR.USR_ID)  "
		cQryDados += "                       END                                     AS USR_FILIAL,  "
		cQryDados += "  	 (SELECT LISTAGG (ACESSO, ',')  "
		cQryDados += "    FROM (SELECT LPAD (GRACESSOS1.USR_CODACESSO, 3, '0')     AS ACESSO  "
		cQryDados += "            FROM TOTVS.SYS_USR_ACCESS GRACESSOS1  "
		cQryDados += "           WHERE     GRACESSOS1.D_E_L_E_T_ = ' '  "
		cQryDados += "                 AND GRACESSOS1.USR_ID = USR.USR_ID  "
		cQryDados += "                 AND GRACESSOS1.USR_ACESSO = 'T')) AS USR_ACESSO  "
		cQryDados += "    FROM TOTVS.SYS_USR USR  "
		cQryDados += "         LEFT JOIN TOTVS.SYS_USR_MODULE USR_MODULE  "
		cQryDados += "               ON     USR_MODULE.D_E_L_E_T_ = USR.D_E_L_E_T_  "
		cQryDados += "                AND USR_MODULE.USR_ID = USR.USR_ID  "
		cQryDados += "                AND USR_MODULE.USR_ACESSO = 'T'  "
		cQryDados += "         LEFT JOIN TOTVS.SYS_USR_GROUPS USR_GROUPS  "
		cQryDados += "             	ON     USR_GROUPS.D_E_L_E_T_ = USR.D_E_L_E_T_  "
		cQryDados += "               AND USR_GROUPS.USR_ID = USR.USR_ID  "
		cQryDados += " 	LEFT JOIN TOTVS.SYS_GRP_GROUP GRP_GROUP ON  "
		cQryDados += " 	GRP_GROUP.D_E_L_E_T_ = USR.D_E_L_E_T_  "
		cQryDados += " 	AND GRP_GROUP.GR__MSBLQL = '2'  "
		cQryDados += " 	AND GRP_GROUP.GR__ID IN NVL((SELECT USR_GRUPO  "
		cQryDados += " 	 FROM TOTVS.SYS_USR_GROUPS   "
		cQryDados += " 	WHERE D_E_L_E_T_ = ' '  "
		cQryDados += " 	AND USR_ID = USR.USR_ID AND USR_PRIORIZA = '1'), ' ')  "
		cQryDados += " 	LEFT JOIN TOTVS.SYS_GRP_MODULE GRP_MODULE ON  "
		cQryDados += " 	USR.D_E_L_E_T_ = GRP_MODULE.D_E_L_E_T_  "
		cQryDados += " 	AND GRP_MODULE.GR__ACESSO = 'T'  "
		cQryDados += " 	AND GRP_MODULE.GR__ID = NVL((SELECT SURGEH.USR_GRUPO  "
		cQryDados += " 	FROM TOTVS.SYS_USR_GROUPS SURGEH  "
		cQryDados += "   WHERE SURGEH.D_E_L_E_T_ = ' '  "
		cQryDados += "   AND SURGEH.USR_ID = USR.USR_ID AND SURGEH.USR_PRIORIZA = '1'), ' ')	 "
		cQryDados += "   WHERE  USR.USR_ID  = '" + _cUser + "' "
		cQryDados += "   AND USR.D_E_L_E_T_ = ' '  "
		cQryDados += "  UNION  "
		cQryDados += "   SELECT DISTINCT USR.USR_ID,  "
		cQryDados += "                  (SELECT NVL (LISTAGG (SURGD.USR_GRUPO, ',')  "
		cQryDados += "                      WITHIN GROUP (ORDER BY SURGD.R_E_C_N_O_),' ')  "
		cQryDados += "         FROM TOTVS.SYS_USR_GROUPS SURGD  "
		cQryDados += "        WHERE     SURGD.D_E_L_E_T_ = ' '  "
		cQryDados += "              AND SURGD.USR_ID = USR.USR_ID)    AS GRUPO_USUARIO ,  "
		cQryDados += "              NVL((SELECT SURGE.USR_GRUPO  "
		cQryDados += "      FROM TOTVS.SYS_USR_GROUPS SURGE  "
		cQryDados += "  WHERE SURGE.D_E_L_E_T_ = ' '  "
		cQryDados += " 	AND SURGE.USR_ID = USR.USR_ID AND SURGE.USR_PRIORIZA = '1'), ' ') AS GRUPO_PRIORIZA,  "
		cQryDados += "                  USR.USR_MSBLQL, USR.USR_DEPTO, USR.USR_CARGO,  "
		cQryDados += " 	 LPAD (GRP_MODULE.GR__MODULO,2,'0') AS USR_MODULO,  "
		cQryDados += " 	(	SELECT	USR_CODMOD  "
		cQryDados += " 	FROM  "
		cQryDados += " 	TOTVS.SYS_USR_MODULE  "
		cQryDados += " 	WHERE  "
		cQryDados += " 	D_E_L_E_T_ = ' '  "
		cQryDados += " 	AND USR_ID = USR.USR_ID  "
		cQryDados += " 	AND USR_MODULO = GRP_MODULE.GR__MODULO) AS USR_CODMOD,  "
		cQryDados += " 	' ' AS USR_REGRA, "
		cQryDados += " 	GRP_MODULE.GR__NIVEL AS USR_NVLCMP,  "
		cQryDados += " 	GRP_GROUP.GR__ALLEMP AS USR_ALLEMP, "
		cQryDados += " 	GRP_MODULE.GR__ARQMENU AS ARQ_MENU_USR,  "
		cQryDados += " 		CASE  "
		cQryDados += " 		WHEN GRP_GROUP.GR__ALLEMP = '1'  "
		cQryDados += "       THEN  'TODAS EMPRESAS '  "
		cQryDados += " 		ELSE  "
		cQryDados += " 	        (	SELECT NVL ( LISTAGG (RTRIM (GRP_FILIAL.GR__FILIAL),  "
		cQryDados += "                                               ','),  "
		cQryDados += "                                      ' ')  "
		cQryDados += "                             FROM TOTVS.SYS_GRP_FILIAL GRP_FILIAL  "
		cQryDados += "                            WHERE GRP_FILIAL.D_E_L_E_T_ = ' ' AND GRP_FILIAL.GR__ACESSO = 'T'  "
		cQryDados += "                                  AND GRP_FILIAL.GR__ID IN (NVL((SELECT USR_GRUPO  "
		cQryDados += "  						       FROM TOTVS.SYS_USR_GROUPS   "
		cQryDados += "   					    WHERE D_E_L_E_T_ = ' '  "
		cQryDados += "   					    AND USR_ID = USR.USR_ID AND ROWNUM = 1), ' ')))  "
		cQryDados += " 		END AS USR_FILIAL,  "
		cQryDados += "  	 (SELECT LISTAGG (ACESSO, ',')  "
		cQryDados += "    FROM (SELECT LPAD (GRACESSOS1.GR__CODACESSO, 3, '0')     AS ACESSO  "
		cQryDados += "            FROM TOTVS.SYS_GRP_ACCESS GRACESSOS1  "
		cQryDados += "           WHERE     GRACESSOS1.D_E_L_E_T_ = ' '  "
		cQryDados += "                 AND GRACESSOS1.GR__ID IN (SELECT USR_GRUPO FROM TOTVS.SYS_USR_GROUPS  "
		cQryDados += "                 WHERE D_E_L_E_T_ = ' ' AND USR_ID = USR.USR_ID  "
		cQryDados += "                 AND GRACESSOS1.GR__ACESSO = 'T'))) AS USR_ACESSO  "
		cQryDados += "    FROM TOTVS.SYS_USR USR  "
		cQryDados += "         LEFT JOIN TOTVS.SYS_USR_MODULE USR_MODULE  "
		cQryDados += "               ON     USR_MODULE.D_E_L_E_T_ = USR.D_E_L_E_T_  "
		cQryDados += "                AND USR_MODULE.USR_ID = USR.USR_ID  "
		cQryDados += "                AND USR_MODULE.USR_ACESSO = 'T'  "
		cQryDados += "         LEFT JOIN TOTVS.SYS_USR_GROUPS USR_GROUPS  "
		cQryDados += "             	ON     USR_GROUPS.D_E_L_E_T_ = USR.D_E_L_E_T_  "
		cQryDados += "               AND USR_GROUPS.USR_ID = USR.USR_ID  "
		cQryDados += " 	LEFT JOIN TOTVS.SYS_GRP_GROUP GRP_GROUP ON  "
		cQryDados += " 	GRP_GROUP.D_E_L_E_T_ = USR.D_E_L_E_T_  "
		cQryDados += " 	AND GRP_GROUP.GR__MSBLQL = '2'  "
		cQryDados += " 	AND GRP_GROUP.GR__ID IN NVL((SELECT USR_GRUPO  "
		cQryDados += " 	 FROM TOTVS.SYS_USR_GROUPS   "
		cQryDados += " 	WHERE D_E_L_E_T_ = ' '  "
		cQryDados += " 	AND USR_ID = USR.USR_ID AND USR_PRIORIZA = '1'), ' ')  "
		cQryDados += "   LEFT JOIN TOTVS.SYS_GRP_FILIAL GRP_FILIAL ON  "
		cQryDados += "   GRP_FILIAL.D_E_L_E_T_ = USR.D_E_L_E_T_ AND GRP_FILIAL.GR__ID IN (NVL((SELECT USR_GRUPO  "
		cQryDados += " 	FROM TOTVS.SYS_USR_GROUPS  "
		cQryDados += "   WHERE D_E_L_E_T_ = ' '  "
		cQryDados += "   AND USR_ID = USR.USR_ID AND ROWNUM  = 1), ' '))  "
		cQryDados += " 	LEFT JOIN TOTVS.SYS_GRP_MODULE GRP_MODULE ON  "
		cQryDados += " 	USR.D_E_L_E_T_ = GRP_MODULE.D_E_L_E_T_  "
		cQryDados += " 	AND GRP_MODULE.GR__ACESSO = 'T'  "
		cQryDados += " 	AND GRP_MODULE.GR__ID = NVL((SELECT SURGEH.USR_GRUPO  "
		cQryDados += " 	FROM TOTVS.SYS_USR_GROUPS SURGEH  "
		cQryDados += "   WHERE SURGEH.D_E_L_E_T_ = ' '  "
		cQryDados += "   AND SURGEH.USR_ID = USR.USR_ID AND ROWNUM = 1), ' ')	 "
		cQryDados += "   WHERE  USR.USR_ID  = '" + _cUser + "' "
		cQryDados += "   AND USR.D_E_L_E_T_ = ' '  "


	Endif

	// cQryDados += "	LEFT JOIN TOTVS.SYS_GRP_MODULE GRP_MODULE ON " 													+ CRLF
	// cQryDados += "	USR.D_E_L_E_T_ = GRP_MODULE.D_E_L_E_T_ " 														+ CRLF
	// cQryDados += "	AND GRP_MODULE.GR__ACESSO = 'T' " 																+ CRLF
	// cQryDados += "	AND GRP_MODULE.GR__ID = NVL((SELECT SURGEH.USR_GRUPO " 											+ CRLF
	// cQryDados += "	FROM TOTVS.SYS_USR_GROUPS SURGEH " 																+ CRLF
	// cQryDados += "  WHERE SURGEH.D_E_L_E_T_ = ' ' " 																+ CRLF
	// cQryDados += "  AND SURGEH.USR_ID = USR.USR_ID AND SURGEH.USR_PRIORIZA = '1'), ' ')	" 							+ CRLF
	// cQryDados += "  WHERE  USR.USR_ID  = '" + _cUser + "' " 														+ CRLF
	// cQryDados += "  AND USR.D_E_L_E_T_ = ' ' " 																		+ CRLF
	// cQryDados += "  ORDER BY USR.USR_ID, USR_MODULO " 																+ CRLF


	PlsQuery(cQryDados, "QRY_DADOS")
	DbSelectArea("QRY_DADOS")
	Count To nTotal
	QRY_DADOS->(DbGoTop())

	WHILE !QRY_DADOS->(EOF())

		cGrupoUsr := AllTrim(QRY_DADOS->GRUPO_USUARIO)
		cGrupoPri := AllTrim(QRY_DADOS->GRUPO_PRIORIZA)
		cModulos  := AllTrim(QRY_DADOS->USR_MODULO) + '-' + AllTrim(QRY_DADOS->USR_CODMOD)
		cAllEmp   := AllTrim(QRY_DADOS->USR_FILIAL)
		cFiliais  := AllTrim(QRY_DADOS->USR_FILIAL)
		cAcessos  := AllTrim(QRY_DADOS->USR_ACESSO)
		cMenus    := AllTrim(QRY_DADOS->ARQ_MENU_USR)

		WHILE !QRY_DADOS->(EOF()) .AND. cGrupoUsr == AllTrim(QRY_DADOS->GRUPO_USUARIO)
			AADD(aRet,{_cUser,;
				cUsrCod,;
				cUsrNome,;
				cSituacao,;
				cDepto,;
				cCargo,;
				AllTrim(QRY_DADOS->USR_NVLCMP),;
				cRegra,;
				cGrupoUsr,;
				cGrupoPri,;
				AllTrim(QRY_DADOS->USR_MODULO) + '-' + AllTrim(QRY_DADOS->USR_CODMOD),;
				AllTrim(QRY_DADOS->USR_FILIAL),;
				AllTrim(QRY_DADOS->USR_ALLEMP),;
				AllTrim(QRY_DADOS->USR_ACESSO),;
				AllTrim(QRY_DADOS->ARQ_MENU_USR),;
				})

			QRY_DADOS->(DbSkip())
		ENDDO

		LOOP
	ENDDO


Return aRet



user function  fQueryGrp(cUsrId,cUsrRegra)

	Local cQryGrp  := ""

	cQryGrp += " SELECT RTRIM (MENU.M_NAME)                  AS M_NAME, " 	 + CRLF
	cQryGrp += "       MENU.M_ID, " 											 + CRLF
	cQryGrp += "       MENU_ITEM.I_ID_MENU, " 								 + CRLF
	cQryGrp += "       MENU_ITEM.I_ID, " 										 + CRLF
	cQryGrp += "       MENU_ITEM.I_FATHER, " 									 + CRLF
	cQryGrp += "       MENU_ITEM.I_ID_FUNC, " 								 + CRLF
	cQryGrp += "       RTRIM (MENU_I18N.N_DESC)             AS N_DESC, " 		 + CRLF
	cQryGrp += "       RTRIM (MENU_FUNCTION.F_FUNCTION)     F_FUNCTION, " 	 + CRLF
	cQryGrp += "       MENU_I18N.N_PAREN_TP, " 								 + CRLF
	cQryGrp += "       MENU_I18N.N_DEFAULT, " 								 + CRLF
	cQryGrp += "       MENU_ITEM.I_TP_MENU, " 								 + CRLF
	cQryGrp += "       MENU_ITEM.I_STATUS, " 									 + CRLF
	cQryGrp += "       MENU_ITEM.I_TYPE " 									 + CRLF
	cQryGrp += "  FROM TOTVS.MPMENU_MENU  MENU " 								 + CRLF
	cQryGrp += "       LEFT JOIN TOTVS.MPMENU_ITEM MENU_ITEM " 				 + CRLF
	cQryGrp += "           ON     MENU_ITEM.D_E_L_E_T_ = MENU.D_E_L_E_T_ " 	 + CRLF
	cQryGrp += "              AND MENU.M_ID = MENU_ITEM.I_ID_MENU " 			 + CRLF
	cQryGrp += "       LEFT JOIN TOTVS.MPMENU_I18N MENU_I18N " 				 + CRLF
	cQryGrp += "           ON     MENU_I18N.D_E_L_E_T_ = MENU.D_E_L_E_T_ " 	 + CRLF
	cQryGrp += "              AND MENU_I18N.N_PAREN_ID = MENU_ITEM.I_ID " 	 + CRLF
	cQryGrp += "              AND MENU_I18N.N_LANG = '1' " 					 + CRLF
	cQryGrp += "       LEFT JOIN TOTVS.MPMENU_FUNCTION MENU_FUNCTION " 		 + CRLF
	cQryGrp += "           ON     MENU_FUNCTION.D_E_L_E_T_ = MENU.D_E_L_E_T_ " + CRLF
	cQryGrp += "              AND MENU_FUNCTION.F_ID = MENU_ITEM.I_ID_FUNC " 	 + CRLF
	cQryGrp += " WHERE   MENU.M_NAME = 'TRVFIN_FIN' AND MENU.D_E_L_E_T_ = ' ' "+ CRLF
	cQryGrp += "       AND MENU_I18N.N_PAREN_TP = '2' " 						 + CRLF
	cQryGrp += "      AND MENU_ITEM.I_TP_MENU = '1' " 						 + CRLF
	cQryGrp += "       AND MENU_ITEM.I_STATUS = '1' " 	                     + CRLF
	cQryGrp += "      -- AND MENU_ITEM.I_TYPE	 = '1' "						 + CRLF


Return cQryGrp




