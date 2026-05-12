extends CharacterBody3D

@export var speed := 5.0
@export var jump_velocity := 4.5
@export var mouse_sensitivity := 0.003

var gravity := 9.8

@onready var camera := $Camera3D

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event):
	# Slipp musen med Escape
	if event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

	# Roter med musen
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		# Venstre/høyre – roter hele spilleren rundt Y-aksen
		rotate_y(-event.relative.x * mouse_sensitivity)
		# Opp/ned – roter bare kameraet rundt X-aksen
		camera.rotate_x(-event.relative.y * mouse_sensitivity)
		# Begrens kameraet så det ikke flips helt rundt
		camera.rotation.x = clamp(camera.rotation.x, -PI / 2, PI / 2)

func _physics_process(delta):
	var direction = Vector3.ZERO

	if Input.is_action_pressed("forward"):
		direction -= transform.basis.z
	if Input.is_action_pressed("backward"):
		direction += transform.basis.z
	if Input.is_action_pressed("left"):
		direction -= transform.basis.x
	if Input.is_action_pressed("right"):
		direction += transform.basis.x

	direction = direction.normalized()

	velocity.x = direction.x * speed
	velocity.z = direction.z * speed

	if not is_on_floor():
		velocity.y -= gravity * delta
	else:
		if Input.is_action_just_pressed("jump"):
			velocity.y = jump_velocity

	move_and_slide()
