class AddTime < ActiveRecord::Migration
	def change
		change_table :routes do |t|
			t.integer :time
		end
	end
end
