
# ensure scores are initialized
scoreboard players add @s fluid.transfer_rate 0

scoreboard players add @s fluid.storage.0 0
scoreboard players add @s fluid.storage.1 0
scoreboard players add @s fluid.storage.2 0
scoreboard players add @s fluid.storage.3 0

scoreboard players add @s fluid.max_storage.0 0
scoreboard players add @s fluid.max_storage.1 0
scoreboard players add @s fluid.max_storage.2 0
scoreboard players add @s fluid.max_storage.3 0

scoreboard players add @s fluid.io.up 0
scoreboard players add @s fluid.io.down 0
scoreboard players add @s fluid.io.north 0
scoreboard players add @s fluid.io.south 0
scoreboard players add @s fluid.io.east 0
scoreboard players add @s fluid.io.west 0

scoreboard players add @s fluid.network_id 0
scoreboard players add @s fluid.network_id.up 0
scoreboard players add @s fluid.network_id.down 0
scoreboard players add @s fluid.network_id.north 0
scoreboard players add @s fluid.network_id.south 0
scoreboard players add @s fluid.network_id.east 0
scoreboard players add @s fluid.network_id.west 0

# update adjacent cables
function fluid:v1.0/tank/update_adjacent
