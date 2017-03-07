class EstanteriaController < ApplicationController

  before_action :authenticate_user!
  
  def index
    @aux = Estanterium.all
    #@aux.each do |f|
     # if f.user_id == current_user.id
      #  @pelicula = Pelicula.where(:id => f.id_pelicula)
      #end
    #end    
  end
  
  def create    
    
    title = "titulo"+params[:lotengo]
    average = "puntuacion"+params[:lotengo]
    genre = "genero"+params[:lotengo]
    release = "estreno"+params[:lotengo]
    overview = "sipnosis"+params[:lotengo]
    id_movie = "id_pelicula"+params[:lotengo]
    imdb = "id_imdb"+params[:lotengo]
    image = "poster"+params[:lotengo]
    
    @pelicula = Pelicula.new
    @pelicula.titulo = params[title] 
    @pelicula.puntuacion = params[average]
    @pelicula.genero = params[genre]
    @pelicula.estreno = params[release]
    @pelicula.sipnosis = params[overview]
    @pelicula.id_pelicula = params[id_movie]
    @pelicula.id_imdb = params[imdb]
    @pelicula.imagen_file_name = params[:url]+params[:tam]+params[image]
    @pelicula.id_user = current_user.id
    
    #@pelicula.poster_from_url(params[:poster])
    
    @pelicula.save
    
    @estanteria = Estanterium.new
    @estanteria.id_pelicula = @pelicula.id_pelicula
    @estanteria.user_id = current_user.id
    
    @estanteria.save

    
    #redirect_to search_path(:busqueda => params[:busqueda])
    
    #render plain: params[:sipnosis].inspect
  end
  
  def destroy
    #id_movie = "id_pelicula"+params[:nolotengo]
    @delete = Pelicula.where(params[:id])
    @eliminate = Estanterium.where(params[:id])
    @delete.each do |borrar|
      if borrar.id_user == current_user.id && borrar.id_pelicula.to_s == params[:id]
        borrar.destroy
      end
    end
    @eliminate.each do |borrar1|
      if borrar1.user_id == current_user.id && borrar1.id_pelicula == params[:id]
        borrar1.destroy
      end
    end
    redirect_to estanteria_path
  end
end
