class FormField < ApplicationRecord
  belongs_to :form
  
  FIELD_TYPES = %w(text_field text_area select checkbox radio date email number phone file)
  
  validates :field_type, presence: true, inclusion: { in: FIELD_TYPES }
  validates :label, presence: true
  validates :position, presence: true
  
  before_validation :set_position, on: :create
  
  def translated_label(language = I18n.locale.to_s)
    return label if language == 'en' || translations.blank?
    translations.dig(language, 'label') || label
  end
  
  def translated_description(language = I18n.locale.to_s)
    return description if language == 'en' || translations.blank?
    translations.dig(language, 'description') || description
  end
  
  def translate_to(target_language)
    return if target_language == 'en'
    
    translator = GoogleTranslate.new
    
    unless translations[target_language].present?
      translations[target_language] = {
        'label' => translator.translate(label, to: target_language),
        'description' => translator.translate(description, to: target_language)
      }
      
      # Translate options if present
      if options['choices'].present?
        translations[target_language]['choices'] = {}
        options['choices'].each do |key, value|
          translations[target_language]['choices'][key] = translator.translate(value, to: target_language)
        end
      end
      
      save
    end
  end
  
  private
  
  def set_position
    self.position ||= (form.form_fields.maximum(:position) || 0) + 1
  end
end 