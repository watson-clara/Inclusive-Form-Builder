class CreateFormSubmissions < ActiveRecord::Migration[7.0]
  def change
    create_table :form_submissions do |t|
      t.references :form, null: false, foreign_key: true
      t.references :user, foreign_key: true
      t.jsonb :data, default: {}
      t.string :status, default: 'submitted'
      
      t.timestamps
    end
  end
end 