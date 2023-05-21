/loadout/bandit/get_spawning_items()
	. = ..()
	if(prob(20))
		. += pick(/loot/random/gun/slavic/bandit,/loot/random/gun/syndicate/bandit,/loot/random/gun/nanotrasen/bandit)
	else
		. += /loot/random/gun/solarian/bandit

/loadout/bandit/male
	spawning_items = list(
		/loot/bandit/back_storage,
		/loot/bandit/belt_storage,
		/loot/bandit/socks/male,
		/loot/bandit/pants/male,
		/loot/bandit/shirt/male,
		/loot/bandit/shoes,
		/loot/bandit/armor,
		/loot/bandit/coat,
		/loot/bandit/head,
		/loot/bandit/melee/small,
	)



/loadout/bandit/female
	spawning_items = list(
		/loot/bandit/back_storage,
		/loot/bandit/belt_storage,
		/loot/bandit/socks/female,
		/loot/bandit/pants/female,
		/loot/bandit/shirt/female,
		/loot/bandit/shoes,
		/loot/bandit/armor,
		/loot/bandit/coat,
		/loot/bandit/head,
		/loot/bandit/melee/small,
	)