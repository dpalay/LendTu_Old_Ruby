module AsearchHelper
	def search_form_row(form, field)
				label = content_tag("label", "#{field.humanize}:", :for => field)
				form_field = form.text_field field
				content_tag("div", content_tag("span", "#{label} #{form_field}", :id => field), :class => "form_row")
	end
end
