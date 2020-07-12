extends NinePatchRect

onready var item = preload("res://Scenes/InventItem.tscn")
onready var container = $Scroll/Grid

func _ready():
	clear()
	visible = false

func clear():
	for i in container.get_children():
		container.remove_child(i)
		i.queue_free()

#  inventory['Apple'] = [15, 8]

func show_inventory(inventory):
	clear()
	for i in inventory.keys():
		var amount = inventory[i][0]
		for j in range(amount / inventory[i][1] + 1):
			
			var new_item = item.instance()
			if amount >= inventory[i][1]:
				container.add_child(new_item)
				new_item.set_item(i, inventory[i][1])
				amount -= inventory[i][1]
				
			elif amount > 0:
				container.add_child(new_item)
				new_item.set_item(i, amount)
				amount = 0