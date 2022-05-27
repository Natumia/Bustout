extends RigidBody2D

export var startSpeed = 50

func _ready():
	randomize()
	start_ball()

func start_ball():
	linear_velocity.y = -startSpeed
#	linear_velocity.x = rand_range(-20, 20)

func _on_Area2D_body_entered(body):
	if body.is_in_group("Brick"):
		body.health = body.health - 1
