class AddFieldOptionsToFormFields < ActiveRecord::Migration[7.0]
  def change
    add_column :form_fields, :placeholder, :string
    add_column :form_fields, :rows, :integer, default: 3
    add_column :form_fields, :multiple, :boolean, default: false
    add_column :form_fields, :choices, :jsonb, default: []
  end
end 