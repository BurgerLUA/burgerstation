/* OLD
//https://www.desmos.com/calculator/uyznrero9w
/proc/calculate_damage_with_armor(var/damage_dealt,var/armor_rating)
	if(damage_dealt < 0)
		CRASH_SAFE("Damage [damage_dealt] was negative!")
		return 0
	if(!damage_dealt || !armor_rating)
		return damage_dealt
	if(abs(armor_rating) == INFINITY)
		return 0
	if(armor_rating <= 0)
		return damage_dealt * (1 + (-armor_rating/200))
	return clamp((damage_dealt - (armor_rating*0.4)) * max(0.5,1 - (armor_rating/(50+damage_dealt))),damage_dealt*0.1,damage_dealt)
*/


/* OLD
//https://www.desmos.com/calculator/vsmeclqdpy
/proc/calculate_damage_with_armor(var/damage_dealt,var/armor_rating)
	if(damage_dealt < 0)
		CRASH_SAFE("Damage [damage_dealt] was negative!")
		return 0
	if(!damage_dealt || !armor_rating)
		return damage_dealt
	if(IS_INFINITY(armor_rating))
		return 0
	if(armor_rating <= 0)
		return damage_dealt * (1 + (-armor_rating/200))
	return max(1,damage_dealt - ( (armor_rating**0.4)*2.8 ) )
*/

/* OLD
//https://www.desmos.com/calculator/sf50j6wote
/proc/calculate_damage_with_armor(var/damage_dealt,var/armor_rating)
	if(damage_dealt < 0)
		CRASH_SAFE("Damage [damage_dealt] was negative!")
		return 0
	if(!damage_dealt || !armor_rating)
		return damage_dealt
	if(IS_INFINITY(armor_rating))
		return 0
	if(armor_rating <= 0)
		return damage_dealt * (1 + (-armor_rating/200))
	return damage_dealt*max(0.5,max(0,1 - (armor_rating/(damage_dealt*1.5))**0.4))
*/


//https://www.desmos.com/calculator/bjhgq1m6e0
/proc/calculate_damage_with_armor(var/damage_dealt,var/armor_rating)
	if(damage_dealt < 0)
		CRASH_SAFE("Damage [damage_dealt] was negative!")
		return 0
	if(!damage_dealt || !armor_rating)
		return damage_dealt
	if(IS_INFINITY(armor_rating))
		return 0
	if(armor_rating <= 0)
		return damage_dealt * (1 + (-armor_rating/200))

	var/a = armor_rating
	var/d = damage_dealt
	var/c = 0.8 //Cooefient
	var/m = 200 //Ideal armor rating to negative c (as a percent) damage.

	if(armor_rating >= m)
		return d*c

	return  ( (1-c*0.5)*d) + (d*cos(a*(1/m)*180)*c*0.5)



//Experimental graph: https://www.desmos.com/calculator/tsnxztlg8s
//https://www.desmos.com/calculator/ydcvdgqub3
//https://www.desmos.com/calculator/oslekv5yxl
//https://www.desmos.com/calculator/1xx8dsvxcs