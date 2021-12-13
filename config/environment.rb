require 'bundler'
Bundler.require


module Concerns
    module InstanceMethods

        def save
            self.class.all << self
        end
    end

   module Findable
        
    def destroy_all
        all.clear
    end

     def create(name)
        self.new(name)
     end

     def find_by_name(name)
        all.find {|i| i.name == name}
     end

     def find_or_create_by_name(name)
        find_by_name(name) ? find_by_name(name) : create(name)
     end

    end
end

require_all 'lib'

