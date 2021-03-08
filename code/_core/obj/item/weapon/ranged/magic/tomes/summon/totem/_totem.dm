/obj/item/weapon/ranged/magic/tome/summon/totem
	name = "totemic tome"
	desc = "None."
	desc_extended = "Summons a totem that produces an effect for 5 minutes. Costs mana to use."
	icon = 'icons/obj/item/weapons/ranged/magic/tomes/totem_summon.dmi'

	shoot_sounds = list('sound/weapons/magic/summon.ogg')
	projectile_speed = 8
	shoot_delay = 30
	projectile = /obj/projectile/bullet/summon

	duration = SECONDS_TO_DECISECONDS(300) //In deciseconds. Only applies to summoning mobs.

	cost_mana = 100
	var/obj/structure/totem/totem_to_spawn = /obj/structure/totem
	object_to_summon = /obj/structure/totem
	value = 3000
	rarity = RARITY_UNCOMMON

/obj/item/weapon/ranged/magic/tome/summon/totem/on_projectile_hit(obj/projectile/P, atom/hit_atom)
	if(istype(P,/obj/projectile/bullet/thrown/))
		return ..()
	var/obj/structure/totem/summoned_totem = new totem_to_spawn(P.previous_loc)
	if(is_living(P.owner))
		var/mob/living/livingOwner = P.owner
		if(livingOwner.totem)
			livingOwner.totem.Destroy()
		livingOwner.totem = summoned_totem
		summoned_totem.owner = livingOwner
		summoned_totem.affecting_faction = livingOwner.loyalty_tag
		summoned_totem.totem_remove_time = duration + world.time
		summoned_totem.leveled_effect = round(livingOwner.get_skill_level(SKILL_MAGIC)/50) //send help
		if(livingOwner.is_player_controlled())
			livingOwner.add_skill_xp(SKILL_MAGIC,cost_mana*1.5)
	INITIALIZE(summoned_totem)
	GENERATE(summoned_totem)
	FINALIZE(summoned_totem)
	if(summoned_totem)
		summoned_totem.Move(get_turf(hit_atom))
	. = ..()
