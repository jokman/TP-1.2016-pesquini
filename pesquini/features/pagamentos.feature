#language: pt

Funcionalidade: Visualizar ranking das empresas que mais receberam pagamentos do governo.

@javascript
Cenario: Visualizar o ranking com as 10 empresas que mais receberam pagamentos.

Ao usuario acessar a pagina de estatisticas e selecionar a opçao "Empresas com o maior numero de pagamentos", o sistema deve mostrar um ranking com as 10 empresas que mais receberam pagamentos do governo.

@javascript
Cenario: Visualizar o ranking de todas as sançoes atraves de um botao.

Dado que eu estou na pagina "/statistics/most_paymented_ranking"
Quando eu clico no link "Todas"
Então eu devo visualizar o ranking de todas as empresas que mais receberam pagamentos
