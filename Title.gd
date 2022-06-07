extends Node2D

onready var pressStart = $RichTextLabel
onready var titleAnim = $Control/AnimationPlayer
onready var tranAnim = $CanvasLayer/ColorRect/AnimationPlayer
onready var highScores = $HighScores

# Going to parse the player scores on this node.
func _ready():
	HighScores.load_scores()
	
	var index = 4
	for i in highScores.get_children():
		if i != highScores.get_children()[0]:
			
			var string = str(HighScores.scores[index])
			var mod = string.length() % 3
			var res = ""
			
			for n in range(0, string.length()):
				if n != 0 and n % 3 == mod:
					res += ","
				res += string[n]
			
			i.set_bbcode(str("[center]", res, "[/center]"))
			index -= 1

func _input(event):
	if event.is_action_pressed("ui_accept") and titleAnim.current_animation == "Begin":
		titleAnim.play("Done")
		highScores.visible = true
		pressStart.visible = true
	elif event.is_action_pressed("ui_accept"):
		tranAnim.play("Fadeout")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Begin":
		titleAnim.play("Done")
		highScores.visible = true
		pressStart.visible = true
	if anim_name == "Fadeout":
		get_tree().change_scene("res://System/SceneManager.tscn")
