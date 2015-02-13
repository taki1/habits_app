class Habit < ActiveRecord::Base
  belongs_to :user
  has_many :results

  validates :user_id, presence: true
  validates :target, 
#    presence: { message: "入力してください" },
#	length: { minimum:1, maximum:255, message: "２５５文字以内で入力してください" }
    presence: {  },
	length: { maximum:255 }
#	length: { minimum:1, maximum:255 }
#	length: { :in => 1..255 }
#  validates :start_at, presence: { message: "入力してください" }
  validates :start_at,
#   length: { minimum:10, maximum:10 },
   length: { minimum:10 },
   timeliness: { on_or_before: :end_at, format: '%Y/%m/%d' }
  validates :end_at, 
   length: { minimum:10 },
   timeliness: { on_or_after: :start_at, format: '%Y/%m/%d' }, allow_blank: false
  #validates :end_at , presence: { message: "入力してください" }

#  scope :done, -> { joins(:results).where("result=1") }
end
