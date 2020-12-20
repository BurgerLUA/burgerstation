/damagetype/npc/legion_assault
	name = "Legion Assault"
	attack_verbs = list("bite","chomp","gnaw")

	impact_sounds = list(
		'sound/weapons/fists/bite.ogg'
	)

	hit_effect = /obj/effect/temp/impact/combat/bite


	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = DAMAGE_CLUB*0.05,
		PIERCE = DAMAGE_CLUB*0.05,
		DARK = DAMAGE_CLUB*0.1
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = AP_CLUB
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = DAMAGE_CLUB*0.4,
		ATTRIBUTE_DEXTERITY = DAMAGE_CLUB*0.2,
		ATTRIBUTE_INTELLIGENCE = DAMAGE_CLUB*0.2
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT,
		ATTRIBUTE_DEXTERITY = PIERCE,
		ATTRIBUTE_INTELLIGENCE = DARK
	)

	attack_delay = SPEED_CLUB*0.5
	attack_delay_max = SPEED_CLUB


/damagetype/npc/legion_assault/post_on_hit(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/total_damage_dealt=0)

	. = ..()

	if(is_advanced(victim))
		var/mob/living/advanced/A = victim
		if(A.dead && istype(attacker,/mob/living/simple/legionare_head))
			var/mob/living/simple/legionare_head/L = attacker
			if(!L.qdeleting)
				L.convert(A)

	return .

