extends Node

# Photo.gd (Photo class definition)

# Define the Photo class to encapsulate the necessary attributes
class_name Photo

const PENALTY_POSITION_DIFFERENCE = 69
const PENALTY_TIME_DIFFERENCE = 42

# Properties of the Photo class
var position  # Variable to store the position of the photo
var picture  # Variable to store the picture (e.g., an Image texture or other relevant data)
var timestamp 
var tornado_position


func efficiency_graph(value, mult):
	# returns a value between 0 and 1 on a graph that looks like a sin-wave
	if value < 0:
		return 0
	if value > mult:
		return 1
	return 1 - (1 - (value / mult) ** 2) ** 2

# Constructor to initialize the Photo object with provided angle, position, and picture
func _init(position,timestamp, picture, tornado_position):
	self.position = position
	self.picture = picture
	self.timestamp = timestamp
	self.tornado_position = tornado_position #get_node("Tornado").global_position


func score(photos):
	# gets the photos and calculates 
	var res = base_score()
	for photo in photos:
		res += comparison_score(photo)
		
	return min(1000, res)

func base_score():
	var distance = (self.position - self.tornado_position).lenght()
	
	var res = 0
	if distance > 1:
		res = 0.5 / distance
	else:
		res = distance * 0.5 + 1
	
	return min(500, res * 10000)

func comparison_score(other):
	var position_difference = (self.position - other.position).length()
	
	
	var time_difference = abs(self.timestamp - other.timestamp)
	
	#print("Δp: ", position_difference, " Δt ", time_difference)
	
	var position_efficiency = efficiency_graph(position_difference, PENALTY_POSITION_DIFFERENCE)
	var time_efficiency = efficiency_graph(time_difference, PENALTY_TIME_DIFFERENCE)
	
	#print("Ep: ",position_efficiency,  " Et: ", time_efficiency)
	
	
	
	var res = position_efficiency * 0.8 + time_efficiency * 0.2 #* angle_efficiency
	res *= 50
	#print("Score: ", res)
	
	return res
	

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
