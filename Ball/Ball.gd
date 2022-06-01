extends RigidBody2D

signal score_change
signal lose_ball

onready var animPlayer = $AnimationPlayer

var ballSpeed = 80

const MAX_SPEED = 250

func _ready(): 
	randomize()
	animPlayer.play("Spawn")

func start_ball():
	linear_velocity.y = -ballSpeed
	linear_velocity.x = rand_range(-0.8 * ballSpeed, 0.8 * ballSpeed)

func _on_Area2D_body_entered(body):
	if body.is_in_group("Brick"):
		if body.health > 1:
			body.health = body.health - 1
			emit_signal("score_change", "hit")
		else:
			body.queue_free()
			emit_signal("score_change", "break")
	if body.is_in_group("LoseBall"):
		emit_signal("lose_ball")
		self.queue_free()

func _integrate_forces(state):
	rotation_degrees = 0
	if state.linear_velocity.length() >= MAX_SPEED:
		state.linear_velocity = state.linear_velocity.normalized() * MAX_SPEED
	elif state.linear_velocity.length() <= ballSpeed:
		state.linear_velocity = state.linear_velocity.normalized() * ballSpeed
