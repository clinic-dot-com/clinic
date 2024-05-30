# frozen_string_literal: true

if Rails.env.development?
  User.ceate!(phone: '380970000000', password: 'password', password_confirmation: 'password', role: 'admin')
end
