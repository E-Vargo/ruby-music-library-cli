require_relative "../config/environment.rb"

class Artist

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
        Song.all.select {|s| s.artist == self}
    end

    def genres 
        songs.collect {|s| s.genre}.uniq
    end

    def add_song(song)
        song.artist ? nil : song.artist = self
    end
end