# frozen_string_literal: true

module CoursePresenter
  def self.single(course)
    {
      id: course.id,
      name: course.name,
      tutors: tutors(course)
    }
  end

  def self.tutors(course)
    course.tutors.map do |tutor|
      {
        id: tutor.id,
        name: tutor.name,
        email: tutor.email
      }
    end
  end

  def self.list(courses)
    courses.map do |course|
      single(course)
    end
  end
end
