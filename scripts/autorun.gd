extends Node

@export var tutorialDialog = 0

func _ready() -> void:
	DiscordRPC.app_id = 1456256387326677054
	DiscordRPC.details = "free-to-win rhythm game where you click wawas"
	DiscordRPC.state = "idle"
	DiscordRPC.large_image = "wawa"
	DiscordRPC.large_image_text = "wawa"
	DiscordRPC.start_timestamp = int(Time.get_unix_time_from_system())
	DiscordRPC.refresh()
	
func rpc_state(state: String) -> void:
	DiscordRPC.state = state
	DiscordRPC.refresh()

func _process(_delta: float) -> void:
	pass

func playSfx(node, path, volume=1.0) -> void:
	var sfxaudiostreamplayer = AudioStreamPlayer2D.new()
	sfxaudiostreamplayer.stream = load(path)
	sfxaudiostreamplayer.volume_db = volume
	node.add_child(sfxaudiostreamplayer)
	sfxaudiostreamplayer.play()
	await get_tree().create_timer(sfxaudiostreamplayer.stream.get_length()).timeout
	sfxaudiostreamplayer.queue_free()
