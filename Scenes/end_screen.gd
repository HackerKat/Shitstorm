extends Node3D
var gameOver = false
@onready var deathUi = $DeathUI
@onready var winUi = $WinUI
@onready var scoreUi = $WinUI/Score
var score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	if gameOver:
		deathUi.show()
	else:
		winUi.show()
		
func _set_score():
	scoreUi.text += str(score)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_retry_pressed():
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
