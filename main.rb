	require_relative 'get_news'
	require 'colorize'
	require 'launchy'

	module Main

		def self.get_keypressed
			system("stty raw -echo")
			t = STDIN.getc
			system("stty -raw echo")
			return t
		end

		def self.show_menu

		puts "Bienvenido al portal de noticias"
		puts "vea noticias en => Reddit = {r},  Mashable = {m}, Digg = {d}, Todas las Anteriores = {t}, Salir = {x}"

		input(get_keypressed)
		Main.search_state
		Main.show_exit
		end

		def self.search_new

			gets.chomp.to_i
		end


		def self.search_state

			puts "¿desea abrir alguna noticia en el navegador predeterminado? SI = {s} N0 = {x}"
			input(get_keypressed)
			
		end

		def self.show_exit

			puts "¿desea volver a verificar las noticias?  SI = {y} || NO = {n}"
			input(get_keypressed)
			
		end

		def self.input(g)

			if g == "r"
				show_reddit
				@@showed = "reddit"
			end

			if g == "m"
				show_mashable
				@@showed = "mashable"
			end
			if g == "d"
				show_digg
				@@showed = "digg"
			end
			if g == "t"
				a = [show_digg, show_reddit, show_mashable]
				@@showed = "all"
			end
			if g == "y"
				GET_NEWS.id=
				Main.show_menu
			end
			if g =="n"
				return false
			end
			if g == "x"
				return false
			end
			if g =="s"
				case @@showed
				when "reddit"
					a = GET_NEWS.reddit
				when "mashable"
					a = GET_NEWS.mashable
				when "digg"
					a = GET_NEWS.digg
				else
					a =[GET_NEWS.digg, GET_NEWS.reddit, GET_NEWS.mashable].flatten
				end
				n = Main.search_new-1
				Launchy.open("#{a[n].url}")
			end

		end

		def self.show_reddit

			puts"----------------REDDIT-------------------".colorize(:blue)
			a = GET_NEWS.get_reddit
			a.each do |a|  
				puts "ID: #{a.id}".colorize(:blue) 
				puts "Titulo: #{a.title}".colorize(:magenta)
				puts "Author: #{a.author}".colorize(:red)
				puts "Created: #{a.created}".colorize(:blue)
				puts "Url: #{a.url}".colorize(:green)
				puts "-------------------------------------------- "
			end
		end

		def self.show_mashable

			puts"----------------MASHABLE-----------------------".colorize(:magenta)
				b = GET_NEWS.get_mashable
			b.each do |b|  

				puts "ID: #{b.id}".colorize(:blue)
				puts "titulo: #{b.title}".colorize(:magenta)
				puts "author: #{b.author}".colorize(:red)
				puts "created: #{b.created}".colorize(:blue)
				puts "url: #{b.url}".colorize(:green)
				puts " "
			end
		end


		def self.show_digg

			puts"----------------DIGG----------------------".colorize(:red)
				c = GET_NEWS.get_digg
			c.each do |c|  
				puts "ID: #{c.id}".colorize(:blue)
				puts "titulo: #{c.title}".colorize(:magenta)
				puts "author: #{c.author}".colorize(:red)
				puts "created: #{c.created}".colorize(:blue)
				puts "url: #{c.url}" .colorize(:green)
				puts " "
			end

			puts"-----------------------------------------------"
		end
	end

	Main.show_menu

