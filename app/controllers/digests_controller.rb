class DigestsController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: [:create]

	def create
    render nothing: true, status: 200
	end
end
