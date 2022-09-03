/damagetype/npc/legion_assault
	attack_verbs = list("bite","chomp","gnaw")

	impact_sounds = list(
		'sound/weapons/fists/bite.ogg'
	)

	hit_effect = /obj/effect/temp/impact/combat/bite


	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 5,
		PIERCE = 5,
		DARK = 5
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(

	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 40,
		ATTRIBUTE_DEXTERITY = 20,
		ATTRIBUTE_INTELLIGENCE = 5
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT,
		ATTRIBUTE_DEXTERITY = PIERCE,
		ATTRIBUTE_INTELLIGENCE = DARK
	)

	attack_delay = 7
	attack_delay_max = 14


/damagetype/npc/legion_assault/post_on_hit(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/total_damage_dealt=0)

	. = ..()

	if(is_advanced(victim))
		var/mob/living/advanced/A = victim
		if(A.dead && istype(attacker,/mob/living/simple/legionare_head))
			var/mob/living/simple/legionare_head/L = attacker
			if(!L.qdeleting && !A.qdeleting)
				L.convert(A)

/damagetype/npc/snowlegion_asault
	attack_verbs = list("bite","chomp","gnaw")

	impact_sounds = list(
		'sound/weapons/fists/bite.ogg'
	)

	hit_effect = /obj/effect/temp/impact/combat/bite


	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 5,
		PIERCE = 5,
		COLD = 5
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(

	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 40,
		ATTRIBUTE_DEXTERITY = 20,
		ATTRIBUTE_INTELLIGENCE = 5
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT,
		ATTRIBUTE_DEXTERITY = PIERCE,
		ATTRIBUTE_INTELLIGENCE = COLD
	)

	attack_delay = 7
	attack_delay_max = 14