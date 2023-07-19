# frozen_string_literal: true

class TutorForm
  include ActiveModel::Model

  attr_accessor :name, :email

  validates :name, presence: true
  validates :email, presence: true, email_format: true
  # validate :dupliacte_email

  def initialize(tutor, params = {})
    @name = params[:name] || tutor.name
    @email = params[:email] || tutor.email
  end

  def attributes
    {
      name:,
      email:
    }
  end

  def dupliacte_email
    errors.add(:email, 'already exists') if Tutor.exists?(email: @email)
  end
end
