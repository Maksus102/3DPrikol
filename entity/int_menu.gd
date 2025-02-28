extends Panel

@onready var use_btn = $USEbtn
@onready var look_btn = $LOOKbtn
@onready var talk_btn = $Talkbtn
@onready var Inter = $"../Head/Interact"
@onready var dial = $"../DialogueBox"
var state = "null"
var clickbug = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_process(false)
	pass # Replace with function body.

func _process(_delta: float) -> void:
	PointClick()
	if Input.is_action_just_released("lclick"):
		match state:
			"Use":
				interact()
			"Look":
				look()
			"Talk":
				talk()
			"null":
				pass
		pass
	
func PointClick():
	var mouseP = get_viewport().get_mouse_position()
	var camp = get_tree().root.get_camera_3d()
	var rayend = Inter.global_position + camp.project_ray_normal(mouseP)
	Inter.look_at(rayend)
	
func interact():
	var detectedint = Inter.get_collider()
	if detectedint != null:
		if detectedint.has_method("use"):
			if detectedint.script != null:
				detectedint.use()
				use_btn.button_pressed = false
				use_btn.emit_signal("toggled",false)
			
func look():
	var detectedint = Inter.get_collider()
	if detectedint != null:
		if detectedint.script != null and detectedint.look_dial_id != null:
			dial.start_id = detectedint.look_dial_id
			dial.start()
			look_btn.button_pressed = false
			look_btn.emit_signal("toggled",false)
			
func talk():
	var detectedint = Inter.get_collider()
	if detectedint != null:
		if detectedint.script != null and detectedint.talk_dial_id != null:
			dial.start_id = detectedint.talk_dial_id
			dial.start()
			talk_btn.button_pressed = false
			talk_btn.emit_signal("toggled",false)
	


func _on_us_ebtn_toggled(toggled_on: bool) -> void:
	if (toggled_on == true):	
		look_btn.disabled = true
		talk_btn.disabled = true
		Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
		state = "Use"
		set_process(true)
	elif (toggled_on == false):
		look_btn.disabled = false
		talk_btn.disabled = false
		Input.set_default_cursor_shape(Input.CURSOR_ARROW)
		state = "null"
		set_process(false)
	pass


func _on_loo_kbtn_toggled(toggled_on: bool) -> void:
	if (toggled_on == true):	
		talk_btn.disabled = true
		use_btn.disabled = true
		Input.set_default_cursor_shape(Input.CURSOR_HELP)
		state = "Look"
		set_process(true)
	elif (toggled_on == false):
		talk_btn.disabled = false
		use_btn.disabled = false
		Input.set_default_cursor_shape(Input.CURSOR_ARROW)
		state = "null"
		set_process(false)
	pass


func _on_talkbtn_toggled(toggled_on: bool) -> void:
	if (toggled_on == true):	
		look_btn.disabled = true
		use_btn.disabled = true
		Input.set_default_cursor_shape(Input.CURSOR_HELP)
		state = "Talk"
		set_process(true)
	elif (toggled_on == false):
		look_btn.disabled = false
		use_btn.disabled = false
		Input.set_default_cursor_shape(Input.CURSOR_ARROW)
		state = "null"
		set_process(false)
	pass # Replace with function body.
