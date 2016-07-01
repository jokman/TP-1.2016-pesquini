#language: pt

Funcionalidade: Efetuar login como administrador para rodar o parser

@javascript
Cenário: Carregar pagina de login

Dado que eu estou na pagina "/"
Quando eu tento rodar o parser
Então devo visulizar uma pagina para efetuar o login

@javascript
Cenário: Efetuar login existente

Dado que eu estou na pagina "/signin"
Dado que eu insira um login existente
Dado que eu insira um password existente
Quando eu clico no botão "Sign in"
Então sou redirecionado para homepage e o parser executado

@javascript
Cenário: Efetuar login inexistente

Dado que eu estou na pagina "/signin"
Quando eu clico no botão "Sign in"
Entao eu vejo o texto "Login ou senha invalidos!"
