/obj/item/weapon/ranged/magic/deathgrips/
	name = "death grippers"
	rarity = RARITY_MYTHICAL
	desc = "You're fit to learn the proper meaning of a beatdown."
	desc_extended = "Grab intent drags victims to you! Attack while in Harm intent to perform a punch rush!"
	icon = 'icons/obj/item/weapons/unarmed/powerfist.dmi'
	cost_mana = 4
	shoot_delay = 1
	burst_delay = 2
	max_bursts = 3

	projectile = /obj/projectile/magic/blade
	projectile_speed = TILE_SIZE*0.75

	automatic = TRUE

	damage_type = /damagetype/unarmed/deathgrip
	ranged_damage_type = /damagetype/unarmed/deathgrip
	var/alt_ranged_damage_type = /damagetype/unarmed/deathgrip/pull

	size = SIZE_2
	weight = 10

	color = COLOR_BLOOD

	value = 5000

/obj/item/weapon/ranged/magic/deathgrips/proc/intent_check(var/mob/caller)
	var/mob/living/self = caller
	if(self.intent == INTENT_HARM)
		ranged_damage_type = initial(ranged_damage_type)
		projectile = /obj/projectile/magic/deathpunch
		cost_mana = 4
		shoot_delay = 1
		burst_delay = 2
		max_bursts = 5
	if(self.intent == INTENT_GRAB)
		ranged_damage_type = alt_ranged_damage_type
		projectile = /obj/projectile/magic/deathgrip
		cost_mana = 20
		shoot_delay = 5
		burst_delay = 0
		max_bursts = 1
	return .

/obj/item/weapon/ranged/magic/deathgrips/shoot(var/mob/caller,var/atom/object,location,params,var/damage_multiplier=1)
	var/mob/living/self = caller

	. = ..()

	if(.)
		intent_check(self)
		src.attack_next = shoot_delay

/obj/item/weapon/ranged/magic/deathgrips/can_gun_shoot(var/mob/caller)
	var/mob/living/self = caller
	if(self.health.mana_current < cost_mana)
		return FALSE
	if(self.intent == INTENT_GRAB || self.intent == INTENT_HARM)
		return TRUE
	if(self.intent == INTENT_HELP || self.intent == INTENT_DISARM) //jank, but how else...
		return FALSE
	else
		log_error("Warning! Someone attempted to use [src.name] without an intent!")
		return FALSE
