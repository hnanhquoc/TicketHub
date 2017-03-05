module ApplicationHelper
	def bootstrap_class_for flash_type
		{ success: 'alert-success', alert: 'alert-danger', error: 'alert-danger', notice: 'alert-warning'}[flash_type.to_sym]
	end

	def flash_messages(opts = {})
		flash.map do |msg_type, message|
			content_tag(:div, message, {:class => "alert #{bootstrap_class_for(msg_type)} fadein show", :style => 'margin-top: 56px;'}) do
				content_tag(:button, '&times'.html_safe, class: 'close', data: {dismiss: 'alert'}) + message
			end
		end.join.html_safe
	end
end
