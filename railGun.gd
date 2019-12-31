extends "res://hitscanWeapon.gd"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if event.is_action_pressed("shoot"):
		if self.is_colliding():
			var collider = get_collider()
			if collider.name == "Enemy":
				# collider.increase_points(self.points)
				print("hit")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
