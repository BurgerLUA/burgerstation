/cqc/
	var/name = "CQC Move Name"
	var/combo = "" //The combo to trigger.
	var/damagetype/damage_type //The damage type that is applied on target.
	var/combo_breaker = FALSE //Should we clear the current combo when this combo is finished?

/cqc/proc/should_apply(var/mob/living/advanced/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/total_damage_dealt=0)

	var/cqc_string = attacker.cqc

	var/combo_length = length(combo)
	var/cqc_length = length(cqc_string)

	if(cqc_length < combo_length)
		return FALSE

	if(cqc_length == combo_length)
		return combo == cqc_string

	var/copy = copytext(cqc_string,-combo_length,0)

	return combo == copy