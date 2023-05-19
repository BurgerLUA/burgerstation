/obj/item/weapon/ranged/thrown
	name = "thrown weapon"
	desc = "Special type for thrown."
	desc_extended = "Left click throws one. Actually throwing the whole thing throws all of them."

	icon_state = "inventory"

	amount = 1
	amount_max = 1

	projectile = /obj/projectile/thrown //Always needs to be thrown
	shoot_sounds = list('sound/effects/fwoosh.ogg')

	company_type = "Black Spider Clan"

	var/one_icon = FALSE //For those who are lazy, and want to only sprite one thing.



/obj/item/weapon/ranged/thrown/get_base_value()
	. = ..()
	. *= 0.05

/obj/item/weapon/ranged/thrown/update_icon()
	. = ..()
	icon = initial(icon)
	if(!one_icon)
		icon_state = "[min(amount,amount_max)]"

/obj/item/weapon/ranged/thrown/shoot_projectile(var/atom/caller,var/atom/target,location,params,var/obj/projectile/projectile_to_use,var/damage_type_to_use,var/icon_pos_x=0,var/icon_pos_y=0,var/accuracy_loss=0,var/projectile_speed_to_use=0,var/bullet_count_to_use=1,var/bullet_color="#FFFFFF",var/view_punch=0,var/damage_multiplier=1,var/desired_iff_tag,var/desired_loyalty_tag,var/desired_inaccuracy_modifier=1,var/base_spread = get_base_spread(),var/penetrations_left=0)

	. = ..()

	for(var/k in .)
		var/obj/projectile/P = k
		var/obj/item/weapon/ranged/thrown/I = new src.type(P)
		I.amount = 1
		INITIALIZE(I)
		FINALIZE(I)
		P.appearance = src.appearance
		P.icon_state = "inventory"
		P.plane = initial(P.plane)
		P.layer = initial(P.layer)
		add_item_count(-1)
		if(src.qdeleting)
			break

/obj/item/weapon/ranged/thrown/kunai
	name = "kunai"
	icon = 'icons/obj/item/weapons/ranged/thrown/kunai.dmi'
	desc = "Just like my japanese animes!"
	desc_extended = "A deadly bladed throwing weapon that pierces flesh and armor."

	ranged_damage_type = /damagetype/ranged/thrown/kunai

	amount = 1
	amount_max = 3

	value = 20



