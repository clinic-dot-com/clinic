# frozen_string_literal: true

ActiveAdmin.register_page 'Dashboard' do
  menu priority: 1, label: proc { I18n.t('active_admin.dashboard') }

  action_item '' do
    if authorized?(:submit_create_appointment)
      link_to 'Create Appointment',
              submit_create_appointment_admin_appointment_path(id: current_user.id),
              class: 'modal-link',
              data: {
                method: :post,
                inputs: {
                  'Desired Doctor': User.doctors.map { |item| [item.display_name, item.id] },
                  'Date': :datepicker
                }.to_json
              }
    end
  end

  action_item '' do
    if authorized?(:change_doctor_categoty)
      link_to 'Change Category',
              change_doctor_categoty_admin_doctor_path(current_user),
              class: 'modal-link',
              data: {
                method: :patch,
                inputs: {
                  'Doctor category': DoctorCategory.pluck(:name, :id).unshift(['blank', nil])
                }.to_json
              }
    end
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
                column :appointment_date
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

    if current_user.doctor?
      columns do
        column do
          panel 'List of Appointments' do
            list_of_appointments = Appointment.where(doctor: current_user)

            if list_of_appointments.any?
              table_for list_of_appointments do
                column :id
                column :user
                column :created_at
                column :recommendation do |row|
                  if row.recommendation.present?
                    status_tag 'present'
                  else
                    link_to 'Leave recommendation',
                            leave_appointment_admin_appointment_path(id: row.id),
                            class: 'modal-link',
                            data: {
                              method: :post,
                              inputs: {
                                recommendation: :text
                              }.to_json
                            }
                  end
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
      end
    end
  end
end
