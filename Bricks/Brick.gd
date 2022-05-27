extends StaticBody2D

export var health = 1 setget _set_health

func _ready():
	pass

func _set_health(value): 
	health = value
	if health == 0:
		queue_free()
	elif get_node_or_null("Sprite") != null:
		$Sprite.set_frame(health - 1)
