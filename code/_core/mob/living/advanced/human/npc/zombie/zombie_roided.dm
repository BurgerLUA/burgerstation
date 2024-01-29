//Roided zombies have a lot of health, a lot of armor, have a ton of stamina, always deal critical hits with unarmed attacks, and their grabs will always be instant reinforced grabs.

/mob/living/advanced/npc/zombie/roided

	name = "zombie roider"
	loadout = /loadout/zombie/roided

	level = 25

	health_base = 500
	stamina_base = 1000
	mana_base = 50

	sex = MALE
	gender = MALE

	var/next_flex = 0


/mob/living/advanced/npc/zombie/roided/Finalize()
	. = ..()
	add_status_effect(BUFF,100,-1, force = TRUE)
	for(var/k in src.labeled_organs)
		var/obj/item/organ/O = labeled_organs[k]
		if(O.armor == /armor/default_organic)
			O.armor = /armor/roided_zombie

/mob/living/advanced/npc/zombie/roided/on_unblocked_hit(atom/attacker,atom/weapon,atom/hit_object,atom/blamed,damagetype/DT,total_damage_dealt=0)

	. = ..()

	if(next_flex <= world.time && total_damage_dealt >= 10 && !horizontal)
		do_emote("flex")
		add_status_effect(PARALYZE,100,2 SECONDS,stealthy=TRUE)
		next_flex = world.time + 10 SECONDS

	if(health.health_current <= health.health_max*0.5 && !has_status_effect(RAGE))
		add_status_effect(RAGE,100,-1)

