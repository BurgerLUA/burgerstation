/mob/living/advanced/proc/add_cqc(cqc_tag)
	cqc_combo += cqc_tag
	var/tag_length = length(cqc_combo)
	if(tag_length > 5)
		cqc_combo = copytext(cqc_combo,1 + (tag_length-5),0)
	return TRUE

/mob/living/advanced/proc/check_cqc(atom/victim,atom/weapon,atom/hit_object,atom/blamed,damagetype/DT)
	if(!cqc_category)
		return FALSE
	for(var/k in SScqc.cqc_category[src.cqc_category])
		var/cqc/C = k
		if(C.should_apply(src,victim,weapon,hit_object,blamed,DT))
			if(C.combo_breaker && length(C.combo) > 1)
				src.cqc_combo = ""
			return SSdamagetype.all_damage_types[C.damage_type]
	return null