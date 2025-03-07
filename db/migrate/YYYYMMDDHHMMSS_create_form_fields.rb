class CreateFormFields < ActiveRecord::Migration[7.0]
  def change
    create_table :form_fields do |t|
      t.references :form, null: false, foreign_key: true
      t.string :field_type, null: false
      t.string :label
      t.text :options
      t.boolean :required, default: false
      t.integer :position
      t.jsonb :translations, default: {}

      t.timestamps
    end
    
    add_index :form_fields, [:form_id, :position]
  end
end 