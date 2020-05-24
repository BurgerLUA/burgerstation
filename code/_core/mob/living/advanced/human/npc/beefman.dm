/mob/living/advanced/npc/beefman
	name = "meat anomaly"
	enable_AI = TRUE
	ai = /ai/advanced/beef
	species = "beefman"
	class = "ashwalker"
	iff_tag = "beefman"
	loyalty_tag = "beefman"

	movement_delay = 1

	footstep_override_id = "splat"

	health_base = 100

/mob/living/advanced/npc/beefman/on_damage_received(var/atom/atom_damaged,var/atom/attacker,var/list/damage_table,var/damage_amount)

	if(damage_amount > 20 & prob(20 + damage_amount))
		play('sounds/weapons/beef/beef_grab.ogg',atom_damaged)
		add_status_effect(STAGGER,5,5,source = attacker)

	return ..()

/mob/living/advanced/npc/beefman/proc/beef()
	if(!health)
		return FALSE
	health.adjust_loss_smart(brute=-health.get_brute_loss()*0.5,burn=-health.get_burn_loss()*0.5)
	if(!check_death())
		revive()
	return TRUE

/mob/living/advanced/npc/beefman/post_death()
	if(prob(50))
		CALLBACK("beef_revive_\ref[src]",SECONDS_TO_DECISECONDS(rand(1,5)),src,.proc/beef)
	return ..()

/mob/living/advanced/npc/beefman/Initialize()
	. = ..()
	update_all_blends()
	return .

/mob/living/advanced/npc/borgman
	name = "borgman"
	enable_AI = TRUE
	ai = /ai/advanced/
	species = "cyborg"
	class = "ashwalker"

/mob/living/advanced/npc/borgman/Initialize()

	. = ..()

	update_all_blends()

	return .