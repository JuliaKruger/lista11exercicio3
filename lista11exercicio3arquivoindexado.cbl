      $set sourceformat"free"
      *>----Divisão de identificação do programa
       Identification Division.
       Program-id. "lista11exercicio3arquivoindexado".
       Author. "Julia Krüger".
       Installation. "PC".
       Date-written. 27/07/2020.
       Date-compiled. 27/07/2020.

      *>----Divisão para configuração do ambiente
       Environment Division.
       Configuration Section.
           special-names. decimal-point is comma.

      *>----Declaração dos recursos externos
       Input-output Section.
       File-control.
           select arqAlunos assign to "arqAlunos.txt"
           organization is indexed
           access mode is dynamic
           lock mode is automatic
           record key is fd-cod
           file status is ws-fs-arqAlunos.

       I-O-Control.


      *>----Declaração de variáveis
       Data Division.

      *>----Variáveis de arquivos
       File Section.
       fd arqAlunos.
       01 fd-cadastro.
           05 fd-cod                               pic 9(03).
           05 fd-nome                              pic x(40) value zero.
           05 fd-endereco                          pic x(40).
           05 fd-nome_mae                          pic x(40).
           05 fd-nome_pai                          pic x(40).
           05 fd-telefone                          pic x(13).
           05 fd-notas.
               10 fd-nota_1                        pic 9(02)v99.
               10 fd-nota_2                        pic 9(02)v99.
               10 fd-nota_3                        pic 9(02)v99.
               10 fd-nota_4                        pic 9(02)v99.

      *>----Variáveis de trabalho
       Working-storage Section.

      *> variável de file status
       77 ws-fs-arqAlunos                          pic 9(02).

      *> variáveis de cadastro e notas
       01 ws-cadastro.
           05 ws-cod                               pic 9(03) value zero.
           05 ws-nome                              pic x(40).
           05 ws-endereco                          pic x(40).
           05 ws-nome_mae                          pic x(40).
           05 ws-nome_pai                          pic x(40).
           05 ws-telefone                          pic x(13).
           05 ws-notas.
               10 ws-nota_1                        pic 9(02)v99.
               10 ws-nota_2                        pic 9(02)v99.
               10 ws-nota_3                        pic 9(02)v99.
               10 ws-nota_4                        pic 9(02)v99.

      *> notas auxiliares para poder testar antes de jogar nas notas
       01 ws-notas-aux.
           05 ws-nota_1_aux                        pic 9(02)v99.
           05 ws-nota_2_aux                        pic 9(02)v99.
           05 ws-nota_3_aux                        pic 9(02)v99.
           05 ws-nota_4_aux                        pic 9(02)v99.

      *> variáveis do menu
       77 ws-cadastro-aluno                        pic x(01).
       77 ws-cadastro-nota                         pic x(01).
       77 ws-consulta-indexada                     pic x(01).
       77 ws-consulta-sequencial                   pic x(01).
       77 ws-alterar                               pic x(01).
       77 ws-deletar                               pic x(01).

      *> variáveis para sair das telas
       77 ws-sair-menu                             pic x(01).
       77 ws-sair-cad-alunos                       pic x(01).
       77 ws-sair-cad-notas                        pic x(01).
       77 ws-sair-consulta-indexada                pic x(01).
       77 ws-sair-consulta-sequencial              pic x(01).
       77 ws-sair-alterar                          pic x(01).
       77 ws-sair-deletar                          pic x(01).
       77 ws-sequencial-proximo                    pic x(01).
       77 ws-sair-consulta-cod                     pic x(01).

      *> variáveis de erro de file status
       01 ws-msn-erro.
           05 ws-msn-erro-ofsset                   pic 9(04).
           05 filler                               pic x(01) value "-".
           05 ws-msn-erro-cod                      pic 9(02).
           05 filler                               pic x(01) value space.
           05 ws-msn-erro-text                     pic x(42).

      *> variáveis auxiliares
       77 ws-msn                                   pic x(30).
       77 ws-aux                                   pic x(01).

      *>----Variáveis para comunicação entre programas
       Linkage Section.

      *>----Declaração de tela
       screen section.
      *>                                0    1    1    2    2    3    3    4    4    5    5    6    6    7    7    8
      *>                                5    0    5    0    5    0    5    0    5    0    5    0    5    0    5    0
      *>                            ----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+
      *> tela principal/menu
       01 tela.
           05 blank screen.
           05 line 01 col 05 value "                ---- Sistema de Cadastro de Alunos ----                        "
           foreground-color 11.
           05 line 03 col 01 value "     MENU                                                                      "
            foreground-color 11.
           05 line 04 col 01 value "      [ ]Cadastro Aluno                                                        ".
           05 line 05 col 01 value "      [ ]Cadastro Notas                                                        ".
           05 line 06 col 01 value "      [ ]Consulta Indexada                                                     ".
           05 line 07 col 01 value "      [ ]Consulta Sequencial                                                   ".
           05 line 08 col 01 value "      [ ]Alterar Cadastro                                                      ".
           05 line 09 col 01 value "      [ ]Deletar Cadastro                                                      ".
           05 line 10 col 01 value "                                                                        [ ]Sair".

      *> variáveis da tela principal/menu
           05 sc-cadastro-aluno            line 04 col 08 pic x(01)
           using ws-cadastro-aluno foreground-color 12.
           05 sc-cadastro-nota             line 05 col 08 pic x(01)
           using ws-cadastro-nota foreground-color 12.
           05 sc-consulta-indexada         line 06 col 08 pic x(01)
           using ws-consulta-indexada foreground-color 12.
           05 sc-consulta-sequencial       line 07 col 08 pic x(01)
           using ws-consulta-sequencial foreground-color 12.
           05 sc-alterar                   line 08 col 08 pic x(01)
           using ws-alterar foreground-color 12.
           05 sc-deletar                   line 09 col 08 pic x(01)
           using ws-deletar foreground-color 12.
           05 sc-sair                      line 10 col 74 pic x(01)
           using ws-sair-menu foreground-color 12.

      *> tela de cadastro de alunos
       01 tela-cadastro-aluno.
           05 blank screen.
           05 line 01 col 01 value "                     ---- Cadastro de Alunos ----                              "
           foreground-color 11.
           05 line 03 col 01 value "      Numero de cadastro do aluno:                                             ".
           05 line 04 col 01 value "      Nome do aluno:                                                           ".
           05 line 05 col 01 value "      Endereco do aluno:                                                       ".
           05 line 06 col 01 value "      Nome da mae do aluno:                                                    ".
           05 line 07 col 01 value "      Nome do pai do aluno:                                                    ".
           05 line 08 col 01 value "      Telefone dos pais:                                                       ".
           05 line 10 col 01 value "                                                                        [ ]Sair".

      *> variáveis da tela de cadastro de alunos
           05 sc-cod-aluno                   line 03  col 37 pic 9(03)
           from ws-cod foreground-color 14.
           05 sc-nome-aluno                line 04 col 21 pic x(50)
           using ws-nome foreground-color 14.
           05 sc-endereco-aluno            line 05 col 26 pic x(50)
           using ws-endereco foreground-color 14.
           05 sc-mae-aluno                 line 06 col 29 pic x(50)
           using ws-nome_mae foreground-color 14.
           05 sc-pai-aluno                 line 07 col 29 pic x(50)
           using ws-nome_pai foreground-color 14.
           05 sc-telefone-pais             line 08 col 26 pic x(13)
           using ws-telefone foreground-color 14.
           05 sc-sair-cad-aluno            line 10 col 74 pic x(01)
           using ws-sair-cad-alunos foreground-color 12.


      *>                                0    1    1    2    2    3    3    4    4    5    5    6    6    7    7    8
      *>                                5    0    5    0    5    0    5    0    5    0    5    0    5    0    5    0
      *>                            ----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+
      *> tela de cadastro de notas de alunos
       01  tela-cadastro-notas.
           05 blank screen.
           05 line 01 col 01 value "                                Cadastro de Notas                               "
           foreground-color 11.
           05 line 03 col 01 value "       Numero de cadastro do aluno:                                             ".
           05 line 04 col 01 value "       Nota 1:                                                                  ".
           05 line 05 col 01 value "       Nota 2:                                                                  ".
           05 line 06 col 01 value "       Nota 3:                                                                  ".
           05 line 07 col 01 value "       Nota 4:                                                                  ".
           05 line 10 col 01 value "                                                                         [ ]Sair".

      *> variáveis da tela de cadastro de notas de alunos
           05 sc-cod-aluno                   line 03  col 37 pic 9(03)
           using ws-cod foreground-color 14.
           05 sc-nota-1                      line 04  col 16 pic 9(02)v99
           using ws-nota_1_aux foreground-color 14.
           05 sc-nota-2                      line 05  col 16 pic 9(02)v99
           using ws-nota_2_aux foreground-color 14.
           05 sc-nota-3                      line 06  col 16 pic 9(02)v99
           using ws-nota_3_aux foreground-color 14.
           05 sc-nota-4                      line 07  col 16 pic 9(02)v99
           using ws-nota_4_aux foreground-color 14.
           05 sc-msn-cad-not                 line 09  col 08 pic x(50)
           from ws-msn foreground-color 15.
           05 sc-sair-cad-notas              line 10  col 75 pic x(01)
           using ws-sair-cad-notas foreground-color 12.

      *> tela para consultar o código do aluno para as consultas de cadastros
       01 tela-consulta-cadastro-cod.
           05 blank screen.
           05 line 01 col 05 value "                     ---- Consulta de Cadastro ----                            "
           foreground-color 11.
           05 line 03 col 01 value "      Numero de cadastro do aluno:                                             ".


      *> variável da tela de consulta de código
           05 sc-cod-aluno-consulta       line 03  col 36 pic 9(03)
           using ws-cod foreground-color 14.

      *> tela para consulta de forma indexada
       01 tela-consulta-indexada.
           05 blank screen.
           05 line 01 col 01 value "                ---- Consulta de Cadastro Indexada ----                        "
           foreground-color 11.
           05 line 03 col 01 value "      Numero de cadastro do aluno:                                             ".
           05 line 04 col 01 value "      Nome do aluno:                                                           ".
           05 line 05 col 01 value "      Endereco do aluno:                                                       ".
           05 line 06 col 01 value "      Nome da mae do aluno:                                                    ".
           05 line 07 col 01 value "      Nome do pai do aluno:                                                    ".
           05 line 08 col 01 value "      Telefone dos pais:                                                       ".
           05 line 10 col 01 value "      Notas do aluno:                                                          ".
           05 line 11 col 01 value "       Nota 1:                                                                 ".
           05 line 12 col 01 value "       Nota 2:                                                                 ".
           05 line 13 col 01 value "       Nota 3:                                                                 ".
           05 line 14 col 01 value "       Nota 4:                                                                 ".
           05 line 15 col 01 value "                                                                        [ ]Sair".

      *> variáveis da tela de consulta indexada
           05 sc-cod-aluno-consulta       line 03  col 36 pic 9(03)
           from ws-cod foreground-color 14.
           05 sc-mostrar-nome-aluno       line 04  col 22 pic x(40)
           from ws-nome foreground-color 14.
           05 sc-mostrar-endereco         line 05  col 26 pic x(40)
           from ws-endereco foreground-color 14.
           05 sc-mostrar-nome-mae         line 06  col 29 pic x(40)
           from ws-nome_mae foreground-color 14.
           05 sc-mostrar-nome-pai         line 07  col 29 pic x(40)
           from ws-nome_pai foreground-color 14.
           05 sc-mostrar-telefone         line 08  col 26 pic x(13)
           from ws-telefone foreground-color 14.
           05 sc-mostrar-nota-1           line 11  col 16 pic 9(02)v99
           from ws-nota_1 foreground-color 14.
           05 sc-mostrar-nota-2           line 12  col 16 pic 9(02)v99
           from ws-nota_2 foreground-color 14.
           05 sc-mostrar-nota-3           line 13  col 16 pic 9(02)v99
           from ws-nota_3 foreground-color 14.
           05 sc-mostrar-nota-4           line 14  col 16 pic 9(02)v99
           from ws-nota_4 foreground-color 14.
           05 sc-sair-indexada            line 15  col 74 pic x(01)
           using ws-sair-consulta-indexada foreground-color 12.

      *> tela para consulta de forma sequencial
       01 tela-consulta-sequencial.
           05 blank screen.
           05 line 01 col 01 value "               ---- Consulta de Cadastro Sequencial ----                       "
           foreground-color 11.
           05 line 03 col 01 value "      Numero de cadastro do aluno:                                             ".
           05 line 04 col 01 value "      Nome do aluno:                                                           ".
           05 line 05 col 01 value "      Endereco do aluno:                                                       ".
           05 line 06 col 01 value "      Nome da mae do aluno:                                                    ".
           05 line 07 col 01 value "      Nome do pai do aluno:                                                    ".
           05 line 08 col 01 value "      Telefone dos pais:                                                       ".
           05 line 10 col 01 value "      Notas do aluno:                                                          ".
           05 line 11 col 01 value "       Nota 1:                                                                 ".
           05 line 12 col 01 value "       Nota 2:                                                                 ".
           05 line 13 col 01 value "       Nota 3:                                                                 ".
           05 line 14 col 01 value "       Nota 4:                                                                 ".
           05 line 15 col 01 value "                                                                     Proximo[ ]".
           05 line 16 col 01 value "                                                                        Sair[ ]".

      *> variáveis da tela de consulta sequencial
           05 sc-cod-aluno-consulta       line 03  col 36 pic 9(03)
           from ws-cod foreground-color 14.
           05 sc-mostrar-nome-aluno       line 04  col 22 pic x(40)
           from ws-nome foreground-color 14.
           05 sc-mostrar-endereco         line 05  col 26 pic x(40)
           from ws-endereco foreground-color 14.
           05 sc-mostrar-nome-mae         line 06  col 29 pic x(40)
           from ws-nome_mae foreground-color 14.
           05 sc-mostrar-nome-pai         line 07  col 29 pic x(40)
           from ws-nome_pai foreground-color 14.
           05 sc-mostrar-telefone         line 08  col 26 pic x(13)
           from ws-telefone foreground-color 14.
           05 sc-mostrar-nota-1           line 11  col 16 pic 9(02)v99
           from ws-nota_1 foreground-color 14.
           05 sc-mostrar-nota-2           line 12  col 16 pic 9(02)v99
           from ws-nota_2 foreground-color 14.
           05 sc-mostrar-nota-3           line 13  col 16 pic 9(02)v99
           from ws-nota_3 foreground-color 14.
           05 sc-mostrar-nota-4           line 14  col 16 pic 9(02)v99
           from ws-nota_4 foreground-color 14.
           05 sc-proximo                  line 15  col 78 pic x(01)
           using ws-sequencial-proximo foreground-color 12.
           05 sc-sair-sequencial             line 16  col 78 pic x(01)
           using ws-sair-consulta-sequencial foreground-color 12.

      *> tela para alterar cadastros
       01 tela-alterar.
           05 blank screen.
           05 line 01 col 01 value "                      ---- Alterar Cadastro ----                               "
           foreground-color 11.
           05 line 03 col 01 value "      Numero de cadastro do aluno:                                             ".
           05 line 04 col 01 value "      Nome do aluno:                                                           ".
           05 line 05 col 01 value "      Endereco do aluno:                                                       ".
           05 line 06 col 01 value "      Nome da mae do aluno:                                                    ".
           05 line 07 col 01 value "      Nome do pai do aluno:                                                    ".
           05 line 08 col 01 value "      Telefone dos pais:                                                       ".
           05 line 10 col 01 value "      Notas do aluno:                                                          ".
           05 line 11 col 01 value "       Nota 1:                                                                 ".
           05 line 12 col 01 value "       Nota 2:                                                                 ".
           05 line 13 col 01 value "       Nota 3:                                                                 ".
           05 line 14 col 01 value "       Nota 4:                                                                 ".
           05 line 16 col 01 value "                                                                        [ ]Sair".

      *> variáveis da tela de alteração de cadastros
           05 sc-cod-aluno-consulta       line 03  col 36 pic 9(03)
           from ws-cod foreground-color 14.
           05 sc-mostrar-nome-aluno       line 04  col 22 pic x(40)
           using ws-nome foreground-color 14.
           05 sc-mostrar-endereco         line 05  col 26 pic x(40)
           using ws-endereco foreground-color 14.
           05 sc-mostrar-nome-mae         line 06  col 29 pic x(40)
           using ws-nome_mae foreground-color 14.
           05 sc-mostrar-nome-pai         line 07  col 29 pic x(40)
           using ws-nome_pai foreground-color 14.
           05 sc-mostrar-telefone         line 08  col 26 pic x(13)
           using ws-telefone foreground-color 14.
           05 sc-mostrar-nota-1           line 11  col 16 pic 9(02)v99
           using ws-nota_1 foreground-color 14.
           05 sc-mostrar-nota-2           line 12  col 16 pic 9(02)v99
           using ws-nota_2 foreground-color 14.
           05 sc-mostrar-nota-3           line 13  col 16 pic 9(02)v99
           using ws-nota_3 foreground-color 14.
           05 sc-mostrar-nota-4           line 14  col 16 pic 9(02)v99
           using ws-nota_4 foreground-color 14.
           05 sc-msn-alterar              line 15  col 05 pic x(30)
           from ws-msn foreground-color 11.
           05 sc-sair-alterar             line 16  col 74 pic x(01)
           using ws-sair-alterar foreground-color 12.

      *> tela para alterar cadastros
       01 tela-alterar-sair.
           05 line 16 col 01 value "                                                                        [ ]Sair".

      *> variáveis da tela de alteração de cadastros
           05 sc-sair-alterar             line 16  col 74 pic x(01)
           using ws-sair-alterar foreground-color 12.

      *> tela para deletar cadastros
       01 tela-deletar.
           05 blank screen.
           05 line 01 col 05 value "                       ---- Deletar Cadastro ----                              "
           foreground-color 11.
           05 line 03 col 01 value "      Numero de cadastro do aluno a ser deletado:                              ".
           05 line 05 col 01 value "                                                                               ".
           05 line 06 col 01 value "                                                                        [ ]Sair".


      *> variáveis da tela de deletar cadastros
           05 sc-cod-aluno-consulta       line 03  col 51 pic 9(03)
           using ws-cod foreground-color 14.
           05 sc-msn-deletar              line 05 col 07 pic x(30)
           from ws-msn foreground-color 11.
           05 sc-sair-deletar             line 06 col 74 pic x(01)
           using ws-sair-deletar foreground-color 12.


      *>Declaração do corpo do programa
       Procedure Division.

           perform inicializa.
           perform processamento.
           perform finaliza.

      *>------------------------------------------------------------------------
      *> Section para abrir o arquivo
      *>------------------------------------------------------------------------
       inicializa section.
           move zero to ws-cod
           open i-o arqAlunos   *> open i-o abre o arquivo para leitura e escrita
           if ws-fs-arqAlunos  <> 00
           and ws-fs-arqAlunos <> 05 then
               move 1                                to ws-msn-erro-ofsset
               move ws-fs-arqAlunos                  to ws-msn-erro-cod
               move "Erro ao abrir arq. arqAlunos "  to ws-msn-erro-text
               perform finaliza-anormal
           end-if
           .
       inicializa-exit.
           exit.

      *>------------------------------------------------------------------------
      *> Processamento do programa
      *>------------------------------------------------------------------------
       processamento section.
      *> receber qual "operação" o usuáriovai querer fazer
           display erase
           perform until ws-sair-menu = "X" or ws-sair-menu = "x"
               move space to ws-cadastro-aluno
               move space to ws-cadastro-nota
               move space to ws-consulta-indexada
               move space to ws-consulta-sequencial
               move space to ws-alterar
               move space to ws-deletar
               move space to ws-sair-menu
               display tela
               accept tela

               if ws-cadastro-aluno = "X"
               or ws-cadastro-aluno = "x" then
                   perform cadastro-alunos
               end-if

               if ws-cadastro-nota = "X"
               or ws-cadastro-nota = "x" then
                   perform cadastro-notas
               end-if

               if ws-consulta-indexada = "X"
               or ws-consulta-indexada = "x" then
                   perform consulta-indexada
               end-if

               if ws-consulta-sequencial = "X"
               or ws-consulta-sequencial = "x" then
                   perform consulta-sequencial-next
               end-if

               if ws-alterar = "X"
               or ws-alterar = "x" then
                   perform alterar
               end-if

               if ws-deletar = "X"
               or ws-deletar = "x" then
                   perform deletar
               end-if

           end-perform
           .
       processamento-exit.
           exit.

      *>------------------------------------------------------------------------
      *> Cadastrar alunos
      *>------------------------------------------------------------------------
      *> está sem perform para sair do cadastro de alunos logo quando o usuário aperta enter (uma forma de fazer)
       cadastro-alunos section.
      *> zerando as variáveis
               move spaces to ws-nome
               move spaces to ws-endereco
               move spaces to ws-nome_mae
               move spaces to ws-nome_pai
               move spaces to ws-telefone
               move zeros to ws-cod
               move space to ws-sair-cad-alunos
      *> saber qual é o próximo código que pode ser utilizado
               perform buscar-prox-cod
      *> aceitar os dados do aluno
               display tela-cadastro-aluno
               accept tela-cadastro-aluno

      *> salvar dados no arquivo

               write fd-cadastro       from ws-cadastro

               if ws-fs-arqAlunos <> 0 then
                   move 2                                     to ws-msn-erro-ofsset
                   move ws-fs-arqAlunos                       to ws-msn-erro-cod
                   move "Erro ao escrever arq. arqAlunos"     to ws-msn-erro-text
                   perform finaliza-anormal
               end-if
           .
       cadastro-alunos-exit.
           exit.

      *>------------------------------------------------------------------------
      *> Cadastrar notas
      *>------------------------------------------------------------------------
      *> está com perform para ficar no cadastro de notas até o usuário apertar sair (outra forma de fazer)
       cadastro-notas section.
           move spaces to ws-sair-cad-notas
           perform until ws-sair-cad-notas = "x"
           or ws-sair-cad-notas = "X"
      *> zerando as variáveis
               move zeros to ws-notas-aux
               move space to ws-sair-cad-notas
               move zeros to ws-cod
               move space to ws-msn
      *> aceitar as notas
               display tela-cadastro-notas
               accept tela-cadastro-notas
      *> conferindo se o usuário quis sair do programa ou não
               if ws-sair-cad-notas = spaces then
      *> testando o código e as notas
                   if ws-cod <> zero then
                       move ws-cod to fd-cod
                       read arqAlunos
      *> movendo os dados do código que já existem no arquivo
                       move fd-cadastro to ws-cadastro

                       if  ws-nota_1_aux >= 0 and ws-nota_1_aux <= 10 then
                           move ws-nota_1_aux  to ws-nota_1
                       else
                           move  "Nota Invalida!"     to ws-msn
                       end-if
                       if  ws-nota_2_aux >= 0
                       and ws-nota_2_aux <= 10 then
                           move ws-nota_2_aux  to ws-nota_2
                       else
                           move  "Nota Invalida!"     to ws-msn
                       end-if
                       if  ws-nota_3_aux >= 0
                       and ws-nota_3_aux <= 10 then
                           move ws-nota_3_aux  to ws-nota_3
                       else
                           move  "Nota Invalida!"     to ws-msn
                       end-if
                       if  ws-nota_4_aux >= 0
                       and ws-nota_4_aux <= 10 then
                           move ws-nota_4_aux  to ws-nota_4
                       else
                           move  "Nota Invalida!"     to ws-msn
                       end-if
                   else
                       move  "Aluno nao cadastrado!"  to ws-msn
                   end-if

      *> salvar dados no arquivo
                   move ws-notas to fd-notas
                   rewrite fd-cadastro from ws-cadastro

                   if ws-fs-arqAlunos <> 0 then
                       move 3                                     to ws-msn-erro-ofsset
                       move ws-fs-arqAlunos                       to ws-msn-erro-cod
                       move "Erro ao reescrever arq. arqAlunos"   to ws-msn-erro-text
                       perform finaliza-anormal
                   end-if
               end-if
           end-perform
           .
       cadastro-notas-exit.
           exit.

      *>------------------------------------------------------------------------
      *> Fazer consulta de forma indexada
      *>------------------------------------------------------------------------
       consulta-indexada section.
           move spaces to ws-sair-consulta-indexada
           perform until ws-sair-consulta-indexada = "x"
           or ws-sair-consulta-indexada = "X"
               move spaces to ws-cadastro
               move zeros to ws-notas

      *> ler dados do arquivo
               display erase
               move zero to ws-cod
      *> aceitando o código que será consultado
               display tela-consulta-cadastro-cod
               accept tela-consulta-cadastro-cod
               move ws-cod to fd-cod

               read arqAlunos
               if  ws-fs-arqAlunos <> 0
               and ws-fs-arqAlunos <> 10 then
                   if ws-fs-arqAlunos = 23 then
                       display "Numero de cadastro informado invalido!"
                   else
                       move 4                                   to ws-msn-erro-ofsset
                       move ws-fs-arqAlunos                     to ws-msn-erro-cod
                       move "Erro ao ler arq. arqAlunos"        to ws-msn-erro-text
                       perform finaliza-anormal
                   end-if
               else
      *> movendo os dados do arquivo para as variáveis que serão mostradas na tela
                   move  fd-cadastro       to  ws-cadastro
      *> mostrando na tela os dados da consulta
                   display tela-consulta-indexada
                   accept tela-consulta-indexada
               end-if
      *> -------------
           end-perform
           .
       consulta-indexada-exit.
           exit.

      *>------------------------------------------------------------------------
      *> Consulta de forma sequencial/do começo ao fim
      *>------------------------------------------------------------------------
       consulta-sequencial-next section.
           display erase
           move zeros to ws-cod
      *> aceitando o código de partida das consultas
           display tela-consulta-cadastro-cod
           accept tela-consulta-cadastro-cod
           if ws-cod = 0 then
               move "x" to ws-sair-consulta-sequencial
           else
               move spaces to ws-sair-consulta-sequencial
               move ws-cod to fd-cod
               read arqAlunos
               move  fd-cadastro       to  ws-cadastro
               display tela-consulta-sequencial
               accept tela-consulta-sequencial
           end-if

           perform until ws-sair-consulta-sequencial = "x"
           or ws-sair-consulta-sequencial = "X"
               move spaces to ws-sair-consulta-sequencial
               move spaces to ws-sequencial-proximo
      *> lendo o arquivo de forma sequencial/do começo ao fim
               read arqAlunos next
               if  ws-fs-arqAlunos <> 0  then
                  if ws-fs-arqAlunos = 10 then
      *> fazendo o arquivo ler de trás para frente
                      perform consulta-sequencial-prev
                  else
                      move 5                                   to ws-msn-erro-ofsset
                      move ws-fs-arqAlunos                     to ws-msn-erro-cod
                      move "Erro ao ler arq. arqAlunos"        to ws-msn-erro-text
                      perform finaliza-anormal
                  end-if
               end-if
      *> movendo os dados do arquivo para as variáveis da working-storage
               move  fd-cadastro       to  ws-cadastro

      *> se o usuário não quis sair do programa, ele mostra o último cadastro de novo, para o usuário "clicar" em sair
               if ws-sair-consulta-sequencial = spaces then
                   move spaces to ws-sair-consulta-sequencial
                   move spaces to ws-sequencial-proximo
                   display tela-consulta-sequencial
                   accept tela-consulta-sequencial
               end-if

           end-perform
           .
       consulta-sequencial-next-exit.
           exit.

      *>------------------------------------------------------------------------
      *> Lendo o arquivo de forma sequencial/do fim ao começo
      *>------------------------------------------------------------------------
       consulta-sequencial-prev section.
           perform until ws-sair-consulta-sequencial = "x"
           or ws-sair-consulta-sequencial = "X"
               move spaces to ws-sair-consulta-sequencial
               move spaces to ws-sequencial-proximo
      *> lendo de trá para frente
               read arqAlunos previous
               if  ws-fs-arqAlunos <> 0  then
                  if ws-fs-arqAlunos = 10 then
                      perform consulta-sequencial-next
                  else
                      move 6                                   to ws-msn-erro-ofsset
                      move ws-fs-arqAlunos                     to ws-msn-erro-cod
                      move "Erro ao ler arq. arqAlunos"        to ws-msn-erro-text
                      perform finaliza-anormal
                  end-if
               end-if
      *> movendo os dados do arquivo para as variáveis da working-storage
               move  fd-cadastro       to  ws-cadastro

      *> mostrando na tela
               display tela-consulta-sequencial
               accept tela-consulta-sequencial

           end-perform
           .
       consultar-temp-seq-prev-exit.
           exit.

      *>------------------------------------------------------------------------
      *> Alterar dados de um cadastro
      *>------------------------------------------------------------------------
       alterar section.
           move spaces to ws-cadastro
           move zeros to ws-notas
           perform until ws-sair-alterar = "x"
           or ws-sair-alterar = "X"
               move space to ws-sair-alterar
               move zeros to ws-cod
      *> aceitar o código no qual serão alterados os dados
               display tela-consulta-cadastro-cod
               accept tela-consulta-cadastro-cod
               if ws-cod = 0 then
                   move "x" to ws-sair-consulta-sequencial
               end-if
               move ws-cod to fd-cod
      *> ler o arquivo para caso o código que o usuário informou não esteja cadastrado
               read arqAlunos
               if ws-fs-arqAlunos <> 0 then
                   if ws-fs-arqAlunos = 23 then
                       display "Aluno nao registrado!" at line 05 col 07
                       accept ws-aux
                   else
                       move 7                                   to ws-msn-erro-ofsset
                       move ws-fs-arqAlunos                     to ws-msn-erro-cod
                       move "Erro ao ler arq. arqAlunos"        to ws-msn-erro-text
                       perform finaliza-anormal
                   end-if
               else
      *> alterar dados do registro do arquivo
                   display tela-alterar
                   accept tela-alterar
                   move ws-nome to fd-nome
                   move ws-endereco to fd-endereco
                   move ws-nome_mae to fd-nome_mae
                   move ws-nome_pai to fd-nome_pai
                   move ws-telefone to fd-telefone
                   move ws-nota_1 to fd-nota_1
                   move ws-nota_2 to fd-nota_2
                   move ws-nota_3 to fd-nota_3
                   move ws-nota_4 to fd-nota_4
      *> reecrevendo os dados no arquivo
                   rewrite fd-cadastro
                   if  ws-fs-arqAlunos = 0 then
                       move "Cadastro alterado com sucesso!" to ws-msn
                       display tela-alterar
      *> tela por cima da tela só para a opção sair, pois estava dando erro sem sentido na localização do "ponteiro"
      *>            display tela-alterar-sair
      *>            accept tela-alterar-sair
                   else
                       move 8                                   to ws-msn-erro-ofsset
                       move ws-fs-arqAlunos                     to ws-msn-erro-cod
                       move "Erro ao alterar arq. arqAlunos"    to ws-msn-erro-text
                       perform finaliza-anormal
                   end-if
               end-if
           end-perform
           move spaces to ws-sair-alterar
           move spaces to ws-msn
           .
       alterar-exit.
           exit.

      *>------------------------------------------------------------------------
      *> Deletar dados do arquivo
      *>------------------------------------------------------------------------
       deletar section.
           perform until ws-sair-deletar = "x"
           or ws-sair-alterar = "X"
               move spaces to ws-sair-deletar
               move zeros to ws-cod
               move spaces to ws-msn
      *> apagar dados do registro do arquivo
               display tela-deletar
               accept tela-deletar
               move ws-cod to fd-cod
      *> apagando os dados do cadastro do código informado
               delete arqAlunos
               if  ws-fs-arqAlunos = 0 then
                   move "Aluno apagado com sucesso!" to ws-msn
                   display tela-deletar
                   accept tela-deletar
               else
                   if ws-fs-arqAlunos = 23 then
                       move "Data informada invalida!" to ws-msn
                       accept ws-aux
                   else
                       move 9                                   to ws-msn-erro-ofsset
                       move ws-fs-arqAlunos                     to ws-msn-erro-cod
                       move "Erro ao apagar arq. arqAlunos"     to ws-msn-erro-text
                       perform finaliza-anormal
                   end-if
               end-if
           end-perform
           .
       deletar-exit.
           exit.


      *>------------------------------------------------------------------------
      *> Buscar proximo indice do aluno
      *>------------------------------------------------------------------------
       buscar-prox-cod section.
           move 1 to fd-cod
           read arqAlunos
           if ws-fs-arqAlunos = 23 then
              move 1 to ws-cod
           else
               perform until ws-fs-arqAlunos = 10
                   read arqAlunos next
               end-perform
               move fd-cod to ws-cod
               add 1 to ws-cod
           end-if
           .
       buscar-prox-cod-exit.
           exit.


      *>------------------------------------------------------------------------
      *> Finalização  Anormal
      *>------------------------------------------------------------------------
       finaliza-anormal section.
           display erase
           display ws-msn-erro.
           stop run
           .
       finaliza-anormal-exit.
           exit.


      *>------------------------------------------------------------------------
      *> Finalização  Normal
      *>------------------------------------------------------------------------
       finaliza section.
           close arqAlunos
           if ws-fs-arqAlunos <> 0 then
               move 10                                to ws-msn-erro-ofsset
               move ws-fs-arqAlunos                  to ws-msn-erro-cod
               move "Erro ao fechar arq. arqAlunos " to ws-msn-erro-text
               perform finaliza-anormal
           end-if
           stop run
           .
       finaliza-exit.
           exit.


