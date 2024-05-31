# frozen_string_literal: true

class AddAdminUser < ActiveRecord::Migration[7.1]
  def up
    User.create(phone: '111', password: Rails.application.credentials.admin_user_password, role: :admin)
  end

  def down
    User.delete_by(phone: '111')
  end
end
