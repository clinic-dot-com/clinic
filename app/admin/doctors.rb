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

  index download_links: false do
    id_column
    column :phone
    column :created_at
    column :updated_at
    actions
  end

  show do
    attributes_table do
      row :id
      row :phone
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
end
