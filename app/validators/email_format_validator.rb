# frozen_string_literal: true

class EmailFormatValidator < ActiveModel::EachValidator
  FORMAT = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  def validate_each(record, attribute, value)
    record.errors.add(attribute, options[:message] || 'is invalid') unless value =~ FORMAT

    record
  end
end
