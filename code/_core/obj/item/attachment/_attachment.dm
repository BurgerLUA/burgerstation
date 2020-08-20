/obj/item/attachment
	name = "weapon attachment"
	desc = "Modular!"
	desc_extended = "Attach this to your weapon for EXTRA POWER."
	icon = 'icons/obj/item/attachments.dmi'

	var/list/stats_attachment_set = list()
	var/list/stats_attachment_add = list()
	var/list/stats_attachment_mul = list()


	/*Possible stats:
		damage_multiplier - The multiplier of damage.
		bullet_count - The amount of projectiles that is shot from this gun at once.
		projectile_speed - The speed of the bullet. Capped at 31
		bullet_spread - Spread from the bullet (like shotgun buckshot, most other ammos have 0)
		static_spread - Spread just from the gun's design.
		skill_spread - Spread from how bad you are at using a gun.
		heat_spread - Spread from constant firing of the gun.
		movement_spread - Spread from moving around.
		inaccuracy_modifer - Target doll inaccuracy.
		prone_mod - accuracy improvement from laying prone.
		view_punch - Basically recoil
		shoot_delay - Delay of the gun.
		bursts_to_use - How many shots does one sustained trigger pull give. Only works on automatic weapons.
		shoot_sounds (SET ONLY)
		shoot_alert (SET ONLY)
		damage_type (SET ONLY)
		bullet_color (SET ONLY)
	*/

	//TODO: ADD AUTOMATIC, ZOOM

	var/attachment_offset_x = 0
	var/attachment_offset_y = 0

	value = 200