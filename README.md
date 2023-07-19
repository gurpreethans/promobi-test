# Course and Tutor APP

App support API only and you can create course with tutors in single API endpoint.

## Features

- Course with tutors can be created in single request
- Course can be created without tutor (We can add validation if needed)
- Tutor can opt only one course at a time
- If passing existing tutor details, backend will ignore the latest details and keep the existing one as is
- If you pass two tutor details like existing and new one, course will be assigned to new tutor and existing one will be ignored

## Tech Stack

- Rails 7
- Ruby 3.1.2
- Sqlite 3
- Multi JSON
- Active Record Import



## Installation and Setup

```sh
git clone git@github.com:gurpreethans/emeritus-test.git
cd emeritus-test
Install and Setup Ruby 3.1.2 - Rbenv or RVM
gem install bundler
bundle install
rails db:setup
rails s
```

## Run Tests
```sh
bundle exec rspec spec
```

## To Do List
- Add pagination to the listing API
- Integrate parallel testing for performance
