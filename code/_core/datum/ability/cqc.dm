/ability/cqc
	name = "CQC Ability"
	desc = "A cqc ability."

	var/damagetype/damage_type

/ability/cqc/on_cast_pre(var/mob/caller,var/atom/target)
	if(get_dist_advanced(caller,target) > 1)
		return FALSE
	. = ..()

/ability/cqc/on_cast(var/mob/caller,var/atom/target)
	caller.attack(caller,target,damage_type_override=damage_type)
	. = ..()


//Sleeping Carp
/ability/cqc/carp/crashing_wave_kick
	name = "Crashing Wave Kick"
	icon_state = "crashing_wave"
	damage_type = /damagetype/cqc/sleeping_carp/crashing_wave_kick
	cooldown = SECONDS_TO_DECISECONDS(10)

/ability/cqc/carp/keelhaul
	name = "Keelhaul"
	icon_state = "keelhaul"
	damage_type = /damagetype/cqc/sleeping_carp/keelhaul
	cooldown = SECONDS_TO_DECISECONDS(10)

/ability/cqc/carp/gnashing_teeth
	name = "Gnashing Teeth"
	icon_state = "gnashing_teeth"
	damage_type = /damagetype/cqc/sleeping_carp/gnashing_teeth
	cooldown = SECONDS_TO_DECISECONDS(10)