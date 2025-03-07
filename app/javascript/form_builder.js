function addChoice(button) {
  const choicesContainer = button.closest('.field-options').querySelector('.choices-container')
  const fieldItem = button.closest('.form-field-item')
  const fieldId = fieldItem.querySelector('input[name*="[field_type]"]').name.match(/\[form_fields_attributes\]\[(\d+)\]/)[1]
  const fieldType = fieldItem.dataset.fieldType
  
  let inputGroupPrefix = ''
  if (fieldType === 'radio' || fieldType === 'checkbox') {
    inputGroupPrefix = `
      <span class="input-group-text">
        <input type="${fieldType}" disabled>
      </span>
    `
  }
  
  const newChoice = `
    <div class="choice-item">
      <div class="input-group mb-2">
        ${inputGroupPrefix}
        <input type="text" 
               name="form[form_fields_attributes][${fieldId}][options][choices][]" 
               class="form-control" 
               placeholder="Enter choice">
        <button type="button" 
                class="btn btn-outline-danger" 
                onclick="removeChoice(this)">
          <i class="fas fa-times"></i>
        </button>
      </div>
    </div>
  `
  choicesContainer.insertAdjacentHTML('beforeend', newChoice)
  
  // Add blur event listener to the new choice input
  const newInput = choicesContainer.lastElementChild.querySelector('input[type="text"]')
  newInput.addEventListener('blur', () => updatePreview(newInput))
  
  // Update preview after adding choice
  updatePreview(button)
}

function removeChoice(button) {
  const choiceItem = button.closest('.choice-item')
  const choicesContainer = choiceItem.closest('.choices-container')
  
  if (choicesContainer.querySelectorAll('.choice-item').length > 1) {
    choiceItem.remove()
  }
  
  // Update preview after removing choice
  updatePreview(button)
}

function deleteField(button) {
  const field = button.closest('.form-field-item')
  field.remove()
  
  const formFields = document.getElementById('form-fields')
  if (formFields.querySelectorAll('.form-field-item').length === 0) {
    const emptyStateHTML = `
      <div class="empty-state">
        <i class="fas fa-layer-group mb-3"></i>
        <p>Start building your form by adding fields</p>
      </div>
    `
    formFields.innerHTML = emptyStateHTML
    formFields.classList.remove('has-fields')
  }
}

function updatePreview(field) {
  const fieldItem = field.closest('.form-field-item')
  const fieldType = fieldItem.dataset.fieldType
  const previewContent = fieldItem.querySelector('.field-preview .preview-content')
  const labelInput = fieldItem.querySelector('input[name*="[label]"]')
  const label = labelInput?.value || 'Field Label'
  const required = fieldItem.querySelector('input[name*="[required]"]').checked

  let preview = ''
  
  switch(fieldType) {
    case 'text':
      const placeholder = fieldItem.querySelector('input[name*="[placeholder]"]')?.value || ''
      preview = `
        <div class="form-group">
          <label class="form-label">${label}${required ? ' *' : ''}</label>
          <input type="text" class="form-control" placeholder="${placeholder}">
        </div>
      `
      break
      
    case 'textarea':
      const rows = fieldItem.querySelector('input[name*="[rows]"]')?.value || 3
      preview = `
        <div class="form-group">
          <label class="form-label">${label}${required ? ' *' : ''}</label>
          <textarea class="form-control" rows="${rows}"></textarea>
        </div>
      `
      break
      
    case 'select':
      const choices = Array.from(fieldItem.querySelectorAll('.choices-container input[type="text"]'))
        .map(input => input.value)
        .filter(value => value.trim() !== '')
      const multiple = fieldItem.querySelector('input[name*="[multiple]"]')?.checked
      preview = `
        <div class="form-group">
          <label class="form-label">${label}${required ? ' *' : ''}</label>
          <select class="form-select" ${multiple ? 'multiple' : ''}>
            ${choices.length > 0 
              ? choices.map(choice => `<option>${choice || 'Option'}</option>`).join('')
              : '<option>Add some choices...</option>'}
          </select>
        </div>
      `
      break
      
    case 'radio':
    case 'checkbox':
      const inputChoices = Array.from(fieldItem.querySelectorAll('.choices-container input[type="text"]'))
        .map(input => input.value.trim())
      
      preview = `
        <div class="form-group">
          <label class="form-label">${label}${required ? ' *' : ''}</label>
          ${inputChoices.length > 0 
            ? inputChoices.map(choice => `
                <div class="form-check">
                  <input class="form-check-input" type="${fieldType}">
                  <label class="form-check-label">${choice || 'Enter choice'}</label>
                </div>
              `).join('')
            : `<div class="text-muted small">Add some choices...</div>`}
        </div>
      `
      break
  }
  
  if (previewContent) {
    previewContent.innerHTML = preview
  } else {
    console.error('Preview content element not found!')
  }
}

function addField(button) {
  const fieldType = button.dataset.fieldType
  
  const template = document.getElementById('field-template').innerHTML
  const timestamp = new Date().getTime()
  
  // Define field type specific details
  const fieldDetails = {
    text: { icon: 'fa-font', label: 'Text Field', options: 'text-options' },
    textarea: { icon: 'fa-paragraph', label: 'Long Text', options: 'textarea-options' },
    select: { icon: 'fa-list', label: 'Select', options: 'select-options' },
    radio: { icon: 'fa-dot-circle', label: 'Radio Buttons', options: 'radio-options' },
    checkbox: { icon: 'fa-check-square', label: 'Checkboxes', options: 'checkbox-options' }
  }
  
  const newField = template
    .replace(/NEW_RECORD/g, timestamp)
    .replace(/FIELD_TYPE/g, fieldType)
    .replace(/TYPE_ICON/g, fieldDetails[fieldType].icon)
    .replace(/TYPE_LABEL/g, fieldDetails[fieldType].label)
  
  const formFields = document.getElementById('form-fields')
  formFields.insertAdjacentHTML('beforeend', newField)
  
  const addedField = formFields.lastElementChild
  
  // Add initial choice for checkbox and radio fields
  if (fieldType === 'checkbox' || fieldType === 'radio') {
    const choicesContainer = addedField.querySelector('.choices-container')
    const addChoiceButton = addedField.querySelector('.btn-outline-primary')
    if (choicesContainer.children.length === 0) {
      addChoice(addChoiceButton) // Add first choice only if none exist
    }
  }
  
  // Show the appropriate options section
  const options = addedField.querySelectorAll('.field-options')
  options.forEach(option => {
    if (option.classList.contains(fieldDetails[fieldType].options)) {
      option.style.display = 'grid'
    } else {
      option.style.display = 'none'
    }
  })

  // For select fields, add the multiple selection option
  if (fieldType === 'select') {
    const multipleOption = `
      <div class="form-check mt-3 multiple-option">
        <input type="checkbox" 
               name="form[form_fields_attributes][${timestamp}][multiple]" 
               id="form_form_fields_attributes_${timestamp}_multiple" 
               class="form-check-input">
        <label class="form-check-label" for="form_form_fields_attributes_${timestamp}_multiple">
          Allow multiple selections
        </label>
      </div>
    `
    const choiceOptions = addedField.querySelector('.select-options')
    choiceOptions.insertAdjacentHTML('beforeend', multipleOption)
  }
  
  const emptyState = formFields.querySelector('.empty-state')
  if (emptyState) emptyState.remove()
  formFields.classList.add('has-fields')
  
  // Initialize field with preview and event listeners
  initializeField(addedField)
  
  // Add event listeners for preview updates
  addedField.querySelectorAll('input, textarea, select').forEach(input => {
    input.addEventListener('input', () => updatePreview(input))
    input.addEventListener('change', () => updatePreview(input))
  })
}

// Add this function to initialize preview when field is added
function initializeField(field) {
  // Add blur event listeners to all choice inputs
  field.querySelectorAll('.choices-container input[type="text"]').forEach(input => {
    input.addEventListener('blur', () => updatePreview(input))
  })
  
  // Add input event listener to label field
  const labelInput = field.querySelector('input[name*="[label]"]')
  if (labelInput) {
    labelInput.addEventListener('input', () => updatePreview(labelInput))
  }
  
  // Update initial preview
  updatePreview(field)
}