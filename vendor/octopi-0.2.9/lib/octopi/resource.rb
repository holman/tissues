module Octopi
  module Resource
    def self.included(base)
      base.extend ClassMethods
      base.set_resource_name(base.name)
      (@@resources||={})[base.resource_name(:singular)] = base
      (@@resources||={})[base.resource_name(:plural)] = base
    end
    
    def self.for(name)
      @@resources[name]
    end
    
    module ClassMethods
      def set_resource_name(singular, plural = "#{singular}s")
        @resource_name = {:singular => declassify(singular), :plural => declassify(plural)}
      end
      
      def resource_name(key)
        @resource_name[key]
      end
      
      def create_path(path)
        (@path_spec||={})[:create] = path
      end
      
      def find_path(path)
        (@path_spec||={})[:find] = path
      end
    
      def resource_path(path)
        (@path_spec||={})[:resource] = path
      end
  
      def delete_path(path)
        (@path_spec||={})[:delete] = path
      end
      
      def find(*args)
        args = args.join('/') if args.is_a? Array
        result = Api.api.find(path_for(:resource), @resource_name[:singular], args, self, @cache)
        key = result.keys.first

        if result[key].is_a? Array
          result[key].map { |r| new(r) }
        else
          Resource.for(key).new(result[key])
        end
      end

      def find_all(*s)
        find_plural(s, :find)
      end
      
      def find_plural(s, path)
        s = s.join('/') if s.is_a? Array
        resources = Api.api.find_all(path_for(path), @resource_name[:plural], s, self)
        resources.map { |item| self.new(item) }
      end
      
      def declassify(s)
        (s.split('::').last || '').downcase if s
      end
    
      def path_for(type)
        @path_spec[type]
      end
    end
  end
end