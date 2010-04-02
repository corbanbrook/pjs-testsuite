class Platform < ActiveRecord::Base
  def name_and_version
    name + " " + version
  end
end
