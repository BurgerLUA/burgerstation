/damagetype/ranged/bullet/pistol_9mm //Look, I know there is an intense debate on whether or not .45 is stronger than 9mm. I'm going to just make them equal because FUCK MAKING A STANCE.
	name = "9mm bullet"
	id = "9mm"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = DAMAGE_D,
		PIERCE = DAMAGE_C
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLUNT = ARMOR_D,
		PIERCE = ARMOR_D
	)