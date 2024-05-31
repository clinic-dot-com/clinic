# frozen_string_literal: true

class AddDefaultValueToUsers < ActiveRecord::Migration[7.1]
  def change
    change_column_default :users, :role, from: nil, to: User::CONST::DEFAULT_ROLE
  end
end
