extends Node

@onready var player = $"../character"
@onready var tornado = $"../Node3D/Tornado"

var distanceToStartSuck = 30
var suckSpeed = 40
var originalSpeed 


# Called when the node enters the scene tree for the first time.
func _ready():
	originalSpeed = player.get("SPEED")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var distance = returnDistance()
	if distance < distanceToStartSuck:
		player.position = player.position.move_toward(tornado.position, delta * 1 / distance * suckSpeed)
		player.setSpeed((distance / originalSpeed) * originalSpeed)
	else:
		player.setSpeed(originalSpeed)
		

func returnDistance() -> float:
	if !player: return -1
	if !tornado: return -2
	var position1 = player.global_position
	var position2 = tornado.global_position
	return position1.distance_to(position2)
