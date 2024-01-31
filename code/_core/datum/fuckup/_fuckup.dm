/fuckup/
	var/name = "Cancel" //Failsafe.

/fuckup/proc/apply(list/file_contents)
	. = file_contents

/fuckup/economy_broke
	name = "ECONOMY BROKE"

/fuckup/economy_broke/apply(list/file_contents)
	. = ..()
	.["currency"] = 80000
	.["revenue"] = 0
	.["expenses"] = 0
	.["partial_tax"] = 0
	.["last_tax_payment"] = 0