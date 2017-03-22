class CreateEstanteria < ActiveRecord::Migration[5.0]
  def change
    create_table :estanteria do |t|
      t.string :id_estanteria
      t.string :id_pelicula
      t.string :id_serie
      t.string :id_videojuego
      t.string :id_musica
      t.string :user
      t.integer :user_id
      t.string :medio

      t.timestamps
    end
  end
end
