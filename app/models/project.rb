class Project < ActiveRecord::Base
	has_many :tasks
	
	validates :title, 
	presence: { message: "入力してください" },
	length: { minimum:2, maximum:100, message: "２文字以上１００文字以内で入力してください" }
	#length: { minimum:3, message: "２文字以上で入力してください" },
	#length: { maximum:10, message: "１０文字以内で入力してください" }
end
