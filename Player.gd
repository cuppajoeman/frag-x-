
extends KinematicBody2D

# A = dV/dT so takes 4 seconds to reach max vel
export var MAX_SPEED = 500
export var ACCELERATION = 2000
export var VEL_VECTOR = Vector2.ZERO

export var points = 0
# set the starting weapon
var current_weapon = load("res://railGun.tscn").instance()
var screen_size

enum Weapons {
	# HitScan
	railGun,
	lightningGun,
	shotGun,
	# Projectile
	rocketLauncher,
	grendeLauncher,
	# Melee
	axe
}


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	# Set the initial weapon
	add_child(current_weapon)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	# The Movement
	var input_dir = get_input_direction_vector()
	if input_dir == Vector2.ZERO:
		# Passing in velocities magnitude
		apply_friction(ACCELERATION * delta)
	else:
		# We are passing our newly calculated velocity
		update_velocity(input_dir * ACCELERATION * delta)
	# This updates the vector to a new one that results from the movement
	# While also moving the node with the given velocity
	VEL_VECTOR = move_and_slide(VEL_VECTOR)
	
	
	# The Aiming
	var look_vec = get_global_mouse_position() - global_position
	global_rotation = atan2(look_vec.y, look_vec.x)
	
# MOVEMENT STUFF

func get_input_direction_vector():
	var dv = Vector2.ZERO
	dv.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	dv.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	return dv.normalized()
	
func update_velocity(new_vel):
	VEL_VECTOR += new_vel
	VEL_VECTOR = VEL_VECTOR.clamped(MAX_SPEED)
	
func apply_friction(amount):
	# Amount is equal to the same vel we move by
	if VEL_VECTOR.length() > amount:
		VEL_VECTOR -= VEL_VECTOR.normalized() * amount
	else:
		VEL_VECTOR = Vector2.ZERO
		

# WEAPON STUFF

func set_weapon(weapon):
    var old_weapon = current_weapon
    remove_child(old_weapon)
    old_weapon.queue_free()
    match weapon:
        Weapons.railGun:
            current_weapon = load("res://railGun.tscn").instance()
    add_child(current_weapon)
	
func increase_points(num_points):
	self.points += num_points