class CreateForms < ActiveRecord::Migration[7.0]
  def change
    create_table :forms do |t|
      t.string :title, null: false
      t.text :description
      t.boolean :active, default: true
      t.references :user, null: false, foreign_key: true
      t.jsonb :translations, default: {}
      
      t.timestamps
    end
  end
end 