extends AudioStreamPlayer3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.


func _on_dialogue_box_dialogue_signal(value: String) -> void:
	if "vo_" in value:
		self.stream = load("res://audio/{1}.ogg".format({"1" : value}))
		self.play()
	pass # Replace with function body.
