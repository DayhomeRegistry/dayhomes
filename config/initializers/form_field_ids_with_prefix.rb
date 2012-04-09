module ActionView
  module Helpers
    InstanceTag.class_eval do

      private

      def add_default_name_and_id_with_prefix(options)
        blank_id = !options['id']
        add_default_name_and_id_without_prefix(options)
        if blank_id and options.has_key? 'prefix'
          options['id'] = "#{options.delete('prefix')}_#{options['id']}"
        end
      end
      alias_method_chain :add_default_name_and_id, :prefix

    end
  end
end