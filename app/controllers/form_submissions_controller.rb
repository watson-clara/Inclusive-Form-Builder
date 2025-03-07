class FormSubmissionsController < ApplicationController
  before_action :set_form
  before_action :set_submission, only: [:show, :edit, :update, :destroy, :review, :complete]
  before_action :authenticate_user!, except: [:new, :create]
  
  def index
    authorize_form_owner
    @submissions = @form.form_submissions
  end
  
  def show
    authorize_submission
  end
  
  def new
    @submission = @form.form_submissions.new
    @language = params[:language] || I18n.locale.to_s
    @form.translate_to(@language) if @language != 'en'
  end
  
  def create
    @submission = @form.form_submissions.new(submission_params)
    @submission.user = current_user if user_signed_in?
    
    if @submission.save
      redirect_to form_submission_thank_you_path(@form), notice: 'Your form has been submitted successfully.'
    else
      @language = params[:language] || I18n.locale.to_s
      @form.translate_to(@language) if @language != 'en'
      render :new
    end
  end
  
  def edit
    authorize_submission
    @language = params[:language] || I18n.locale.to_s
    @form.translate_to(@language) if @language != 'en'
  end
  
  def update
    authorize_submission
    
    if @submission.update(submission_params)
      redirect_to form_submission_path(@form, @submission), notice: 'Submission was successfully updated.'
    else
      @language = params[:language] || I18n.locale.to_s
      @form.translate_to(@language) if @language != 'en'
      render :edit
    end
  end
  
  def destroy
    authorize_submission
    @submission.destroy
    redirect_to form_submissions_path(@form), notice: 'Submission was successfully deleted.'
  end
  
  def review
    authorize_form_owner
    @submission.review!
    redirect_to form_submission_path(@form, @submission), notice: 'Submission marked as reviewed.'
  end
  
  def complete
    authorize_form_owner
    @submission.complete!
    redirect_to form_submission_path(@form, @submission), notice: 'Submission marked as completed.'
  end
  
  def thank_you
  end
  
  private
  
  def set_form
    @form = Form.find(params[:form_id])
  end
  
  def set_submission
    @submission = @form.form_submissions.find(params[:id])
  end
  
  def authorize_form_owner
    unless current_user.admin? || @form.user_id == current_user.id
      redirect_to forms_path, alert: 'You are not authorized to view these submissions.'
    end
  end
  
  def authorize_submission
    unless current_user.admin? || @form.user_id == current_user.id || 
           (@submission.user_id.present? && @submission.user_id == current_user.id)
      redirect_to forms_path, alert: 'You are not authorized to view this submission.'
    end
  end
  
  def submission_params
    params.require(:form_submission).permit(data: {})
  end
end 