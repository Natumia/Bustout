extends Node2D

onready var ballScene = preload("res://Ball/Ball.tscn")

var levelSpeed = 80

func _ready():
	levelSpeed = clamp(levelSpeed, 80, 250)

func spawn_ball():
	var ball = ballScene.instance()
	add_child(ball)
	ball.set_position(Vector2(128, 200))
	ball.ballSpeed = levelSpeed
	return ball

func check_balls():
	var ballCount = get_tree().get_nodes_in_group("Ball").size()
	return ballCount

func check_bricks():
	var brickCount = get_tree().get_nodes_in_group("Brick").size()
	return brickCount
