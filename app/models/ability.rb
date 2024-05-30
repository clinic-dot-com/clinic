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
    can :read, :all
    can :update, User, id: user.id
    can :manage, Appointment, doctor_id: user.id
  end

  def patient_abilities(user)
    can :read, Doctor
    can :manage, Appointment, user_id: user.id
    can :read, User, id: user.id
    can :create, User
  end
end
