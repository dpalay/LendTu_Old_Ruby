# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
	
	def admin?
  	(current_user.role=="admin")
  end
  
  def menu_link(name, sym_cont, sym_action=nil)
  	link_to_unless_current("<span>#{name}</span>", {:controller => sym_cont, :action => sym_action}) do
  		link_to("<span>#{name}</span>", {:controller => sym_cont, :action => sym_action}, :class => "current")
		end
  end
  
	def javascript(*files)
  	content_for(:head) { javascript_include_tag(*files) }
	end

	def stylesheet(*files)
	  content_for(:head) { stylesheet_link_tag(*files) }
	end
	
	def show_flash
		if flash[:error]
			content_tag("div",  "#{flash[:error]}", :id => "flash_error")
		end
		if flash[:warning]
			content_tag("div",  "#{flash[:warning]}", :id => "flash_warning")
		end
	end
  
end