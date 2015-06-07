module Rlauth
    class Configuration
        @@config = YAML.load_file("#{Rails.root}/config/configuration.yml")

        def self.respond_to?(sym, include_private = false)
            self.handle?(sym)  || super(sym, include_private)
        end

        def self.method_missing(sym, *args, &block)
            return @@config[sym] if self.handle?(sym)
            super(sym, *args, &block)
        end

        def self.config
            @@config
        end

        private

        def self.handle?(sym)
            @@config[sym] != nil
        end
    end
end