class Instrument < ApplicationRecord
	before_destroy :not_referenced_by_any_line_item
	mount_uploader :image, ImageUploader
	serialize :image, JSON
	belongs_to :user,optional: true
	has_many :line_items


	validates :title,:brand,:model,:price, presence: true
	validates :description,length:{maximum: 1000,too_long:"%{count}characters is the maximum allowed"}
	validates :title, length:{maximum: 100,too_long:"%{count}characters is maximum allowed"}
	validates :price, length:{maximum: 7}


	BRAND = %w{ Samsung Redmi Realme Vivo Oppo Nokia Oneplus Moto}
	COLOR = %w{ Black Red Blue White }
	CONDITION = %w{ New Excellent Used Poor Good }



	private
	def not_referenced_by_any_line_item
		unless line_items.empty?
			errors.add(:base,"Line items present")

			throw :abort
		end
	end


end
