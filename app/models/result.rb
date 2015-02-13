class Result < ActiveRecord::Base
  belongs_to :habit
  scope :finished, -> { where(result: 1) }
end
