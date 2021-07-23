/obj/item/weapon/ranged/spellgem/metronome
	name = "Soupy's All Purpose spell gem"
	desc = "The source of all... everything, I guess"
	desc_extended = "Soupy the Bozomancer spent a decade crafting the perfect spell, enabling all spells at any time from a single gem. Upon perfecting his masterpiece, he resigned his position as leader of the Syndicate to run Donk Co."
	icon_state = "damage"

	cost_mana = 7
	shoot_delay = 1.5

	bullet_count = 1
	projectile_speed = BULLET_SPEED_PISTOL_LIGHT
	spread_per_shot = 3

	projectile = /obj/projectile/magic/chaos
	ranged_damage_type = /damagetype/ranged/magic/chaos

	shoot_sounds = list('sound/weapons/magic/chaos.ogg','sound/weapons/magic/arc_blade.ogg','sound/weapons/magic/electrical_blast.ogg','sound/weapons/magic/fireball.ogg','sound/weapons/magic/firestream.ogg','sound/weapons/magic/frost.ogg','sound/weapons/magic/fractal.ogg','sound/weapons/magic/magic_missile.ogg','sound/weapons/magic/slow.ogg','sound/weapons/magic/summon.ogg','sound/weapons/magic/zap.ogg')

	var/projectile_list = list(/obj/projectile/magic/fireball, /obj/projectile/magic/chaos,/obj/projectile/magic/magic_missile,/obj/projectile/magic/blade,/obj/projectile/magic/tesla,/obj/projectile/magic/frost,/obj/projectile/magic/lesser_fire,/obj/projectile/magic/crystal,/obj/projectile/magic/shadow,/obj/projectile/magic/fractal,/obj/projectile/magic/holy_cross,/obj/projectile/magic/unholy_skull)

	var/damage_list = list(/damagetype/ranged/magic/arcblade,/damagetype/ranged/magic/frost,/damagetype/ranged/magic/holy_cross,/damagetype/ranged/magic/chaos,/damagetype/ranged/magic/crystal,/damagetype/ranged/magic/flame,/damagetype/ranged/magic/magefire,/damagetype/ranged/magic/magic_missile,/damagetype/ranged/magic/tesla)

	color = "#B00B1E" //LOLZ
	color_2 = "#DEAD00" //Spelling in my spells
	color_3 = "#00BEEF" //i spell while i spell

	value = 2700

/obj/item/weapon/ranged/spellgem/metronome/can_gun_shoot(var/mob/caller) //Shuffle properties, then check.
    cost_mana = rand(3, 17)
    ranged_damage_type = pick(damage_list)
    projectile = pick(projectile_list)
    shoot_delay = rand(8, 40) / 10
    bullet_count = rand(1, 4)
    spread_per_shot = rand(0, 6)
    projectile_speed = rand(12, TILE_SIZE - 1)

    return ..()
