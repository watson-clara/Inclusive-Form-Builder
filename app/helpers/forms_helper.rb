module FormsHelper
  def field_type_icon(type)
    case type
    when 'text' then 'fa-font'
    when 'textarea' then 'fa-paragraph'
    when 'select' then 'fa-list'
    when 'radio' then 'fa-dot-circle'
    when 'checkbox' then 'fa-check-square'
    else 'fa-question'
    end
  end

  def field_type_description(type)
    case type
    when 'text' then 'Short text response'
    when 'textarea' then 'Long text response'
    when 'select' then 'Choose one from a dropdown'
    when 'radio' then 'Choose one from options'
    when 'checkbox' then 'Choose multiple options'
    end
  end
end 