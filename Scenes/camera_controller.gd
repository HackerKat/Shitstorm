extends Control
var battery_status = 5
var storage_capacity = 5

@onready var battery = $Battery
@onready var storageLabel = $Storage/Label
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	battery.value =  battery_status * 100
	storageLabel.text = str(storage_capacity)
