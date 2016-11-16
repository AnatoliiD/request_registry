class RequestRegistry < Module
  VERSION = '0.1.0'
  def initialize(*method_list)
    @method_list = method_list
  end

  def extended(object)
    method_list = @method_list
    object.instance_variable_set '@request_registry_key', object.name.freeze
    object.class_eval do
      attr_accessor(*method_list)
    end
    object.singleton_class.class_eval do
      define_method :instance do
        RequestStore.store[@request_registry_key] ||= object.new
      end
      object.public_instance_methods(false).each do |method|
        define_method method do |*args|
          instance.send(method, *args)
        end
      end
    end
  end
end
