/proc/easy_miss_message(var/atom/attacker, var/atom/victim, var/atom/weapon, var/atom/hit_object, var/damagetype/DT, var/miss_text = "misses")
	attacker.visible_message(\
		replacetext(DT.get_miss_message_3rd(attacker,victim,weapon,hit_object),"#REASON",miss_text),\
		replacetext(DT.get_miss_message_1st(attacker,victim,weapon,hit_object),"#REASON",miss_text),\
		replacetext(DT.get_miss_message_sound(attacker,victim,weapon,hit_object),"#REASON",miss_text)\
	)