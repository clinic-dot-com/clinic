# frozen_string_literal: true

ActiveAdmin.register_page 'Dashboard' do
  menu priority: 1, label: proc { I18n.t('active_admin.dashboard') }

  action_item '' do
    link_to 'Create Appointment', create_appointment_form_admin_appointment_path(id: current_user.id)
  end

  content title: proc { I18n.t('active_admin.dashboard') } do
    if current_user.patient?
      columns do
        column do
          panel 'your Appointments' do
            collection_of_app = Appointment.where(user: current_user)

            if collection_of_app.any?
              table_for collection_of_app do
                column :id
                column :doctor
                column 'actions' do |row|
                  link_to 'Delete', admin_appointment_path(row), method: :delete
                end
              end
            else
              div class: 'blank_slate_container', id: 'dashboard_default_message' do
                span class: 'blank_slate' do
                  small 'There is no any Appointment assigned to you'
                end
              end
            end
          end
        end
        column do
          panel 'Your recomendations from doctors' do
            collection_of_recomendation = Appointment.where('user_id = ? AND recommendation IS NOT NULL',
                                                            current_user.id)

            if collection_of_recomendation.any?
              table_for collection_of_recomendation do
                column 'Recomendation from' do |appointment|
                  appointment.doctor.phone
                end
                column :recommendation
              end
            else
              div class: 'blank_slate_container', id: 'dashboard_default_message' do
                span class: 'blank_slate' do
                  small 'There is no any Recommendations'
                end
              end
            end
          end
        end
      end
    end
  end
end
