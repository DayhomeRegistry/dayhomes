class Plan < ActiveRecord::Base
	belongs_to :product, class_name: '::Spree::Product', foreign_key: 'product_id'
end
