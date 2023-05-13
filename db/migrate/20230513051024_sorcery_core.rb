class SorceryCore < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :nickname, null: false, limit: 191
      t.string :email,            null: false, index: { unique: true }, limit: 191
      t.string :crypted_password, limit: 191
      t.string :salt, limit: 191
      t.integer :role, default: 0, null: false
      t.text :bio
      t.string :sns_identifier, limit: 191

      t.timestamps                null: false
    end
  end
end
