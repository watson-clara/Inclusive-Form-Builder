# Inclusive Form Builder

A user-friendly form builder focused on accessibility and inclusivity.

## Status
🚧 This project is still being actively developed and debugged. Major features like the form preview functionality are being refined.

## Features (In Progress)
- Drag-and-drop form building
- Multiple field types (text, textarea, select, radio, checkbox)
- Real-time preview
- Accessibility-first design
- Form validation
- Response collection

## Features

- **Accessible Form Creation**
  - WCAG 2.1 compliant forms (in progress)
  - Screen reader friendly
  - Keyboard navigation support
  - Clear error messages
  - Help text for form fields

- **Multilingual Support** (in progress)
  - Automatic translation of form fields
  - Support for multiple languages including:
    - English
    - Spanish
    - French
  - Language preference settings for users

- **Form Field Types**
  - Text input
  - Text area
  - Select dropdown
  - Radio buttons
  - Checkboxes

- **Form Management**
  - Create and edit forms
  - Preview forms
  - Track form submissions
  - Form status management (active/inactive)

## Technical Stack

- **Backend**
  - Ruby 3.2
  - Rails 8.0
  - PostgreSQL database

- **Frontend**
  - Bootstrap 5
  - Stimulus.js
  - Hotwire/Turbo
  - Font Awesome icons

## Getting Started

1. **Prerequisites**
   ```bash
   ruby 3.2.0
   postgresql
   ```

2. **Installation**
   ```bash
   # Clone the repository
   git clone https://github.com/watson-clara/inclusive-form-builder.git
   cd inclusive-form-builder

   # Install dependencies
   bundle install

   # Setup database
   rails db:create db:migrate db:seed
   ```

3. **Running the Application**
   ```bash
   # Start the Rails server
   rails server
   ```

4. Visit `http://localhost:3000` in your browser

## Sample Accounts

The seed data includes these test accounts:

| Role     | Email               | Password |
|----------|---------------------|----------|
| Admin    | admin@example.com   | password |
| Provider | provider@example.com| password |
| Patient  | patient@example.com | password |

## Accessibility Features (in progress)

- ARIA labels and descriptions
- Semantic HTML structure
- Keyboard navigation support
- Clear error messages
- Form field help text

## Multilingual Support (in progress)

Forms can be translated into multiple languages:
- English (default)
- Spanish
- French

## License

This project is licensed under the MIT License - see the LICENSE.md file for details

## Acknowledgments

- Bootstrap for the UI framework
- Font Awesome for icons
- The Rails community for inspiration and support

## Contributing
As this is an active work in progress, please feel free to open issues for bugs or feature requests.
