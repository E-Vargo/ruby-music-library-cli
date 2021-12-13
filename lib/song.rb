require_relative "../config/environment.rb"

class Song

    extend Concerns::Findable
    include Concerns::InstanceMethods

    attr_accessor :name
    attr_reader :artist, :genre

    @@all = []

    def initialize(name, artist = nil, genre = nil)
        @name = name
        save
        self.artist = artist if artist
        self.genre = genre if genre
    end

    def self.all
        @@all
    end

    def save
        self.class.all << self
    end

    def artist=(artist)
        @artist = artist 
        artist.add_song(self)
    end

    def genre=(genre)
        @genre = genre
    end

    def self.new_from_filename(file_name)
        array = file_name.split(/( - |[.])/)
        new_song = Song.new(array[2])
        artist = Artist.find_or_create_by_name(array[0])
        genre = Genre.find_or_create_by_name(array[4])
        new_song.artist = artist 
        new_song.genre = genre
        new_song
    end

    def self.create_from_filename(file_name)
        new_from_filename(file_name)
    end


end