/******************************************************************************
    Reign of the Undead, v2.x

    Copyright (c) 2010-2013 Reign of the Undead Team.
    See AUTHORS.txt for a listing.

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to
    deal in the Software without restriction, including without limitation the
    rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
    sell copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in
    all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.

    The contents of the end-game credits must be kept, and no modification of its
    appearance may have the effect of failing to give credit to the Reign of the
    Undead creators.

    Some assets in this mod are owned by Activision/Infinity Ward, so any use of
    Reign of the Undead must also comply with Activision/Infinity Ward's modtools
    EULA.
******************************************************************************/

//BOT MODELS AND ANIMATIONS
#include scripts\include\hud;
#include scripts\include\entities;
#include scripts\include\utility;

initZomModels()
{
    debugPrint("in _types::initZomModels()", "fn", level.nonVerbose);

    level.zom_models = [];
    addZomModel("zombie_all", "izmb_zombie1_body", "izmb_zombie2_head");
    addZomModel("zombie_all", "izmb_zombie2_body", "izmb_zombie2_head");
    addZomModel("zombie_all", "izmb_zombie3", "");
    addZomModel("zombie_all", "body_complete_sp_russian_farmer", "");
    addZomModel("zombie_all", "body_complete_sp_vip", "");
    addZomModel("zombie_all", "body_complete_sp_zakhaevs_son", "");
    addZomModel("zombie", "izmb_zombie1_body", "izmb_zombie2_head");
    addZomModel("zombie", "izmb_zombie2_body", "izmb_zombie2_head");
    addZomModel("zombie", "izmb_zombie3", "");
    addZomModel("fat", "body_complete_sp_russian_farmer", "");
    addZomModel("fast", "body_complete_sp_vip", "");
    addZomModel("fast", "body_complete_sp_zakhaevs_son", "");
    addZomModel("tank", "body_hellknight", "");
    addZomModel("quad", "bo_quad", "");
    addZomModel("dog", "german_sheperd_dog", "");
    addZomModel("boss", "cyclops", "");
}

addZomModel(type, body, head)
{
    debugPrint("in _types::addZomModel()", "fn", level.nonVerbose);

    if (isdefined(level.zom_models[type])) {
        size = level.zom_models[type].size;
        level.zom_models[type][size] = body;
        level.zom_models_head[type][size] = head;
    } else {
        level.zom_models[type][0] = body;
        level.zom_models_head[type][0] = head;
    }
}

loadZomModel(type)
{
    debugPrint("in _types::loadZomModel()", "fn", level.veryHighVerbosity);

    self DetachAll();

    modelType = level.zom_types[type].modelType;
    id = randomint(level.zom_models[modelType].size);
    self setmodel(level.zom_models[modelType][id]);
    head = level.zom_models_head[modelType][id];
    if (head != "") {self attach(head);}
}


loadAnimTree(type)
{
    debugPrint("in _types::loadAnimTree()", "fn", level.veryHighVerbosity);

    animTree = level.zom_types[type].animTree;
    switch (animTree) {
        case "zombie":
            self.animation["stand"] = "bot_zombie_stand_mp";
            self.animation["walk"] = "bot_zombie_walk_mp";
            self.animation["sprint"] = "bot_zombie_run_mp";
            self.animation["melee"] = "bot_zombie_melee_mp";
            break;
        case "zombiefast":
            self.animation["stand"] = "bot_zombie_stand_mp";
            self.animation["walk"] = "bot_zombie_walk_mp";
            self.animation["sprint"] = "m40a3_acog_mp";
            self.animation["melee"] = "bot_zombie_melee_mp";
            break;
        case "dog":
            self.animation["stand"] = "bot_dog_idle_mp";
            self.animation["sprint"] = "bot_dog_run_mp";
            self.animation["melee"] = "defaultweapon_mp";
        break;
        case "boss":
            self.animation["stand"] = "bot_zombie_stand_mp";
            self.animation["sprint"] = "bot_zombie_run_mp";
            self.animation["melee"] = "bot_zombie_melee_mp";
        break;
        case "quad":
            self.animation["stand"] = "flash_grenade_mp";
            self.animation["walk"] = "concussion_grenade_mp";
            self.animation["sprint"] = "smoke_grenade_mp";
            self.animation["melee"] = "g3_gl_mp";
        break;
    }
}


// TYPES

initZomTypes()
{
    debugPrint("in _types::initZomTypes()", "fn", level.nonVerbose);

    level.zom_types = [];
    addZomType("zombie", "zombie", "zombie", "zombie",        18, 46, 20,  96, 40,   200, .8, 1, 0.075); // Default zombie
    addZomType("burning", "zombie_all", "zombie", "zombie",   18, 36, 20,  96, 40,   200, .8, 1, 0.0); // Code handled
    addZomType("toxic", "quad", "quad", "zombie",             18, 36, 26, 104, 50,   180, .6, 1, 0.55); // Code handled
    addZomType("fat", "fat", "zombie", "zombie",              16, 42, 16, 100, 40,   275, .8, 0, 0.05);
    addZomType("fast", "fast", "zombiefast", "zombie",        30, 68, 34,  96, 40,   150, .7, 0, 0.075);
    addZomType("runners", "fast", "zombiefast", "zombie",     30, 68, 34,  96, 40,   150, .7, 1, 0.075);
    addZomType("tank", "tank", "zombie", "zombie",            16, 40, 20, 100, 30,   800, .8, 0, 0.05);
    addZomType("burning_tank", "tank", "zombie", "zombie",    16, 40, 20, 100, 30,   800, .8, 0, 0.05); // burning tank (hell) zombies
    addZomType("dog", "dog", "dog", "dog",                    18, 58, 30,  96, 30,   125, .8, 1, 0.1); // Dog zombie
    addZomType("burning_dog", "dog", "dog", "dog",            18, 53, 30,  96, 30,   125, .8, 1, 0.1); // Burning dog zombie
    addZomType("boss", "boss", "boss", "zombie",              20, 58, 30, 160, 80, 10000, .8, 1, 0.0);
    addZomType("cyclops", "boss", "boss", "zombie",           20, 45, 30, 160, 60,  3500, .8, 1, 0.0); // cyclops, damaged by everything
}

addZomType(name, modelType, animTree, soundType, walkSpeed, runSpeed, meleeSpeed, meleeRange, damage, maxHealth, meleeTime, sprintOnly, infectionChance)
{
    debugPrint("in _types::addZomType()", "fn", level.nonVerbose);

    struct = spawnstruct();
    level.zom_types[name] = struct;
    struct.modelType = modelType;
    struct.animTree = animTree;
    struct.walkSpeed = walkSpeed;
    struct.runSpeed = runSpeed;
    struct.meleeSpeed = meleeSpeed;
    struct.meleeRange = meleeRange;
    struct.damage = damage;
    struct.maxHealth = maxHealth;
    struct.meleeTime = meleeTime;
    struct.sprintOnly = sprintOnly;
    struct.infectionChance = infectionChance;
    struct.soundType = soundType;
    struct.barricadeDamage = damage;
    struct.spawnFX = undefined;
}


/**
 * @brief Selects the correct environment blur for a special wave
 *
 * @param type string The type of the special wave
 *
 * @returns float, the blur setting to be used with this wave
 */
getBlurForSpecialWave(type)
{
    debugPrint("in _types::getBlurForSpecialWave()", "fn", level.nonVerbose);

    switch (type) {
        case "burning":         // Fall through
        case "burning_dog":     // Fall through
        case "burning_tank":    // Fall through
        case "inferno":
            return .65;
        case "toxic":
            return 1;
        default:
            return level.dvar["env_blur"];
    }
}

/**
 * @brief Selects the correct environment ambient for a special wave
 *
 * @param type string The type of the special wave
 *
 * @returns string, the ambient setting to be used with this wave
 */
getAmbientForSpecialWave(type)
{
    debugPrint("in _types::getAmbientForSpecialWave()", "fn", level.nonVerbose);

    switch (type) {
        case "burning":         // Fall through
        case "burning_dog":     // Fall through
        case "burning_tank":    // Fall through
        case "inferno":
            return "ambient_inferno";
        case "zombie":
            return "zom_ambient";
        case "toxic":
            return "ambient_toxic";
        case "tank":
            return "ambient_tank";
        case "boss":            // Fall through
        case "many_bosses":     // Fall through
        case "cyclops":
            return "ambient_boss";
        default:
            return "zom_ambient";
    }
}

/**
 * @brief Selects the correct environment fog for a special wave
 *
 * @param type string The type of the special wave
 *
 * @returns string, the fog setting to be used with this wave
 */
getFogForSpecialWave(type)
{
    debugPrint("in _types::getFogForSpecialWave()", "fn", level.nonVerbose);

    switch (type) {
        case "toxic":
            return "toxic";
        case "boss":            // Fall through
        case "many_bosses":     // Fall through
        case "cyclops":
            return "boss";
        default:
            return "";
    }
}

/**
 * @brief Selects the correct environment vision for a special wave
 *
 * @param type string The type of the special wave
 *
 * @returns string, the vision setting to be used with this wave
 */
getVisionForSpecialWave(type)
{
    debugPrint("in _types::getVisionForSpecialWave()", "fn", level.nonVerbose);

    switch (type) {
        case "burning":         // Fall through
        case "burning_dog":     // Fall through
        case "burning_tank":    // Fall through
        case "inferno":
            return "inferno";
        case "boss":            // Fall through
        case "many_bosses":     // Fall through
        case "cyclops":
            return "boss";
        default:
            return "";
    }
}

/**
 * @brief Selects the correct environment FX for a special wave
 *
 * @param type string The type of the special wave
 *
 * @returns string, the FX setting to be used with this wave
 */
getFxForSpecialWave(type)
{
    debugPrint("in _types::getFxForSpecialWave()", "fn", level.nonVerbose);

    switch (type) {
        case "burning":         // Fall through
        case "burning_dog":     // Fall through
        case "burning_tank":    // Fall through
        case "inferno":
            return "ember";
        case "tank":
            return "lightning";
        case "boss":            // Fall through
        case "many_bosses":     // Fall through
        case "cyclops":
            return "lightning_boss";
        default:
            return "";
    }
}

loadZomStats(type)
{
    debugPrint("in _types::loadZomStats()", "fn", level.veryHighVerbosity);

    struct = level.zom_types[type];

    self.walkSpeed = struct.walkSpeed;
    self.runSpeed = struct.runSpeed;
    self.meleeSpeed = struct.meleeSpeed;
    self.meleeRange = struct.meleeRange;
    self.damage = struct.damage;
    self.barricadeDamage = struct.barricadeDamage;
    self.meleeTime = struct.meleeTime;
    self.sprintOnly = struct.sprintOnly;
    self.maxHealth = int(struct.maxHealth);
    self.infectionChance = struct.infectionChance;
    self.soundType = struct.soundType;

    self.walkOnly = false;
    if (randomfloat(1) > level.slowBots) {
        self.walkOnly = true;
    }
}

/// @param type string The type of bot, not the type of special wave
onSpawn(type)
{
    debugPrint("in _types::onSpawn()", "fn", level.veryHighVerbosity);

    // track if a turret is targeting this bot, to help turrets work co-operatively
    self.isTurretTarget = false;
    // by default, turrets aim 48 inches above the bot's feet
    self.turretAimHeight = 42;

    switch (type) {
        case "burning":
            PlayFXOnTag(level.burningFX, self, "j_spinelower" );
            self playloopsound("fire_wood_medium");
            break;
        case "burning_tank":
            PlayFXOnTag(level.burningFX, self, "j_spinelower" );
            self playloopsound("fire_wood_medium");
            break;
        case "burning_dog":
            PlayFXOnTag(level.burningDogFX, self, "j_shoulder_le" );
            self.turretAimHeight = 12;
            // German sheperd tags
            // j_mainroot j_pelvis j_spine1 j_hip_base_le j_hip_base_ri j_spine2
            // j_tail_base j_hip_le j_hip_ri j_spine3 j_tail0 j_knee_le j_knee_ri
            // j_spine4 j_tail1 j_ankle_le j_ankle_ri j_neck j_shoulder_base_le
            // j_shoulder_base_ri j_tail2 j_ball_le j_ball_ri j_neck_end j_shoulder_le
            // j_shoulder_ri j_tail3 j_elbow_le j_elbow_ri j_head j_toe_le j_toe_ri
            // j_eyebrow_top_le j_eyebrow_top_ri j_eyelid_bottom_le j_eyelid_bottom_ri
            // j_eyelid_top_le j_eyelid_top_ri j_helmet j_jaw j_lip_top_le j_lip_top_ri
            // j_nose j_wrist_le j_wrist_ri le_ear ri_ear tag_eye tag_mouth_fx j_palm_le
            // j_palm_ri le_ear_end ri_ear_end j_palm_end_le j_palm_end_ri

            self playloopsound("fire_wood_medium");
            break;
        case "toxic":
            self.turretAimHeight = 12; //16;
            //PlayFXOnTag(level.toxicFX, self, "j_head");
            break;
        case "dog":
            self.turretAimHeight = 12;
            break;
        case "boss":
            if (level.waveType == "boss") { // final wave is a single boss
                nextBossStatus();
                self.quake = true;
                self thread bossSpecialAttack();
            } else if (level.waveType == "many_bosses") { // final wave is many bosses
                self.quake = true;
                self thread manyBossesSpecialAttack();
            }
            break;
        case "cyclops":
            self thread cyclopsSpecialAttack();
            self.turretAimHeight = 55;
            // height of headicon above origin.  doesn't work?
            self.entityHeadIconOffset = (0,0,175);
            break;
    }
}

bossSpecialAttack()
{
    debugPrint("in _types::bossSpecialAttack()", "fn", level.nonVerbose);

    self endon("death");
    wait 3;
    // divide by zero guard
    if (level.killballFactor == 0) {level.killballFactor = 0.01;}
    while (1) {
        self thread doSpecialAttack();
        wait int((20 + randomint(10)) * (1 / level.killballFactor));
    }
}

manyBossesSpecialAttack()
{
    debugPrint("in _types::bossSpecialAttack()", "fn", level.nonVerbose);

    self endon("death");
    self endon("boss_fake_death");
    wait 3;
    // divide by zero guard
    if (level.killballFactor == 0) {level.killballFactor = 0.01;}
    while (1) {
        self thread doSpecialAttack();
        wait int((20 + randomint(10)) * (1 / level.killballFactor));
    }
}

doSpecialAttack()
{
    debugPrint("in _types::doSpecialAttack()", "fn", level.nonVerbose);

    for (i=0; i<level.players.size; i++) {
        if (level.players[i].isAlive) {
            self thread killBall(level.players[i]);
        }
        wait 0.5;
    }
}

cyclopsSpecialAttack()
{
    debugPrint("in _types::cyclopsSpecialAttack()", "fn", level.nonVerbose);

    self endon("death");
    wait randomint(10);
    while (1) {
        self thread doCyclopsSpecialAttack();
        wait 30 + randomint(10);
    }
}

doCyclopsSpecialAttack()
{
    debugPrint("in _types::doCyclopsSpecialAttack()", "fn", level.nonVerbose);

    for (i=0; i<level.players.size; i++) {
        if (level.players[i].isAlive) {
            // don't throw a kill ball at every player
            if (randomInt(10) < 6) {self thread killBall(level.players[i]);}
        }
        wait 1;
    }
}

deleteKillBall(time)
{
    debugPrint("in _types::deleteKillBall()", "fn", level.nonVerbose);

    self endon("death");
    wait time;
    self delete();
}

killBall(player)
{
    debugPrint("in _types::killBall()", "fn", level.nonVerbose);

    // Spawn a moving kill ball
    offset = (0,0,40);
    killBall = spawn("script_model",self.origin + offset);
    killBall setModel("tag_origin");
    killBall thread deleteKillBall(10+level.players.size/5);
    wait 0.05;
    playFXOnTag(level.soulFX,killBall,"tag_origin");
    killBall endon("death");
    translationSpeed = 2;

    killBall moveto(self.origin + (0,0,400), 5);
    wait 5;
    while(isdefined(player)) {
        locationOfPlayerHead = player getTagOrigin("j_head");
        separation = distance(killBall.origin, locationOfPlayerHead);

        if(separation > 30) {
            // Set speed when kill ball is far from player
            if (translationSpeed > 1.5) {translationSpeed -= 0.05;}

            // Set speed when kill ball is close to player
            if (separation < 64) {translationSpeed = .1;}

            // Move kill ball towards player's head
            locationOfPlayerHead = player getTagOrigin("j_head");
            killBall moveTo(locationOfPlayerHead, translationSpeed);
            wait 0.1;
        } else {
            // Kill ball has caught the player
            player.isPlayer = true;
            player.entity = player;
            player damageEnt(
                self, // eInflictor = the entity that causes the damage (e.g. a claymore)
                self, // eAttacker = the player that is attacking
                int(50*level.dif_zomDamMod), // iDamage = the amount of damage to do
                "MOD_MELEE", // sMeansOfDeath = string specifying the method of death (e.g. "MOD_PROJECTILE_SPLASH")
                self.pers["weapon"], // sWeapon = string specifying the weapon used (e.g. "claymore_mp")
                self.origin, // damagepos = the position damage is coming from
                //(0,self GetPlayerAngles()[1],0) // damagedir = the direction damage is moving in
                vectorNormalize(player.origin-self.origin)
                );
            killBall delete();
            wait 0.1;
            break;
        }

    }
}


/// @param type string The type of bot, not the type of special wave
onDamage(type, sMeansOfDeath, sWeapon, iDamage, eAttacker)
{
    debugPrint("in _types::onDamage()", "fn", level.fullVerbosity);

    switch (type) {
        case "boss":  // this is a boss zombie
            if (level.bossStatus == "dead") {return 0;}
            if (sMeansOfDeath == "MOD_IMPACT") {return 0;}
            acceptableDamage = false;       // flag: is this damage acceptable?
            if (level.bossStatus == "explosives") {
                if (scripts\players\_weapons::isExplosive(sWeapon)) {
                    acceptableDamage = true;
                }
            } else if (level.bossStatus == "primary") {
                if ((sWeapon == eAttacker.primary) && (sMeansOfDeath != "MOD_MELEE")) {
                    acceptableDamage = true;
                }
            } else if (level.bossStatus == "sidearm") {
                if ((sWeapon == eAttacker.secondary) && (sMeansOfDeath != "MOD_MELEE")) {
                    acceptableDamage = true;
                }
            } else if (level.bossStatus == "melee") {
                if (sMeansOfDeath == "MOD_MELEE") {
                    acceptableDamage = true;
                }
            }

            if (level.waveType == "boss") { // final wave is a single boss
                self.health = 10000;        // we don't actually do real damage to the boss
                if (acceptableDamage) {
                    eAttacker scripts\players\_players::incUpgradePoints(5 * level.dvar["game_rewardscale"]);
                    level.bossDamageDone += idamage;
                    newValue = int(level.bossDamageDone * 100 / level.bossDamageToDo);
                    if (newValue > 100) {newValue = 100;}

                    level.bossOverlay setValue(newValue);
                    if (newValue == 100) {nextBossStatus();}
                    if (level.bossStatus == "dead") {return 0;}
                    else {return 1;}
                }
            } else if (level.waveType == "many_bosses") { // final wave is many bosses
                if (acceptableDamage) {
                    eAttacker scripts\players\_players::incUpgradePoints(5 * level.dvar["game_rewardscale"]);

                    // calculate the actual damage _bots::Callback_BotDamage() will apply
                    if(!isDefined(self.incdammod)) {
                        self.incdammod = 1;
                    }
                    appliedDamage = int(idamage * eAttacker scripts\players\_abilities::getDamageModifier(sWeapon, sMeansOfDeath, self, iDamage) * self.incdammod);
                    if (appliedDamage < 1) {appliedDamage = 1;}

                    if (self.health <= appliedDamage) {
                        // this damage will kill the bot
                        level.bossDamageDone += self.health;
                        spawnpoint = spawnstruct();
                        spawnpoint.angles = self.angles;
                        spawnpoint.origin = self.origin;
                        level.bosses[self.id].nextSpawnpoint = spawnpoint;
                    } else {
                        level.bossDamageDone += appliedDamage;
                    }
                    newValue = int(level.bossDamageDone * 100 / level.bossDamageToDo);
                    if (newValue > 100) {newValue = 100;}

                    level.bossOverlay setValue(newValue);
                    if (newValue == 100) {nextBossStatus();}
                    if (level.bossStatus == "dead") {return 0;}
                    else {return 1;}
                }
            }
            return 0; // bail on _bots::Callback_BotDamage()
        case "cyclops":
            // Limit the possible points to multiples of 10 to limit the number
            // of unique strings to stop string overflow errors
            points = int(1.25 * iDamage);
            modulo = points % 10;
            if (modulo >= 5) {
                // round up
                points = points + 10 - modulo;
            } else {
                // round down
                points = points - modulo;
                // Always give at least 10 points
                if (points == 0) {points = 10;}
            }
            eAttacker scripts\players\_players::incUpgradePoints(points);
            return 1;
        default:
            return 1;
    }
}

/**
 * @brief Starts the appropriate next method of attacking the final zombie
 *
 * @returns nothing
 */
nextBossStatus()
{
    debugPrint("in _types::nextBossStatus()", "fn", level.nonVerbose);

    if (!level.bossDoExplosives && !level.bossDoPrimary && !level.bossDoSidearm && !level.bossDoMelee) {
        if (level.waveType == "boss") {
            level.bossStatus = "dead";
            level.bossOverlay fadeout(1);
            wait 0.1;
            self suicide();
            return;
        } else if (level.waveType == "many_bosses") {
            //level.bossStatus = "dead";
            level.bossOverlay fadeout(1);
            wait 0.1;
            return;
        }
    }

    if (isDefined(level.bossOverlay)) {
        level.bossOverlay destroy();
    }

    difficultyFactor = 1; // default
    red = (1,0,0);
    green = (0,1,0);
    if (level.bossColor == (0,0,0)) {level.bossColor = red;}
    else if (level.bossColor == red) {level.bossColor = green;}
    else {level.bossColor = red;}

    if (level.bossDoExplosives) {
        level.bossStatus = "explosives";
        level.bossOverlay = overlayMessage(&"ZOMBIE_BOSS_EXPLOSIVES", "", level.bossColor);
        level.bossDoExplosives = false;
        difficultyFactor = getDvarFloat("surv_boss_explosives_factor");
    } else if (level.bossDoPrimary) {
        level.bossStatus = "primary";
        level.bossOverlay = overlayMessage(&"ZOMBIE_BOSS_PRIMARY", "", level.bossColor);
        level.bossDoPrimary = false;
        difficultyFactor = getDvarFloat("surv_boss_primary_factor");
    } else if (level.bossDoSidearm) {
        level.bossStatus = "sidearm";
        level.bossOverlay = overlayMessage(&"ZOMBIE_BOSS_SIDEARM", "", level.bossColor);
        level.bossDoSidearm = false;
        difficultyFactor = getDvarFloat("surv_boss_sidearm_factor");
    } else if (level.bossDoMelee) {
        level.bossStatus = "melee";
        level.bossOverlay = overlayMessage(&"ZOMBIE_BOSS_KNIFE", "", level.bossColor);
        level.bossDoMelee = false;
        difficultyFactor = getDvarFloat("surv_boss_melee_factor");
    }

    level.bossCurrentMethod++;

    level.bossOverlay setvalue(0);
    level.bossDamageDone = 0;
    if (level.waveType == "boss") {
        level.bossDamageToDo = level.activePlayers * 1400 * difficultyFactor;
    } else if (level.waveType == "many_bosses") {
        // calculate boss' health for next kill method
        botHealth = int(2500 * difficultyFactor);
        level.bossDamageToDo = level.waveSize * botHealth;
        wait 0.5;
        for (i=0; i < level.bosses.size; i++) {
            if (isDefined(level.bosses[i].nextSpawnpoint)) {
                // If it is defined, we aren't on the first method, so we need to respawn
                // boss zombies.  We respawn them at the same spot they previously
                // went down, not at the normal spawn points
                boss = scripts\bots\_bots::spawnZombie("boss", level.bosses[i].nextSpawnpoint);
                boss.id = i;
                level.bosses[i] = boss;
            } else {
                boss = level.bosses[i];
            }
            boss.health = botHealth;
            boss.maxHealth = botHealth;
        }
    }
}


onAttack(type, target)
{
    debugPrint("in _types::onAttack()", "fn", level.medVerbosity);

    switch (type) {
        case "boss":            // Fall through
        case "many_bosses":     // Fall through
        case "cyclops":
            target thread scripts\players\_players::bounce(vectorNormalize(target.origin+(0,0,15)-self.origin));
            target shellShock("boss", 2);
        default:
            return 1;
    }
}



onCorpse(type)
{
    debugPrint("in _types::onCorpse()", "fn", level.veryHighVerbosity);

    switch (type) {
        case "burning":         // Fall through
        case "burning_tank":    // Fall through
        case "burning_dog":
            PlayFX(level.explodeFX, self.origin);
            self PlaySound("explo_metal_rand");
            self scripts\bots\_bots::zomAreaDamage(160);
            return 0;
        case "dog":
            return 1;
        case "toxic":
            if (randomfloat(1)<.3)
            toxicCloud(self.origin, 10);
            return 2;
        default:
            return 2;
    }
}

toxicCloud(org, time)
{
    debugPrint("in _types::toxicCloud()", "fn", level.nonVerbose);

    ent = spawn("script_origin", org);
    playfx(level.toxicFX, org);
    ent playsound("toxic_gas");
    self endon("death");
    for (t=0;t<40; t++) {
        for (i=0; i<level.players.size; i++) {
            if (!isDefined(level.players[i])) {continue;}
            if (distance(level.players[i].origin, org) < 128) {
                if (!isDefined(!level.players[i].entoxicated)) {continue;}
                if (!level.players[i].entoxicated) {
                    level.players[i].entoxicated = true;
                    level.players[i] shellshock("toxic_gas_mp", 5);
                    level.players[i] thread unEntoxicate(7);
                }
            }
        }
        wait .25;
    }
}


unEntoxicate(time)
{
    debugPrint("in _types::unEntoxicate()", "fn", level.nonVerbose);

    self endon("death");
    self endon("disconnect");
    wait time;

    if(isDefined(self)) {
        self.entoxicated = false;
    }
}
