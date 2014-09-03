module Blokade
  module Configuration
    extend ActiveSupport::Concern

    KLASS_CONSTANTS = [
      :permission_class,
      :grant_class,
      :power_class,
      :role_class,
      :user_class,
      :blokadable_class,
      :luser_class,
      :skywire_class,
    ]

    # When this module is extended, set all configuration options to their default values
    def self.extended(base)
      # Get our constants setup
      KLASS_CONSTANTS.each { |k| base.send(:mattr_accessor, k.to_sym) }
      base.send(:mattr_accessor, :default_blokades)

      # Reset the values
      base.reset

      # Setup our Klass Constants
      base.setup_klass_constants
    end

    # Resets all the values to their defaults.
    def reset
      # Permission (Don't Override)
      self.permission_class = "Blokade::Permission"

      # Grant (Don't Override)
      self.grant_class = "Blokade::Grant"

      # Power (Don't Override)
      self.power_class = "Blokade::Power"

      # Role (Override)
      self.role_class = "Blokade::Role"

      # User (Override)
      self.user_class = "Blokade::User"

      # Local User (Override)
      self.luser_class = "Blokade::Luser"

      # User (Override)
      self.skywire_class = "Blokade::Skywire"

      # Blokadable (Override)
      self.blokadable_class = "Blokade::Blokadable"

      # Default Blokades actions
      self.default_blokades = [:manage, :index, :show, :new, :create, :edit, :update, :destroy]
    end

     # Allows setting all configuration options in a block
    def configure
      yield self
    end

    def setup_klass_constants
      Blokade::Configuration::KLASS_CONSTANTS.each do |klass|
        send(:define_singleton_method, "#{klass.to_s.gsub(/(_class)$/, '_klass')}".to_sym) do
          self.send(klass).try(:constantize)
        end
      end
    end

    # def permission_klass
    #   self.permission_class.constantize
    # end

    # def grant_klass
    #   self.grant_class.constantize
    # end

    # def power_klass
    #   self.power_class.constantize
    # end

    # def role_klass
    #   self.role_class.constantize
    # end

    # def user_klass
    #   self.user_class.constantize
    # end

    # def luser_klass
    #   self.luser_class.constantize
    # end

    # def skywire_klass
    #   self.skywire_class.constantize
    # end

    # def blokadable_klass
    #   self.blokadable_class.constantize
    # end

  end
end
