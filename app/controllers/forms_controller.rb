class FormsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_form, only: [:show, :edit, :update, :destroy, :preview, :translate]
  before_action :authorize_form, only: [:edit, :update, :destroy]
  
  def index
    @forms = current_user.provider? ? Form.all : current_user.forms
  end
  
  def show
    @language = params[:language] || current_user.preferred_language || 'en'
    @form.translate_to(@language) if @language != 'en'
  end
  
  def new
    @form = Form.new
  end
  
  def create
    @form = current_user.forms.new(form_params)
    
    if @form.save
      redirect_to @form, notice: 'Form was successfully created.'
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @form.update(form_params)
      redirect_to @form, notice: 'Form was successfully updated.'
    else
      render :edit
    end
  end
  
  def destroy
    @form.destroy
    redirect_to forms_path, notice: 'Form was successfully deleted.'
  end
  
  def preview
    @language = params[:language] || current_user.preferred_language || 'en'
    @form.translate_to(@language) if @language != 'en'
    render :preview, layout: 'form_preview'
  end
  
  def translate
    language = params[:language]
    if language.present?
      @form.translate_to(language)
      redirect_to form_path(@form, language: language), notice: "Form translated to #{language}"
    else
      redirect_to @form, alert: 'Language parameter is required'
    end
  end
  
  private
  
  def set_form
    @form = Form.find(params[:id])
  end
  
  def authorize_form
    unless current_user.admin? || @form.user_id == current_user.id
      redirect_to forms_path, alert: 'You are not authorized to perform this action.'
    end
  end
  
  def form_params
    params.require(:form).permit(:title, :description, :active)
  end
end 