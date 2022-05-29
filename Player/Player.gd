extends KinematicBody2D

onready var tween = $Tween

var velocity = Vector2.ZERO
var mousePos = Vector2.ZERO

var maxSpeed =  300

# This will need to be set in the Scene Manager and Accessed with the
# Pause Button. 
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)

# This allows me to escape out of game confinement.
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _physics_process(_delta):
	velocity = Vector2.ZERO
	mousePos = get_local_mouse_position()
	if abs(mousePos.x) <= 3:
		velocity.x = 0
	else:
		velocity.x = lerp(velocity.x, mousePos.x, 5)
		velocity.x = clamp(velocity.x, -maxSpeed, maxSpeed)
	
	velocity = move_and_slide(velocity)
