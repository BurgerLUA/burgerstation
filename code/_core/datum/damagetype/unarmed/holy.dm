/damagetype/unarmed/holy
	attack_verbs = list("bless","exorcise","smite","beatify","sanctify","proselytizes")

	hit_effect = /obj/effect/temp/impact/combat/punch

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 10,
		HOLY = 0
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 0,
		HOLY = 0
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 25,
		ATTRIBUTE_DEXTERITY = 10
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = BLUNT,
		ATTRIBUTE_DEXTERITY = BLUNT
	)

	skill_stats = list(
		SKILL_UNARMED = 30,
		SKILL_PRAYER = 60
	)

	skill_damage = list(
		SKILL_UNARMED = BLUNT,
		SKILL_PRAYER = HOLY
	)

	cqc_tag = "4"

	attack_delay = 5
	attack_delay_max = 10

/damagetype/unarmed/holy/slam
	damage_mod = 4

	attack_delay = 5*2
	attack_delay_max = 10*2

/damagetype/unarmed/holy/slam/post_on_hit(var/atom/attacker,var/turf/attacker_turf,var/atom/victim,var/turf/victim_turf,var/atom/weapon,var/atom/hit_object,var/total_damage_dealt=0)

	. = ..()

	if(is_living(victim))
		var/mob/living/L = victim
		L.add_status_effect(STUN,10,10)


/damagetype/unarmed/holy/kick
	damage_mod = 2

	attack_delay = 5*2
	attack_delay_max = 10*2

/damagetype/unarmed/holy/kick/post_on_hit(var/atom/attacker,var/turf/attacker_turf,var/atom/victim,var/turf/victim_turf,var/atom/weapon,var/atom/hit_object,var/total_damage_dealt=0)

	. = ..()

	if(is_living(victim))
		var/mob/living/LV = victim
		LV.add_status_effect(STUN,20,20)
		var/list/offsets = get_directional_offsets(attacker,LV)
		if(!(offsets[1] || offsets[2]))
			offsets[1] = rand(-1,1)
			offsets[2] = offsets[1] ? rand(-1,1) : pick(-1,1)
		LV.throw_self(attacker,null,16,16,offsets[1]*12,offsets[2]*12,lifetime=5)






/damagetype/unarmed/holy/spiked
	attack_verbs = list("curse","defile","desecrate","taint","blaspheme","pollute")

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 10,
		PIERCE = 15,
		DARK = 0
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = 25,
		PIERCE = 25,
		DARK = 25
	)

	attribute_stats = list(
		ATTRIBUTE_STRENGTH = 25,
		ATTRIBUTE_DEXTERITY = 10
	)

	attribute_damage = list(
		ATTRIBUTE_STRENGTH = list(BLUNT,PIERCE),
		ATTRIBUTE_DEXTERITY = list(BLUNT,PIERCE)
	)

	skill_stats = list(
		SKILL_UNARMED = 30,
		SKILL_PRAYER = 60

	)

	skill_damage = list(
		SKILL_UNARMED = list(BLUNT,PIERCE),
		SKILL_PRAYER = DARK
	)

	cqc_tag = "4"

	attack_delay = 7
	attack_delay_max = 15