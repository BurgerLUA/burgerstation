/cqc/
	var/name = "CQC Move Name"
	var/combo = "" //The combo to trigger.
	var/damagetype/damage_type //The damage type that is applied on target.
	var/combo_breaker = FALSE //Should we clear the current combo when this combo is finished?
	var/priority = 0 //Lower values get more priority. Automatically assigned based on combo length
	var/category

/cqc/New(var/desired_loc)

	if(!priority)
		priority = 1000 - length(combo)

	 . = ..()

/cqc/proc/should_apply(var/mob/living/advanced/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/damagetype/DT)

	var/combo_length = length(combo)

	if(combo_length == 1 && DT.cqc_tag == combo)
		return TRUE

	var/cqc_string = attacker.cqc_combo

	var/cqc_length = length(cqc_string)

	if(cqc_length < combo_length)
		return FALSE

	var/damagetype/new_DT = all_damage_types[damage_type]

	if(!new_DT.allow_friendly_fire && is_living(victim))
		var/mob/living/L = victim
		if(!allow_hostile_action(attacker.loyalty_tag,L))
			return FALSE

	if(cqc_length == combo_length)
		return combo == cqc_string

	var/copy = copytext(cqc_string,-combo_length,0)

	return combo == copy