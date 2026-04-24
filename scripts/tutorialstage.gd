extends Node2D

func beat(bpm: int) -> void:
	while true:
		$title.scale = Vector2(1.25, 1.25)
		$score.scale = Vector2(1.25, 1.25)
		var tween = get_tree().create_tween()
		var tween2 = get_tree().create_tween()
		tween.tween_property($title, "scale", Vector2(1.0, 1.0), 1.0/(bpm/60.0)).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
		tween2.tween_property($score, "scale", Vector2(1.0, 1.0), 1.0/(bpm/60.0)).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
		await get_tree().create_timer(1.0/(bpm/60.0)).timeout

func loadstage() -> void:
	var file = FileAccess.open("res://tutorialstage.json", FileAccess.READ)
	var json_string = file.get_as_text()
	file.close()
	var json = JSON.new()
	json.parse(json_string)
	for item in json.data:
		if "x" in item:
			wawacount += 1
			var newWawa = $Wawa.duplicate()
			newWawa.position.x = item.x
			newWawa.position.y = item.y
			newWawa.visible = true
			get_tree().create_timer(item.time-1.7).timeout.connect(self.add_child.bind(newWawa))

var wawacount = 0
func _ready() -> void:
	loadstage()
	Autorun.rpc_state("in the tutorial stage")
	Autorun.tutorialDialog = 1
	$blackbg.visible = true
	$blackbg.modulate.a = 1.0
	for i in range(25):
		$blackbg.modulate.a -= 0.04
		await get_tree().create_timer(0.01).timeout
	$blackbg.visible = false
	beat(100)
	$AudioStreamPlayer2D.play()
	await get_tree().create_timer(65.0).timeout
	$AudioStreamPlayer2D.stop()
	$blackbg.visible = true
	for i in range(25):
		$blackbg.modulate.a += 0.04
		await get_tree().create_timer(0.01).timeout
	get_tree().change_scene_to_file("res://scenes/tutorial.tscn")

func _process(_delta: float) -> void:
	$title.pivot_offset = $title.size * 0.5
	$score.pivot_offset = $score.size * 0.5
	# the score may end up like 999900 because godot rounds up the score to add so thats why i added this
	var equationofhell = (((1000000/wawacount)/25)*25)*wawacount
	if score == equationofhell:
		score = 1000000
	$score.text = str(score)

var score = 0
func addscore() -> void:
	for i in range(25):
		score += (1000000/wawacount)/25
		await get_tree().create_timer(0.01).timeout
