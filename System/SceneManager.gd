extends Node2D

onready var spawnLabel = $GUI/SpawnNotice

onready var stageNumber = $GUI/StageNumber
onready var scoreAmount = $GUI/ScoreAmount
onready var livesAmount = $GUI/LivesAmount

onready var transition = $GUI/LevelTransition/AnimationPlayer

var transitionPaused = false

var currentLevel = null
var lives = 3
var score = 0

var player = null
var scoreMult = null

func _ready():
	currentLevel = $CurrentLevel.get_children()[0]
	scoreMult = 1 + int(currentLevel.name) * .3

func _process(_delta):
	if currentLevel.check_balls() == 0:
		spawnLabel.visible = true
	else:
		spawnLabel.visible = false
	
	if currentLevel.check_bricks() == 0:
		goto_next_level()
	
	stageNumber.set_bbcode(str("[center]", int(currentLevel.name), "[/center]"))

func goto_next_level():
	var levelNumber = int(currentLevel.name)
	if !ResourceLoader.exists(str("res://Levels/Level_", levelNumber + 1, ".tscn")):
		print("Next level not found!")
	else:
		get_tree().paused = true
		transitionPaused = true
		transition.play("FadeOut")
	
	scoreMult = 1 + int(currentLevel.name) * .3

func transition_start():
	var levelNumber = int(currentLevel.name)
	var nextLevel = load(str("res://Levels/Level_", levelNumber + 1, ".tscn")).instance()
	currentLevel.queue_free()
	$CurrentLevel.add_child(nextLevel)
	currentLevel = $CurrentLevel.get_node(str("Level_", levelNumber + 1))
	currentLevel.levelSpeed = 80 + levelNumber * 5
	player = currentLevel.get_node("Player")
	transition.play("FadeIn")

func transition_end():
	get_tree().paused = false
	transitionPaused = false

func _input(event):
	if event.is_action_pressed("ui_accept") and currentLevel.check_balls() == 0 and transitionPaused == false:
		currentLevel.spawn_ball()
		var ball = currentLevel.get_node("Ball")
		ball.connect("score_change", self, "adjust_score")
		ball.connect("lose_ball", self, "lose_life")
	if event.is_action_pressed("ui_end"):
		goto_next_level()

func adjust_score(value):
	var adjustScore = 0
	if value == "hit":
		adjustScore = 50 * scoreMult
	elif value == "break":
		adjustScore = 100 * scoreMult
	adjustScore = round(adjustScore)
	score += adjustScore
	
	var string = str(score)
	var mod = string.length() % 3
	var res = ""
	
	for i in range(0, string.length()):
		if i != 0 and i % 3 == mod:
			res += ","
		res += string[i]
	
	scoreAmount.set_bbcode(str("[center]", res, "[/center]"))

func lose_life():
	lives -= 1
	if lives == 0:
		HighScores.save_scores(score)
		get_tree().change_scene("res://Title.tscn")
	else:
		livesAmount.set_bbcode(str("[center]", lives, "[/center]"))
