function addChoice(button) {
  const choicesContainer = button.closest('.choice-options').querySelector('.choices-container')
  const fieldItem = button.closest('.form-field-item')
  const fieldId = fieldItem.querySelector('input[name*="[field_type]"]').name.match(/\[form_fields_attributes\]\[(\d+)\]/)[1]
  
  const newChoice = `
    <div class="choice-item">
      <div class="input-group mb-2">
        <input type="text" 
               name="form[form_fields_attributes][${fieldId}][options][choices][]" 
               class="form-control" 
               placeholder="Enter choice"
               onchange="updatePreview(this)">
        <button type="button" 
                class="btn btn-outline-danger" 
                onclick="removeChoice(this)">
          <i class="fas fa-times"></i>
        </button>
      </div>
    </div>
  `
  choicesContainer.insertAdjacentHTML('beforeend', newChoice)
  updatePreview(button)
}

function removeChoice(button) {
  const choiceItem = button.closest('.choice-item')
  const choicesContainer = choiceItem.closest('.choices-container')
  
  if (choicesContainer.querySelectorAll('.choice-item').length > 1) {
    choiceItem.remove()
    updatePreview(button)
  }
}

function updatePreview(element) {
  const fieldElement = element.closest('.form-field-item')
  const fieldType = fieldElement.dataset.fieldType
  const previewContainer = fieldElement.querySelector('.field-preview')
  const choices = Array.from(fieldElement.querySelectorAll('.choice-options input[type="text"]'))
    .map(input => input.value)
    .filter(value => value.trim() !== '')
  const isMultiple = fieldElement.querySelector('.multiple-option input[type="checkbox"]').checked

  switch(fieldType) {
    case 'select':
      previewContainer.innerHTML = `
        <select class="form-control" ${isMultiple ? 'multiple' : ''} disabled>
          ${choices.length > 0 
            ? choices.map(choice => `<option>${choice}</option>`).join('')
            : '<option>Select an option</option>'
          }
        </select>
      `
      break
    case 'radio':
      previewContainer.innerHTML = choices.map(choice => `
        <div class="form-check">
          <input class="form-check-input" type="radio" disabled>
          <label class="form-check-label">${choice}</label>
        </div>
      `).join('') || `
        <div class="form-check">
          <input class="form-check-input" type="radio" disabled>
          <label class="form-check-label">Radio option</label>
        </div>
      `
      break
    case 'checkbox':
      previewContainer.innerHTML = choices.map(choice => `
        <div class="form-check">
          <input class="form-check-input" type="checkbox" disabled>
          <label class="form-check-label">${choice}</label>
        </div>
      `).join('') || `
        <div class="form-check">
          <input class="form-check-input" type="checkbox" disabled>
          <label class="form-check-label">Checkbox option</label>
        </div>
      `
      break
  }
}

function deleteField(button) {
  const field = button.closest('.form-field-item')
  field.remove()
  
  const formFields = document.getElementById('form-fields')
  // If no fields left, show empty state
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

function addField(button) {
  const fieldType = button.dataset.fieldType
  const template = document.getElementById('field-template').innerHTML
  const timestamp = new Date().getTime()
  const newField = template
    .replace(/NEW_RECORD/g, timestamp)
    .replace(/FIELD_TYPE/g, fieldType)
  
  const formFields = document.getElementById('form-fields')
  formFields.insertAdjacentHTML('beforeend', newField)
  
  // Remove empty state if it exists
  const emptyState = formFields.querySelector('.empty-state')
  if (emptyState) emptyState.remove()
  formFields.classList.add('has-fields')
} 