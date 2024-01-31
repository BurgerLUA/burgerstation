
/proc/span(class,text,style)
	return "<span class='[class]' [style ? "style='[style]'" : ""]>[text]</span>"

/proc/div(class,text)
	return "<div class='[class]'>[text]</div>"