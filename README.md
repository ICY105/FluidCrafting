# FluidCrafting
Custom fluid mechanics library for Minecraft Datapacks. This does not add in-world fluids, but does add systems for storing, transporting, and using custom fluids in blocks and items. See [Mechanization](https://github.com/ICY105/Mechanization) for examples of how this is used in practice. This is a very advanced library. Don't attempt using this unless you know what you're doing. If you need practice, try using the [DatapackEnergy](https://github.com/ICY105/DatapackEnergy) library. It's very similiar, but less complicated as it doesn't involve NBT definitions.

This library manages:
* NBT definitions for fluids
* Designating block marking entities as entities that can store fluids
  - Scoreboard and NBT definitions for storing fluid
  - Up to 4 different fluid types can be stores per block
  - Supporting functions for managing fluids, such as Inputing/Outputting fluids with items (ie bucket)
* Designating items as holding a fluid
* Designating block marking entities as pipes that can transfer fluids
  - Automatic fluid transfering between enabled blocks
  - Model Data for easily displaying connections

This is an embedded library, so you package it inside your datapack as opposed to having a separate download. Requires [LanternLoad](https://github.com/LanternMC/load) to operate.

Depending on your use case, you may be able to use FluidCrafting's data format without using the library itself, with compatibility being enabled if another datapack is using Fluid Crafting. For example, if you have a Tinker's Construct datpack, you can store the smeltery's fluid in FluidCrafting's format, then if Mechanization is installed it can pump fluid in/out of the smeltary.

# NBT Format
This specifies how FluidCrafting intereprets NBT data, specifically for fluid-containing items.
```
Arbitarty Fluid:
    fluid:{id:"fluid_id", temperature: 0, color: <decimal color, ie. leather armor>, name:'{"text":"name"}'}

    note: if you want a pack-exclusive fluid (no one else will use it), set the id to <pack:fluid>. If you want a cross-datapack fluid (like water), set to just <fluid>
```

```
Item:
    Item.tag.fluid{<fluid data>, storage:<stored_amount>, max_storage:<max_amount>}

    Remove fluid data for an item that store fluid but is empty.

Armor Stand (tank):
    ArmorItems[3].fluids:[{<data>}, ...]

[Glowing] Item Frame (tank):
    Item.tag.fluids:[{<data>}, ...]

Item Display (tank):
    item.tag.fluids:[{<data>}, ...]

Marker (tank):
    data.fluids:[{<data>}, ...]
    ...
```

# Scoreboard Data
```
fluid.data
    Used to pass data between functions and for storing arbitrary data on an entity.

    On a pipe, this is a binary encoded number of which sides are connected, ie:
          up down north south east west
    63 -> 1  1    1     1     1    1    -> all sides are active
	      1  2    4     8     16   32
    This can be used to update the model to display connections when 
    function #fluid:v1/pipe_update is triggered.
```

```
fluid.transfer_rate
    Caps how much fluid can be pump in/out of a tank, and how much fluid a pipe network can handel.
    The rate is limited by the lowest rate in the entire network.

    Make sure this score is 1+ on all pipes and tanks.
```

```
fluid.storage.0
fluid.storage.1
fluid.storage.2
fluid.storage.3
    Indicates how much fluid is stored in each of the 4 fluid slots.
```

```
fluid.max_storage.0
fluid.max_storage.1
fluid.max_storage.2
fluid.max_storage.3
    Indicates how much fluid can be stored in each of the 4 fluid slots. Set to 0 to disable that slot.
```

```
fluid.io.up
fluid.io.down
fluid.io.north
fluid.io.south
fluid.io.east
fluid.io.west
    Sets which tank slots interface with which sides, and whether they input or output. Postive numbers accept fluids, negative numbers expell fluid.
    Set the value to a binary encoded number representing which tank slots are enabled, ie:
    15 -> 1  1  1  1 -> all tanks are active
	      1  2  4  8
    For example, if you only want tank slot 1 to input, set to 1. If you want slot 2 and 3 to output, set to -6.
```

# Selector Tags
Selector tags indicate FluidCrafting should do something with the tagged entity.
```
fluid.tank
    Indicates entity should store fluids. Must be one of the supported entities: Armor Stand, [Glowing] Item Frame, Marker, Item Display. If you need a different entity, let me know. It must support arbitrary NBT data. Note that for most entities the NBT data is stored on the item, so replacing the item will clear the tank.

fluid.pipe
    Indicates entity is a pipe that should connect tanks.
```

# Function Calls
You make function calls from your datapack whenever you want FluidCrafting to execute a specific task.

# Function Tags
Function tags are called by FluidCrafting when it needs your datapack to do something. You need to add a function to FluidCrafting's function tag list for each function.
```
#fluid:v1/pipe_update
    Runs when a pipe has been updated. You can use this to change its model to display new connections.
```

```
#fluid:v1/pipe_can_connect
  Executed as and at a tank.
  Used to disable pipes connecting to a tank from certain sides.
  #pipe.in fluid.data -> 0-5 indicating direction (up, down, north, south, east, west)
  #pipe.out fluid.data -> 1 for can connect, 0 for cannot connect (defaults to can connect)
```

# How to use
1. Install [LanternLoad](https://github.com/LanternMC/load) in your datapack
2. Copy the `data/fluid` folder into your data pack
3. Merge the contents of `/data/load/tags/functions/load.json` and your own `data/load/tags/functions/load.json`
4. Implement the API as described above.

For easier mangament of dependencies, check out my project [Datapack Build Manager](https://github.com/ICY105/DatapackBuildManager).
