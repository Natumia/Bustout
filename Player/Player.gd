extends KinematicBody2D

var velocity = Vector2.ZERO
var mousePos = Vector2.ZERO

var maxSpeed =  300

func _physics_process(_delta):
	velocity = Vector2.ZERO
	mousePos = get_local_mouse_position()
	if abs(mousePos.x) <= 3:
		velocity.x = 0
	else:
		velocity.x = lerp(velocity.x, mousePos.x, 5)
		velocity.x = clamp(velocity.x, -maxSpeed, maxSpeed)
	
	velocity = move_and_slide(velocity)
