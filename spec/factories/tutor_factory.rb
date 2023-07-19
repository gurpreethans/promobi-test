# frozen_string_literal: true

FactoryBot.define do
  factory :tutor do
    name { 'Adam' }
    email { 'adam@example.com' }
    association :course, factory: :course
  end
end
