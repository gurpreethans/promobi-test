# frozen_string_literal: true

require 'rails_helper'
RSpec.describe 'Courses', type: :request do
  let(:headers) do
    {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json'
    }
  end

  let(:course) { FactoryBot.create(:course) }
  let!(:tutor) { FactoryBot.create(:tutor, course:) }

  describe 'GET' do
    context 'when listing courses' do
      it 'returns courses' do
        get courses_path, headers: headers
        expect(response.status).to eq(200)
        data = JSON.parse response.body
        expect(data.count).to eq(1)
      end
    end
  end

  describe 'POST' do
    context 'when creating course with invalid data' do
      it 'returns error' do
        post courses_path, params: { course: { name: '' } }.to_json, headers: headers
        expect(response.status).to eq(422)
        data = JSON.parse response.body
        expect(data['name'].first).to eq("can't be blank")
      end
    end

    context 'when creating course with invalid tutor data' do
      it 'returns error' do
        post courses_path, params: { course: { name: 'MBA', tutors: [{ name: '' }] } }.to_json, headers: headers
        expect(response.status).to eq(422)
        data = JSON.parse response.body
        tutors = data['tutors'].first
        expect(tutors['name'].first).to eq("can't be blank")
        expect(tutors['email'].first).to eq("can't be blank")
      end
    end

    context 'when creating course with valid data' do
      it 'creates course' do
        post courses_path, params: { course: { name: 'MBA' } }.to_json, headers: headers
        expect(response.status).to eq(200)
        data = JSON.parse response.body
        expect(data['name']).to eq('MBA')
      end
    end

    context 'when creating course with valid tutor data' do
      it 'creates course and tutor' do
        post courses_path,
             params: { course: { name: 'MBA', tutors: [{ name: 'Adam', email: 'adam@google.com' }] } }.to_json, headers: headers
        expect(response.status).to eq(200)
        data = JSON.parse response.body
        expect(data['name']).to eq('MBA')
        tutor = data['tutors'].first
        expect(tutor['name']).to eq('Adam')
        expect(tutor['email']).to eq('adam@google.com')
      end
    end

    context 'when creating course with valid duplicate tutor' do
      it 'creates course only' do
        post courses_path, params: { course: { name: 'MBA', tutors: [{ name: 'Adam', email: tutor.email }] } }.to_json,
                           headers: headers
        expect(response.status).to eq(200)
        data = JSON.parse response.body
        expect(data['name']).to eq('MBA')
        expect(data['tutors']).to be_empty
      end
    end

    context 'when creating course with valid duplicate and new tutor' do
      it 'creates course with single tutor' do
        post courses_path,
             params: { course: { name: 'MBA', tutors: [{ name: 'Adam', email: tutor.email }, { name: 'Adam', email: 'adam@google.com' }] } }.to_json, headers: headers
        expect(response.status).to eq(200)
        data = JSON.parse response.body
        expect(data['name']).to eq('MBA')
        expect(data['tutors'].count).to eq(1)
      end
    end
  end
end
