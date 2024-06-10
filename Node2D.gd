extends Enemy
@onready var _animated_sprite = $AnimatedSprite2D
@onready var _progress_bar = $TextureProgressBar
var speed = 20
var player_chase = false
var player = null

func _physics_process(delta):
	_progress_bar.value = hp
	
	if (hp > 0):
		_animated_sprite.play("idle")
	if player_chase:
		velocity = global_position.direction_to(player.global_position) * speed
	else:
		velocity = Vector2(0,0)
	move_and_slide()

func _on_detection_area_body_entered(body):
	player = body
	player_chase = true
	
func _on_detection_area_body_exited(_body):
	player = null
	player_chase = false
	
func _die(delta):
	if (hp <= 0):
		_animated_sprite.pause("idle")
		_animated_sprite.play("death")
