class AdminpanelController < ApplicationController
	before_action do
		unless current_user && current_user.admin?
			flash[:alert] = "Secured!"
			redirect_to root_path
		end
	end

	def admin
	end
end
