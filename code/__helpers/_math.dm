/proc/floor(x)
	return round(x)

/proc/ceiling(x,y=1)
	return (-round(-x / y) * y)

/proc/scale(value,min,max)
	return (value - min) / (max - min)


/proc/rand_precise(var/min,var/max)
	return rand(min*100,max*100) / 100

/proc/arctan(x,y)
	if(!x && !y)
		return 0

	var/a = arccos(x/sqrt(x*x+y*y))

	return (y>=0) ? (a):(-a)


// Clamps (duh) a number between 2 other numbers.
// Yes, this implementation is faster than a min(max()) clamp, I've profiled it.
#define Clamp(x, min, max) (x <= min ? min : (x >= max ? max : x))
#define CLAMP01(x)         Clamp((x), 0, 1)



#define BLOCK_DISTANCE(A1,A2) max(abs(A1.x - A2.x),abs(A1.y - A2.y))

#define INFINITY 0xFFFFFF

#define MODULUS(x, y) ( (x) - (y) * round((x) / (y)) )

#define SIMPLIFY_DEGREES(degrees) (MODULUS((degrees), 360))