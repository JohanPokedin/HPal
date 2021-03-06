--#############################################
--##### Edited Trip Holy Paladin by Johan #####
--#############################################


local _G, setmetatable                            = _G, setmetatable
local TMW                                       = TMW
local CNDT                                      = TMW.CNDT
local Env                                       = CNDT.Env
local A                                         = _G.Action
local Listener                                  = Action.Listener
local Create                                    = Action.Create
local GetToggle                                 = Action.GetToggle
local SetToggle                                 = Action.SetToggle
local GetGCD                                    = Action.GetGCD
local GetCurrentGCD                             = Action.GetCurrentGCD
local GetPing                                   = Action.GetPing
local ShouldStop                                = Action.ShouldStop
local BurstIsON                                 = Action.BurstIsON
local AuraIsValid                               = Action.AuraIsValid
local AuraIsValidByPhialofSerenity                = A.AuraIsValidByPhialofSerenity
local InterruptIsValid                          = Action.InterruptIsValid
local FrameHasSpell                             = Action.FrameHasSpell
local Utils                                     = Action.Utils
local TeamCache                                 = Action.TeamCache
local EnemyTeam                                 = Action.EnemyTeam
local FriendlyTeam                              = Action.FriendlyTeam
local LoC                                       = Action.LossOfControl
local Player                                    = Action.Player 
local MultiUnits                                = Action.MultiUnits
local UnitCooldown                              = Action.UnitCooldown
local Unit                                      = Action.Unit 
local IsUnitEnemy                               = Action.IsUnitEnemy
local IsUnitFriendly                            = Action.IsUnitFriendly
local HealingEngine                             = Action.HealingEngine
local ActiveUnitPlates                          = MultiUnits:GetActiveUnitPlates()
local TeamCacheFriendly                         = TeamCache.Friendly
local TeamCacheFriendlyIndexToPLAYERs           = TeamCacheFriendly.IndexToPLAYERs
local IsIndoors, UnitIsUnit                     = IsIndoors, UnitIsUnit
local TR                                        = Action.TasteRotation
local Pet                                       = LibStub("PetLibrary")
local next, pairs, type, print                  = next, pairs, type, print 
local math_floor                                = math.floor
local math_ceil                                 = math.ceil
local tinsert                                   = table.insert 
local select, unpack, table                     = select, unpack, table 
local CombatLogGetCurrentEventInfo              = _G.CombatLogGetCurrentEventInfo
local UnitGUID, UnitIsUnit, UnitDamage, UnitAttackSpeed, UnitAttackPower = UnitGUID, UnitIsUnit, UnitDamage, UnitAttackSpeed, UnitAttackPower
local select, math                              = select, math 
local huge                                      = math.huge  
local UIParent                                  = _G.UIParent 
local CreateFrame                               = _G.CreateFrame
local wipe                                      = _G.wipe
local IsUsableSpell                             = IsUsableSpell
local UnitPowerType                             = UnitPowerType 

--For Toaster
local Toaster                                    = _G.Toaster
local GetSpellTexture                             = _G.TMW.GetSpellTexture

--- ============================ CONTENT ===========================
--- ======= APL LOCALS =======
-- luacheck: max_line_length 9999

-- Spells
Action[ACTION_CONST_PALADIN_HOLY] = {
    -- Racial
    ArcaneTorrent                          = Create({ Type = "Spell", ID = 50613     }),
    BloodFury                              = Create({ Type = "Spell", ID = 20572      }),
    Fireblood                              = Create({ Type = "Spell", ID = 265221     }),
    AncestralCall                          = Create({ Type = "Spell", ID = 274738     }),
    Berserking                             = Create({ Type = "Spell", ID = 26297    }),
    ArcanePulse                            = Create({ Type = "Spell", ID = 260364    }),
    QuakingPalm                            = Create({ Type = "Spell", ID = 107079     }),
    Haymaker                               = Create({ Type = "Spell", ID = 287712     }), 
    WarStomp                               = Create({ Type = "Spell", ID = 20549     }),
    BullRush                               = Create({ Type = "Spell", ID = 255654     }),  
    GiftofNaaru                            = Create({ Type = "Spell", ID = 59544    }),
    Shadowmeld                             = Create({ Type = "Spell", ID = 58984    }), -- usable in Action Core 
    Stoneform                              = Create({ Type = "Spell", ID = 20594    }), 
    WilloftheForsaken                      = Create({ Type = "Spell", ID = 7744        }), -- not usable in APL but user can Queue it   
    EscapeArtist                           = Create({ Type = "Spell", ID = 20589    }), -- not usable in APL but user can Queue it
    WillToSurvive                           = Create({ Type = "Spell", ID = 59752    }), -- not usable in APL but user can Queue it
    
    -- Spells
    Sanguine = Create({ Type = "Spell", ID = 226510, Hidden = true}),    
    Combustion = Create({ Type = "Spell", ID = 99240, Hidden = true}),    
    
    -- Paladin General
    AvengingWrath                    = Action.Create({ Type = "Spell", ID = 31884    }),    
    BlessingofFreedom                = Action.Create({ Type = "Spell", ID = 1044        }),
    BlessingofProtection            = Action.Create({ Type = "Spell", ID = 1022        }),
    BlessingofSacrifice                = Action.Create({ Type = "Spell", ID = 6940        }),
    ConcentrationAura                = Action.Create({ Type = "Spell", ID = 317920    }),
    Consecration                    = Action.Create({ Type = "Spell", ID = 26573    }),
    CrusaderAura                    = Action.Create({ Type = "Spell", ID = 32223    }),
    CrusaderStrike                    = Action.Create({ Type = "Spell", ID = 35395    }),
    DevotionAura                    = Action.Create({ Type = "Spell", ID = 465        }),    
    DivineShield                    = Action.Create({ Type = "Spell", ID = 642        }),
    DivineSteed                        = Action.Create({ Type = "Spell", ID = 190784    }),
    FlashofLight                    = Action.Create({ Type = "Spell", ID = 19750, predictName = "FlashofLight"        }),
    HammerofJustice                    = Action.Create({ Type = "Spell", ID = 853        }),
    HammerofJusticeGreen            = Action.Create({ Type = "SpellSingleColor", ID = 853, Color = "GREEN", Desc = "[1] CC", Hidden = true, Hidden = true, QueueForbidden = true }),    
    HammerofWrath                    = Action.Create({ Type = "Spell", ID = 24275    }),
    HandofReckoning                    = Action.Create({ Type = "Spell", ID = 62124    }),    
    Judgment                        = Action.Create({ Type = "Spell", ID = 275773    }),
    LayOnHands                        = Action.Create({ Type = "Spell", ID = 633, predictName = "LayOnHands"            }),    
    Redemption                        = Action.Create({ Type = "Spell", ID = 7328        }),
    RetributionAura                    = Action.Create({ Type = "Spell", ID = 183435    }),
    ShieldoftheRighteous            = Action.Create({ Type = "Spell", ID = 53600    }),
    TurnEvil                        = Action.Create({ Type = "Spell", ID = 10326    }),
    WordofGlory                        = Action.Create({ Type = "Spell", ID = 85673, predictName = "WordofGlory"        }),    
    Forbearance                        = Action.Create({ Type = "Spell", ID = 25771    }),
    
    
    -- Holy Specific
    Absolution                        = Action.Create({ Type = "Spell", ID = 212056    }),
    AuraMastery                        = Action.Create({ Type = "Spell", ID = 31821    }),
    BeaconofLight                    = Action.Create({ Type = "Spell", ID = 53563    }),
    Cleanse                            = Action.Create({ Type = "Spell", ID = 4987        }),
    DivineProtection                = Action.Create({ Type = "Spell", ID = 498        }),
    HolyLight                        = Action.Create({ Type = "Spell", ID = 82326, predictName = "HolyLight"            }),
    HolyShock                        = Action.Create({ Type = "Spell", ID = 20473, predictName = "HolyShock"            }),
    LightofDawn                        = Action.Create({ Type = "Spell", ID = 85222, predictName = "LightofDawn"        }),
    LightofMartyr                    = Action.Create({ Type = "Spell", ID = 183998, predictName = "LightofMartyr"    }),
    InfusionofLight                    = Action.Create({ Type = "Spell", ID = 53576, Hidden = true        }),    
    InfusionofLightBuff                = Action.Create({ Type = "Spell", ID = 54149, Hidden = true        }),    
    
    -- Normal Talents
    CrusadersMight                    = Action.Create({ Type = "Spell", ID = 196926, Hidden = true    }),
    BestowFaith                        = Action.Create({ Type = "Spell", ID = 223306, predictName = "BestowFaith"        }),
    LightsHammer                    = Action.Create({ Type = "Spell", ID = 114158    }),    
    SavedbytheLight                    = Action.Create({ Type = "Spell", ID = 157047, Hidden = true    }),
    JudgmentofLight                    = Action.Create({ Type = "Spell", ID = 183778, Hidden = true    }),        
    HolyPrism                        = Action.Create({ Type = "Spell", ID = 114165, predictName = "HolyPrism"        }),
    FistofJustice                    = Action.Create({ Type = "Spell", ID = 234299, Hidden = true    }),
    Repentance                        = Action.Create({ Type = "Spell", ID = 20066    }),
    BlindingLight                    = Action.Create({ Type = "Spell", ID = 115750    }),        
    UnbreakableSpirit                = Action.Create({ Type = "Spell", ID = 114154, Hidden = true    }),        
    Cavalier                        = Action.Create({ Type = "Spell", ID = 230332, Hidden = true    }),
    RuleofLaw                        = Action.Create({ Type = "Spell", ID = 214202    }),
    DivinePurpose                    = Action.Create({ Type = "Spell", ID = 223817, Hidden = true    }),    
    DivinePurposeBuff               = Action.Create({ Type = "Spell", ID = 223819, Hidden = true     }),
    HolyAvenger                        = Action.Create({ Type = "Spell", ID = 105809    }),
    Seraphim                        = Action.Create({ Type = "Spell", ID = 152262    }),
    SanctifiedWrath                    = Action.Create({ Type = "Spell", ID = 53376    }),    
    AvengingCrusader                = Action.Create({ Type = "Spell", ID = 216331    }),
    Awakening                        = Action.Create({ Type = "Spell", ID = 248033, Hidden = true    }),
    GlimmerofLight                    = Action.Create({ Type = "Spell", ID = 325966, Hidden = true    }),
    GlimmerofLightBuff                = Action.Create({ Type = "Spell", ID = 287280, Hidden = true    }),
    BeaconofFaith                    = Action.Create({ Type = "Spell", ID = 156910    }),
    BeaconofVirtue                    = Action.Create({ Type = "Spell", ID = 200025    }),        
    
    -- PvP
    DivineFavor                               = Action.Create({ Type = "Spell", ID = 210294 }),
    HordeFlag                                = Action.Create({ Type = "Spell", ID = 156618 }),
    AllianceFlag                           = Action.Create({ Type = "Spell", ID = 156621 }),
    OrbofPowerPurple                               = Action.Create({ Type = "Spell", ID = 121175 }), 
    OrbofPowerGreen                               = Action.Create({ Type = "Spell", ID = 121176 }), 
    OrbofPowerBlue                               = Action.Create({ Type = "Spell", ID = 121164 }), 
    OrbofPowerOrange                        = Action.Create({ Type = "Spell", ID = 121177 }), 
    FocusedAssault                           = Action.Create({ Type = "Spell", ID = 46392 }),
    NetherstormFlag                           = Action.Create({ Type = "Spell", ID = 34976 }),
    CleanseTheWeak                            = Action.Create({ Type = "Spell", ID = 199330 }),
    RecentlySavedByTheLight                    = Action.Create({ Type = "Spell", ID = 157131 }),
    HallowedGround                            = Action.Create({ Type = "Spell", ID = 216868 }),
    Mindgames                                 = Action.Create({ Type = "Spell", ID = 323673 }),
    
    --    Later
    
    -- Covenant Abilities
    DivineToll                        = Action.Create({ Type = "Spell", ID = 304971    }),    
    SummonSteward                    = Action.Create({ Type = "Spell", ID = 324739    }),
    AshenHallow                        = Action.Create({ Type = "Spell", ID = 316958    }),    
    DoorofShadows                    = Action.Create({ Type = "Spell", ID = 300728    }),
    VanquishersHammer                = Action.Create({ Type = "Spell", ID = 328204    }),    
    Fleshcraft                        = Action.Create({ Type = "Spell", ID = 331180    }),
    BlessingoftheSeasons            = Action.Create({ Type = "Spell", ID = 328278    }),
    BlessingofSummer                = Action.Create({ Type = "Spell", ID = 328620    }),    
    BlessingofAutumn                = Action.Create({ Type = "Spell", ID = 328622    }),    
    BlessingofSpring                = Action.Create({ Type = "Spell", ID = 328282    }),    
    BlessingofWinter                = Action.Create({ Type = "Spell", ID = 328281    }),        
    Soulshape                        = Action.Create({ Type = "Spell", ID = 310143    }),
    Flicker                            = Action.Create({ Type = "Spell", ID = 324701    }),
    
    -- Conduits
    
    
    -- Legendaries
    Shadowbreaker = Create({ Type = "Spell", ID = 337812,Hidden = true}),
    Maraad = Create({ Type = "Spell", ID = 234848,Hidden = true}),
    MaraadBuff = Create({ Type = "Spell", ID = 234862,Hidden = true}),
	MadParagon = Create({ Type = "Spell", ID = 337594,Hidden = true}),
    -- General Legendaries
    
    --Holy Legendaries
    
    
    --Anima Powers - to add later...
    
    
    -- Trinkets
    TuftofSmolderingPlumage = Create({ Type = "Trinket", ID = 184020}),  
    SoullettingRuby = Create({ Type = "Trinket", ID = 178809}),  
    
    -- Potions
    PotionofUnbridledFury            = Action.Create({ Type = "Potion", ID = 169299, QueueForbidden = true }),     
    SuperiorPotionofUnbridledFury    = Action.Create({ Type = "Potion", ID = 168489, QueueForbidden = true }),
    PotionofSpectralIntellect        = Action.Create({ Type = "Potion", ID = 171273, QueueForbidden = true }),
    PotionofSpectralStamina            = Action.Create({ Type = "Potion", ID = 171274, QueueForbidden = true }),
    PotionofEmpoweredExorcisms        = Action.Create({ Type = "Potion", ID = 171352, QueueForbidden = true }),
    PotionofHardenedShadows            = Action.Create({ Type = "Potion", ID = 171271, QueueForbidden = true }),
    PotionofPhantomFire                = Action.Create({ Type = "Potion", ID = 171349, QueueForbidden = true }),
    PotionofDeathlyFixation            = Action.Create({ Type = "Potion", ID = 171351, QueueForbidden = true }),
    SpiritualHealingPotion            = Action.Create({ Type = "Item", ID = 171267, QueueForbidden = true }),
    PhialofSerenity                    = Action.Create({ Type = "Item", ID = 177278 }),
    
    -- Misc
    Channeling                      = Action.Create({ Type = "Spell", ID = 209274, Hidden = true     }),    -- Show an icon during channeling
    TargetEnemy                     = Action.Create({ Type = "Spell", ID = 44603, Hidden = true     }),    -- Change Target (Tab button)
    StopCast                        = Action.Create({ Type = "Spell", ID = 61721, Hidden = true     }),        -- spell_magic_polymorphrabbit
    PoolResource                    = Action.Create({ Type = "Spell", ID = 209274, Hidden = true     }),
    Quake                           = Action.Create({ Type = "Spell", ID = 240447, Hidden = true     }), -- Quake (Mythic Plus Affix)
    Cyclone                         = Action.Create({ Type = "Spell", ID = 33786, Hidden = true     }), -- Cyclone     
    
}

-- To create essences use next code:
Action:CreateEssencesFor(ACTION_CONST_PALADIN_HOLY)  -- where PLAYERSPEC is Constance (example: ACTION_CONST_MONK_BM)
local A = setmetatable(Action[ACTION_CONST_PALADIN_HOLY], { __index = Action })


local player = "player"
local targettarget = "targettarget"
local target = "target"
local mouseover = "mouseover"
local focustarget = "focustarget"
local focus = "focus"

-- Call to avoid lua limit of 60upvalues 
-- Call RotationsVariables in each function that need these vars
local function RotationsVariables()
    combatTime = Unit(player):CombatTime()
    inCombat = Unit(player):CombatTime() > 0
    UseDBM = GetToggle(1 ,"DBM") -- Don't call it DBM else it broke all the global DBM var used by another addons
    Potion = GetToggle(1, "Potion")
    Racial = GetToggle(1, "Racial")
    HealMouseover = GetToggle(2, "HealMouseover")
    DPSMouseover = GetToggle(2, "DPSMouseover")
    -- ProfileUI vars
    BeaconWorkMode = GetToggle(2, "BeaconWorkMode")    
    TrinketMana = GetToggle(2, "TrinketMana")
    LightofDawnHP = GetToggle(2, "LightofDawnHP")
    LightofDawnUnits = GetToggle(2, "LightofDawnUnits")
    UseLightofDawn = GetToggle(2, "UseLightofDawn")
    ForceWoGHP = GetToggle(2, "ForceWoGHP")
	HolyLightHP = GetToggle(2, "HolyLightHP")
	WordofGloryHP = GetToggle(2, "WordofGloryHP")
	HolyShockHP = GetToggle(2, "HolyShockHP")
	BestowFaithHP = GetToggle(2, "BestowFaithHP")
	FlashofLightHP = GetToggle(2, "FlashofLightHP")
	HolyPrismHP = GetToggle(2, "HolyPrismHP")
	LightofMartyr = GetToggle(2, "LightofDawnHP")
	DFHolyLightHP = GetToggle(2, "DFHolyLightHP")
    if A.Shadowbreaker:HasLegendaryCraftingPower() then
        LightofDawnRange = 40
    elseif not A.Shadowbreaker:HasLegendaryCraftingPower() then
        LightofDawnRange = 15
    end
    
end


local Temp                               = {
    TotalAndPhys                            = {"TotalImun", "DamagePhysImun"},
    TotalAndPhysKick                        = {"TotalImun", "DamagePhysImun", "KickImun"},
    TotalAndPhysAndCC                       = {"TotalImun", "DamagePhysImun", "CCTotalImun"},
    TotalAndPhysAndStun                     = {"TotalImun", "DamagePhysImun", "StunImun"},
    TotalAndPhysAndCCAndStun                = {"TotalImun", "DamagePhysImun", "CCTotalImun", "StunImun"},
    TotalAndMag                             = {"TotalImun", "DamageMagicImun"},
    TotalAndMagKick                         = {"TotalImun", "DamageMagicImun", "KickImun"},
}

local GetTotemInfo, IsMouseButtonDown, UnitIsUnit = GetTotemInfo, IsMouseButtonDown, UnitIsUnit

-- [1] CC AntiFake Rotation
local function AntiFakeStun(unit) 
    return 
    IsUnitEnemy(unit) and Unit(unit):GetDR("stun") > 0 and
    Unit(unit):GetRange() <= 10 and Unit(unit):HasBuffs(A.Sanguine.ID) == 0 and Unit(unit):HasDeBuffs({"Silenced", "Stuned", "Sleep", "Fear", "Disoriented", "Incapacitated"}) == 0 and
    A.HammerofJusticeGreen:AbsentImun(unit, Temp.TotalAndPhysAndCCAndStun, true)          
end 
A[1] = function(icon)    
    local useKick, useCC, useRacial = A.InterruptIsValid(targettarget, "TargetMouseover")    
    
    
    
    -- Manual Key
    if     A.HammerofJusticeGreen:IsReady(nil, nil, nil, true) and 
    (
        AntiFakeStun(mouseover) or 
        AntiFakeStun(target) or 
        (
            not IsUnitEnemy(mouseover) and 
            not IsUnitEnemy(target) and                     
            (
                (A.IsInPvP and EnemyTeam():PlayersInRange(1, 10)) or 
                (not A.IsInPvP and MultiUnits:GetByRange(10) >= 1)
            )
        )
    )
    then 
        return A.HammerofJusticeGreen:Show(icon)         
    end
    
    
end

TMW:RegisterCallback("TMW_ACTION_HEALINGENGINE_UNIT_UPDATE", function(callbackEvent, thisUnit, db, QueueOrder) 
        
        local _,_,_,_,_,NPCID = Unit("target"):InfoGUID()
        
        if IsUnitEnemy("target") or NPCID == 171577 or NPCID == 165759 then
            if thisUnit.Unit and (thisUnit.HP > GetToggle(2, "HolyShockHP") and (not AuraIsValid(thisUnit.Unit, "UseDispel", "Dispel") or AuraIsValid(thisUnit.Unit, "UseDispel", "Dispel") and not A.Cleanse:IsReady()) and (not AuraIsValid(thisUnit.Unit, true, "BlessingofFreedom") or AuraIsValid(thisUnit.Unit, true, "BlessingofFreedom") and not A.BlessingofFreedom:IsReady())) then
                thisUnit.Enabled = false
            end     
        end
        
		if Unit("target"):IsExplosives() then
			thisUnit.Enabled = false
		end
		
        if A.InstanceInfo.KeyStone >= 7 and thisUnit.Unit and Unit(thisUnit.Unit):HasDeBuffsStacks(209858) >= GetToggle(2, "Necrotic") and (not AuraIsValid(thisUnit.Unit, "UseDispel", "Dispel") or AuraIsValid(thisUnit.Unit, "UseDispel", "Dispel") and not A.Cleanse:IsReady()) and (not AuraIsValid(thisUnit.Unit, true, "BlessingofFreedom") or AuraIsValid(thisUnit.Unit, true, "BlessingofFreedom") and not A.BlessingofFreedom:IsReady()) then
            thisUnit.isSelectAble = false
        end
        
        if thisUnit.Unit and (Unit(thisUnit.Unit):HasBuffs(344916) > 0 or Unit(thisUnit.Unit):HasBuffs(108978) > 0) and (not AuraIsValid(thisUnit.Unit, "UseDispel", "Dispel") or AuraIsValid(thisUnit.Unit, "UseDispel", "Dispel") and not A.Cleanse:IsReady()) and (not AuraIsValid(thisUnit.Unit, true, "BlessingofFreedom") or AuraIsValid(thisUnit.Unit, true, "BlessingofFreedom") and not A.BlessingofFreedom:IsReady()) then
            thisUnit.isSelectAble = false
        end
        
end)

local function SelfDefensives()
    if Unit(player):CombatTime() == 0 then 
        return 
    end 
    
    local unit
    if A.IsUnitEnemy("mouseover") then 
        unit = "mouseover"
    elseif A.IsUnitEnemy("target") then 
        unit = "target"
    end  
    
    -- DivineShield
    if A.DivineShield:IsReady(player) and GetToggle(2, "UseDivineShield") and combatTime > 0 and Unit(player):HasDeBuffs(A.Forbearance.ID, true) == 0 and Unit(player):HealthPercent() < 20 and Unit(player):TimeToDieX(20) < 3
    then 
        return A.DivineShield
    end
    
    -- BlessingofProtection
    if A.BlessingofProtection:IsReady(player) and combatTime > 0 and not A.DivineShield:IsReady(player) and Unit(player):HealthPercent() < 30 and (Unit(player):HasBuffs("TotalImun") == 0 or Unit(player):HasBuffs("DamagePhysImun") == 0 and Unit(player):TimeToDieX(20) - Unit(player):TimeToDieMagicX(20) < -1)
    and Unit(player):HasDeBuffs(A.Forbearance.ID, true) == 0 and UnitIsUnit("target", player)
    then 
        return A.BlessingofProtection
    end
    
    -- DivineProtection
    if A.DivineProtection:IsReady(player) and Unit(player):HealthPercent() < 60 and Unit(player):TimeToDieX(20) < 10 then
        return A.DivineProtection
    end
    
    -- Stoneform on self dispel (only PvE)
    if A.Stoneform:IsRacialReady("player", true) and not A.IsInPvP and A.AuraIsValid("player", "UseDispel", "Dispel") then 
        return A.Stoneform
    end 
    
end 
SelfDefensives = A.MakeFunctionCachedStatic(SelfDefensives)

-----------------------------------------
--        ROTATION FUNCTIONS           --
-----------------------------------------

local ipairs, pairs = ipairs, pairs
local FriendlyGUIDs = TeamCache.Friendly.GUIDs

-- [3] Single Rotation
A[3] = function(icon, isMulti)
    --------------------
    --- ROTATION VAR ---
    --------------------
    local CurrentTanks = HealingEngine.GetMembersByMode("TANK")
    local getmembersAll = HealingEngine.GetMembersAll()
    local inCombat = Unit(player):CombatTime() > 0
    local isMoving = Player:IsMoving()
    local isMovingFor = A.Player:IsMovingTime()
    local combatTime = Unit(player):CombatTime()    
    local ShouldStop = Action.ShouldStop()
    local Pull = Action.BossMods:GetPullTimer()
    local AoEON = GetToggle(2, "AoE")
    local IsCCDebuff = {
        118,
        853,
        3355,
        5484,
        5782,
        8122,
        9484,
        15487,
        19386,
        20066,
        31661,
        105421,
        113724,
        118905,
        179057,
        204399,
        209749,
        209790,
        211881,
        217832,
        226943,
        240574,
        314793,
        317009,
        323673
    }
    local IsSlowDebuff = {
        116,
        120,
        339,
        3409,
        5760,
        6360,
        31589,
        31935,
        54644,
        55095,
        61391,
        102359,
        117526,
        183218,
        196840,
        205708,
        228358,
        337113
    }
    local IsDoTDebuff = {
        328305,
        8680,
        233397,
        55095,
        191587,
        146739,
        247456,
        48181,
        257284,
        12654,
        157736,
        164812,
        321712,
        32390,
        589,
        63106,
        164815,
        325203        
    }    
    local PVPMELEE = {
        ACTION_CONST_WARRIOR_ARMS,
        ACTION_CONST_WARRIOR_FURY,
        ACTION_CONST_HUNTER_SURVIVAL,
        ACTION_CONST_ROGUE_ASSASSINATION,
        ACTION_CONST_ROGUE_SUBTLETY,
        ACTION_CONST_ROGUE_OUTLAW,
        ACTION_CONST_SHAMAN_ENCHANCEMENT,
        ACTION_CONST_MONK_WINDWALKER,
        ACTION_CONST_DEMONHUNTER_HAVOC,
        ACTION_CONST_DEATHKNIGHT_FROST,
        ACTION_CONST_DEATHKNIGHT_UNHOLY
    }
    local PVEMELEE = {
        ACTION_CONST_WARRIOR_ARMS,
        ACTION_CONST_WARRIOR_FURY,
        ACTION_CONST_HUNTER_SURVIVAL,
        ACTION_CONST_ROGUE_ASSASSINATION,
        ACTION_CONST_ROGUE_SUBTLETY,
        ACTION_CONST_ROGUE_OUTLAW,
        ACTION_CONST_SHAMAN_ENCHANCEMENT,
        ACTION_CONST_MONK_WINDWALKER,
        ACTION_CONST_DEMONHUNTER_HAVOC,
        ACTION_CONST_DEATHKNIGHT_FROST,
        ACTION_CONST_DEATHKNIGHT_UNHOLY,
        ACTION_CONST_DRUID_FERAL,
        ACTION_CONST_PALADIN_RETRIBUTION
    }    
    local CCImmune = {
        [170850] = true, --Raging Bloodhorn TOP
        [164506] = true, --Ancient Captain TOP
        [162744] = true, --Nekthara the Mangler TOP
        [167532] = true, --Heavin the Breaker TOP
        [167536] = true, --Harugia the Bloodthirsty TOP
        [167533] = true, --Advent Nevermore TOP
        [167534] = true, --Rek the Hardened TOP
        [163086] = true, --Rancid Gasbag TOP
        [167998] = true, --Portal Guardian TOP
        [169893] = true, --Nefarious Darkspear TOP
        [162763] = true, --Soulforged Bonereaver TOP
        [169905] = true, --Risen Warlord DOS
        [168942] = true, --Death Speaker DOS
        [170572] = true, --Atal'ai Hoodoo Hexxer DOS
        [167962] = true, --Defunct Dental Drill DOS
        [167964] = true, --4.RF-4.RF DOS
        [171184] = true, --Mythresh, Sky's Talons DOS
        [171343] = true, --Bladebeak Matriarch DOS
        [164557] = true, --Shard of Halkias HOA
        [167876] = true, --Inquisitor Sigar HOA
        [164929] = true, --Tirnenn Villager Mists
        [164926] = true, --Drust Boughbreaker Mists
        [173714] = true, --Mistveil Nightblossom Mists
        [173720] = true, --Mistveil Gorgegullet Mists
        [173655] = true, --Mistveil Matriarch Mists
        [167111] = true, --Spiremaw Staghorn Mists
        [165137] = true, --Zolramus Gatekeeper NW
        [165824] = true, --Nar'zudah NW
        [165197] = true, --Skeletal Monstrosity NW
        [165919] = true, --Skeletal Marauder NW
        [172981] = true, --Kyrian Stichwerk NW
        [173044] = true, --Stitching Assistant NW
        [167731] = true, --Separation Assistant NW
        [163621] = true, --Goregrind NW
        [163620] = true, --Rotspew NW
        [167731] = true, --Separation Assistant NW
        [168310] = true, --Plagueroc PF
        [163882] = true, --Decaying Flesh Giant PF
        [168393] = true, --Plaguebelcher PF
        [169159] = true, --Unstable Canister PF
        [163894] = true, --Blighted Spinebreaker PF
        [168886] = true, --Virulax Blightweaver PF
        [169861] = true, --Ickor Bileflesh PF
        [162038] = true, --Regal Mistdancer SD
        [162047] = true, --Insatiable Brute SD
        [162057] = true, --Chamber Sentinel SD
        [162040] = true, --Grand Overseer SD
        [171376] = true, --Head Custodian Javlin SD
        [171799] = true, --Depths Warden SD
        [162057] = true, --Chamber Sentinel SD
        [168318] = true, --Forsworn Goliath SOA
        [163520] = true, --Forsworn Squad-Leader SOA
        [168681] = true, --Forsworn Helion SOA
        [168844] = true, --Lakesis SOA
        [168843] = true, --Klotos SOA
        [168845] = true --Astronos SOA
    }
    local MagicNPCID = {
        [165946] = true, -- Mor'dretha
        [169875] = true, -- Shackled Soul
        [167998] = true, -- Portal Guardian
        [160495] = true, -- Maniacal Soulbinder
        [170882] = true, -- Bone Magus
        [169893] = true, -- Nefarious Darkspeaker
        [162309] = true, -- Kul'tharok
        [164450] = true, -- Dealer Xy'example
        [164556] = true, -- Millhouse Manastorm
        [164555] = true, -- Millificent Manastorm
        [167965] = true, -- Lubricator
        [167967] = true, -- Sentient Oil
        [167962] = true, -- Defunct Dental Drill
        [168934] = true, -- Enraged Spirit
        [164185] = true, -- Echelon
        [165410] = true, -- High Adjudicator Aleez
        [164218] = true, -- Lord Chamberlain
        [164567] = true, -- Ingra Maloch
        [164501] = true, -- Mistcaller
        [167116] = true, -- Spinemaw Reaver
        [167111] = true, -- Spinemaw Staghorn
        [172312] = true, -- Spinemaw Gorger
        [167113] = true, -- Spinemaw Acid Gullet
        [167117] = true, -- Spinemaw Larva
        [164517] = true, -- Tred'ova
        [168578] = true, -- Fungalmancer
        [169696] = true, -- Mire Soldier
        [168572] = true, -- Fungal Stormer
        [168574] = true, -- Pestilent Harvester
        [168969] = true, -- Gushing Slime
        [163894] = true, -- Blighted Spinebreaker
        [163892] = true, -- Rotting Slimeclaw
        [163891] = true, -- Rotmarrow Slime
        [168627] = true, -- Plaguebinder
        [164705] = true, -- Pestilence Slime
        [168878] = true, -- Rigged Plagueborer
        [168886] = true, -- Virulax Blightweaver
        [164707] = true, -- Congealed Slime
        [164967] = true, -- Doctor Ickus
        [167956] = true, -- Dark Acolyte
        [162039] = true, -- Wicked Oppressor
        [162102] = true, -- Grand Proctor Beryllia
        [162103] = true, -- Executor Tarvold
        [168882] = true, -- Fleeting Manifestation
        [162040] = true, -- Grand Overseer
        [165076] = true, -- Gluttonous Tick
        [163077] = true, -- Azules
        [162059] = true, -- Kin-Tara
        [162058] = true, -- Ventunax
        [168681] = true, -- Forsworn Helion
        [162060] = true, -- Oryphrion
        [168843] = true, -- Klotos
        [168844] = true, -- Lakesis
        [168845] = true, -- Astronos
        [162691] = true, -- Blightbone
        [165137] = true, -- Zolramus Gatekeeper
        [163157] = true, -- Amarth
        [163620] = true, -- Rotspew
        [162693] = true, -- Nalthor the Rimebinder
        [179892] = true, -- Oros Coldheart
        [179446] = true -- Incinerator Arkolath
    }
    local PVEDispelDebuffs = {
        173757,    183347,    240443,    242391,    270248,    275014,    304093,    304831,    307115,    317661,    317963,    319626,    320788,    321038,    321968,    322410,    322557,    322817,    322818,    322977,    323365,    324293,    324859,    325224,    325701,    325725,    325885,    326092,
        326617,    326632,    327481,    327648,    328180,    328331,    328664,    329110,    329325,    329326,    329608,    329862,    329904,
        329905,    329976, 332605,    332707,    333708,    334505,    334765,    338353,    338729,    340026,    342207, 347283, 348756, 349954, 350713, 
        353573, 353588, 355641, 355732, 355915, 356031, 
        356324, 357029, 358973,
        
        272588,    277043,    319070,    319898,    320248,    320512,    320542,    320596,    321821,    322358,    324652,    327882,    328002,    328501,    328986,    330592,    330700,    331399,    333711,    340630,    341949,
        
        7992, 325552, 326092, 334900, 334926
    }
    
    local PVEBOFDebuffs = {
        173757, 259220, 292910, 295945, 295991, 304831, 319592, 320480, 320788, 324381, 324652, 324859, 326092, 328012, 328180, 328409, 328664, 329325, 329862, 330810, 331606, 332397, 334926, 335306, 338729, 355711, 358777
    }
    
    local PVPDispelDebuffs = {
        3409, 5760, 328305, 8680, 19386, 
        
        233397, 55095, 191587,
        
        116, 118, 120, 122, 339, 3355, 589, 853, 5484, 5782, 8122, 9484, 12654, 15487, 20066, 31589, 31661, 31935, 32390, 48181, 54644, 61391, 63106, 105421, 117526, 118905, 146739, 157736, 164812, 164815, 179057, 183218, 196840, 
        204399, 205708, 209749, 209790, 211881,
        217832, 226943, 228358, 240574, 247456, 257284, 314793, 317009, 321712, 323673, 325203
        
    }
    
    local PVPBOFDebuffs = {
        116, 120, 122, 339, 1715, 3409, 3600, 5116, 6360, 12323, 19387, 45524, 51485, 54644, 58180, 61391, 102359, 109248, 116095, 135299, 183218, 186387, 196840, 204206, 209749, 334275
    }
    
    -- Healing Engine vars
    local AVG_DMG = HealingEngine.GetIncomingDMGAVG()
    local AVG_HPS = HealingEngine.GetIncomingHPSAVG()
    local TeamCacheEnemySize = TeamCache.Enemy.Size
    local DungeonGroup = TeamCache.Friendly.Size >= 2 and TeamCache.Friendly.Size <= 5
    local RaidGroup = TeamCache.Friendly.Size >= 5
    local TeamCacheFriendlySize = TeamCache.Friendly.Size
    local TeamCacheFriendlyType = TeamCache.Friendly.Type or "none"     
    
    
    RotationsVariables()    
    
    --------------------------------
    local UseCovenant = A.GetToggle(1, "Covenant")
    
    --------------------
    --- DPS ROTATION ---
    --------------------
    local function DamageRotation(unitID)
        
        if A.Zone == "arena" or A.InstanceInfo.isRated or A.Zone == "pvp" or inCombat then
            
            local _,_,_,_,_,NPCID1 = Unit(unitID):InfoGUID()
            local useCC = Action.InterruptIsValid(unitID)
            if useCC and not CCImmune[NPCID1] and Unit(unitID):HasDeBuffs({"Silenced", "Stuned", "Sleep", "Fear", "Disoriented", "Incapacitated"}) == 0 and Unit(unitID):IsControlAble("stun") and Unit(unitID):HasBuffs(A.Sanguine.ID) == 0 and A.HammerofJustice:IsReady(unitID) and Unit(unitID):GetDR("stun") > 0 and Unit(unitID):GetRange() <= 10 and A.HammerofJustice:AbsentImun(unitID, Temp.TotalAndPhysAndCC) and not Unit(unitID):IsBoss() and not Unit(unitID):IsDead() and Unit(unitID):CanInterrupt(true, nil, 20, 85)
            then 
                return A.HammerofJustice:Show(icon)       
            end          
            
            if (A.Zone == "arena" or A.InstanceInfo.isRated) and A.HammerofJustice:IsReady("target") and Unit("target"):HasDeBuffs({"Silenced", "Stuned", "Sleep", "Fear", "Disoriented", "Incapacitated"}) == 0 and Unit("target"):GetDR("stun") == 100 and A.HammerofJustice:AbsentImun("target", Temp.TotalAndPhysAndCC) and IsUnitEnemy("target") then
                return A.HammerofJustice:Show(icon)       
            end    
            
            if (A.Zone == "arena" or A.InstanceInfo.isRated) and A.HammerofJustice:IsReady("mouseover") and Unit("mouseover"):HasDeBuffs({"Silenced", "Stuned", "Sleep", "Fear", "Disoriented", "Incapacitated"}) == 0 and Unit("mouseover"):GetDR("stun") == 100 and A.HammerofJustice:AbsentImun("mouseover", Temp.TotalAndPhysAndCC) and IsUnitEnemy("mouseover") then
                return A.HammerofJustice:Show(icon)       
            end    
            
            if useCC and not CCImmune[NPCID1] and Unit(unitID):HasDeBuffs({"Silenced", "Stuned", "Sleep", "Fear", "Disoriented", "Incapacitated"}) == 0 and Unit(unitID):IsControlAble("disorient") and A.BlindingLight:IsReady(unitID) and Unit(unitID):GetDR("disorient") > 0 and Unit(unitID):GetRange() <= 10 and A.BlindingLight:AbsentImun(unitID, Temp.TotalAndPhysAndCC) and not Unit(unitID):IsBoss() and not Unit(unitID):IsDead() and Unit(unitID):CanInterrupt(true, nil, 20, 85)
            then 
                return A.BlindingLight:Show(icon)       
            end            
            
            if Unit(mouseover):Name() == "Spiteful Shade" and Unit(mouseover):HasBuffs(A.Sanguine.ID) == 0 and A.HammerofJustice:IsReady(mouseover) and Unit(mouseover):HasDeBuffs({"Stuned", "Disoriented", "PhysStuned"}) == 0 and Unit("targettarget"):Name() == Unit(player):Name() and A.HammerofJustice:AbsentImun(mouseover, Temp.TotalAndPhysAndCC) and Unit(mouseover):GetDR("stun") >= 50 then
                return A.HammerofJustice:Show(icon) 
            end
            
            if Unit(unitID):IsExplosives() then
				if A.HammerofWrath:IsReady(unitID) then
					return A.HammerofWrath:Show(icon)
				elseif A.Judgment:IsReady(unitID) then
					return A.Judgment:Show(icon)
				elseif A.CrusaderStrike:IsReady(unitID) then
					return A.CrusaderStrike:Show(icon)
				elseif A.HolyShock:IsReady(unitID) and HealingEngine.GetBelowHealthPercentUnits(80, 40) == 0 then
					return A.HolyShock:Show(icon)
				end
			end
            
            if Unit(unitID):HasDeBuffs("BreakAble") == 0 and A.Zone == "arena" or A.InstanceInfo.isRated or (Unit(unitID):GetRange() <= 15) then
                
				if MultiUnits:GetByRangeInCombat(30) >= 4 and A.GetToggle(2, "OffensiveDT") and A.DivineToll:IsReady(unitID) and HealingEngine.GetBelowHealthPercentUnits(80, 40) <= 1 then
					return A.DivineToll:Show(icon)
				end
				
				if A.HammerofWrath:IsReady(unitID) and Unit(player):HasDeBuffs(A.Mindgames.ID) == 0 and (A.AshenHallow:GetSpellTimeSinceLastCast() <= 30 or A.MadParagon:HasLegendaryCraftingPower() and Unit(player):HasBuffs(A.AvengingWrath.ID) > 0)
				and IsUnitEnemy(unitID) and Unit(unitID):HasDeBuffs(A.Cyclone.ID) == 0 and not Unit(target):IsDead() then
					return A.HammerofWrath:Show(icon)
				end     
				
                --Soulletting Ruby Trinket
                if A.SoullettingRuby:IsReady(unitID) and IsUnitEnemy(unitID) and Unit(unitID):HasDeBuffs(A.Cyclone.ID) == 0 and combatTime > 0 and not Unit(unitID):IsPet() and not Unit(unitID):IsDead() and Unit(player):HealthPercent() <= GetToggle(2, "TrinketBurstHealing") 
                and A.SoullettingRuby:AbsentImun(unitID, Temp.TotalAndMagPhys) and (TeamCacheFriendlyType ~= "none" and HealingEngine.GetBelowHealthPercentUnits(80, 40) >= 3 or TeamCacheFriendlyType == "none")  then
                    return A.SoullettingRuby:Show(icon)
                end
                
                if A.Consecration:IsReady(player) and MultiUnits:GetByRange(5) >= 2 and Unit(unitID):HasDeBuffs(204242, true) <= 1 and A.CrusaderStrike:IsInRange(unitID) then
                    return A.Consecration:Show(icon)
                end
                
                if A.Awakening:IsTalentLearned() and A.LightofDawn:IsReady(unitID) and A.GetToggle(2, "LightofDawnDump") and Player:HolyPower() == A.GetToggle(2, "DumpHP") and Unit(player):HasBuffs(A.AvengingWrath.ID) == 0 then
                    return A.LightofDawn:Show(icon)
                end
                
                if (A.Awakening:IsTalentLearned() and A.GetToggle(2, "LightofDawnDump") and Unit(player):HasBuffs(A.AvengingWrath.ID) > 0 or A.Awakening:IsTalentLearned() and not A.GetToggle(2, "LightofDawnDump") or not A.Awakening:IsTalentLearned()) and A.ShieldoftheRighteous:IsReady(player) and Player:HolyPower() >= A.GetToggle(2, "DumpHP") and Unit(player):HasDeBuffs(A.Mindgames.ID) == 0 and A.CrusaderStrike:IsInRange(unitID) and IsUnitEnemy(unitID) and Unit(unitID):HasDeBuffs(A.Cyclone.ID) == 0 
                and (HealingEngine.GetBelowHealthPercentUnits(80, 40) < 1 or (HealingEngine.GetBelowHealthPercentUnits(50, 40) < 1 and TeamCache.Friendly.Size <= 2)) then
                    return A.ShieldoftheRighteous:Show(icon)
                end
                
                if A.HammerofWrath:IsReady(unitID) and Unit(player):HasDeBuffs(A.Mindgames.ID) == 0 and Unit(unitID):GetRange() <= 30 and Unit(unitID):HasDeBuffs(A.Cyclone.ID) == 0 then
                    return A.HammerofWrath:Show(icon)
                end
                
                if A.Judgment:IsReady(unitID) and Unit(player):HasDeBuffs(A.Mindgames.ID) == 0 and Unit(unitID):GetRange() <= 30 and Unit(unitID):HasDeBuffs(A.Cyclone.ID) == 0 then
                    return A.Judgment:Show(icon)
                end
                
                if ((A.Zone == "pvp" or A.Zone == "arena" or A.InstanceInfo.isRated) or (Player:ManaPercentage() > GetToggle(2, "ManaConservation") * 2)) and A.HolyShock:IsReady(unitID) and Unit(player):HasDeBuffs(A.Mindgames.ID) == 0 and GetToggle(2, "HolyShockDPS") and Unit(unitID):GetRange() <= 40 and Unit(unitID):HasDeBuffs(A.Cyclone.ID) == 0 then
                    return A.HolyShock:Show(icon)
                end
                
                if A.CrusaderStrike:IsReady(unitID) and Unit(player):HasDeBuffs(A.Mindgames.ID) == 0 and A.CrusaderStrike:IsInRange(unitID) and Unit(unitID):HasDeBuffs(A.Cyclone.ID) == 0 and
                ((A.CrusadersMight:IsTalentLearned() and Player:HolyPower() < 5 and A.HolyShock:GetCooldown() >= 1.0 and Player:ManaPercentage() > GetToggle(2, "ManaConservation")) 
                    or (not A.CrusadersMight:IsTalentLearned() and Player:HolyPower() < 5 and ((A.Zone == "pvp" or A.Zone == "arena" or A.InstanceInfo.isRated) or (Player:ManaPercentage() > GetToggle(2, "ManaConservation")))))
                then
                    return A.CrusaderStrike:Show(icon)
                end
                
                if A.Consecration:IsReady(player) and Unit(unitID):HasDeBuffs(204242, true) <= 1 and A.CrusaderStrike:IsInRange(unitID) then
                    return A.Consecration:Show(icon)
                end
            end    
        end
        
    end
    DamageRotation = Action.MakeFunctionCachedDynamic(DamageRotation)
    
    ---------------------
    --- HEAL ROTATION ---
    ---------------------
    local function HealingRotation(unitID) 
        
        local useDispel, useShields, useHoTs, useUtils = HealingEngine.GetOptionsByUnitID(unitID)
        local unitGUID = UnitGUID(unitID)    

        --Auras
        if (A.Zone == "pvp" or A.Zone == "arena" or A.InstanceInfo.isRated) and A.ConcentrationAura:IsReady() and Unit(player):HasBuffs(A.ConcentrationAura.ID) == 0 and Unit(player):HasBuffs(A.CrusaderAura.ID) == 0 and Unit(player):HasBuffs(A.RetributionAura.ID) == 0 
        and Unit(player):HasBuffs(A.DevotionAura.ID) == 0 then
            return A.ConcentrationAura:Show(icon)
        end
        
        if (A.Zone ~= "pvp" or A.Zone ~= "arena" or not A.InstanceInfo.isRated) and A.DevotionAura:IsReady() and Unit(player):HasBuffs(A.DevotionAura.ID) == 0 and Unit(player):HasBuffs(A.CrusaderAura.ID) == 0 and Unit(player):HasBuffs(A.RetributionAura.ID) == 0 
        and Unit(player):HasBuffs(A.ConcentrationAura.ID) == 0 then
            return A.DevotionAura:Show(icon)
        end
        
        --Lay on hands
        if Unit(player):HasDeBuffs(A.Mindgames.ID) == 0 and combatTime > 0 and Action.Zone ~= "arena" and not Action.InstanceInfo.isRated   -- Forbearance
        then
            for i = 1, #getmembersAll do 
                if Unit(getmembersAll[i].Unit):GetRange() <= 40 then 
                    if not Unit(getmembersAll[i].Unit):IsPet() and Unit(getmembersAll[i].Unit):HasDeBuffs(A.Cyclone.ID) == 0 and not Unit(getmembersAll[i].Unit):IsDead() and A.LayOnHands:IsReadyByPassCastGCD(getmembersAll[i].Unit) and (Unit(getmembersAll[i].Unit):HealthDeficit() >= Unit(player):HealthMax() or Unit(getmembersAll[i].Unit):HealthPercent() <= 30 
                        and Unit(getmembersAll[i].Unit):TimeToDie() <= 3) and Unit(getmembersAll[i].Unit):HasDeBuffs(A.Forbearance.ID, true) == 0 then
                        HealingEngine.SetTarget(getmembersAll[i].Unit, 0.5)    -- Add 1sec delay in case of emergency switch     
                        return A.LayOnHands:Show(icon)                        
                    end                    
                end                
            end    
        end 
        
        if GetToggle(1, "StopCast") then
            
            if Unit(player):HasDeBuffs(A.Quake.ID) > 0 and (Unit(player):IsCastingRemains(A.HolyLight.ID) > Unit(player):HasDeBuffs(A.Quake.ID) or Unit(player):IsCastingRemains(A.FlashofLight.ID) > Unit(player):HasDeBuffs(A.Quake.ID)) then
                return A:Show(icon, ACTION_CONST_STOPCAST)
            end
            
            if inCombat and Unit(player):HasBuffs(A.DivineFavor.ID, true) == 0 and (((Unit(player):IsCastingRemains(A.HolyLight.ID) > Player:Execute_Time(A.HolyLight.ID)/2 or Unit(player):IsCastingRemains(A.FlashofLight.ID) > Player:Execute_Time(A.FlashofLight.ID)/2) and A.HolyShock:IsReady(unitID) and Unit(unitID):HealthPercent() < HolyShockHP)
                or ((Unit(player):IsCastingRemains(A.HolyLight.ID) > 0.5 or Unit(player):IsCastingRemains(A.FlashofLight.ID) > 0.5) and A.WordofGlory:IsReady(unitID) and Unit(unitID):HealthPercent() < WordofGloryHP) or (Unit(player):IsCastingRemains(A.HolyLight.ID) > 0 and Unit(unitID):HealthPercent() >= HolyLightHP) 
				or (Unit(player):IsCastingRemains(A.FlashofLight.ID) > 0 and Unit(unitID):HealthPercent() >= FlashofLightHP)) then
                return A:Show(icon, ACTION_CONST_STOPCAST)
            end
            
        end
        
        --Blessing of Sacrifice
        if A.BlessingofSacrifice:IsReadyByPassCastGCD(unitID) and Unit(unitID):HasDeBuffs(A.Cyclone.ID) == 0 and combatTime > 0 and not UnitIsUnit(unitID, player) and not Unit(unitID):IsPet() and not Unit(unitID):IsDead() and Unit(unitID):HealthPercent() <= 40 
        and Unit(unitID):TimeToDieX(20) <= 4 and (Unit(unitID):HasBuffs("TotalImun") == 0 or Unit(unitID):HasBuffs("DamagePhysImun") > 0 and Unit(unitID):TimeToDieMagicX(20) <= 4 or Unit(unitID):HasBuffs("DamageMagicImun") > 0 and Unit(unitID):TimeToDieX(20) - Unit(unitID):TimeToDieMagicX(20) < -1) then
            return A.BlessingofSacrifice:Show(icon)
        end    
        
        --Blessing of Protection (Keystone Combustion Aggro)
        for i = 1, #getmembersAll do 
            if combatTime > 0 and useShields and Unit(getmembersAll[i].Unit):GetRange() <= 40 and A.InstanceInfo.KeyStone >= 15 then 
                if not Unit(getmembersAll[i].Unit):IsPet() and not Unit(getmembersAll[i].Unit):IsDead() and A.BlessingofProtection:IsReady(getmembersAll[i].Unit) 
                and Unit(getmembersAll[i].Unit):HasDeBuffs(A.Forbearance.ID) == 0 and Unit(getmembersAll[i].Unit):HasBuffs(A.Combustion.ID) > 0
                and Unit(getmembersAll[i].Unit):IsTanking() and not Unit(getmembersAll[i].Unit):Role("TANK") and not UnitIsUnit(getmembersAll[i].Unit, player) and (Unit(getmembersAll[i].Unit):HasBuffs("TotalImun") == 0 or Unit(getmembersAll[i].Unit):HasBuffs("DamagePhysImun") == 0) then
                    HealingEngine.SetTarget(getmembersAll[i].Unit, 0.5)       
                    return A.BlessingofProtection:Show(icon)                        
                end                    
            end                
        end    
        
        local _,_,_,_,_,NPCID1 = Unit(unitID):InfoGUID()
        
        --Blessing of Protection
        
        if A.BlessingofProtection:IsReady(unitID) and not MagicNPCID[NPCID1] and Unit(unitID):HasDeBuffs(A.Cyclone.ID) == 0 and useShields and combatTime > 0 and not Unit(unitID):IsPet() and not Unit(unitID):IsTank() and not UnitIsUnit(unitID, player) and not Unit(unitID):IsDead() 
        and Unit(unitID):HealthPercent() <= 30 and Unit(unitID):TimeToDieX(20) <= 4 and Unit(unitID):HasDeBuffs(A.OrbofPowerBlue.ID) == 0 and Unit(unitID):HasDeBuffs(A.OrbofPowerGreen.ID) == 0 
        and Unit(unitID):HasDeBuffs(A.OrbofPowerPurple.ID) == 0 and Unit(unitID):HasDeBuffs(A.OrbofPowerOrange.ID) == 0 and Unit(unitID):HasDeBuffs(A.Forbearance.ID, true) == 0
        and not Unit(unitID):HasFlags() and (Unit(unitID):HasBuffs("TotalImun") == 0 or Unit(unitID):HasBuffs("DamagePhysImun") == 0 and Unit(unitID):TimeToDieX(20) - Unit(unitID):TimeToDieMagicX(20) < -1) then
            return A.BlessingofProtection:Show(icon)
        end    
        
        if A.WillToSurvive:IsReady() and Unit(player):HasDeBuffs("Stuned") > 2 then
            return A.WillToSurvive:Show(icon)
        end
        
        --Tuft Trinket (remove after obsolete in 9.1)
        if A.TuftofSmolderingPlumage:IsReady(unitID) and Unit(unitID):HasDeBuffs(A.Cyclone.ID) == 0 and combatTime > 0 and not Unit(unitID):IsPet() and not Unit(unitID):IsDead() and Unit(unitID):HealthPercent() <= GetToggle(2, "TrinketBurstHealing") 
        and (Unit(unitID):HasBuffs("TotalImun") == 0 or Unit(unitID):HasBuffs("DamagePhysImun") > 0 and Unit(unitID):TimeToDieMagicX(20) <= 3 or Unit(unitID):HasBuffs("DamageMagicImun") > 0 and Unit(unitID):TimeToDieX(20) - Unit(unitID):TimeToDieMagicX(20) < -1) then
            return A.TuftofSmolderingPlumage:Show(icon)
        end
        
        --Soulletting Ruby Trinket
        if A.SoullettingRuby:IsReady(unitID) and IsUnitEnemy(unitID) and Unit(unitID):HasDeBuffs(A.Cyclone.ID) == 0 and combatTime > 0 and not Unit(unitID):IsPet() and not Unit(unitID):IsDead() and Unit(player):HealthPercent() <= GetToggle(2, "TrinketBurstHealing") 
        and A.SoullettingRuby:AbsentImun(unitID, Temp.TotalAndMagPhys) and HealingEngine.GetBelowHealthPercentUnits(80, 40) >= 3 then
            return A.SoullettingRuby:Show(icon)
        end
        
        --Holy Light Divine Favor w/o Infusion
        if A.HolyLight:IsReady(unitID) and Unit(player):HasDeBuffs(A.Mindgames.ID) < 0.8 and Unit(unitID):HasDeBuffs(A.Cyclone.ID) == 0 and Unit(player):HasBuffs(A.DivineFavor.ID, true) > 0 and Unit(unitID):TimeToDie() <= 5 and Unit(unitID):HealthPercent() <= DFHolyLightHP and not Unit(unitID):IsDead() and Unit(player):GetCurrentSpeed() == 0 then
            return A.HolyLight:Show(icon)
        end    
        
        -- Beacon of Light - Self
        if not A.BeaconofVirtue:IsTalentLearned() and A.BeaconofLight:IsReady() and BeaconWorkMode == "Self" then
            if UnitIsUnit(unitID, player) and Unit(player):HasBuffs(A.BeaconofLight.ID, true) == 0  then    
                return A.BeaconofLight:Show(icon)                        
            end                    
        end
        
        -- Beacon of Light - Tank
        if not A.BeaconofVirtue:IsTalentLearned() and A.BeaconofLight:IsReady(unitID) and BeaconWorkMode == "Tanking Units" then
            if Unit(unitID):Role("TANK") and Unit(unitID):HasBuffs(A.BeaconofLight.ID, true) == 0 and HealingEngine.GetBuffsCount(A.BeaconofLight.ID, 0, true) == 0 then
                return A.BeaconofLight:Show(icon)
            end
        end
		
		-- Beacon of Faith PVE - 2x Tank
        if not A.BeaconofVirtue:IsTalentLearned() and BeaconWorkMode == "Beacon of Faith 2" then
            if A.BeaconofLight:IsReady(unitID) and Unit(unitID):Role("TANK") and Unit(unitID):HasBuffs(A.BeaconofLight.ID, true) == 0 and Unit(unitID):HasBuffs(A.BeaconofFaith.ID, true) == 0 and HealingEngine.GetBuffsCount(A.BeaconofLight.ID, 0, true) == 0 then
                return A.BeaconofLight:Show(icon)
            end
			if A.BeaconofFaith:IsReady(unitID) and Unit(unitID):Role("TANK") and Unit(unitID):HasBuffs(A.BeaconofLight.ID, true) == 0 and Unit(unitID):HasBuffs(A.BeaconofFaith.ID, true) == 0 and HealingEngine.GetBuffsCount(A.BeaconofFaith.ID, 0, true) == 0 then
                return A.BeaconofFaith:Show(icon)
			end
		end
        
        -- Beacon of Faith PVE
        if not A.BeaconofVirtue:IsTalentLearned() and A.BeaconofFaith:IsTalentLearned() and BeaconWorkMode == "Beacon of Faith" then
            if UnitIsUnit(unitID, player) and A.BeaconofFaith:IsReady(unitID) and Unit(player):HasBuffs(A.BeaconofFaith.ID, true) == 0 then
                return A.BeaconofFaith:Show(icon)
            end
            if Unit(unitID):Role("TANK") and Unit(unitID):HasBuffs(A.BeaconofLight.ID, true) == 0 and HealingEngine.GetBuffsCount(A.BeaconofLight.ID, 0, true) == 0 then
                return A.BeaconofLight:Show(icon)
            end
        end
        
        -- Beacon of Light - Beacon of Faith + Saved By the Light
        if A.SavedbytheLight:IsTalentLearned() and A.BeaconofFaith:IsTalentLearned() and BeaconWorkMode == "Beacon of Faith + Saved By the Light" then
            if UnitIsUnit(unitID, player) and not Unit(unitID):IsDead() and Unit(player):HasBuffs(A.BeaconofLight.ID, true) == 0 and Unit(player):HasDeBuffs(A.RecentlySavedByTheLight.ID, true) == 0 
            or not UnitIsUnit(unitID, player) and HealingEngine.GetBuffsCount(A.BeaconofFaith.ID) > 0 and Unit(unitID):HasDeBuffs(A.Cyclone.ID) == 0 and not Unit(unitID):IsDead() and IsUnitFriendly(unitID) and Unit(unitID):IsPlayer() and Unit(player):HasDeBuffs(A.RecentlySavedByTheLight.ID, true) > 0 and Unit(unitID):HasDeBuffs(A.RecentlySavedByTheLight.ID, true) == 0 and Unit(unitID):HasBuffs(A.BeaconofLight.ID, true) == 0 and Unit(unitID):HasBuffs(A.BeaconofFaith.ID, true) == 0 and Unit(unitID):HealthPercent() <= 45 and combatTime > 0 then
                return A.BeaconofLight:Show(icon)                        
            end           
            if IsUnitFriendly(unitID) and Unit(unitID):HasDeBuffs(A.Cyclone.ID) == 0 and not UnitIsUnit(unitID, player) and not Unit(unitID):IsDead() and Unit(unitID):IsPlayer() and Unit(unitID):HasBuffs(A.RecentlySavedByTheLight.ID, true) == 0 and (Unit(player):HasBuffs(A.BeaconofLight.ID, true) == 0 or Unit(player):HasDeBuffs(A.RecentlySavedByTheLight.ID, true) == 0) and Unit(unitID):HasBuffs(A.BeaconofLight.ID, true) == 0 and Unit(unitID):HasBuffs(A.BeaconofFaith.ID, true) == 0 and Unit(unitID):HealthPercent() <= 45 and combatTime > 0 then
                return A.BeaconofFaith:Show(icon)
            end
        end
        
        --Beacon of Virtue
        if A.BeaconofVirtue:IsReady(unitID) and Unit(player):HasDeBuffs(A.Mindgames.ID) == 0 and A.BeaconofVirtue:IsTalentLearned() and TeamCacheFriendlyType ~= "none" and
        (
            (       
                not IsUnitEnemy(target) and
                A.BeaconofVirtue:IsInRange(target) and
                Unit(target):HasDeBuffs(A.Cyclone.ID) == 0
            )
        ) and
        (
            (
                DungeonGroup and
                HealingEngine.GetBelowHealthPercentUnits(GetToggle(2, "BoVHPParty"), 30) >= GetToggle(2, "BoVUnitsParty") 
            ) or
            (
                RaidGroup and
                HealingEngine.GetBelowHealthPercentUnits(GetToggle(2, "BoVHPRaid"), 30) >= GetToggle(2, "BoVUnitsRaid")
            )
        )
        then
            return A.BeaconofVirtue:Show(icon)
        end
        
		-- Toll + Wrath Amplifier
		if combatTime > 0 and A.DivineToll:IsReady(unitID) and HealingEngine.GetBelowHealthPercentUnits(70, 30) >= 5 and Unit(player):HasBuffs(A.AvengingWrath.ID) == 0 and A.AvengingWrath:IsReady() and TeamCacheFriendlyType == "raid" then
			return A.AvengingWrath:Show(icon)
		end
		
        -- #17 HPvE DivineToll
        if A.DivineToll:IsReady(unitID) and combatTime > 0 and Unit(unitID):IsPlayer() and Unit(unitID):HasDeBuffs(A.Cyclone.ID) == 0 and not Unit(unitID):IsDead() 
		and not IsUnitEnemy(unitID) and Unit(unitID):GetRange() <= 30 and Unit(unitID):HealthPercent() < HolyShockHP and
        ((Player:HolyPower() <= 1 and
                        (    (Action.Zone == "arena" and (TeamCache.Friendly.Size >= 2 and HealingEngine.GetBelowHealthPercentUnits(80, 30) >= 2))
                            or
                            (TeamCacheFriendlyType == "none" and MultiUnits:GetByRange(10) > 2 and Unit(player):HealthPercent() <= 80) 
                            or
                            (TeamCacheFriendlyType == "party" and HealingEngine.GetBelowHealthPercentUnits(GetToggle(2, "DivineTollHPParty"), 30) >= GetToggle(2, "DivineTollUnitsParty")) 
                            or
                            (TeamCacheFriendlyType == "raid" and HealingEngine.GetBelowHealthPercentUnits(GetToggle(2, "DivineTollHPRaid"), 30) >= GetToggle(2, "DivineTollUnitsRaid"))
                        )
                    ) 
                    or
                    TeamCacheFriendly ~= "raid" and HealingEngine.GetBelowHealthPercentUnits(50, 30) >= 4 and Player:HolyPower() <= 3 or (TeamCacheFriendlyType == "raid" and HealingEngine.GetBelowHealthPercentUnits(80, 30) >= 5))
                then
                    return A.DivineToll:Show(icon)
        end
             
        
        if not Action.InstanceInfo.isRated or Action.InstanceInfo.isRated and (Unit(unitID):HealthPercent() >= 30 or Unit(unitID):HealthPercent() < 30 and not A.HolyShock:IsReady() and not A.WordofGlory:IsReady()) then
            
            -- PVP Dispel Prioritization
            if (A.Zone == "arena" or A.InstanceInfo.isRated) and A.Cleanse:IsReady() and A.GetToggle(2, "DispelSniper") then
                for i = 1, 40 do
                    for x = 1, #IsCCDebuff do
                        local name, rank, icon, count, debuffType = UnitDebuff(unitID, i) 
                        if debuffType == IsCCDebuff[x] and Unit(IsCCDebuff[i].Unit):HasDeBuffs(342938) == 0 and Unit(IsCCDebuff[i].Unit):HasDeBuffs(A.Cyclone.ID) == 0 and AuraIsValid(IsCCDebuff[i].Unit, "UseDispel", "Dispel") then
                            HealingEngine.SetTarget(IsCCDebuff[i].Unit, 0.5)
                        end
                    end
                    for x = 1, #IsSlowDebuff do
                        local name, rank, icon, count, debuffType = UnitDebuff(unitID, i) 
                        if debuffType == IsSlowDebuff[x] and Unit(IsSlowDebuff[i].Unit):HasDeBuffs(342938) == 0 and Unit(IsSlowDebuff[i].Unit):HasDeBuffs(A.Cyclone.ID) == 0 and AuraIsValid(IsSlowDebuff[i].Unit, "UseDispel", "Dispel") and Unit(IsSlowDebuff[i].Unit):HasSpec(PVPMELEE) then
                            HealingEngine.SetTarget(IsSlowDebuff[i].Unit, 0.5)
                        end
                    end
                    for x = 1, #IsSlowDebuff do
                        local name, rank, icon, count, debuffType = UnitDebuff(unitID, i) 
                        if debuffType == IsSlowDebuff[x] and Unit(IsSlowDebuff[i].Unit):HasDeBuffs(342938) == 0 and AuraIsValid(IsSlowDebuff[i].Unit, "UseDispel", "Dispel") and Unit(IsSlowDebuff[i].Unit):HasDeBuffs(A.Cyclone.ID) == 0 then
                            HealingEngine.SetTarget(IsSlowDebuff[i].Unit, 0.5)
                        end
                    end
                    for x = 1, #IsDoTDebuff do                    
                        local name, rank, icon, count, debuffType = UnitDebuff(unitID, i) 
                        if debuffType == IsDoTDebuff[x] and Unit(IsDoTDebuff[i].Unit):HasDeBuffs(342938) == 0 and AuraIsValid(IsDoTDebuff[i].Unit, "UseDispel", "Dispel") and Unit(IsDoTDebuff[i].Unit):HasDeBuffs(A.Cyclone.ID) == 0 then
                            HealingEngine.SetTarget(IsDoTDebuff[i].Unit, 0.5)
                        end
                    end
                end
            end
			
            if (A.Zone == "arena" or A.InstanceInfo.isRated) and A.BlessingofFreedom:IsReady() and A.GetToggle(2, "DispelSniper") then
                for i = 1, #getmembersAll do 
                    if Unit(getmembersAll[i].Unit):GetRange() <= 40 and not Unit(getmembersAll[i].Unit):IsDead() and Unit(getmembersAll[i].Unit):HasBuffs(A.BlessingofFreedom.ID) == 0 
                    and AuraIsValid(getmembersAll[i].Unit, true, "BlessingofFreedom") and Unit(getmembersAll[i].Unit):HasSpec(PVPMELEE) and Unit(getmembersAll[i].Unit):HasDeBuffs(A.Cyclone.ID) == 0 then  
                        HealingEngine.SetTarget(getmembersAll[i].Unit, 0.5)                                      
                    end                
                end
            end
            
            if A.Cleanse:IsReady() and A.GetToggle(2, "DispelSniper") then
                for i = 1, #getmembersAll do 
                    if Unit(getmembersAll[i].Unit):GetRange() <= 40 and not Unit(getmembersAll[i].Unit):IsDead() and AuraIsValid(getmembersAll[i].Unit, "UseDispel", "Dispel")
                    and Unit(getmembersAll[i].Unit):HasDeBuffs(342938) == 0 and Unit(getmembersAll[i].Unit):HasDeBuffs(A.Cyclone.ID) == 0 then  
                        HealingEngine.SetTarget(getmembersAll[i].Unit, 0.5)                                      
                    end                
                end
            end
            
            if A.BlessingofFreedom:IsReady() and A.GetToggle(2, "DispelSniper") then
                for i = 1, #getmembersAll do 
                    if Unit(getmembersAll[i].Unit):GetRange() <= 40 and Unit(getmembersAll[i].Unit):GetCurrentSpeed() <= 70 and not Unit(getmembersAll[i].Unit):IsDead() and Unit(getmembersAll[i].Unit):HasBuffs(A.BlessingofFreedom.ID) == 0 
                    and AuraIsValid(getmembersAll[i].Unit, true, "BlessingofFreedom") and Unit(getmembersAll[i].Unit):HasDeBuffs(A.Cyclone.ID) == 0 then  
                        HealingEngine.SetTarget(getmembersAll[i].Unit, 0.5)                                      
                    end                
                end
            end
			
			if A.BlessingofProtection:IsReady() and A.GetToggle(2, "DispelSniper") then
                for i = 1, #getmembersAll do 
                    if Unit(getmembersAll[i].Unit):GetRange() <= 40 and not Unit(getmembersAll[i].Unit):IsDead() and Unit(getmembersAll[i].Unit):HasBuffs(A.BlessingofProtection.ID) == 0 and Unit(getmembersAll[i].Unit):HasDeBuffs(A.Forbearance.ID) == 0
                    and AuraIsValid(getmembersAll[i].Unit, true, "BlessingofProtection") and Unit(getmembersAll[i].Unit):HasDeBuffs(A.Cyclone.ID) == 0 then  
                        HealingEngine.SetTarget(getmembersAll[i].Unit, 0.5)                                      
                    end                
                end
            end
            
            -- #1 HPvE Dispel
            if A.Cleanse:IsReady(unitID) and (((A.Zone ~= "arena" or not A.InstanceInfo.isRated)) or ((A.Zone == "arena" or A.InstanceInfo.isRated))) and
            useDispel and Unit(unitID):HasDeBuffs(342938) == 0 and
            (
                -- MouseOver
                (
                    Unit("mouseover"):IsExists() and 
                    MouseHasFrame() and                      
                    not IsUnitEnemy("mouseover") and        
                    AuraIsValid(mouseover, "UseDispel", "Dispel")
                ) or 
                (
                    (
                        not A.GetToggle(2, "mouseover") or 
                        not Unit("mouseover"):IsExists() or 
                        IsUnitEnemy("mouseover")
                    ) and        
                    not IsUnitEnemy("target") and A.GetToggle(2, "DispelSniper") and
                    AuraIsValid(target, "UseDispel", "Dispel")
                )
            )
            then
                return A.Cleanse:Show(icon)
            end        
            
            -- #2 HPvE BoF
            if A.BlessingofFreedom:IsReady(unitID) and (((A.Zone == "arena" or A.InstanceInfo.isRated)) or ((A.Zone ~= "arena" or not A.InstanceInfo.isRated) and Unit(unitID):GetCurrentSpeed() <= 70)) and Unit(unitID):HasBuffs(A.BlessingofFreedom.ID) == 0 and
            useUtils and
            (
                -- MouseOver
                (
                    Unit("mouseover"):IsExists() and 
                    MouseHasFrame() and                      
                    not IsUnitEnemy("mouseover") and        
                    AuraIsValid(mouseover, true, "BlessingofFreedom")
                ) or 
                (
                    (
                        not A.GetToggle(2, "mouseover") or 
                        not Unit("mouseover"):IsExists() or 
                        IsUnitEnemy("mouseover")
                    ) and        
                    not IsUnitEnemy("target") and A.GetToggle(2, "DispelSniper") and
                    AuraIsValid(target, true, "BlessingofFreedom")
                )
            )
            then
                return A.BlessingofFreedom:Show(icon)
            end        
			
			-- #3 HPvE BoP
            if A.BlessingofProtection:IsReady(unitID) and Unit(unitID):HasBuffs(A.BlessingofProtection.ID) == 0 and Unit(unitID):HasDeBuffs(A.Forbearance.ID) == 0 and not Unit(unitID):IsPet() and not Unit(unitID):IsTank() and
            useShields and not Unit(unitID):IsDead() and
            (
                -- MouseOver
                (
                    Unit("mouseover"):IsExists() and 
                    MouseHasFrame() and                      
                    not IsUnitEnemy("mouseover") and        
                    AuraIsValid(mouseover, true, "BlessingofProtection")
                ) or 
                (
                    (
                        not A.GetToggle(2, "mouseover") or 
                        not Unit("mouseover"):IsExists() or 
                        IsUnitEnemy("mouseover")
                    ) and        
                    not IsUnitEnemy("target") and A.GetToggle(2, "DispelSniper") and
                    AuraIsValid(target, true, "BlessingofProtection")
                )
            )
            then
                return A.BlessingofProtection:Show(icon)
            end     
            
        end
        
		if A.LightofMartyr:IsReady(unitID) and Unit(player):HasBuffsStacks(A.MaraadBuff.ID) > 2 and Unit(unitID):HealthPercent() < LightofMartyrHP and Player:HolyPower() >= 3 and HealingEngine.GetBelowHealthPercentUnits(LightofDawnHP, 15) >= LightofDawnUnits then
			return A.LightofMartyr:Show(icon)
		end		
		
        if A.LightofDawn:IsReady(unitID) and Unit(player):HasDeBuffs(A.Mindgames.ID) == 0 and not Unit(unitID):IsDead() and TeamCacheFriendlyType == "raid" and UseLightofDawn and HealingEngine.GetBelowHealthPercentUnits(LightofDawnHP, 15) >= LightofDawnUnits and HealingEngine.GetBelowHealthPercentUnits(ForceWoGHP, 40) == 0 then
            return A.LightofDawn:Show(icon)
        end
        
        --Word of Glory at 5 HP
        if A.WordofGlory:IsReady(unitID) and Unit(player):HasDeBuffs(A.Mindgames.ID) == 0 and Unit(unitID):HasDeBuffs(A.Cyclone.ID) == 0 and not Unit(unitID):IsDead() and Unit(unitID):HealthPercent() < WordofGloryHP and Player:HolyPower() >= 5 then
            return A.WordofGlory:Show(icon)
        end
        
        if A.HolyPrism:IsReady(unitID) and Unit(player):HasDeBuffs(A.Mindgames.ID) == 0 and Unit(unitID):HasDeBuffs(A.Cyclone.ID) == 0 and not Unit(unitID):IsDead() and Unit(unitID):HealthPercent() < HolyPrismHP then
            return A.HolyPrism:Show(icon)
        end       
        
        --Holy Shock target
        if A.HolyShock:IsReady(unitID) and IsUnitFriendly(unitID) and Unit(player):HasDeBuffs(A.Mindgames.ID) == 0 and Unit(unitID):HasDeBuffs(A.Cyclone.ID) == 0 and not Unit(unitID):IsDead() and Unit(unitID):HealthPercent() < HolyShockHP then
            return A.HolyShock:Show(icon)
        end
        
        --Word of Glory 3 HP
        if A.WordofGlory:IsReady(unitID) and Unit(player):HasDeBuffs(A.Mindgames.ID) == 0 and Unit(unitID):HasDeBuffs(A.Cyclone.ID) == 0 and not Unit(unitID):IsDead() and Unit(unitID):HealthPercent() < WordofGloryHP then
            return A.WordofGlory:Show(icon)
        end
        
		if A.Maraad:HasLegendaryCraftingPower() and Unit(player):HasBuffsStacks(A.MaraadBuff.ID) > 0 then
			for i = 1, #getmembersAll do 
				if Unit(getmembersAll[i].Unit):GetRange() <= 40 and not Unit(getmembersAll[i].Unit):IsDead() and (Unit(getmembersAll[i].Unit):HasBuffs(A.BeaconofLight.ID, true) > 0 or Unit(getmembersAll[i].Unit):HasBuffs(A.BeaconofFaith.ID, true) > 0) and Unit(getmembersAll[i].Unit):HealthPercent() < LightofMartyrHP then
					for x = 1, #getmembersAll do
						if Unit(getmembersAll[x].Unit):GetRange() <= 40 and A.LightofMartyr:IsReady(getmembersAll[x].Unit) and Unit(getmembersAll[x].Unit):HealthPercent() < LightofMartyrHP then
							HealingEngine.SetTarget(getmembersAll[x].Unit, 0.5)
							return A.LightofMartyr:Show(icon)
						end
					end
				end                
			end
		end
        
		if A.HammerofWrath:IsReady(targettarget) and Unit(targettarget):HasDeBuffs("BreakAble") == 0 and Unit(player):HasDeBuffs(A.Mindgames.ID) == 0 and (A.AshenHallow:GetSpellTimeSinceLastCast() <= 30 or Unit(player):HasBuffs(A.AvengingWrath.ID) > 0)
		and Unit(unitID):HasDeBuffs(A.Cyclone.ID) == 0 and not Unit(target):IsDead() then
			return A.HammerofWrath:Show(icon)
		end      
		
		if A.HammerofWrath:IsReady(focustarget) and Unit(focustarget):HasDeBuffs("BreakAble") == 0 and Unit(player):HasDeBuffs(A.Mindgames.ID) == 0 and (A.AshenHallow:GetSpellTimeSinceLastCast() <= 30 or Unit(player):HasBuffs(A.AvengingWrath.ID) > 0)
		and Unit(unitID):HasDeBuffs(A.Cyclone.ID) == 0 and not Unit(target):IsDead() then
			return A.HammerofWrath:Show(icon)
		end      
		
        if A.Consecration:IsReady(player) and A.HallowedGround:IsTalentLearned() and IsUnitFriendly(unitID) and Unit(unitID):GetRange() <= 5 and Unit(unitID):HasDeBuffs(IsSlowDebuff) >= 1 then
            return A.Consecration:Show(icon)
        end
        
        if A.ArcaneTorrent:IsReady(player) and not Unit(player):IsDead() and Player:HolyPower() == 2 and combatTime > 0 then
            return A.ArcaneTorrent:Show(icon)
        end
        
        if TeamCacheFriendlyType ~= "raid" and A.HolyShock:IsReady(unitID) and not Unit(unitID):IsDead() and Unit(unitID):HealthPercent() <= 90 and (HealingEngine.GetBelowHealthPercentUnits(90, 40) == 1 and Player:ManaPercentage() >= 50 and Player:HolyPower() < 5) and Unit(player):HasDeBuffs(A.Mindgames.ID) == 0 then
				return A.HolyShock:Show(icon)
		end
		
        if A.WordofGlory:IsReady(unitID) and not Unit(unitID):IsDead() and Unit(unitID):HealthPercent() <= 90 and combatTime == 0 then
            return A.WordofGlory:Show(icon)
        end
        
        --Rule of Law
        if A.RuleofLaw:IsReady(player) and not Unit(unitID):IsDead() and IsUnitFriendly(unitID) and combatTime > 0 and A.RuleofLaw:IsTalentLearned() and Unit(player):HasBuffs(A.RuleofLaw.ID, true) == 0 and inCombat and 
        ((Unit(unitID):CanInterract(40) and (A.RuleofLaw:GetSpellCharges() == 2 and (Unit(unitID):Health() <= Unit(unitID):HealthMax()*0.6 or HealingEngine.GetBelowHealthPercentUnits(LightofDawnHP, 15) >= LightofDawnUnits)) or (Unit(unitID):TimeToDie() <= 6 or Unit(unitID):Health() <= Unit(unitID):HealthMax()*0.35) or (not Unit(unitID):CanInterract(40)))) then
            return A.RuleofLaw:Show(icon)
        end
        
        --Bestow Faith
        if A.BestowFaith:IsReady(unitID) and Unit(player):HasDeBuffs(A.Mindgames.ID) == 0 and Unit(unitID):HasDeBuffs(A.Cyclone.ID) == 0 and not Unit(unitID):IsDead() and Unit(unitID):HealthPercent() < BestowFaithHP then
            return A.BestowFaith:Show(icon)
        end    
        
        if A.DivineFavor:IsTalentLearned() and Unit(player):HasDeBuffs(A.Mindgames.ID) == 0 and IsUnitFriendly("target") and Unit("target"):HasDeBuffs(A.Cyclone.ID) == 0 and Unit("target"):GetRange() <= 40 and Unit("target"):HealthPercent() < DFHolyLightHP and Unit("target"):TimeToDie() < 5 and A.DivineFavor:IsReady(player) then
            return A.DivineFavor:Show(icon)
        end
        
        if A.Zone == "pvp" or A.Zone == "arena" or A.InstanceInfo.isRated or inCombat then
            
            local useCC = Action.InterruptIsValid(unitID)
            if useCC and not CCImmune[NPCID1] and Unit(unitID):HasDeBuffs({"Silenced", "Stuned", "Sleep", "Fear", "Disoriented", "Incapacitated"}) == 0 and Unit(unitID):HasBuffs(A.Sanguine.ID) == 0 and A.HammerofJustice:IsReady(unitID) and Unit(unitID):GetDR("stun") > 0 and Unit(unitID):GetRange() <= 10 and A.HammerofJustice:AbsentImun(unitID, Temp.TotalAndPhysAndCC) and not Unit(unitID):IsBoss() and IsUnitEnemy(unitID) and not Unit(target):IsDead() and Unit(unitID):CanInterrupt(true, nil, 20, 85)
            then 
                return A.HammerofJustice:Show(icon)       
            end       
            
            if (A.Zone == "arena" or A.InstanceInfo.isRated) and A.HammerofJustice:IsReady("targettarget") and Unit("targettarget"):HasDeBuffs({"Silenced", "Stuned", "Sleep", "Fear", "Disoriented", "Incapacitated"}) == 0 and Unit("targettarget"):GetDR("stun") == 100 and A.HammerofJustice:AbsentImun("targettarget", Temp.TotalAndPhysAndCC) and IsUnitEnemy("targettarget") then
                return A.HammerofJustice:Show(icon)       
            end                     
            
            if useCC and not CCImmune[NPCID1] and Unit(unitID):HasDeBuffs({"Silenced", "Stuned", "Sleep", "Fear", "Disoriented", "Incapacitated"}) == 0 and A.BlindingLight:IsReady(unitID) and Unit(unitID):GetDR("disorient") > 0 and Unit(unitID):GetRange() <= 10 and A.BlindingLight:AbsentImun(unitID, Temp.TotalAndPhysAndCC) and not Unit(unitID):IsBoss() and IsUnitEnemy(unitID) and not Unit(target):IsDead() and Unit(unitID):CanInterrupt(true, nil, 20, 85)
            then 
                return A.BlindingLight:Show(icon)       
            end            
            
            if Unit(unitID):HasDeBuffs("BreakAble") == 0 and Unit(player):HasDeBuffs(A.Mindgames.ID) == 0 then
                
                if Player:ManaPercentage() > GetToggle(2, "ManaConservation") and A.CrusaderStrike:IsReady(targettarget) and A.CrusaderStrike:IsInRange(targettarget) and IsUnitEnemy(targettarget) and Unit(targettarget):HasDeBuffs(A.Cyclone.ID) == 0 
                and not Unit(target):IsDead() and (A.CrusadersMight:IsTalentLearned() and ((Player:HolyPower() < 5 and A.HolyShock:GetCooldown() >= 1.0)) or (not A.CrusadersMight:IsTalentLearned() and Player:HolyPower() < 5 and Player:ManaPercentage() > GetToggle(2, "ManaConservation"))) then
                    return A.CrusaderStrike:Show(icon)        
                end
				
                if Player:ManaPercentage() > GetToggle(2, "ManaConservation") and A.CrusaderStrike:IsReady(focustarget) and A.CrusaderStrike:IsInRange(focustarget) and IsUnitEnemy(focustarget) and Unit(focustarget):HasDeBuffs(A.Cyclone.ID) == 0 
                and not Unit(target):IsDead() and (A.CrusadersMight:IsTalentLearned() and ((Player:HolyPower() < 5 and A.HolyShock:GetCooldown() >= 1.0)) or (not A.CrusadersMight:IsTalentLearned() and Player:HolyPower() < 5 and Player:ManaPercentage() > GetToggle(2, "ManaConservation"))) then
                    return A.CrusaderStrike:Show(icon)        
                end
                
                if A.HammerofWrath:IsReady(targettarget) and (Unit(targettarget):HealthPercent() <= 20 or Unit(player):HasBuffs(A.AvengingWrath.ID, true) > 0) 
                and IsUnitEnemy(targettarget) and Unit(targettarget):HasDeBuffs(A.Cyclone.ID) == 0 and not Unit(target):IsDead() then
                    return A.HammerofWrath:Show(icon)
                end            
				
				if A.HammerofWrath:IsReady(focustarget) and (Unit(focustarget):HealthPercent() <= 20 or Unit(player):HasBuffs(A.AvengingWrath.ID, true) > 0) 
                and IsUnitEnemy(focustarget) and Unit(focustarget):HasDeBuffs(A.Cyclone.ID) == 0 and not Unit(target):IsDead() then
                    return A.HammerofWrath:Show(icon)
                end            
                
                if A.Judgment:IsReady(targettarget) and (Unit(targettarget):GetRange() <= 10 or A.Zone == "arena" or A.InstanceInfo.isRated or A.Zone == "pvp") and IsUnitEnemy(targettarget) and Unit(targettarget):HasDeBuffs(A.Cyclone.ID) == 0 and Unit(targettarget):HasDeBuffs(196941, true) == 0 
                and A.JudgmentofLight:IsTalentLearned() and not Unit(target):IsDead() then
                    return A.Judgment:Show(icon)
                end
				
				if A.Judgment:IsReady(focustarget) and (Unit(focustarget):GetRange() <= 10 or A.Zone == "arena" or A.InstanceInfo.isRated or A.Zone == "pvp") and IsUnitEnemy(focustarget) and Unit(focustarget):HasDeBuffs(A.Cyclone.ID) == 0 and Unit(focustarget):HasDeBuffs(196941, true) == 0 
                and A.JudgmentofLight:IsTalentLearned() and not Unit(target):IsDead() then
                    return A.Judgment:Show(icon)
                end
                
                -- Consecration
                if A.Consecration:IsReady(player) and not Unit(target):IsDead() and Unit(unitID):HasDeBuffs(204242, true) <= 1 and IsUnitEnemy(targettarget) and A.CrusaderStrike:IsInRange(targettarget) then
                    return A.Consecration:Show(icon)
                end        
                
            end
            
        end
        
        if A.Zone == "arena" or A.InstanceInfo.isRated or A.Zone == "pvp" or inCombat then
            
            if A.Awakening:IsTalentLearned() and A.LightofDawn:IsReady(unitID) and A.GetToggle(2, "LightofDawnDump") and Player:HolyPower() == A.GetToggle(2, "DumpHP") and Unit(player):HasBuffs(A.AvengingWrath.ID) == 0 then
                return A.LightofDawn:Show(icon)
            end
            
            if (A.Awakening:IsTalentLearned() and A.GetToggle(2, "LightofDawnDump") and Unit(player):HasBuffs(A.AvengingWrath) > 0 or A.Awakening:IsTalentLearned() and not A.GetToggle(2, "LightofDawnDump") or not A.Awakening:IsTalentLearned()) and A.ShieldoftheRighteous:IsReady(player) and Player:HolyPower() >= A.GetToggle(2, "DumpHP") and A.CrusaderStrike:IsInRange(targettarget) and IsUnitEnemy(targettarget) and Unit(targettarget):HasDeBuffs(A.Cyclone.ID) == 0 
            and (HealingEngine.GetBelowHealthPercentUnits(80, 40) < 1 or (HealingEngine.GetBelowHealthPercentUnits(50, 40) < 1 and TeamCache.Friendly.Size <= 2)) then
                return A.ShieldoftheRighteous:Show(icon)
            end
            
        end
        
		if HealingEngine.GetBelowHealthPercentUnits(GetToggle(2, "HolyShockHP"), 40) == 0 and (not GetToggle(2, "DispelSniper") or GetToggle(2, "DispelSniper") and ((HealingEngine.GetDeBuffsCount(PVEDispelDebuffs) == 0 and HealingEngine.GetDeBuffsCount(PVPDispelDebuffs) == 0) or ((HealingEngine.GetDeBuffsCount(PVEDispelDebuffs) > 0 or HealingEngine.GetDeBuffsCount(PVPDispelDebuffs) > 0) 
		and not A.Cleanse:IsReady())) and ((HealingEngine.GetDeBuffsCount(PVEBOFDebuffs) == 0 and HealingEngine.GetDeBuffsCount(PVPBOFDebuffs) == 0) or ((HealingEngine.GetDeBuffsCount(PVEBOFDebuffs) > 0 or HealingEngine.GetDeBuffsCount(PVPBOFDebuffs) > 0) 
		and not A.BlessingofFreedom:IsReady()))) then
			if GetToggle(2, "AutoTarget") and Unit(player):CombatTime() > 0 and MultiUnits:GetByRangeInCombat(15) >= 1 and not Unit(target):IsExplosives() and not Unit(target):IsCondemnedDemon() and (not Unit(target):IsExists() or IsUnitFriendly(target) or Unit(target):IsEnemy()) then 
				if A.IsExplosivesExists() or A.IsCondemnedDemonsExists() then
					return A:Show(icon, ACTION_CONST_AUTOTARGET)			  				 
				end 
				
				if  (not Unit(target):IsExists() or IsUnitFriendly(target) or (A.Zone ~= "none" and not A.IsInPvP and not Unit(target):IsCracklingShard() and Unit(target):CombatTime() == 0 and Unit(target):IsEnemy() and Unit(target):HealthPercent() >= 100)) 	-- No existed or switch target in PvE if we accidentally selected out of combat unit  			
					and ((not A.IsInPvP and MultiUnits:GetByRangeInCombat(15) >= 1) or A.Zone == "pvp") 																																-- If rotation mode is PvE and in 40 yards any in combat enemy (exception target) or we're on (R)BG 
				then 
					return A:Show(icon, ACTION_CONST_AUTOTARGET)
				end 
			end 
        end    
        
    end    
    HealingRotation = Action.MakeFunctionCachedDynamic(HealingRotation)
    
    ---------------------
    --- FILLER ROTATION ---
    ---------------------
    local function FillerRotation(unitID) 
        
        local useDispel, useShields, useHoTs, useUtils = HealingEngine.GetOptionsByUnitID(unitID)
        local unitGUID = UnitGUID(unitID)    
        
        -- Light of the Martyr
        if Player:ManaPercentage() > GetToggle(2, "ManaConservation") and A.LightofMartyr:IsReady(unitID) and Unit(player):HasDeBuffs(A.Mindgames.ID) == 0 and Unit(unitID):HasDeBuffs(A.Cyclone.ID) == 0 and not Unit(unitID):IsDead() and (Unit(player):HealthPercent() >= 50 or Unit(player):HasBuffs(A.DivineShield.ID) > 0) and Unit(unitID):HealthPercent() < A.GetToggle(2, "LightofMartyrHP") and Unit(player):GetCurrentSpeed() ~= 0 and not UnitIsUnit(unitID, player) then
            return A.LightofMartyr:Show(icon)
        end    
        
        if Unit(player):HasDeBuffs(A.Quake.ID) == 0 then
            
            if not inCombat or inCombat and not A.HolyShock:IsReady() and not A.WordofGlory:IsReady() then 
                
                --Flash of Light Infusion proc
                if A.FlashofLight:IsReady(unitID) and Unit(player):HasDeBuffs(A.Mindgames.ID) < Player:Execute_Time(A.FlashofLight.ID) and not A.WordofGlory:IsReady(unitID) 
				and Player:Execute_Time(A.FlashofLight.ID) - A.HolyShock:GetCooldown() <= Player:Execute_Time(A.FlashofLight.ID)/2 and Unit(unitID):HealthPercent() <= A.GetToggle(2, "FlashofLightHP") 
				and Unit(player):HasBuffs(A.DivineFavor.ID, true) == 0 and not Unit(unitID):IsDead() and Unit(player):HasBuffs(A.InfusionofLightBuff.ID, true) > Player:Execute_Time(A.FlashofLight.ID) 
				and Unit(unitID):HealthPercent() < FlashofLightHP 
				and Unit(unitID):TimeToDie() > Player:Execute_Time(A.FlashofLight.ID) and Unit(unitID):TimeToDie() < 8 and Unit(player):GetCurrentSpeed() == 0 then
                    return A.FlashofLight:Show(icon)
                end
                
                --Holy Light Infusion proc
                if A.HolyLight:IsReady(unitID) and Unit(player):HasDeBuffs(A.Mindgames.ID) < Player:Execute_Time(A.HolyLight.ID) and not A.WordofGlory:IsReady(unitID) 
				and Player:Execute_Time(A.HolyLight.ID) - A.HolyShock:GetCooldown() <= Player:Execute_Time(A.HolyLight.ID)/2 and Unit(player):HasBuffs(A.DivineFavor.ID, true) == 0 and not Unit(unitID):IsDead() 
				and Unit(player):HasBuffs(A.InfusionofLightBuff.ID, true) > Player:Execute_Time(A.HolyLight.ID) and Unit(unitID):HealthPercent() < HolyLightHP 
				and Unit(player):GetCurrentSpeed() == 0 then
                    return A.HolyLight:Show(icon)
                end    
                
                --Flash of Light no infusion
                if Player:ManaPercentage() > GetToggle(2, "ManaConservation") and A.FlashofLight:IsReady(unitID) and Unit(player):HasDeBuffs(A.Mindgames.ID) < Player:Execute_Time(A.FlashofLight.ID) 
				and not A.WordofGlory:IsReady(unitID) and Player:Execute_Time(A.FlashofLight.ID) - A.HolyShock:GetCooldown() <= Player:Execute_Time(A.FlashofLight.ID)/2 
				and Unit(unitID):HealthPercent() <= A.GetToggle(2, "FlashofLightHP") and Unit(player):HasBuffs(A.DivineFavor.ID, true) == 0 and not Unit(unitID):IsDead() 
				and Unit(unitID):TimeToDie() > Player:Execute_Time(A.FlashofLight.ID) and Unit(unitID):TimeToDie() < 8 and Unit(player):GetCurrentSpeed() == 0 then
                    return A.FlashofLight:Show(icon)
                end
                
                --Holy Light no infusion
                if Player:ManaPercentage() > GetToggle(2, "ManaConservation") and A.HolyLight:IsReady(unitID) and Unit(player):HasDeBuffs(A.Mindgames.ID) < Player:Execute_Time(A.HolyLight.ID) and not A.WordofGlory:IsReady(unitID) 
				and Player:Execute_Time(A.HolyLight.ID) - A.HolyShock:GetCooldown() <= Player:Execute_Time(A.HolyLight.ID)/2 and Unit(player):HasBuffs(A.DivineFavor.ID, true) == 0 and not Unit(unitID):IsDead() 
				and Unit(unitID):HealthPercent() < HolyLightHP and Unit(player):GetCurrentSpeed() == 0 then
                    return A.HolyLight:Show(icon)
                end    
				
            end
            
        end
        
    end
    FillerRotation = Action.MakeFunctionCachedDynamic(FillerRotation)
    
    -- Defensive
    local SelfDefensive = SelfDefensives()
    if SelfDefensive then 
        return SelfDefensive:Show(icon)
    end 
    
    -- Cleanse Mouseover 
    if A.Cleanse:IsReady(mouseover) then 
        unitID = mouseover 
        
        if HealingRotation(unitID) then 
            return true 
        end 
    end  
    
    -- Heal Mouseover 
    if IsUnitFriendly(mouseover) and A.GetToggle(2, "HealMouseover") then 
        unitID = mouseover 
        
        if HealingRotation(unitID) then 
            return true 
        end 
    end      
    
    -- Heal Target 
    if IsUnitFriendly(target) then 
        unitID = target 
        
        if HealingRotation(unitID) then 
            return true 
        end 
    end  
    
    -- DPS Mouseover 
    if IsUnitEnemy(mouseover) then 
        unitID = mouseover    
        
        if DamageRotation(unitID) and A.GetToggle(2, "DPSMouseover") then 
            return true 
        end 
    end  
        
    -- Filler Mouseover 
    if IsUnitFriendly(mouseover) and A.GetToggle(2, "HealMouseover") then 
        unitID = mouseover 
        
        if FillerRotation(unitID) then 
            return true 
        end 
    end      
    
    -- Filler Target 
    if IsUnitFriendly(target) then 
        unitID = target 
        
        if FillerRotation(unitID) then 
            return true 
        end 
    end  
    
    -- DPS Target     
    if IsUnitEnemy(target) then 
        unitID = target
        
        if DamageRotation(unitID) then 
            return true 
        end 
    end         
end 

A[4] = nil
A[5] = nil 
A[6] = function(icon)    
    
    if IsUnitEnemy("mouseover") and Unit("mouseover"):IsExplosives() or IsUnitEnemy("mouseover") and Unit("mouseover"):IsTotem() then 
        return A:Show(icon, ACTION_CONST_LEFT)
    end
end 
A[7] = nil 
A[8] = nil 

