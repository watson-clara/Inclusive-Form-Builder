class FormSubmission < ApplicationRecord
  belongs_to :form
  belongs_to :user, optional: true
  
  validates :data, presence: true
  validates :status, inclusion: { in: %w(draft submitted reviewed completed) }
  
  def complete!
    update(status: 'completed')
  end
  
  def review!
    update(status: 'reviewed')
  end
end 