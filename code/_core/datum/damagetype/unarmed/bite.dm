/damagetype/unarmed/bite/
	name = "bite"
	attack_verbs = list("bite","chomp","gnaw")

	impact_sounds = list(
		'sound/weapons/fists/bite.ogg'
	)

	hit_effect = /obj/effect/temp/impact/combat/bite

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = DAMAGE_AXE*0.1,
		PIERCE = DAMAGE_AXE*0.4
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = AP_CLUB*0.5,
		PIERCE = AP_CLUB*0.5
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = DAMAGE_AXE*0.3,
		ATTRIBUTE_DEXTERITY = DAMAGE_AXE*0.1
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = list(BLADE,PIERCE),
		ATTRIBUTE_DEXTERITY = list(BLADE,PIERCE)
	)

	skill_stats = list(
		SKILL_UNARMED = DAMAGE_AXE*0.1
	)

	skill_damage = list(
		SKILL_UNARMED = list(BLADE,PIERCE),
	)

	throw_mul = 1

	attack_delay = SPEED_AXE*0.5
	attack_delay_max = SPEED_AXE


/damagetype/unarmed/bite/zombie
	name = "zombie bite"

/damagetype/unarmed/bite/zombie/post_on_hit(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/total_damage_dealt=0)

	if(total_damage_dealt >= 10 && victim && victim.reagents)
		victim.reagents.add_reagent(/reagent/toxin/zombie_toxin,CEILING(total_damage_dealt*0.05,1),caller = is_living(attacker) ? attacker : null)

	return ..()
