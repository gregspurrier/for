module For
  class Context
    instance_methods.each { |m| undef_method m unless m =~ /^(__|instance_eval)/ }

    class <<self
      def build(bindings)
        context_klass = Class.new(self)
        bindings.keys.each do |key|
          context_klass.instance_eval do
            define_method(key) { bindings[key] }
          end
        end
        context_klass.new
      end
    end
  end
end
