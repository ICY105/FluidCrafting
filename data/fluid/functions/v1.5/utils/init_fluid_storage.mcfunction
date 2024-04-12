# 
# Create data entries for storing fluids if needed.
# Entity independent.
#

execute if entity @s[type=minecraft:armor_stand] unless items entity @s armor.head * run item replace entity @s armor.head with minecraft:stone_button
execute if entity @s[type=minecraft:item_frame] unless items entity @s contents * run item replace entity @s contents with minecraft:stone_button
execute if entity @s[type=minecraft:glow_item_frame] unless items entity @s contents * run item replace entity @s contents with minecraft:stone_button
execute if entity @s[type=minecraft:item_display] unless items entity @s contents * run item replace entity @s contents with minecraft:stone_button

function fluid:v1.5/utils/get_fluids
execute unless data storage fluid:io fluids[3] run data modify storage fluid:io fluids append value {}
execute unless data storage fluid:io fluids[3] run data modify storage fluid:io fluids append value {}
execute unless data storage fluid:io fluids[3] run data modify storage fluid:io fluids append value {}
execute unless data storage fluid:io fluids[3] run data modify storage fluid:io fluids append value {}
function fluid:v1.5/utils/store_fluids
