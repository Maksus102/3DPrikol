extends Node
class_name  Inventory

var items = []

func _ready():
	Inventory.new()
	pass
	
func add_item(item: Object):
	#print(item)
	items.append(item.id)


func remove_item(item: String):
	items.erase(item)


func has_item(item: String):
	return items.has(item)


func get_item_count(item: String):
	var count = 0
	for i in items:
		if i == item:
			count += 1
	return count
