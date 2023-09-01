extends Control

@onready var _server = $WebSocketServer

const PORT = 8000

func _ready():
	var err = _server.listen(PORT)
	if err != OK:
		info("Error listing on port %s" % PORT)
		return
	info("Listing on port %s, supported protocols: %s" % [PORT, _server.supported_protocols])

func info(msg):
	print(msg)
	#_log_dest.add_text(str(msg) + "\n")


# Server signals
func _on_web_socket_server_client_connected(peer_id):
	var peer: WebSocketPeer = _server.peers[peer_id]
	info("Remote client connected: %d. Protocol: %s" % [peer_id, peer.get_selected_protocol()])
	_server.send(-peer_id, "[%d] connected" % peer_id)


func _on_web_socket_server_client_disconnected(peer_id):
	var peer: WebSocketPeer = _server.peers[peer_id]
	info("Remote client disconnected: %d. Code: %d, Reason: %s" % [peer_id, peer.get_close_code(), peer.get_close_reason()])
	_server.send(-peer_id, "[%d] disconnected" % peer_id)


func _on_web_socket_server_message_received(peer_id, message):
	info("Server received data from peer %d: %s" % [peer_id, message])
	if message.begins_with('s'):
			_server.send(-peer_id, message)
	else:
		_server.send(-peer_id, "[%d] Says: %s" % [peer_id, message])

