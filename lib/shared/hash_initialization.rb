# frozen_string_literal: true

module HashInitialization
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def attr_readable(*attrs)
      attrs.each do |attr|
        attr_reader attr
      end

      define_method :initialize do |args|
        attrs.each do |attr|
          instance_variable_set("@#{attr}", args.fetch(attr, nil))
        end
      end
    end
  end
end
