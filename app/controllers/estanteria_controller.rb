class EstanteriaController < ApplicationController

  before_action :authenticate_user!
  
  def index
    
    @generos = ["Acción", "Animación", "Aventura", "Ciencia ficción", "Comedia", "Crimen", "Drama", "Documental", "Familia", "Fantasía", "Guerra", "Historia", "Misterio", "Música", "Romance", "Suspense", "Terror"]
    @medios = ["Todo", "DVD", "Blu-ray", "HD-DVD"]
    @filtrado = {"Medios" => @medios, "Géneros" => @generos}
    
    @multimedia = params[:peliculas]
    
    @ordenar = params[:select_ordenar]
    @filtrar = params[:select_filtrar]
   
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
    soporte = "soporte"+params[:lotengo]
    num_copias = "num_copias"+params[:lotengo]
    ubicacion = "ubicacion"+params[:lotengo]
    
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
    @pelicula.soporte = params[soporte]
    @pelicula.num_copias = params[num_copias]
    @pelicula.ubicacion = params[ubicacion]
    @pelicula.prestado = 0
      
    #@pelicula.poster_from_url(params[:poster])
    
    @pelicula.save
    
    @estanteria = Estanterium.new
    @estanteria.id_pelicula = @pelicula.id_pelicula
    @estanteria.medio = @pelicula.soporte
    @estanteria.user_id = current_user.id
    
    @estanteria.save
     
    #redirect_to search_path(:busqueda => params[:busqueda])
    
    #render plain: params[:sipnosis].inspect
  end
  
  def destroy
    #id_movie = "id_pelicula"+params[:nolotengo]
    #@delete = Pelicula.where(params[:id])
    #@eliminate = Estanterium.where(params[:id])
    #@delete.each do |borrar|
    #  if borrar.id_user == current_user.id && borrar.id_pelicula.to_s == params[:id]
    #    borrar.destroy
    #  end
    #end
    #@eliminate.each do |borrar1|
    #  if borrar1.user_id == current_user.id && borrar1.id_pelicula == params[:id]
    #    borrar1.destroy
    #  end
    #end
    #redirect_to estanteria_path
  end
  
  def borrar
    
    id_movie = "id_pelicula"+params[:lotengo]
    soporte = "soporte"+params[:lotengo]
    
    @delete = Pelicula.where(["soporte = :soporte and id_pelicula = :id", { id: params[id_movie], soporte: params[soporte] }])
    @eliminate = Estanterium.where(["medio = :medio and id_pelicula = :id", { id: params[id_movie], medio: params[soporte] }])
    @delete.each do |borrar|
      if borrar.id_user == current_user.id && borrar.id_pelicula.to_s == params[id_movie]
        borrar.destroy
      end
    end
    @eliminate.each do |borrar1|
      if borrar1.user_id == current_user.id && borrar1.id_pelicula == params[id_movie]
        borrar1.destroy
      end
    end
    redirect_to estanteria_path
  end
  
  def actualizar
    
    @edit = params[:edit]
    @prestar = params[:prestar]
    
    if @edit == "true"
      @pelicula = Pelicula.where(params[:id])
      @pelicula.each do |pelicula|
        if pelicula.id_user == current_user.id && pelicula.id_pelicula.to_s == params[:id]
         pelicula.num_copias = params[:num_copias]
         pelicula.ubicacion = params[:ubicacion]
         pelicula.save
        end
      end
    end
    
    if @prestar == "true"
      @p = params[:id_prestar]
      @pelicula = Pelicula.where(params[:id])
      @pelicula.each do |pelicula|
        if pelicula.id_user == current_user.id && pelicula.id_pelicula.to_s == params[:id]
          if @p == "Si"
            pelicula.prestado = 1
            pelicula.pres_prestamo = params[:pres_prestamo]
            pelicula.save
          end
          if @p == "No"
            pelicula.prestado = 0
            pelicula.pres_prestamo = nil
            pelicula.save
          end
        end
      end
    end
    
 end
  
end
