extends VBoxContainer

func display_leaderboard(leaderboard):
	for child in get_children():
		child.free()
	for entry in leaderboard:
		var entry_label = Label.new()
		entry_label.text = "%s: %d" % [entry["name"], entry["score"]]
		add_child(entry_label)
