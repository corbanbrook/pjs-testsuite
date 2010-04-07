class Test < ActiveRecord::Base
  belongs_to :configuration
  belongs_to :example
  belongs_to :user
  
  named_scope :completed, :conditions => { :is_complete => true }
  named_scope :uncompleted, :conditions => { :is_complete => false }
  named_scope :passed, :conditions => { :pass => true }
  named_scope :failed, :conditions => { :pass => false }, :order => "updated_at DESC"
  
  # make sure the user gives a reason why they failed a test
  validates_presence_of :note, :on => :update, :if => Proc.new { |test| test.pass == false }, :message => "You must enter a reason why the test failed in the notes section."
end
