#Include 'totvs.ch'
#Include 'parmtype.ch'

User Function CNTA300P()

Local aParam     := PARAMIXB
Local xRet       := .T.
Local oObj       := ''
Local cIdPonto   := ''
Local cIdModel   := ''
Local lIsGrid    := .F.
Local cClasse := ""m
Local nLinha     := 0
Local nQtdLinhas := 0
Local cMsg       := ''

If aParam <> NIL
         
       oObj       := aParam[1]
       cIdPonto   := aParam[2]
       cIdModel   := aParam[3]
       lIsGrid    := ( Len( aParam ) > 3 )

       If     cIdPonto == 'MODELPOS'

             cMsg := 'Chamada na valida��o total do modelo (MODELPOS).' + CRLF
             cMsg += 'ID ' + cIdModel + CRLF            

             If !( xRet := ApMsgYesNo( cMsg + 'Continua ?' ) )
                    Help( ,, 'Help',, 'O MODELPOS retornou .F.', 1, 0 )
             EndIf

            

       ElseIf cIdPonto == 'FORMPOS'

             cMsg := 'Chamada na valida��o total do formul�rio (FORMPOS).' + CRLF
             cMsg += 'ID ' + cIdModel + CRLF            

             If      cClasse == 'FWFORMGRID'
                    cMsg += '� um FORMGRID com ' + Alltrim( Str( nQtdLinhas ) ) + ;
'     linha(s).' + CRLF
cMsg += 'Posicionado na linha ' + Alltrim( Str( nLinha     ) ) + CRLF

             ElseIf cClasse == 'FWFORMFIELD'
                    cMsg += '� um FORMFIELD' + CRLF
             EndIf
         
             If !( xRet := ApMsgYesNo( cMsg + 'Continua ?' ) )
                    Help( ,, 'Help',, 'O FORMPOS retornou .F.', 1, 0 )
             EndIf       

       ElseIf cIdPonto == 'FORMLINEPRE'

             If aParam[5] == 'DELETE'
cMsg := 'Chamada na pre valida��o da linha do formul�rio (FORMLINEPRE).' + CRLF
                    cMsg += 'Onde esta se tentando deletar uma linha' + CRLF
                    cMsg += '� um FORMGRID com ' + Alltrim( Str( nQtdLinhas ) ) +;
' linha(s).' + CRLF
cMsg += 'Posicionado na linha ' + Alltrim( Str( nLinha     ) ) + CRLF
                    cMsg += 'ID ' + cIdModel + CRLF
                 
                    If !( xRet := ApMsgYesNo( cMsg + 'Continua ?' ) )
                           Help( ,, 'Help',, 'O FORMLINEPRE retornou .F.', 1, 0 )
                    EndIf
             EndIf
          
       ElseIf cIdPonto == 'FORMLINEPOS'

cMsg := 'Chamada na valida��o da linha do formul�rio (FORMLINEPOS).' + CRLF
             cMsg += 'ID ' + cIdModel + CRLF
             cMsg += '� um FORMGRID com ' + Alltrim( Str( nQtdLinhas ) ) + ;
' linha(s).' + CRLF
             cMsg += 'Posicionado na linha ' + Alltrim( Str( nLinha     ) ) + CRLF            

             If !( xRet := ApMsgYesNo( cMsg + 'Continua ?' ) )
                    Help( ,, 'Help',, 'O FORMLINEPOS retornou .F.', 1, 0 )
             EndIf
          
       ElseIf cIdPonto == 'MODELCOMMITTTS'
ApMsgInfo('Chamada apos a grava��o total do modelo e dentro da transa��o (MODELCOMMITTTS).' + CRLF + 'ID ' + cIdModel )
       
       ElseIf cIdPonto == 'MODELCOMMITNTTS'
ApMsgInfo('Chamada apos a grava��o total do modelo e fora da transa��o (MODELCOMMITNTTS).' + CRLF + 'ID ' + cIdModel)
     
             //ElseIf cIdPonto == 'FORMCOMMITTTSPRE'         

       ElseIf cIdPonto == 'FORMCOMMITTTSPOS'

ApMsgInfo('Chamada apos a grava��o da tabela do formul�rio (FORMCOMMITTTSPOS).' + CRLF + 'ID ' + cIdModel)
         
       ElseIf cIdPonto == 'MODELCANCEL'

cMsg := 'Chamada no Bot�o Cancelar (MODELCANCEL).' + CRLF + 'Deseja Realmente Sair ?'
         
             If !( xRet := ApMsgYesNo( cMsg ) )
                    Help( ,, 'Help',, 'O MODELCANCEL retornou .F.', 1, 0 )
             EndIf
          
       ElseIf cIdPonto == 'BUTTONBAR'

ApMsgInfo('Adicionando Botao na Barra de Botoes (BUTTONBAR).' + CRLF + 'ID ' + cIdModel )

xRet := { {'Salvar', 'SALVAR', { || Alert( 'Salvou' ) }, 'Este botao Salva' } }
           
       EndIf

EndIf

Return xRet
