extends Node
class_name GSig
@onready var player = Player
static var talker = null

func _ready() -> void:
	pass
	
static func testprint(caller):
	print("GSig hears {0}".format({"0" : caller}))
	
static func npc_talk(caller,dial):
	talker = caller
	var ndial = dial
	dial.dialogue_processed.connect(_on_dsig)
	pass
	
static func _on_dsig(speaker, dialogue, options):
	print(speaker)
	if talker.id == speaker:
		talker.mloc.play("talk")
	pass
	
