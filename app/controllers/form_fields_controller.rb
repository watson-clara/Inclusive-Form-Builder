class FormFieldsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_form
  before_action :set_form_field, only: [:edit, :update, :destroy]
  before_action :authorize_form
  
  def new
    @form_field = @form.form_fields.new
  end
  
  def create
    @form_field = @form.form_fields.new(form_field_params)
    
    if @form_field.save
      redirect_to edit_form_path(@form), notice: 'Field was successfully added.'
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @form_field.update(form_field_params)
      redirect_to edit_form_path(@form), notice: 'Field was successfully updated.'
    else
      render :edit
    end
  end
  
  def destroy
    @form_field.destroy
    redirect_to edit_form_path(@form), notice: 'Field was successfully removed.'
  end
  
  def sort
    params[:positions].each do |id, position|
      @form.form_fields.find(id).update(position: position)
    end
    
    head :ok
  end
  
  private
  
  def set_form
    @form = Form.find(params[:form_id])
  end
  
  def set_form_field
    @form_field = @form.form_fields.find(params[:id])
  end
  
  def authorize_form
    unless current_user.admin? || @form.user_id == current_user.id
      redirect_to forms_path, alert: 'You are not authorized to perform this action.'
    end
  end
  
  def form_field_params
    params.require(:form_field).permit(
      :field_type, :label, :description, :required, :position,
      options: [:placeholder, :min, :max, choices: {}],
      accessibility_attributes: [:aria_label, :aria_description, :help_text]
    )
  end
end 