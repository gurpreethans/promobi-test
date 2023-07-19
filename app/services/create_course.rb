# frozen_string_literal: true

class CreateCourse
  attr_reader :course

  def self.call(attributes)
    new(attributes).call
  end

  def initialize(attributes)
    @attributes = attributes
    @tutors = attributes.delete(:tutors)
  end

  def call
    ActiveRecord::Base.transaction do
      @course = create_course
      create_tutors
    end

    self
  end

  def create_course
    Course.create!(
      name: @attributes[:name]
    )
  end

  def create_tutors
    return if @tutors.empty?

    columns = %i[name email course_id]

    values = @tutors.map do |tutor|
      [tutor[:name], tutor[:email], @course.id]
    end

    tutors = Tutor.import(
      columns, values, on_duplicate_key_ignore: true
    )
  end
end
