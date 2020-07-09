/mob/living/advanced/npc/beefman
	name = "meat anomaly"
	desc = "A disgusting monster made by beef"
	enable_AI = TRUE
	ai = /ai/advanced/beef
	species = "beefman"
	class = /class/beefman
	iff_tag = "beefman"
	loyalty_tag = "beefman"

	movement_delay = 1

	health_base = 50

	butcher_contents = list(
		/obj/item/soulgem/rare,
		/obj/item/container/food/dynamic/meat/raw_beefman,
		/obj/item/container/food/dynamic/meat/raw_beefman,
		/obj/item/container/food/dynamic/meat/raw_beefman,
		/obj/item/container/food/dynamic/meat/raw_beefman
	)

/mob/living/advanced/npc/beefman/Initialize()
	. = ..()
	change_organ_visual("skin", desired_color = pick("#C42F36","#A02518","#742210","#541900","#261007"))
	update_all_blends()
	return .


/mob/living/advanced/npc/beefman/on_damage_received(var/atom/atom_damaged,var/atom/attacker,var/atom/weapon,var/list/damage_table,var/damage_amount,var/critical_hit_multiplier,var/stealthy=FALSE)

	if(damage_amount > 20 & luck(src,20 + damage_amount,FALSE))
		play('sound/weapons/beef/beef_grab.ogg',atom_damaged)
		add_status_effect(STAGGER,5,5,source = attacker)

	return ..()

/mob/living/advanced/npc/beefman/proc/beef()
	if(!health)
		return FALSE
	health.adjust_loss_smart(brute=-health.get_brute_loss()*0.25,burn=-health.get_burn_loss()*0.25)
	if(!check_death())
		revive()
	return TRUE

/mob/living/advanced/npc/beefman/post_death()
	CALLBACK("beef_revive_\ref[src]",SECONDS_TO_DECISECONDS(rand(3,8)),src,.proc/beef)
	return ..()

/mob/living/advanced/npc/beefman/Initialize()
	. = ..()
	update_all_blends()
	return .