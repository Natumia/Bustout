extends StaticBody2D

export var health = 1 setget _set_health

func _set_health(value): 
	health = value
	if get_node_or_null("Sprite") != null:
		$Sprite.set_frame(health - 1)
