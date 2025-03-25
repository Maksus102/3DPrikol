extends Node
class_name GSig

func _ready() -> void:
	print("GSig is on")
	
static func testprint(caller):
	print("GSig hears {0}".format({"0" : caller}))
	
static func npc_talk(caller):
	pass
