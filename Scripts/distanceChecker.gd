extends Node

@onready var player = %Player
@onready var tornado = $"../Tornado"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(returnDistance())

func returnDistance() -> float:
	if !player: return -1
	if !tornado: return -2
	var position1 = player.global_position
	var position2 = tornado.global_position
	return position1.distance_to(position2)
