#define PROJECTILE_MODE_CLOCKWISE "clockwise"
#define PROJECTILE_MODE_COUNTER_CLOCKWISE "counter-clockwise"
#define PROJECTILE_MODE_BULLETHELL "bullethell"
#define PROJECTILE_MODE_CIRCLE "circle"

/ai/simple/glockroach/

	objective_delay = 10
	attack_delay = 10

/ai/simple/glockroach/handle_attacking()

	if(objective_attack)
		handle_projectiles()

	return ..()

/ai/simple/glockroach/proc/handle_projectiles()

	if(!objective_attack)
		return FALSE

	play('sound/weapons/canman_shot.ogg',get_turf(owner))
	owner.shoot_projectile(owner,objective_attack,null,null,/obj/projectile/bullet/firearm/pistol,/damagetype/ranged/bullet/can_man,16,16,0,TILE_SIZE*0.5,1,"#FF4A00",0,0,1,owner.iff_tag,owner.loyalty_tag)
	owner.set_dir(get_dir(owner,objective_attack))

	return TRUE