extends Node

@onready var player = $"../character"
@onready var tornado = $"../Node3D/Tornado"
@onready var allTornados = [$"../Node3D/Tornado", $"../Node3D2/Tornado", $"../Node3D3/Tornado"]

var distanceToStartSuck = 50
var suckSpeed = 50
var deathDistance = 5
var originalSpeed 


# Called when the node enters the scene tree for the first time.
func _ready():
	originalSpeed = player.get("SPEED")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	checkTornadoStuff(delta)
		

func returnDistance(index) -> float:
	var position1 = player.global_position
	var position2 = allTornados[index].global_position
	return position1.distance_to(position2)
	
func checkTornadoStuff(delta):
	for i in range(allTornados.size()):
		var distance = returnDistance(i)
		if distance < distanceToStartSuck:
			player.position = player.position.move_toward(allTornados[i].position, delta * 1 / distance * suckSpeed)
			player.setSpeed((distance / originalSpeed) * originalSpeed)
		else:
			player.setSpeed(originalSpeed)
		# Dead
		if distance < deathDistance:
			print("DEAD")
			player.endGame(true)
		
