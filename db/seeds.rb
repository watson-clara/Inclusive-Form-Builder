# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Clear existing data
puts "Clearing existing data..."
FormSubmission.destroy_all
FormField.destroy_all
Form.destroy_all
User.destroy_all

# Create admin user
puts "Creating admin user..."
admin = User.create!(
  email: 'admin@example.com',
  name: 'Admin User',
  role: 'admin',
  password: 'password',
  password_confirmation: 'password'
)

# Create provider user
puts "Creating provider user..."
provider = User.create!(
  email: 'provider@example.com',
  name: 'Healthcare Provider',
  role: 'provider',
  password: 'password',
  password_confirmation: 'password'
)

# Create patient user
puts "Creating patient user..."
patient = User.create!(
  email: 'patient@example.com',
  name: 'John Patient',
  role: 'patient',
  preferred_language: 'es',
  password: 'password',
  password_confirmation: 'password'
)

# Create a sample form
puts "Creating sample medical history form..."
medical_history = provider.forms.create!(
  title: 'Medical History Form',
  description: 'Please complete this form to help us understand your medical history and provide better care.',
  active: true
)

# Add form fields
puts "Adding fields to medical history form..."

# Personal Information section
medical_history.form_fields.create!(
  field_type: 'text_field',
  label: 'Full Name',
  description: 'Enter your legal name as it appears on your ID',
  required: true,
  position: 1,
  accessibility_attributes: {
    'help_text' => 'Please enter your full legal name including first, middle (if applicable), and last name'
  }
)

medical_history.form_fields.create!(
  field_type: 'date',
  label: 'Date of Birth',
  required: true,
  position: 2
)

medical_history.form_fields.create!(
  field_type: 'select',
  label: 'Gender',
  position: 3,
  options: {
    'choices' => {
      'male' => 'Male',
      'female' => 'Female',
      'non_binary' => 'Non-binary',
      'other' => 'Other',
      'prefer_not_to_say' => 'Prefer not to say'
    }
  },
  accessibility_attributes: {
    'help_text' => 'Select the gender you identify with'
  }
)

medical_history.form_fields.create!(
  field_type: 'email',
  label: 'Email Address',
  required: true,
  position: 4
)

medical_history.form_fields.create!(
  field_type: 'text_field',
  label: 'Phone Number',
  position: 5
)

# Medical History section
medical_history.form_fields.create!(
  field_type: 'checkbox',
  label: 'Do you have any of the following conditions?',
  position: 6,
  options: {
    'choices' => {
      'diabetes' => 'Diabetes',
      'hypertension' => 'High Blood Pressure',
      'asthma' => 'Asthma',
      'heart_disease' => 'Heart Disease',
      'cancer' => 'Cancer',
      'arthritis' => 'Arthritis',
      'none' => 'None of the above'
    }
  },
  accessibility_attributes: {
    'help_text' => 'Check all conditions that apply to you'
  }
)

medical_history.form_fields.create!(
  field_type: 'radio',
  label: 'Do you smoke?',
  required: true,
  position: 7,
  options: {
    'choices' => {
      'yes' => 'Yes',
      'no' => 'No',
      'former' => 'Former smoker'
    }
  }
)

medical_history.form_fields.create!(
  field_type: 'text_area',
  label: 'List any medications you are currently taking',
  position: 8,
  accessibility_attributes: {
    'help_text' => 'Include prescription medications, over-the-counter medications, vitamins, and supplements'
  }
)

medical_history.form_fields.create!(
  field_type: 'text_area',
  label: 'Do you have any allergies?',
  position: 9,
  description: 'Include allergies to medications, foods, or environmental factors'
)

# Create a second form
puts "Creating sample patient intake form..."
patient_intake = admin.forms.create!(
  title: 'New Patient Intake Form',
  description: 'Welcome to our practice. Please fill out this form to help us get to know you better.',
  active: true
)

# Add form fields to second form
puts "Adding fields to patient intake form..."

patient_intake.form_fields.create!(
  field_type: 'text_field',
  label: 'Full Name',
  required: true,
  position: 1
)

patient_intake.form_fields.create!(
  field_type: 'text_field',
  label: 'Preferred Name',
  position: 2,
  description: 'If different from your legal name'
)

patient_intake.form_fields.create!(
  field_type: 'select',
  label: 'Preferred Language',
  position: 3,
  options: {
    'choices' => {
      'en' => 'English',
      'es' => 'Spanish',
      'fr' => 'French',
      'zh' => 'Chinese',
      'ar' => 'Arabic',
      'other' => 'Other'
    }
  },
  accessibility_attributes: {
    'help_text' => 'Select your preferred language for communication'
  }
)

patient_intake.form_fields.create!(
  field_type: 'radio',
  label: 'Do you need an interpreter?',
  position: 4,
  options: {
    'choices' => {
      'yes' => 'Yes',
      'no' => 'No'
    }
  }
)

patient_intake.form_fields.create!(
  field_type: 'text_area',
  label: 'What is your primary reason for visiting today?',
  required: true,
  position: 5,
  accessibility_attributes: {
    'help_text' => 'Briefly describe your symptoms or concerns'
  }
)

patient_intake.form_fields.create!(
  field_type: 'checkbox',
  label: 'How did you hear about us?',
  position: 6,
  options: {
    'choices' => {
      'referral' => 'Referral from another doctor',
      'friend' => 'Friend or family member',
      'insurance' => 'Insurance provider',
      'internet' => 'Internet search',
      'social_media' => 'Social media',
      'other' => 'Other'
    }
  }
)

# Create some sample submissions
puts "Creating sample form submissions..."

# Sample submission for medical history form
medical_history.form_submissions.create!(
  user: patient,
  data: {
    '1' => 'John Patient',
    '2' => '1985-04-15',
    '3' => 'male',
    '4' => 'patient@example.com',
    '5' => '555-123-4567',
    '6' => ['asthma', 'arthritis'],
    '7' => 'no',
    '8' => 'Albuterol inhaler as needed\nIbuprofen occasionally for joint pain',
    '9' => 'Penicillin - causes rash\nPollen - seasonal allergies'
  },
  status: 'submitted'
)

# Sample submission for patient intake form
patient_intake.form_submissions.create!(
  user: patient,
  data: {
    '1' => 'John Patient',
    '2' => 'Johnny',
    '3' => 'es',
    '4' => 'no',
    '5' => 'I have been experiencing lower back pain for the past two weeks, especially after sitting for long periods.',
    '6' => ['internet', 'friend']
  },
  status: 'reviewed'
)

# Translate forms to Spanish
puts "Translating forms to Spanish..."
medical_history.translate_to('es')
patient_intake.translate_to('es')

puts "Seed data created successfully!"
