# 
# Copies fluid data from storage into entity.
# Entity independent.
#

execute if entity @s[type=minecraft:armor_stand] run data modify entity @s ArmorItems[3].components."minecraft:custom_data".fluids set from storage fluid:io fluids
execute if entity @s[type=minecraft:item_frame] run data modify entity @s Item.components."minecraft:custom_data".fluids set from storage fluid:io fluids
execute if entity @s[type=minecraft:glow_item_frame] run data modify entity @s Item.components."minecraft:custom_data".fluids set from storage fluid:io fluids
execute if entity @s[type=minecraft:item_display] run data modify entity @s item.components."minecraft:custom_data".fluids set from storage fluid:io fluids
execute if entity @s[type=minecraft:marker] run data modify entity @s data.fluids set from storage fluid:io fluids
