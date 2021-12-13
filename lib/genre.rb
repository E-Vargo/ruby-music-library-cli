require_relative "../config/environment.rb"

class Genre
    
    extend Concerns::Findable
    include Concerns::InstanceMethods

    attr_accessor :name

    @@all = []

    def initialize(name)
        @name = name
        save
    end

    def self.all
        @@all
    end

    def songs
        Song.all.select {|s| s.genre == self}
    end

    def artists 
        songs.collect {|s| s.artist}.uniq
    end

end