# frozen_string_literal: true

if Rails.env.development?
  User.create!(phone: '380970000000', password: 'password', password_confirmation: 'password', role: 'admin')
end
