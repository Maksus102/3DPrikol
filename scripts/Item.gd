extends Node
class_name Item
@export var id = ""
var playainv
func _ready():
	playainv = get_node("../Player/Inventar")
func inter():
	playainv.add_item(self)
	queue_free()
