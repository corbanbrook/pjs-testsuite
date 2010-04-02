class Test < ActiveRecord::Base
  belongs_to :configuration
  belongs_to :example
  belongs_to :user
  
  named_scope :completed, :conditions => { :is_complete => true }
  named_scope :uncompleted, :conditions => { :is_complete => false }
  named_scope :passed, :conditions => { :pass => true }
  named_scope :failed, :conditions => { :pass => false }
end
