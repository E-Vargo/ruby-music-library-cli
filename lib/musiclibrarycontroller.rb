require_relative "../config/environment.rb"
require 'pry'

class MusicLibraryController

     attr_accessor :list

    def initialize(path = './db/mp3s')
        n = MusicImporter.new(path)
        n.import
        @list = Song.all.sort_by {|i| i.name}
    end

    def call 
        puts "Welcome to your music library!"
        puts "To list all of your songs, enter 'list songs'."
        puts "To list all of the artists in your library, enter 'list artists'."
        puts "To list all of the genres in your library, enter 'list genres'."
        puts "To list all of the songs by a particular artist, enter 'list artist'."
        puts "To list all of the songs of a particular genre, enter 'list genre'."
        puts "To play a song, enter 'play song'."
        puts "To quit, type 'exit'."
        puts "What would you like to do?"
        input = gets.chomp
        if input == "list songs"
            list_songs
        elsif input == "list artists"
            list_artists
        elsif input == "list genres"
            list_genres 
        elsif input == "list artist"
            list_songs_by_artist
        elsif input == "list genre"
            list_songs_by_genre
        elsif input == "play song"
            play_song
        end
            unless input == "exit"
                call
            end
    end

    def list_songs
       @list.each_with_index {|x, i| puts "#{i + 1}. #{x.artist.name} - #{x.name} - #{x.genre.name}"}
    end

    def list_artists
        list = Artist.all.sort_by {|a| a.name}
        list.each_with_index {|x, i| puts "#{i + 1}. #{x.name}"}
    end

    def list_genres
        list = Genre.all.sort_by {|a| a.name}
        list.each_with_index {|x, i| puts "#{i + 1}. #{x.name}"}
    end

    def list_songs_by_artist
        puts "Please enter the name of an artist:"
        input = gets.chomp
        if Artist.all.find {|g| g.name == input}
            art = Artist.all.find {|a| a.name == input}
            list = art.songs.sort_by {|s| s.name}
            list.each_with_index {|x, i| puts "#{i + 1}. #{x.name} - #{x.genre.name}"}
        end
    end
    

    def list_songs_by_genre 
        puts "Please enter the name of a genre:"
        input = gets.chomp
        if Genre.all.find {|g| g.name == input}
            genre = Genre.all.find {|g| g.name == input}
            list = genre.songs.sort_by {|s| s.name}
            final = list.each_with_index {|x, i| puts "#{i + 1}. #{x.artist.name} - #{x.name}"}
        end
    end

    def play_song  
        puts "Which song number would you like to play?"
        input = gets.chomp.to_i
        if input >= 1 && input <= @list.count
            song = @list[input - 1]
            puts "Playing #{song.name} by #{song.artist.name}"
        end
    end
end