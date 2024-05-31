# frozen_string_literal: true

###
# The main policy file that determinate who can receive access to specifiuc action in admin panel
class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user

    if user.admin?
      admin_abilities(user)
    elsif user.doctor?
      doctor_abilities(user)
    elsif user.patient?
      patient_abilities(user)
    end
  end

  def admin_abilities(_user)
    can :manage, :all
  end

  def doctor_abilities(user)
    can :manage, ActiveAdmin::Page, name: 'Dashboard'
    can :manage, DoctorCategory
    can :manage, Doctor
    can :manage, Appointment, doctor_id: user.id
  end

  def patient_abilities(_user)
    can :manage, ActiveAdmin::Page, name: 'Dashboard'
    can :read, Doctor, role: 'doctor'
    can :destroy, Appointment
  end
end
