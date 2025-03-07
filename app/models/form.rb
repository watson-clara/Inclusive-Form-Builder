class Form < ApplicationRecord
  belongs_to :user
  has_many :form_fields, -> { order(position: :asc) }, dependent: :destroy
  has_many :form_submissions, dependent: :destroy
  
  validates :title, presence: true
  
  def translated_title(language = I18n.locale.to_s)
    return title if language == 'en' || translations.blank?
    translations.dig(language, 'title') || title
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
        'title' => translator.translate(title, to: target_language),
        'description' => translator.translate(description, to: target_language)
      }
      save
    end
    
    form_fields.each do |field|
      field.translate_to(target_language)
    end
  end
end 