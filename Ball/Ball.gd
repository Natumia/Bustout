extends RigidBody2D

onready var animPlayer = $AnimationPlayer

var ballSpeed = 50

func _ready(): 
	ballSpeed = clamp(ballSpeed, 120, 200)
	randomize()
	animPlayer.play("Spawn")

func start_ball():
	linear_velocity.y = -ballSpeed
	linear_velocity.x = rand_range(-20, 20)

func _on_Area2D_body_entered(body):
	if body.is_in_group("Brick"):
		if body.health > 1:
			body.health = body.health - 1
		else:
			body.queue_free()
	if body.is_in_group("LoseBall"):
		self.queue_free()

func _integrate_forces(state):
	rotation_degrees = 0
	if state.linear_velocity.length() > ballSpeed:
		state.linear_velocity = state.linear_velocity.normalized() * ballSpeed
