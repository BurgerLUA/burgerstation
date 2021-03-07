/obj/item/weapon/ranged/magic/tome/summon/totem
	name = "totemic tome"
	desc = "None."
	desc_extended = "Summons a totem that produces an effect for 5 minutes. Costs mana to use."
	icon = 'icons/obj/item/weapons/ranged/magic/tomes/totem_summon.dmi'

	cost_mana = 150
	object_to_summon = /obj/structure/totem
	value = 3000

/obj/item/weapon/ranged/magic/tome/summon/totem/on_projectile_hit(obj/projectile/P, atom/hit_atom)

	if(istype(P,/obj/projectile/bullet/thrown/))
		return ..()

	var/obj/structure/totem/summoned_object = new object_to_summon(P.previous_loc)
	if(is_living(P.owner))
		var/mob/living/L2 = P.owner
		if(L2.totem)
			L2.totem.Destroy()
		L2.totem = summoned_object
		summoned_object.owner = L2
		summoned_object.affecting_faction = L2.loyalty_tag
		summoned_object.totem_remove_time = duration + world.time
		summoned_object.leveled_effect = round(L2.get_skill_level(SKILL_MAGIC)/50) //send help
		if(L2.is_player_controlled())
			L2.add_skill_xp(SKILL_MAGIC,cost_mana*1.5)
	INITIALIZE(summoned_object)
	GENERATE(summoned_object)
	FINALIZE(summoned_object)
	if(summoned_object)
		summoned_object.Move(get_turf(hit_atom))
	return ..()
