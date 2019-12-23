extends Area2D

export var speed = 400
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
func _process(delta):
	# The Movement
	var velocity = Vector2()  # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if velocity.length() > 0:
	# If 1 and 1 gives sqrt(2)
		velocity = velocity.normalized() * speed
	
	# We now move the position and prevent from leaving the screen
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	# The Aiming
	var look_vec = get_global_mouse_position() - global_position
	global_rotation = atan2(look_vec.y, look_vec.x)
	
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