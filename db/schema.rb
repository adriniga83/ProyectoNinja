# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170424083334) do

  create_table "estanteria", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "id_estanteria"
    t.string   "id_pelicula"
    t.string   "id_serie"
    t.string   "id_videojuego"
    t.string   "id_musica"
    t.string   "user"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "user_id"
    t.string   "medio"
    t.index ["user_id"], name: "Usuario_idx", using: :btree
  end

  create_table "juegos", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "titulo"
    t.text     "plataformas",         limit: 65535
    t.text     "sipnosis",            limit: 65535
    t.date     "estreno"
    t.integer  "id_user"
    t.integer  "id_juego"
    t.string   "soporte"
    t.integer  "num_copias"
    t.string   "ubicacion"
    t.integer  "prestado",            limit: 1
    t.string   "pres_prestamo"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "imagen_file_name"
    t.string   "imagen_content_type"
    t.integer  "imagen_file_size"
    t.datetime "imagen_updated_at"
    t.index ["id_user"], name: "User_idx", using: :btree
  end

  create_table "musicas", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "titulo"
    t.string   "genero"
    t.date     "estreno"
    t.string   "lista_canciones"
    t.integer  "id_user"
    t.integer  "id_musica"
    t.string   "soporte"
    t.string   "num_copias"
    t.string   "ubicacion"
    t.boolean  "prestado"
    t.string   "pres_prestamo"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "imagen_file_name"
    t.string   "imagen_content_type"
    t.integer  "imagen_file_size"
    t.datetime "imagen_updated_at"
  end

  create_table "peliculas", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "titulo"
    t.text     "genero",              limit: 65535
    t.text     "sipnosis",            limit: 65535
    t.date     "estreno"
    t.decimal  "puntuacion",                        precision: 5, scale: 2
    t.integer  "duracion"
    t.string   "actores"
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
    t.string   "imagen_file_name"
    t.string   "imagen_content_type"
    t.integer  "imagen_file_size"
    t.datetime "imagen_updated_at"
    t.integer  "id_user"
    t.integer  "id_pelicula"
    t.integer  "id_imdb"
    t.string   "soporte",             limit: 45
    t.integer  "num_copias"
    t.string   "ubicacion"
    t.integer  "prestado",            limit: 1
    t.string   "pres_prestamo"
    t.index ["id_user"], name: "User_idx", using: :btree
  end

  create_table "series", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "titulo"
    t.text     "genero",              limit: 65535
    t.text     "sipnosis",            limit: 65535
    t.date     "estreno"
    t.decimal  "puntuacion",                        precision: 5, scale: 2
    t.integer  "duracion"
    t.string   "actores"
    t.integer  "id_user"
    t.integer  "id_serie"
    t.integer  "id_imdb"
    t.string   "soporte"
    t.integer  "num_copias"
    t.string   "ubicacion"
    t.integer  "prestado",            limit: 1
    t.string   "pres_prestamo"
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
    t.string   "imagen_file_name"
    t.string   "imagen_content_type"
    t.integer  "imagen_file_size"
    t.datetime "imagen_updated_at"
    t.integer  "num_seasons"
    t.string   "status",              limit: 45
    t.text     "temporadas",          limit: 65535
    t.index ["id_user"], name: "User_idx", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "user",                   default: "", null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "id_estanteria"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["user"], name: "index_users_on_user", unique: true, using: :btree
  end

  add_foreign_key "estanteria", "users", name: "Usuario"
  add_foreign_key "peliculas", "users", column: "id_user", name: "User"
end
