extends Node

var state = false
@onready var yes = get_node('Ya')
@onready var no = get_node('No')

func _process(_delta):
	if Input.is_action_just_pressed("CloseGame") and state == true:
		state = false
		get_tree().paused = false
		menuoff()
	elif Input.is_action_just_pressed("CloseGame") and state == false:
		state = true
		menuon()
		#get_tree().paused = true
	if yes.button_pressed:
		get_tree().quit()
	elif no.button_pressed:
		#get_tree().paused = false
		menuoff()
	pass

func menuon():
	self.visible = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func menuoff():
	state = false
	self.visible = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
