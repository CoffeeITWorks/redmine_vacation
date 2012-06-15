require_dependency 'user'

module VacationUserPatch
  def self.included(base)
    base.extend(ClassMethods)
    
    base.send(:include, InstanceMethods)
    
    base.class_eval do
      named_scope :not_vacation_manager, lambda {
        { :conditions => ["#{User.table_name}.id NOT IN (SELECT vacation_managers.user_id FROM vacation_managers)"] }
      }    
    end

  end
    
  module ClassMethods
  end
  
  module InstanceMethods
    def is_vacation_manager?
      VacationManager.find_by_user_id(self.id).present?
    end
  end
end