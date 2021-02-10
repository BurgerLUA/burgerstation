/proc/span(var/class,var/text,var/style)
	return "<span class='[class]' [style ? "style='[style]'" : ""]>[text]</span>"

/proc/div(var/class,var/text)
	return "<div class='[class]'>[text]</div>"
