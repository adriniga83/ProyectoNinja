class SearchController < ApplicationController
  require 'json'
  require 'uri'
  require 'net/http'
  require 'openssl'

  before_action :authenticate_user!
  
  def search
    
    @plataformas = ["Super Nintendo", "Nintendo 64", "GameCube", "Wii", "Wii U", "Nintendo Switch", "Game Boy", "Game Boy Color", "Game Boy Advance", "Nintendo DS", "Nintendo 3DS", "PlayStation", "PlayStation 2", "PlayStation 3", "PlayStation 4", "PlayStation Portable", "PlayStation Vita", "Xbox", "Xbox 360", "Xbox One", "PC", "Genesis"]
 
    @categoria = params[:id]
    
    if @categoria == "Peliculas"   
      @respuesta = false;
      @busqueda = params[:titulo]
      if request.post?
        @search = Tmdb::Movie.find(params[:titulo])
      end
      url = URI("https://api.themoviedb.org/3/configuration?api_key=d4345c394b5a85b5749cfb819a8b2e01")

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      request = Net::HTTP::Get.new(url)
      #request.body = "{}"

      response = http.request(request)
      #@prueba = response.read_body 
      bodyjson = JSON.parse(response.body)
      @base_url = bodyjson['images']['base_url']
      @sizes = bodyjson['images']['poster_sizes']
      @parametro = params[:titulo]
    end
    
    if @categoria == "Musica"
      
     app_key = 'KWqwYwVmtTmeqhdePChA'
     app_secret = 'vKhpoTljtDVzTOvsFhoIExnVWLukuFwI'
     url = URI("https://api.discogs.com/database/search?q="+params[:titulo]+"&key="+app_key+"&secret="+app_secret)

     http = Net::HTTP.new(url.host, url.port)
     http.use_ssl = true
     http.verify_mode = OpenSSL::SSL::VERIFY_NONE

     request = Net::HTTP::Get.new(url)

     response = http.request(request)
     bodyjson = JSON.parse(response.body)
     @cancion = bodyjson["results"]
        
    end
    
    if @categoria == "Juegos"
     
     @juego = GiantBomb::Game.find(params[:titulo])
      
    end
    
    if @categoria == "Series"
           
      @respuesta = false;
      @busqueda = params[:titulo]
      #if request.post?
        @serie = Tmdb::TV.find(params[:titulo]);
      #end
      url = URI("https://api.themoviedb.org/3/configuration?api_key=d4345c394b5a85b5749cfb819a8b2e01")

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      request = Net::HTTP::Get.new(url)
      #request.body = "{}"

      response = http.request(request)
      #@prueba = response.read_body 
      bodyjson = JSON.parse(response.body)
      @base_url = bodyjson['images']['base_url']
      @sizes = bodyjson['images']['poster_sizes']
      
    end
    
  end
  
  def configuracion
    
  end
end
