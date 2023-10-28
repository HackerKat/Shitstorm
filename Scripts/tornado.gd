extends RigidBody3D

var velocity = Vector3(1, 0, 1)  # Initial velocity.
var speed = 0.1  # Adjust the speed as needed.
var angular_speed = 1.0  # Adjust the angular speed as needed.
var previous_direction = Vector3(0,0,0)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Update the rotation based on the angular speed.
	#rotate_y(angular_speed * delta)
	
	# Generate random numbers for the X, Y, and Z components of velocity.
	var random_direction = Vector3(randf_range(-1.0,1.0), 0, randf_range(-1.0,1.0))
	random_direction = random_direction.normalized() + previous_direction
	
	# Update the velocity based on the random direction and adjust the speed.
	velocity = random_direction * speed
	previous_direction = random_direction
	# Move the object based on the updated velocity.
	# global_transform.origin += velocity * delta
	apply_force(random_direction)
	# * delta)
