#include 'totvs.ch'



User Function MYCRMA980() ///cXXX1,cXXX2,cXXX3,cXXX4,cXXX5,cXXX6
    Local aParam        := PARAMIXB
    Local xRet          := .T.
    Local lIsGrid       := .F.
//  Local nLinha        := 0
//  Local nQtdLinhas    := 0
//  Local cRotMVC       := "CRMA980"
    Local cIDPonto      := ''
    Local cIDModel      := ''
//  Local cIDForm       := ''
//  Local cEvento       := ''
//  Local cCampo        := ''
//  Local cConteudo     := ''
//  Local cMsg          := ''
    Local oObj          := NIL
    Local cCodigo       := ""
    Local cLoja         := ""


    

    If aParam <> NIL
        oObj        := aParam[1]
        cIDPonto    := aParam[2]
        cIDModel    := aParam[3]
        lIsGrid     := (Len(aParam) > 3)
        nOperation := oObj:GetOperation()

        If cIDPonto == 'MODELCOMMITTTS'
            // Mostra o tipo de Operacao
            //MsgAlert("Operacao " + CValToChar(nOperation), "Tipo de operacao MODELCOMMITTTS")
            // Inclusao

            If nOperation == 3
               
                FWAlertSuccess('Deu certo',"upadupa!")

            EndIf

            // // Alteracao
            // If nOperation == 4
            //     MsgAlert("Entrou no PE - Operacao de Alteracao", "Tipo de operacao 4 MODELCOMMITTTS")
            // EndIf

            // // Exclusao
            // If nOperation == 5
            //     MsgAlert("Entrou no PE - Operacao de Exclusao", "Tipo de operacao 5 MODELCOMMITTTS")
            // EndIf
        EndIf
    EndIf
Return xRet
