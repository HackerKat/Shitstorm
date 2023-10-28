extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const FRICTION = 25
const HORIZONTAL_ACCELERATION = 30
const MAX_SPEED=5
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var normal_cam = $Camera3D
@onready var selfie_cam = $SelfieCam
@onready var current_cam = $Camera3D
@onready var camera_ui = $SelfieCam/CameraUI

var is_selfie_active = false
var battery_time = Timer.new()

var amount_photos = 5
var min_to_end = 5
var battery_status = 1
var seconds_for_timer = min_to_end * 60
var photos: Array = []

func _ready():
	Input.mouse_mode=Input.MOUSE_MODE_CAPTURED
	# Start timer for battery
	#battery_time.connect("timeout",self,"do_this")
	battery_time.wait_time = seconds_for_timer
	battery_time.one_shot = true
	add_child(battery_time)
	battery_time.start()

func _process(delta):
	camera_ui.visible = is_selfie_active
	battery_status = battery_time.time_left / seconds_for_timer
	camera_ui.battery_status = battery_status

func _unhandled_input(event):
	if event is InputEventMouseMotion and Input.mouse_mode==Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * .005)
		current_cam.rotate_x(-event.relative.y * .005)
		current_cam.rotation.x = clamp(current_cam.rotation.x, -PI/2, PI/2)

func _unhandled_key_input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		if Input.mouse_mode==Input.MOUSE_MODE_CAPTURED: 
			Input.mouse_mode=Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode=Input.MOUSE_MODE_CAPTURED

func _input(event):
	if event.is_action_pressed("switch_camera"):
		switch_camera()
	elif event.is_action_pressed("take_photo"):
		take_photo()

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor() and Input.mouse_mode==Input.MOUSE_MODE_CAPTURED:
		velocity.y += JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Vector3.ZERO
	var movetoward = Vector3.ZERO
	input_dir.x = Input.get_vector("move_left", "move_right", "move_forward", "move_backward").x
	input_dir.y = Input.get_vector("move_left", "move_right", "move_forward", "move_backward").y
	input_dir=input_dir.normalized()
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	direction *= SPEED
	velocity.x = move_toward(velocity.x,direction.x, HORIZONTAL_ACCELERATION * delta)
	velocity.z = move_toward(velocity.z,direction.z, HORIZONTAL_ACCELERATION * delta)

	var angle=5
	#rotation_degrees=Vector3(input_dir.normalized().y*angle,rotation_degrees.y,-input_dir.normalized().x*angle)
	var t = delta * 6
	if Input.mouse_mode==Input.MOUSE_MODE_CAPTURED: 
		rotation_degrees=rotation_degrees.lerp(Vector3(input_dir.normalized().y*angle,rotation_degrees.y,-input_dir.normalized().x*angle),t)
	
	move_and_slide()
	force_update_transform()

func switch_camera():
	if is_selfie_active:
		# change current_cam to normal_cam
		current_cam = normal_cam
		# turn off selfie_cam for viewport 
		# so normal_cam is used
		selfie_cam.current = false
		is_selfie_active = false
	else:
		current_cam = selfie_cam
		selfie_cam.current = true
		is_selfie_active = true

func take_photo():
	if photos.size() + 1 < amount_photos:
		var viewport: Viewport = get_viewport()
		var tex: Texture = viewport.get_texture()
		var img: Image = tex.get_image()
		img.flip_y()
		var photo: Photo = Photo.new(position, battery_time.time_left, img)
		photos.append(photo)
		
		camera_ui.storage_capacity = photo.size()
		print("photo has been taken")
	else:
		print("no photo left")
