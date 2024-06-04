extends CharacterBody2D

const SPEED = 100
const SPRINT_MULT = 1.5
const MAX_HP = 100
const MAX_STAM = 100
var HP = 100
var STAM = 100
@onready var _animated_sprite = $AnimatedSprite2D
@onready var _progress_bar = $TextureProgressBar
func _physics_process(delta):
	_progress_bar.value = STAM
	_progress_bar.visible = !STAM == 100
	
	_anim_move(delta)
	_anim_turn(delta)
	var direction := Vector2.ZERO
	if (STAM <= MAX_STAM) and !Input.is_action_pressed("ui_sprint"):
		STAM += 0.25;
		if (STAM > MAX_STAM):
			STAM = MAX_STAM
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	if Input.is_action_pressed("ui_up"):
		direction.y -= 1
	if Input.is_action_pressed("ui_down"):
		direction.y += 1
	if Input.is_action_pressed("ui_sprint") and (STAM > 0):
		velocity = direction.normalized() * SPEED * SPRINT_MULT
		STAM -= 0.5
	else:
		velocity = direction.normalized() * SPEED
	
	move_and_slide()



func _anim_move(_delta):
	if (Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_down")):
		_animated_sprite.play("run")
	else:
		_animated_sprite.stop()
func _anim_turn(_delta):
	if (Input.is_action_pressed("ui_left")):
		if (!_animated_sprite.is_flipped_h()):
			_animated_sprite.set_flip_h(!_animated_sprite.is_flipped_h())
	if (Input.is_action_pressed("ui_right")):
		if (_animated_sprite.is_flipped_h()):
			_animated_sprite.set_flip_h(!_animated_sprite.is_flipped_h())
	
		


		
	
