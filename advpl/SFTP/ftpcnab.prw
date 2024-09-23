#include 'totvs.ch'
#include 'tbiconn.ch'
#include 'protheus.ch'



user function  FtpCnab()

	local cArq          := ""
	local cEndereco     := ""
	local cUsr          := ""
	local cPass         := ""
//	local lReturn       := .T.
	local nPorta        := 0
//	local cAliasZ81     := GetNextAlias()
	local cError        := ""
//	local cIDLog        := ""
//	local nQtdReg       := ""
//	local cMsg          := ""
//	local cLock			:= ""
	//local cMsgFull      := ""
	//Default aConnection :={'99', '01'}



		PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01'



	cEndereco         :=  getNewPar("MV_XENDFTP", "importacao.cobmais.com.br")
	nPorta            :=  getNewPar("MV_XPORFTP", 22)
	cUsr              :=  getNewPar("MV_XUSRFTP", "assessoria831")
	cPass             :=  getNewPar("MV_XPSSFTP", "Cobmais@FTP@3*0-r*32h9qn")
//	cPass             :=  getNewPar("MV_XPSSFTP", "Cobmais")


	cArq 	  := "\cprova\TESTE.RET"
	cDirFtp   := "/SANTANDER/TESTE.RET"
	cError    := ""
	nStatus   := SFTPUpld1(cArq, cDirFtp, cEndereco , cUsr , cPass, @cError )

	if 	nStatus == 0

		conout("SFTP enviado com sucesso!!")

	else
		conout("Falha no envio SFTP!")
	Endif


	If Select("SX6") > 0
		RPCClearEnv()
	endIf

return
