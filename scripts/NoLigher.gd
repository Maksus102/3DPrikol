extends Area3D

@export var lights_list : Array[Light3D]
var state = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_body_entered(body):
	if body.is_in_group("Player"):
		if state == false:
			for i in lights_list:
				i.visible = false
				state = true
		elif state == true:
			for i in lights_list:
				i.visible = true
				state = false
	pass # Replace with function body.
