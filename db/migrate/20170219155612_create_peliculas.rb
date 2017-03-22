class CreatePeliculas < ActiveRecord::Migration[5.0]
  def change
    create_table :peliculas do |t|
      t.string :titulo
      t.string :genero
      t.string :sipnosis
      t.date :estreno
      t.integer :puntuacion
      t.integer :duracion
      t.string :actores
      t.integer :id_user
      t.integer :id_pelicula
      t.integer :id_imdb
      t.string :soporte
      t.string :num_copias
      t.string :ubicacion
      t.boolean :prestado
      t.string :pers_prestamo

      t.timestamps
    end
    
    add_attachment :peliculas, :imagen
  end
end
