# frozen_string_literal: true

ActiveAdmin.register Appointment do
  permit_params do
    %i[user_id status recommendation]
  end

  filter :status

  controller do
    def destroy
      super do |success, failed|
        success.html do
          flash[:notice] = 'The Appointment was successfully destroyd.'
          redirect_back(fallback_location: admin_dashboard_path)
        end

        failed.html do
          flash[:error] = resource.errors.full_messages.join(', ')
          redirect_back(fallback_location: admin_dashboard_path)
        end
      end
    end
  end

  form do |f|
    f.inputs do
      if current_user.patient?
        f.input :doctor, as: :select,
                         collection: User.doctors.pluck(:phone, :id),
                         hint: 'Select phone number of your doctor'

        f.input :status, as: :hidden, input_html: { value: 'new' }
        f.input :user_id, as: :hidden, input_html: { value: current_user.id }
      end

      f.input :recommendation if current_user.doctor?
    end

    f.actions
  end

  member_action :leave_appointment, method: :post do
    recommendation = params.fetch(:recommendation)
    if recommendation.present?
      resource.update!(recommendation:)
      flash[:notice] = 'The recommendation was successfully created'
    else
      flash[:error] = 'The recommendation is not specified'
    end

    redirect_back(fallback_location: admin_dashboard_path)
  end

  member_action :submit_create_appointment, method: :post do
    authorize!(:submit_create_appointment)
    appointment_date = params.fetch('Date').presence || Date.today
    doctor_id = params.fetch('Desired Doctor')
    @form = Appointment.new(user_id: current_user.id, appointment_date:, doctor_id:, status: 'new')
    doctor = Doctor.find(doctor_id)
    raise "The #{doctor.display_name} is not available at the moment" if doctor.patients.count >= 10

    @form.save!
    flash[:notice] = 'The appointment was successfully created'
  rescue ActiveRecord::RecordInvalid => e
    flash[:error] = e.message
  rescue StandardError => e
    flash[:error] = e.message
  ensure
    redirect_to admin_dashboard_path
  end
end
