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

ActiveRecord::Schema.define(version: 20170608220657) do

  create_table "audits", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.integer "auditable_id"
    t.string "auditable_type"
    t.integer "associated_id"
    t.string "associated_type"
    t.integer "user_id"
    t.string "user_type"
    t.string "username"
    t.string "action"
    t.text "audited_changes", limit: 4294967295
    t.integer "version", default: 0
    t.string "comment"
    t.string "remote_address"
    t.string "request_uuid"
    t.datetime "created_at"
    t.index ["associated_id", "associated_type"], name: "associated_index", length: { associated_type: 191 }
    t.index ["auditable_id", "auditable_type"], name: "auditable_index", length: { auditable_type: 191 }
    t.index ["created_at"], name: "index_audits_on_created_at"
    t.index ["request_uuid"], name: "index_audits_on_request_uuid", length: { request_uuid: 191 }
    t.index ["user_id", "user_type"], name: "user_index", length: { user_type: 191 }
  end

  create_table "cached_notes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.bigint "user_id"
    t.bigint "script_id"
    t.text "text"
    t.datetime "added_at"
    t.string "link"
    t.integer "line"
    t.index ["script_id"], name: "index_cached_notes_on_script_id"
    t.index ["user_id"], name: "index_cached_notes_on_user_id"
  end

  create_table "project_memberships", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.boolean "write_access", default: false
    t.string "position", limit: 191
    t.bigint "project_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id", "user_id"], name: "index_project_memberships_on_project_id_and_user_id", unique: true
    t.index ["project_id"], name: "index_project_memberships_on_project_id"
    t.index ["user_id"], name: "index_project_memberships_on_user_id"
  end

  create_table "projects", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "name", limit: 191
    t.string "language", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "style_guide"
    t.index ["name"], name: "index_projects_on_name", unique: true
  end

  create_table "scripts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "name", limit: 191
    t.text "text", limit: 4294967295, null: false
    t.string "stage", default: "untouched", null: false
    t.bigint "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "project_id"], name: "index_scripts_on_name_and_project_id", unique: true
    t.index ["project_id"], name: "index_scripts_on_project_id"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "name", limit: 191
    t.string "discord_uid", limit: 20
    t.boolean "admin", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.integer "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.index ["discord_uid"], name: "index_users_on_discord_uid", unique: true
    t.index ["name"], name: "index_users_on_name", unique: true
  end

  add_foreign_key "cached_notes", "scripts"
  add_foreign_key "cached_notes", "users"
end
