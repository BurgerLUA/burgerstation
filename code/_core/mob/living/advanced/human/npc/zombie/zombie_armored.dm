//Has lots of armor and carries an explosive that it uses to suicide bomb targets.

/mob/living/advanced/npc/zombie/armored
	name = "zombie juggernaut"
	loadout = /loadout/zombie/armored

	level = 40

/mob/living/advanced/npc/zombie/armored/act_explode(var/atom/owner,var/atom/source,var/atom/epicenter,var/magnitude,var/desired_loyalty_tag)

	if(owner == src)
		gib()
		return TRUE

	. = ..()