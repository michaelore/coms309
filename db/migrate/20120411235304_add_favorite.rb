class AddFavorite < ActiveRecord::Migration
	def change
		change_table :ratings do |t|
			t.integer :favorite
		end
	end
end
