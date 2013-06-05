require "rubygems"
require "sinatra"
require "i18n"

use Rack::Session::Cookie

set :views, File.dirname(__FILE__) + "/templates"

# Loading locales
Dir.glob("i18n/*.yml").each { |locale| I18n.load_path << locale}
I18n.locale = "pt-BR"

# Home
get "/" do redirect "/#{current_locale}/portalopme" end

# Visão Geral do Portal OPME
get "/portalopme" do redirect "/#{current_locale}/portalopme", 303 end
get "/:locale/portalopme" do |locale|
  set_locale(locale)
  erb :"portalopme/index"
end

# Entendendo o SIstema
get "/understanding_the_system" do redirect "/#{current_locale}/understanding_the_system", 303 end
get "/:locale/understanding_the_system" do |locale|
  set_locale(locale)
  erb :"understanding_the_system/index"
end


# Menu Principal
get "/menu_principal" do redirect "/#{current_locale}/menu_principal", 303 end
get "/:locale/menu_principal" do |locale|
  set_locale(locale)
  erb :"menu_principal/index"
end


# Orçamentos
get "/orcamentos" do redirect "/#{current_locale}/orcamentos", 303 end
get "/:locale/orcamentos" do |locale|
  set_locale(locale)
  erb :"orcamentos/index"
end


# Relatorios
get "/relatorios" do redirect "/#{current_locale}/relatorios", 303 end
get "/:locale/relatorios" do |locale|
  set_locale(locale)
  erb :"relatorios/index"
end

# Configuracoes
get "/configuracoes" do redirect "/#{current_locale}/configuracoes", 303 end
get "/:locale/configuracoes" do |locale|
  set_locale(locale)
  erb :"configuracoes/index"
end



# App helpers
def set_locale(locale)
  if I18n.available_locales.include?(locale.to_sym)
    session[:locale] = locale
    return I18n.locale = locale
  end

  redirect request.fullpath.gsub("/#{locale}/", "/#{current_locale}/")
end

def current_locale
  session[:locale].nil? ? "pt-BR" : session[:locale]
end

def link_to(name, url)
  "<a href='/#{current_locale}/#{url}'>#{name}</a>"
end

def is_group_active?(group)
  "in" if group == request.path_info.split("/")[2]
end

def is_group_item_active?(group, item=nil)
  if group == request.path_info.split("/")[2]
    return "active" if request.path_info.split("/").length == 3 && item.nil?
    return "active" if item == request.path_info.split("/").last
  end
end