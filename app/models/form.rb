class Form < ApplicationRecord
  belongs_to :user
  has_many :form_fields, -> { order(position: :asc) }, dependent: :destroy
  has_many :form_submissions, dependent: :destroy
  
  accepts_nested_attributes_for :form_fields, allow_destroy: true
  
  validates :title, presence: true
  validates :description, length: { maximum: 1000 }
  
  scope :active, -> { where(active: true) }
  
  def translated_title(language = I18n.locale.to_s) # gives current language as string 'en' 'fr' etc
    return title if language == 'en' || translations.blank?
    translations.dig(language, 'title') || title # gets nested hash values if nil then return origional title
  end
  
  def translated_description(language = I18n.locale.to_s)
    return description if language == 'en' || translations.blank?
    translations.dig(language, 'description') || description
  end
  
  def translate_to(target_language)
    return if target_language == 'en' # do nothing if english
    
    translator = GoogleTranslate.new  # google translation api 
    
    unless translations[target_language].present? # generate new translation if none exists 
      translations[target_language] = {
        'title' => translator.translate(title, to: target_language),
        'description' => translator.translate(description, to: target_language)
      }
      save
    end
    
    form_fields.each do |field|
      field.translate_to(target_language) # make sure all forms are translated 
    end
  end
end 
