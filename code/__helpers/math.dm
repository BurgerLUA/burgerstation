/proc/clamp(var/value,var/min,var/max)
	return max(min,min(value,max))