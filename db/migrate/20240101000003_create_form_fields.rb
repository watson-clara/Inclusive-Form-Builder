class CreateFormFields < ActiveRecord::Migration[7.0]
  def change
    create_table :form_fields do |t|
      t.references :form, null: false, foreign_key: true
      t.string :field_type, null: false
      t.string :label, null: false
      t.text :description
      t.boolean :required, default: false
      t.integer :position
      t.jsonb :options, default: {}
      t.jsonb :translations, default: {}
      t.jsonb :validations, default: {}
      t.jsonb :accessibility_attributes, default: {}
      
      t.timestamps
    end
  end
end 