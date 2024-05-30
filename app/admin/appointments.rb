# frozen_string_literal: true

ActiveAdmin.register Appointment do
  permit_params do
    %i[user_id status recommendation]
  end
end
