class SearchController < ApplicationController
	def search
		@search = params[:search]
		@options = params[:option]
		@ways = params[:way]

		if @options == "user"
			if @ways == "perfect"
				@users = User.where(name: "#{@search}")
			end
			if @ways == "front"
				@users = User.where('name LIKE ?', "#{@search}%")
			end
			if @ways == "behind"
				@users = User.where('name LIKE ?', "%#{@search}")
			end
			if @ways == "part"
				@users = User.where('name LIKE ?', "%#{@search}%")
			end
		end

		if @options == "book"
			if @ways == "perfect"
				@books = Book.where(body: "#{@search}")
			end
			if @ways == "front"
				@books = Book.where('body LIKE ?', "#{@search}%")
			end
			if @ways == "behind"
				@books = Book.where('body LIKE ?', "%#{@search}")
			end
			if @ways == "part"
				@books = Book.where('body LIKE ?', "%#{@search}%")
			end
		end
	end

end
