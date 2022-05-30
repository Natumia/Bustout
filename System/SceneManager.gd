extends Node2D

var currentLevel = null

func _ready():
	currentLevel = $CurrentLevel.get_children()[0]

func goto_next_level():
	var levelNumber = int(currentLevel.name)
	if !ResourceLoader.exists(str("res://Levels/Level_", levelNumber + 1, ".tscn")):
		print("Next level not found!")
	else:
		var nextLevel = load(str("res://Levels/Level_", levelNumber + 1, ".tscn")).instance()
		currentLevel.queue_free()
		$CurrentLevel.add_child(nextLevel)
		currentLevel = $CurrentLevel.get_node(str("Level_", levelNumber + 1))

func _input(event):
	if event.is_action_pressed("ui_accept") and currentLevel.check_balls() == 0:
		currentLevel.spawn_ball()
	if event.is_action_pressed("ui_end"):
		goto_next_level()

 
