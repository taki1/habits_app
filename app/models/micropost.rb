class Micropost < ActiveRecord::Base
	belongs_to :user

	#validates :content, length: { minimum:1, maximum:10 }
	validates :content, 
	length: { minimum:1, maximum:10, message: "1文字以上１０文字以内で入力してください" }
end
