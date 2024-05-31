# frozen_string_literal: true

ActiveAdmin.register Doctor do
  controller do
    def scoped_collection
      super.doctors
    end
  end

  permit_params do
    permitted = %i[phone password role password_confirmation]
    permitted
  end

  action_item '', only: :show do
    if authorized?(:change_doctor_categoty)
      link_to 'Change Category',
              change_doctor_categoty_admin_doctor_path(resource),
              class: 'modal-link',
              data: {
                method: :patch,
                inputs: {
                  'Doctor category': DoctorCategory.pluck(:name, :id).push(['blank', nil])
                }.to_json
              }
    end
  end

  index download_links: false do
    id_column
    column :phone
    column :category
    column :created_at
    column :updated_at
    actions do |row|
      link_to 'Change Category',
              change_doctor_categoty_admin_doctor_path(row),
              class: 'modal-link',
              data: {
                method: :patch,
                inputs: {
                  'Doctor category': DoctorCategory.pluck(:name, :id).push(['blank', nil])
                }.to_json
              }
    end
  end

  show do
    attributes_table do
      row :id
      row :phone
      row :doctor_category
    end
  end

  form do |f|
    f.inputs do
      f.input :phone, input_html: { autofocus: :autofocus }
      f.input :password
      f.input :password_confirmation
      f.input :role, as: :hidden, input_html: { value: User::CONST::DOCTOR_ROLE_NAME }
    end

    f.actions
  end

  member_action :change_doctor_categoty, method: :patch do
    doctor_category_id = params.fetch('Doctor category')
    resource.update!(doctor_category_id:)
    flash[:notice] = 'The categoty was successfully changed'

    redirect_back(fallback_location: admin_dashboard_path)
  end
end
