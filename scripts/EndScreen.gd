extends CanvasLayer

var PATH: String = "user://leaderboard3.json"
var leaderboard = []
var score = 0

func load_leaderboard() -> Array:
	var json_as_text = FileAccess.get_file_as_string(PATH)
	var json_as_dict = JSON.parse_string(json_as_text)
	if json_as_dict:
		return(json_as_dict)
	return([])

func _ready() -> void:
	visible = false
	
func _on_map_scene_end_game(new_score: Variant) -> void:
	visible = true
	score = new_score
	leaderboard = load_leaderboard()
	$EndPage/EndScoreLabel.text = "Score final : " + str(new_score)
	$EndPage/AddScoreComponent/AddScoreLabel.text = str(new_score)
	$EndPage/AddScoreComponent.visible = true
	$EndPage/LeaderBoardPage.display_leaderboard(leaderboard)

func _on_button_pressed() -> void:
	visible = false

func save_leaderboard(entries: Array):
	var file = FileAccess.open(PATH, FileAccess.WRITE)
	var json_text = JSON.stringify(entries, "\t")
	file.store_line(json_text)
	file.close()

func _on_add_score_button_pressed() -> void:
	$EndPage/AddScoreComponent.visible = false
	leaderboard.append({"name": $EndPage/AddScoreComponent/NameScoreEdit.text, "score": score})
	leaderboard.sort_custom(func(a, b): return a["score"] > b["score"])
	save_leaderboard(leaderboard)
	$EndPage/LeaderBoardPage.display_leaderboard(leaderboard)
