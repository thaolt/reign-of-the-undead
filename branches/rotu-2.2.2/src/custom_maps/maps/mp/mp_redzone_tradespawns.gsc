// =============================================================================
// File Name = 'mp_redzone_tradespawns.gsc'
// Map Name = 'mp_redzone'
// =============================================================================
//
// This file was generated by the RotU admin development command 'Save Tradespawns'
//
// =============================================================================
//
// This file contains the tradespawns (equipment & weapon shop locations) for
// the map 'mp_redzone'
load_tradespawns()
{
    level.tradespawns = [];

    level.tradespawns[0] = spawnstruct();  // spec'd for weapon shop
    level.tradespawns[0].origin = (1185.89,4343.99,0.001);
    level.tradespawns[0].angles = (0.00006,90.0824,0);
    level.tradespawns[1] = spawnstruct();  // spec'd for equipment shop
    level.tradespawns[1].origin = (1168.77,4133.88,-0.001);
    level.tradespawns[1].angles = (0,89.3243,0);
    level.tradespawns[2] = spawnstruct();  // spec'd for weapon shop
    level.tradespawns[2].origin = (3859.32,3507.66,-0.001);
    level.tradespawns[2].angles = (0,270.967,0);
    level.tradespawns[3] = spawnstruct();  // spec'd for equipment shop
    level.tradespawns[3].origin = (3787.76,3886.82,2.85329);
    level.tradespawns[3].angles = (1.57928,358.154,0);
    level.tradespawns[4] = spawnstruct();  // spec'd for weapon shop
    level.tradespawns[4].origin = (3904.18,849.825,-0.001);
    level.tradespawns[4].angles = (0,179.423,0);
    level.tradespawns[5] = spawnstruct();  // spec'd for equipment shop
    level.tradespawns[5].origin = (3441.26,944.811,-0.001);
    level.tradespawns[5].angles = (0,90.6097,0);
    level.tradespawns[6] = spawnstruct();  // spec'd for weapon shop
    level.tradespawns[6].origin = (1543.84,507.553,40.001);
    level.tradespawns[6].angles = (0,180.654,0);
    level.tradespawns[7] = spawnstruct();  // spec'd for equipment shop
    level.tradespawns[7].origin = (2048.57,681.188,40);
    level.tradespawns[7].angles = (0,267.984,0);
    level.tradespawns[8] = spawnstruct();  // spec'd for weapon shop
    level.tradespawns[8].origin = (2033.2,2843.51,-0.001);
    level.tradespawns[8].angles = (0.00006,179.95,0);
    level.tradespawns[9] = spawnstruct();  // spec'd for equipment shop
    level.tradespawns[9].origin = (3020.62,2288.44,-0.001);
    level.tradespawns[9].angles = (0,315.676,0);

    level.tradeSpawnCount = level.tradespawns.size;
}