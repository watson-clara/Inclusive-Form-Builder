class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :name
      t.string :role, default: 'provider'
      t.string :preferred_language, default: 'en'
      t.string :password_digest
      
      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end 