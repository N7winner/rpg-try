extends CharacterBody2D
#node references
@onready var animation_sprite = $AnimatedSprite2D
# player movement speed
@export var speed = 50
#direction and animation to be updated throughout game state
var new_direction = Vector2(0,1) #only move one spaces
var animation


func _physics_process(delta):
		# get player input (left, right, up, down
	var direction: Vector2
	direction.x = Input.get_action_strength("ui_right") -Input.get_action_strength("ui_left")
	direction.y = Input.get_action_strength("ui_down") -Input.get_action_strength("ui_up")
	# if input is digital, normalize it for diagonal movement
	if abs(direction.x) == 1 and abs(direction.y) == 1:
		direction = direction.normalized()
	# apply movement
	var movement = speed * direction * delta
	# moves our player around, whilst enforcing collisions so that they come to a stop when colliding with another object.
	move_and_collide(movement)
	#plays animations
	player_animations(direction)

#animations

func player_animations(direction : Vector2):
	var new_direction = Vector2(0,1)
	#Vector2.ZERO is short for Vector2(0, 0)
	if direction != Vector2.ZERO:
		#update our direction with the new_direction
		new_direction = direction
		#play walk anim since we're moving
		animation = "walk_" + returned_direction(new_direction)
		animation_sprite.play(animation)
	else:
		#play idle since we're standing still
		animation = "idle_" + returned_direction(new_direction)
		animation_sprite.play(animation)
		
#animation direction
func returned_direction(direction : Vector2):
	#it normalizes the direction vector
	var normalized_direction = direction.normalized()
	var default_return = "side"
	
	if normalized_direction.y > 0:
		return "down"
	elif normalized_direction.y < 0:
		return "up"
	elif normalized_direction.x > 0:
		$AnimatedSprite2D.flip_h = false
		return "side"
	elif normalized_direction.x < 0:
		$AnimatedSprite2D.flip_h = true
		return "side"
	#default value is empty
	return default_return
