# frozen_string_literal: true

class ChangePhone < ActiveRecord::Migration[7.1]
  def up
    User.delete_by(phone: '111')
    User.create(phone: '380970000000', password: Rails.application.credentials.admin_user_password, role: :admin)
  end

  def down
    User.delete_by(phone: '380970000000')
    User.create(phone: '111', password: Rails.application.credentials.admin_user_password, role: :admin)
  end
end
