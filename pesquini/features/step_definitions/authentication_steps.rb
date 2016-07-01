# encoding: utf-8
Before do

  @user = User.new
  @user.login = "sanjaninha"
  @user.password = "sanjana123"
  @user.save

  @enterprise = Enterprise.new
  @enterprise.corporate_name = "COOPERSEMO"
  @enterprise.sanctions_count = 32
  @enterprise.payments_sum = 20
  @enterprise.save

end
Dado(/^que insiro uma empresa existente$/) do
  fill_in 'q_corporate_name_cont', :with=> "COOPERSEMO"
end

Quando(/^eu clico no botão "(.*?)"$/) do |arg1|
  click_button arg1
end

Entao(/^vejo os dados prévios desta empresa\.$/) do
page.should have_content('COOPERSEMO')
end

Quando(/^eu clico no link "(.*?)"$/) do |arg1|
  click_link arg1
end

Quando(/^eu clico no id "(.*?)"$/) do |arg1|
  find("#"+arg1).click
end

Entao(/^vejo os dados das sançoes da mesma$/) do
  page.should have_content(1)
end

Então(/^eu vejo o texto "(.*?)"$/) do |arg1|
  page.should have_content arg1
end

Então(/^eu sou redirecionado para a Homepage$/) do
  visit '/'
end

Dado(/^que eu visitei a pagina de estatisticas$/) do
  visit '/statistics'
end

Entao(/^vejo o ranking dos grupos das empresas com mais sançoes$/) do
  visit '/statistics/most_sanctioned_ranking'
end

Entao(/^vejo o nome de todas as empresas com (\d+) sanções$/) do |arg1|
  page.should have_content arg1
end

Entao(/^vejo o ranking das (\d+) empresas que mais receberam pagamentos$/) do |arg1|
  page.should have_content (1)
end


Então(/^eu devo visualizar o ranking de todas as empresas que mais receberam pagamentos$/) do
  page.should have_content (20)
end

Dado(/^que eu estou na pagina "(.*?)"$/) do |arg1|
  visit arg1
end

Dado(/^que insiro uma empresa inexistente$/) do
  fill_in 'q_corporate_name_cont', :with=> "inexistente"
end

Quando(/^eu tento rodar o parser$/) do
  visit '/parser/cei'
end

Então(/^devo visulizar uma pagina para efetuar o login$/) do
  page.should have_content ("Login")
end

Então(/^sou redirecionado para homepage e o parser executado$/) do
  page.should have_content ("Pesquisa")
end

Dado(/^que eu insira um login existente$/) do
  fill_in 'session_login', :with=> "sanjaninha"
end

Dado(/^que eu insira um password existente$/) do
  fill_in 'session_password', :with=> "sanjana123"
end
