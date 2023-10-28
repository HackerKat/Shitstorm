extends Node3D
var gameOver = GlobalData.is_dead
@onready var deathUi = $DeathUI
@onready var winUi = $WinUI
@onready var scoreUi = $WinUI/Score
@onready var scoreText = scoreUi.text
@onready var photoUione = $WinUI/Photo1
@onready var photoUitwo = $WinUI/Photo2
@onready var photoUithree = $WinUI/Photo3
@onready var photoUifour = $WinUI/Photo4
@onready var photoUifive = $WinUI/Photo5
var score = GlobalData.score
var photos = GlobalData.photos

# Called when the node enters the scene tree for the first time.
func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	Input.mouse_mode=Input.MOUSE_MODE_VISIBLE
	if gameOver:
		deathUi.show()
	else:
		winUi.show()
		_set_score()
		_set_photos()
		
func _set_score():
	scoreUi.text = scoreText + str(int(score))
	
func _set_photos():
	var itex = ImageTexture.new()
	#itex = ImageTexture.create_from_image(photos[0].picture)
	
	photoUione.texture = ImageTexture.create_from_image(photos[0].picture)
	photoUitwo.texture = ImageTexture.create_from_image(photos[1].picture)
	photoUithree.texture = ImageTexture.create_from_image(photos[2].picture)
	photoUifour.texture = ImageTexture.create_from_image(photos[3].picture)
	photoUifive.texture = ImageTexture.create_from_image(photos[4].picture)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_retry_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
	
