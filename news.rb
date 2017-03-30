class New_object
	attr_accessor :author, :title, :created, :url, :id
	def initialize (array)
		@author = array[0]
		@title = array[1]
		@created = array[2]
		@url = array[3]
		@id = array[4]
	end
end
	





