#define FLAG_PREFIX_NONE 0x0
#define FLAG_PREFIX_ALL 0xFF
#define FLAG_PREFIX_RANGED 0x1
#define FLAG_PREFIX_MELEE 0x2
#define FLAG_PREFIX_MAGIC 0x4

/prefix/
	name = "Prefix Template"
	id = null
	desc = "Description for the prefix."

	var/value_mul = 1

	var/rarity = RARITY_COMMON

	var/flags = FLAG_PREFIX_ALL

	var/list/stat_mul = list(
		"damage" = 1,
		"multishot" = 1,
		"firerate" = 1,
		"accuracy" = 1
	)

	var/chance_weight = 1
