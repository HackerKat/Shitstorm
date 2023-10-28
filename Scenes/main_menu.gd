extends Control

const loading_scene_path = "res://Scenes/loading.tscn"
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_play_button_pressed():
	get_tree().change_scene_to_file(loading_scene_path)


func _on_quit_button_pressed():
	get_tree().quit()


func _on_credits_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/credits.tscn")
