require "sinatra"
require "sinatra/reloader"
require "artii"
require 'pry'

@made_ascii = ""
@ascii_text = ""
@text_typo=""

get "/ascii" do	
	erb :ascii
end

post "/make-ascii"do
	@made_ascii = params[:user_text]
	@text_typo = params[:text_typo]
	if @text_typo == "special" && @made_ascii == "secret"
		redirect "/secret/special"
	else
		redirect "/ascii/#{params[:user_text]}/#{params[:text_typo]}"
	end
end

get "/secret/special" do
	erb :secret
end

get "/ascii/:user_text/?:text_typo?" do
	@made_ascii = params[:user_text]
	@text_typo = params[:text_typo]
	
	if @text_typo == nil
		ascii = Artii::Base.new :font => 'slant'
	else
		ascii = Artii::Base.new :font => @text_typo
	end

	@item = ascii.asciify(@made_ascii)



	erb :ascii
end

post "/animal" do
	@animal = params[:animal]
	if @animal == "elephant" 
		redirect "elephant/secret/special"
	else
		redirect "/ascii"
	end
end

get "/elephant/secret/special" do
	erb :elephant
end