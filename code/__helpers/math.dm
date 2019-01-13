/proc/clamp(var/value,var/min,var/max)
	return max(min,min(value,max))

/proc/floor(x, y=1)
	return round(x,y)

/proc/ceiling(x, y=1)
	return -round(-x / y) * y

/proc/scale(value,min,max)
	return (value - min) / (max - min)

/proc/arctan(x,y)
	if(!x && !y)
		return 0

	var/a = arccos(x/sqrt(x*x+y*y))

	return (y>=0) ? (a):(-a)