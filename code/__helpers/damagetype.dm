proc/get_combat_grade(var/combat_rating)
	switch(combat_rating)
		if(0 to 5)
			return "<div color='#FF0000'>F</div>"
		if(5 to 10)
			return "<div color='#FF6A00'>E</div>"
		if(10 to 20)
			return "<div color='#FFD800'>D</div>"
		if(20 to 40)
			return "<div color='#B6FF00'>C</div>"
		if(40 to 80)
			return "<div color='#4CFF00'>B</div>"
		if(80 to 160)
			return "<div color='#00FF90'>A</div>"
		if(160 to INFINITY)
			return "<div color='#00FFFF'>S</div>"