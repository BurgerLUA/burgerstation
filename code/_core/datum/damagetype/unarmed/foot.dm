//Foot
/damagetype/unarmed/foot/
	name = "foot"
	attack_verbs = list("kick")

	hit_effect = /obj/effect/temp/impact/combat/kick

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = DAMAGE_CLUB*0.2
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 0
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = DAMAGE_CLUB*0.3,
		ATTRIBUTE_DEXTERITY = DAMAGE_CLUB*0.1
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = list(BLUNT),
		ATTRIBUTE_DEXTERITY = list(BLUNT)
	)

	skill_stats = list(
		SKILL_UNARMED = DAMAGE_CLUB*0.4
	)

	skill_damage = list(
		SKILL_UNARMED = list(BLUNT)
	)

	allow_friendly_fire = FALSE

	cqc_tag = "5"

	attack_delay = SPEED_CLUB*0.5
	attack_delay_max = SPEED_CLUB


/damagetype/unarmed/foot/post_on_hit(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/total_damage_dealt=0)

	if(is_living(victim))
		var/mob/living/L = victim
		var/luck_value = (total_damage_dealt/DAMAGE_CLUB)*200
		if(luck(list(attacker,weapon),luck_value) && luck(list(victim,hit_object),100,FALSE))
			L.add_status_effect(STAGGER,5,5, source = attacker)

	return ..()