class KittensController < ApplicationController

	def index
		@kittens = Kitten.all
		respond_to do |format|
			format.html
			format.json { render :json => @kittens }
		end
	end

	def show
		@kitten = Kitten.find(params[:id])
		respond_to do |format|
			format.html
			format.json { render :json => @kitten }
		end
	end

	def new
		@kitten = Kitten.create
	end

	def create
		@kitten = Kitten.create(kitten_params)
		if @kitten.save
			flash[:success] = "Kitten successfully registered!"
			redirect_to @kitten
		else
			flash.now[:error] = "Are you sure you have a kitten? If so, enter all the info."
			render :new
		end
	end

	def edit
		@kitten = Kitten.find(params[:id])
	end

	def update
		@kitten = Kitten.find(params[:id])
		if @kitten.update_attributes(kitten_params)
			flash[:success] = "Kitten successfully updated!"
			redirect_to @kitten
		else
			flash.now[:error] = "Are you sure you know this kitten? If so, enter all the info."
			render :edit
		end
	end

	def destroy
		Kitten.find(params[:id]).destroy
		flash[:success] = "Kitten successfully deleted!"
		redirect_to root_url
	end

	private

	def kitten_params
		params.require(:kitten).permit(:name, :age, :cuteness, :softness)
	end
end
