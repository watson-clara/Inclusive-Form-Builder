# Inclusive Form Builder

A customizable form-building tool designed for healthcare providers to collect patient information with accessibility and multilingual support.

## Features

- **Accessible Form Creation**: Build forms that follow WCAG 2.1 guidelines
- **Multilingual Support**: Automatic translation of form fields and instructions
- **Customizable Fields**: Various field types including text, select, checkbox, radio, date, etc.
- **Responsive Design**: Works on all devices using Bootstrap
- **Form Management**: Create, edit, preview, and manage form submissions

## Technical Stack

- Ruby on Rails
- PostgreSQL
- Bootstrap 5
- jQuery

## Getting Started

1. Clone the repository
2. Install dependencies: `bundle install`
3. Set up the database: `rails db:create db:migrate db:seed`
4. Start the server: `rails server`
5. Visit http://localhost:3000 in your browser

## Sample Accounts

The seed data includes the following accounts for testing:

- **Admin**: admin@example.com / password
- **Provider**: provider@example.com / password
- **Patient**: patient@example.com / password

## Accessibility Features

- ARIA attributes for screen readers
- Keyboard navigation support
- High contrast mode
- Clear error messages
- Help text for form fields

## Multilingual Support

Forms can be translated into multiple languages including:
- English
- Spanish
- French
- And more...
