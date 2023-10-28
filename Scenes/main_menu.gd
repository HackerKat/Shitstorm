extends Control

var gameStarted
const loading_scene_path = "res://Scenes/loading.tscn"
@onready var continueButton = $ContinueButton
@onready var playButton = $PlayButton
@onready var mainmenu = $"."
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	


func _on_play_button_pressed():
	gameStarted = true
	get_tree().change_scene_to_file(loading_scene_path)


func _on_quit_button_pressed():
	get_tree().quit()


func _on_credits_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/credits.tscn")


func _on_continue_button_pressed():
	get_tree().paused = false
	mainmenu.hide()
