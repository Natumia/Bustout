extends RigidBody2D

export var levelSpeed = 50

func _ready(): 
	levelSpeed = clamp(levelSpeed, 120, 200)
	randomize()
	start_ball()

func start_ball():
	linear_velocity.y = -levelSpeed
	linear_velocity.x = rand_range(-20, 20)

func _on_Area2D_body_entered(body):
	if body.is_in_group("Brick"):
		body.health = body.health - 1

func _integrate_forces(state):
	rotation_degrees = 0
	if state.linear_velocity.length() > levelSpeed:
		state.linear_velocity = state.linear_velocity.normalized() * levelSpeed
