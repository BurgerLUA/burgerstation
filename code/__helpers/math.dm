/proc/clamp(var/value,var/min,var/max)
	return max(min,min(value,max))

/proc/floor(x, y=1)
	return round(x,y)

/proc/ceiling(x, y=1)
	return -round(-x / y) * y

/proc/scale(value,min,max)
	return (value - min) / (max - min)