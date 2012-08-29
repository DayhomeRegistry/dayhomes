# ClientSideValidations Initializer

#require 'client_side_validations/simple_form' if defined?(::SimpleForm)
#require 'client_side_validations/formtastic'  if defined?(::Formtastic)

# Uncomment the following block if you want each input field to have the validation messages attached.
#ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|  
   #unless html_tag =~ /^<label/
   #  %{<div class="field_with_errors">#{html_tag}</div>}.html_safe
   #else
   #  %{<div class="field_with_errors">#{html_tag}<label for="#{instance.send(:tag_id)}" class="message">#{instance.error_message.first}</label></div>}.html_safe
   #end
#end

ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
 html = %(<div class="field_with_errors">#{html_tag}</div>).html_safe
 # add nokogiri gem to Gemfile
 elements = Nokogiri::HTML::DocumentFragment.parse(html_tag).css "label, input"
 elements.each do |e|
   if e.node_name.eql? 'label'
     html = %(<div class="clearfix error">#{e}</div>).html_safe
   elsif e.node_name.eql? 'input'
     if instance.error_message.kind_of?(Array)
       html = %(<div class="clearfix error">#{html_tag}<span class="help-inline">&nbsp;#{instance.error_message.join(',')}</span></div>).html_safe
     else
       html = %(<div class="clearfix error">#{html_tag}<span class="help-inline">&nbsp;#{instance.error_message}</span></div>).html_safe
     end
   end
 end
 html
end