extends CharacterBody2D

@onready var sprite = $Sprite2D 

const SPEED = 200.0
const JUMP_VELOCITY = -450.0

# ----------------- THE FIX IS HERE -----------------
# Change 'const' to '@onready var'
@onready var GRAVITY_STRENGTH: float = ProjectSettings.get_setting("physics/2d/default_gravity")
# ---------------------------------------------------

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		# Apply gravity directly to the Y component of the velocity.
		velocity.y += GRAVITY_STRENGTH * delta 

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
		
		# Code for flipping the sprite
		sprite.flip_h = direction < 0
		
	else:
		velocity.x = move_toward(velocity.x, 0, 12)

	move_and_slide()
