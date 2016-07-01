#language: pt

Funcionalidade: Pesquisar Empresas Inidonias
  Ao usuário entrar no sistema, ele poderá inserir o nome ou cnpj de uma das empresas no campo pré-determinado para tal função

@javascript
Cenário: Pesquisar uma empresa a partir da pagina inicial

Ao usuário tentar pesquisar uma empresa existente, ela deverá ter seus dados mostrados a partir da pagina inicial.

Dado que eu estou na pagina "/"
Dado que insiro uma empresa existente
Quando eu clico no id "search_index"
Entao vejo os dados prévios desta empresa.

@javascript
Cenário: Pesquisar uma empresa a partir da pagina enterprises

Ao usuário tentar pesquisar uma empresa existente, ela deverá ter seus dados mostrados a partir da pagina enterprises

Dado que eu estou na pagina "/enterprises"
Dado que insiro uma empresa existente
Quando eu clico no botão "Search"
Entao vejo os dados prévios desta empresa.

@javascript
Cenário: Pesquisar uma empresa não existente

Dado que eu estou na pagina "/"
Dado que insiro uma empresa inexistente
Quando eu clico no id "search_index"
Entao eu vejo o texto "Não existem sanções contra a empresa procurada."
