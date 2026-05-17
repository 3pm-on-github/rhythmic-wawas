extends Sprite2D

var finalwawa = null
func _ready() -> void:
	self.self_modulate.a = 0.75
	self.modulate.a = 0.0
	finalwawa = self.get_child(0)
	finalwawa.position.y = -1280
	var tween = get_tree().create_tween()
	var tween3 = get_tree().create_tween()
	tween.tween_property(finalwawa, "position:y", 0, 2.0)
	tween3.tween_property(self, "modulate:a", 1.0, 0.5)
	self.get_child(1).pressed.connect(on_clicked)
	self.get_child(1).mouse_entered.connect(mouse_entered)
	self.get_child(1).mouse_exited.connect(mouse_exited)
	await get_tree().create_timer(2.25).timeout
	if not clicked:
		var tween2 = get_tree().create_tween()
		tween2.tween_property(self, "modulate:a", 0.0, 0.25)
		await get_tree().create_timer(0.25).timeout
		self.queue_free()

func _process(_delta: float) -> void:
	pass

var mousehover = false
var clicked = false
func on_clicked() -> void:
	if finalwawa.position.y > -25 and not clicked:
		clicked = true
		print("peak")
		self.get_parent().addscore()
		Autorun.playSfx(self.get_parent(), "res://audio/ow.wav")
		self.self_modulate.a = 0.0
		var img := Image.new()
		img = load("res://images/evilWawa.png").get_image()
		finalwawa.texture = ImageTexture.create_from_image(img)
		var tween = get_tree().create_tween()
		tween.tween_property(finalwawa, "scale", Vector2(1, 0.1), 0.25).set_trans(Tween.TRANS_SINE)
		tween.tween_property(finalwawa, "modulate:a", 0.0, 0.25)
		await get_tree().create_timer(0.25).timeout
		self.queue_free()
		
func _input(ev):
	if ev is InputEventKey and (ev.keycode == KEY_X or ev.keycode == KEY_W) and mousehover and not ev.echo:
		on_clicked()
		
func mouse_entered() -> void:
	mousehover = true

func mouse_exited() -> void:
	mousehover = false
