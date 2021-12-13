require_relative "../config/environment.rb"

class MusicImporter

    attr_accessor :path, :files

    def initialize(path)
        @path = path
    end

    def files
        @files = Dir.entries(@path)
        @files.delete_if {|f| f == ".." || f == "."}
    end

    def import 
        self.files.each {|f| Song.create_from_filename(f)}
    end
end