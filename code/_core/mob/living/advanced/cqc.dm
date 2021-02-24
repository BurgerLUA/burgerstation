/mob/living/advanced/proc/add_cqc(var/cqc_tag)
	cqc += cqc_tag
	var/tag_length = length(cqc)
	if(tag_length > 5)
		cqc = copytext(cqc,1 + (tag_length-5),0)
	return TRUE

/mob/living/advanced/proc/check_cqc(var/atom/victim,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/damagetype/DT)
	for(var/k in known_cqc)
		var/cqc/C = SScqc.all_cqc[k]
		if(C.should_apply(src,victim,weapon,hit_object,blamed,DT))
			if(C.combo_breaker && length(C.combo) > 1)
				src.cqc = ""
			return all_damage_types[C.damage_type]
	return null