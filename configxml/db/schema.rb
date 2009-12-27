# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20091204011110) do

  create_table "computers", :force => true do |t|
    t.integer  "cid"
    t.string   "cname"
    t.integer  "oid"
    t.integer  "did"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "owner_id"
  end

  create_table "distros", :force => true do |t|
    t.integer  "did"
    t.string   "dname"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "owners", :force => true do |t|
    t.integer  "oid"
    t.string   "oname"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "packages", :force => true do |t|
    t.integer  "cid"
    t.string   "package"
    t.string   "version"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "computer_id"
  end

end
