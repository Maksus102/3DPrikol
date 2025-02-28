extends Node

var state = false
@onready var yes = get_node('Ya')
@onready var no = get_node('No')
@onready var chlang = get_node('ChLang')
var langstate = "rus"

func _process(_delta):
	if Input.is_action_just_pressed("CloseGame") and state == true:
		state = false
		get_tree().paused = false
		menuoff()
	elif Input.is_action_just_pressed("CloseGame") and state == false:
		state = true
		menuon()
	if yes.button_pressed:
		get_tree().quit()
	elif no.button_pressed:
		menuoff()
	elif chlang.button_pressed:
		match langstate:
			"rus": 	
				$"../DialogueBox".data = load("res://dialogesEng.tres")
				langstate = "eng"
			"eng":
				$"../DialogueBox".data = load("res://dialogesRus.tres")
				langstate = "rus"
			
	pass

func menuon():
	self.visible = true
	get_tree().paused = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func menuoff():
	state = false
	get_tree().paused = false
	self.visible = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
