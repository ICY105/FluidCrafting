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
  - 

This is an embedded library, so you package it inside your datapack as opposed to having a separate download. Requires [LanternLoad](https://github.com/LanternMC/load) to operate.
