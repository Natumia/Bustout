extends Node2D

onready var pressStart = $RichTextLabel
onready var titleAnim = $Control/AnimationPlayer
onready var tranAnim = $CanvasLayer/ColorRect/AnimationPlayer

func _input(event):
	if event.is_action_pressed("ui_accept") and titleAnim.current_animation == "Begin":
		titleAnim.play("Done")
		pressStart.visible = true
	elif event.is_action_pressed("ui_accept"):
		tranAnim.play("Fadeout")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Begin":
		titleAnim.play("Done")
		pressStart.visible = true
	if anim_name == "Fadeout":
		get_tree().change_scene("res://System/SceneManager.tscn")
