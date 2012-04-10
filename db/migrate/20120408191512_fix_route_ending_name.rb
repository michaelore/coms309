class FixRouteEndingName < ActiveRecord::Migration
	def change
		rename_column :routes, :end_id, :ending_id
	end
end
