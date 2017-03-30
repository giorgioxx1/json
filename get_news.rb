require 'json'
require 'rest-client'
require 'time'
require 'date'
require_relative 'news'



module GET_NEWS

	@@id = 1
	@@reddit = []
	@@mashable = []
	@@digg = []

	def self.id=
		puts @@id
		@@id = 1
		puts @@id
		@@reddit = []
		@@mashable = []
		@@digg = []
	end

	def self.reddit
		@@reddit 
	end

	def self.mashable
		@@mashable
	end

	def self.digg
		@@digg
	end

	def  self.get_reddit
		news = RestClient.get "https://www.reddit.com/.json"
		news_hash = JSON.parse(news)
		a = news_hash["data"]["children"]
		new_full = [ ]

		for i in 0..a.length-1 
			author = a[i]["data"]["author"] 
			title = a[i]["data"]["title"]
			created = a[i]["data"]["created"]
			url = a[i]["data"]["url"]

			created = Time.at(created).to_s
			created = created.split(" ")[0]
			created = created.split("-").reverse.join("-")

			new_full [i] = New_object.new([author,title,created,url,@@id])
			@@id+=1

		end
		new_full = new_full.sort_by {|hola| hola.created}
		new_full
		@@reddit = new_full
	end

	def self.get_mashable
		news = RestClient.get "http://mashable.com/stories.json"
		news_hash = JSON.parse(news)
		a = news_hash["new"]
		new_full = [ ]
		for i in 0..a.length-1 
			author = a[i]["author"] 
			title = a[i]["title"]
			post_date = a[i]["post_date"]
			post_date = post_date.to_s
			post_date = post_date.split("T")[0]
			post_date = post_date.split("-").reverse.join("-")
			link = a[i]["link"]
			new_full [i] = New_object.new([author,title,post_date,link,@@id])
			@@id+=1
		end
		new_full = new_full.sort_by {|hola| hola.created}
		new_full
		@@mashable = new_full
	end

	def self.get_digg
		news = RestClient.get "http://digg.com/api/news/popular.json"
		news_hash = JSON.parse(news)
		a = news_hash["data"]["feed"]
		new_full = [ ]
		t = Time.now
		for i in 0..a.length-1 
			author = a[i]["content"]["author"] 
			title = a[i]["content"]["title_alt"]
			date = a[i]["date"]
			date = Time.at(date).to_s
			date = date.split(" ")[0]
			date = date.split("-").reverse.join("-")
			url = a[i]["content"]["url"]
			new_full [i] = New_object.new([author,title,date,url,@@id])
			@@id+=1
		end
		new_full = new_full.sort_by {|hola| hola.created}
		new_full
		@@digg = new_full
	end


end

