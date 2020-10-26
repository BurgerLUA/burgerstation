/damagetype/npc/goliath_tentacle //No skill
	name = "goliath tentacle"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLADE = DAMAGE_AXE*0.25,
		BLUNT = DAMAGE_AXE*0.1,
		PIERCE = DAMAGE_AXE*0.35,
		DARK = DAMAGE_AXE*0.3
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = AP_AXE*0.25,
		BLUNT = AP_AXE*0.25,
		PIERCE = AP_AXE*0.25,
		DARK = AP_AXE*0.25
	)

	attack_delay = SPEED_AXE*0.5
	attack_delay_max = SPEED_AXE