//Has lots of armor and carries an explosive that it uses to suicide bomb targets.

/mob/living/advanced/npc/zombie/armored
	name = "zombie juggernaut"
	loadout = /loadout/zombie/armored

	level = 20

/mob/living/advanced/npc/zombie/armored/act_explode(atom/owner,atom/source,atom/epicenter,magnitude,desired_loyalty_tag)

	if(owner == src)
		gib()
		return TRUE

	. = ..()