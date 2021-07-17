--######################################
--##### TRIP'S RETRIBUTION PALADIN #####
--######################################

local _G, setmetatable							= _G, setmetatable
local math_random = math.random
local A                         			    = _G.Action
local Covenant									= _G.LibStub("Covenant")
local TMW										= _G.TMW
local Listener                                  = Action.Listener
local Create                                    = Action.Create
local GetToggle                                 = Action.GetToggle
local SetToggle                                 = Action.SetToggle
local GetGCD                                    = Action.GetGCD
local GetCurrentGCD                             = Action.GetCurrentGCD
local GetPing                                   = Action.GetPing
local ShouldStop                                = Action.ShouldStop
local BurstIsON                                 = Action.BurstIsON
local CovenantIsON								= Action.CovenantIsON
local AuraIsValid                               = Action.AuraIsValid
local AuraIsValidByPhialofSerenity				= A.AuraIsValidByPhialofSerenity
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
local ActiveUnitPlates                          = MultiUnits:GetActiveUnitPlates()
local IsIndoors, UnitIsUnit                     = IsIndoors, UnitIsUnit
local pairs                                     = pairs

--For Toaster
local Toaster									= _G.Toaster
local GetSpellTexture 							= _G.TMW.GetSpellTexture

--- ============================ CONTENT ===========================
--- ======= APL LOCALS =======
-- luacheck: max_line_length 9999

Action[ACTION_CONST_PALADIN_RETRIBUTION] = {
    -- Racial
    ArcaneTorrent						= Create({ Type = "Spell", ID = 50613	}),
    BloodFury							= Create({ Type = "Spell", ID = 20572	}),
    Fireblood							= Create({ Type = "Spell", ID = 265221	}),
    AncestralCall						= Create({ Type = "Spell", ID = 274738	}),
    Berserking							= Create({ Type = "Spell", ID = 26297	}),
    ArcanePulse							= Create({ Type = "Spell", ID = 260364	}),
    QuakingPalm							= Create({ Type = "Spell", ID = 107079	}),
    Haymaker							= Create({ Type = "Spell", ID = 287712	}), 
    WarStomp							= Create({ Type = "Spell", ID = 20549	}),
    BullRush							= Create({ Type = "Spell", ID = 255654	}),  
    GiftofNaaru							= Create({ Type = "Spell", ID = 59544	}),
    Shadowmeld							= Create({ Type = "Spell", ID = 58984	}), -- usable in Action Core 
    Stoneform							= Create({ Type = "Spell", ID = 20594	}), 
    WilloftheForsaken					= Create({ Type = "Spell", ID = 7744	}), -- not usable in APL but user can Queue it   
    EscapeArtist						= Create({ Type = "Spell", ID = 20589	}), -- not usable in APL but user can Queue it
    EveryManforHimself					= Create({ Type = "Spell", ID = 59752	}), -- not usable in APL but user can Queue it
    LightsJudgment						= Create({ Type = "Spell", ID = 255647	}),	
    
    -- Spells
    -- Paladin General
    AvengingWrath						= Create({ Type = "Spell", ID = 31884	}),    
    BlessingofFreedom					= Create({ Type = "Spell", ID = 1044	}),
    BlessingofProtection				= Create({ Type = "Spell", ID = 1022	}),
    BlessingofSacrifice					= Create({ Type = "Spell", ID = 6940	}),
    ConcentrationAura					= Create({ Type = "Spell", ID = 317920	}),
    Consecration						= Create({ Type = "Spell", ID = 26573	}),
    CrusaderAura						= Create({ Type = "Spell", ID = 32223	}),
    CrusaderStrike						= Create({ Type = "Spell", ID = 35395	}),
    DevotionAura						= Create({ Type = "Spell", ID = 465		}),    
    DivineShield						= Create({ Type = "Spell", ID = 642		}),
    DivineSteed							= Create({ Type = "Spell", ID = 190784	}),
    FlashofLight						= Create({ Type = "Spell", ID = 19750	}),
    HammerofJustice						= Create({ Type = "Spell", ID = 853		}),
    HammerofJusticeGreen				= Create({ Type = "SpellSingleColor", ID = 853, Color = "GREEN", Desc = "[1] CC", Hidden = true, Hidden = true, QueueForbidden = true }),    
    HammerofWrath						= Create({ Type = "Spell", ID = 24275	}),
    HandofReckoning						= Create({ Type = "Spell", ID = 62124	}),    
    Judgment							= Create({ Type = "Spell", ID = 20271	}),
    JudgmentDebuff						= Create({ Type = "Spell", ID = 197277, Hidden = true	}),	
    LayOnHands							= Create({ Type = "Spell", ID = 633		}),    
    Redemption							= Create({ Type = "Spell", ID = 7328	}),
    RetributionAura						= Create({ Type = "Spell", ID = 183435	}),
    ShieldoftheRighteous				= Create({ Type = "Spell", ID = 53600	}),
    TurnEvil							= Create({ Type = "Spell", ID = 10326	}),
    WordofGlory							= Create({ Type = "Spell", ID = 85673	}),  
    Forbearance							= Create({ Type = "Spell", ID = 25771	}),
    
    -- Retribution Specific
    BladeofJustice						= Create({ Type = "Spell", ID = 184575	}),
    CleanseToxins						= Create({ Type = "Spell", ID = 213644	}),	
    DivineStorm							= Create({ Type = "Spell", ID = 53385	}),	
    HandofHindrance						= Create({ Type = "Spell", ID = 183218	}),	
    Rebuke								= Create({ Type = "Spell", ID = 96231	}),	
	RebukeGreen 						= Create({ Type = "SpellSingleColor",ID = 96231,Hidden = true,Color = "GREEN",QueueForbidden = true}),
    ShieldofVengeance					= Create({ Type = "Spell", ID = 184662	}),	
    TemplarsVerdict						= Create({ Type = "Spell", ID = 85256	}),
    WakeofAshes							= Create({ Type = "Spell", ID = 255937	}),	
    
    -- Normal Talents
    Zeal		                        = Create({ Type = "Spell", ID = 269569, Hidden = true	}),
    RighteousVerdict					= Create({ Type = "Spell", ID = 267610, Hidden = true	}),	
    ExecutionSentence					= Create({ Type = "Spell", ID = 343527	}),
    FiresofJustice						= Create({ Type = "Spell", ID = 203316, Hidden = true	}),
    BladeofWrath						= Create({ Type = "Spell", ID = 231832, Hidden = true 	}),
    EmpyreanPower						= Create({ Type = "Spell", ID = 326732, Hidden = true	}),
    EmpyreanPowerBuff					= Create({ Type = "Spell", ID = 326733, Hidden = true	}),	
    FistofJustice						= Create({ Type = "Spell", ID = 234299, Hidden = true	}),
    Repentance							= Create({ Type = "Spell", ID = 20066	}),
    BlindingLight						= Create({ Type = "Spell", ID = 115750	}),
    UnbreakableSpirit					= Create({ Type = "Spell", ID = 114154, Hidden = true	}),	
    Cavalier							= Create({ Type = "Spell", ID = 230332, Hidden = true	}),
    EyeforanEye							= Create({ Type = "Spell", ID = 205191	}),	
    DivinePurpose						= Create({ Type = "Spell", ID = 223817, Hidden = true	}),	
    HolyAvenger							= Create({ Type = "Spell", ID = 105809	}),		
    Seraphim							= Create({ Type = "Spell", ID = 152262	}),		
    SelflessHealer						= Create({ Type = "Spell", ID = 85804, Hidden = true	}),	
    JusticarsVengeance					= Create({ Type = "Spell", ID = 215661	}),	
    HealingHands						= Create({ Type = "Spell", ID = 326734, Hidden = true	}),	
    SanctifiedWrath						= Create({ Type = "Spell", ID = 317866, Hidden = true	}),
    Crusade								= Create({ Type = "Spell", ID = 231895	}),	
    FinalReckoning						= Create({ Type = "Spell", ID = 343721	}),	
    FinalReckoningDebuff				= Create({ Type = "Spell", ID = 343724, Hidden = true	}),	
    
    -- PvP Talents
    Luminescence						= Create({ Type = "Spell", ID = 199428, Hidden = true	}),
    UnboundFreedom						= Create({ Type = "Spell", ID = 305394, Hidden = true	}),
    VengeanceAura						= Create({ Type = "Spell", ID = 210323, Hidden = true	}),
    BlessingofSanctuary					= Create({ Type = "Spell", ID = 210256	}),	
    UltimateRetribution					= Create({ Type = "Spell", ID = 287947, Hidden = true	}),
    Lawbringer							= Create({ Type = "Spell", ID = 246806, Hidden = true	}),	
    DivinePunisher						= Create({ Type = "Spell", ID = 204914, Hidden = true	}),
    AuraofReckoning						= Create({ Type = "Spell", ID = 247675, Hidden = true	}),
    Jurisdiction						= Create({ Type = "Spell", ID = 204979, Hidden = true	}),
    LawandOrder							= Create({ Type = "Spell", ID = 204934, Hidden = true	}),	
    CleansingLight						= Create({ Type = "Spell", ID = 236186	}),	
    
    -- Covenant Abilities
    DivineToll						= Create({ Type = "Spell", ID = 304971    }),    
    SummonSteward					= Create({ Type = "Spell", ID = 324739    }),
    AshenHallow						= Create({ Type = "Spell", ID = 316958    }),    
    DoorofShadows					= Create({ Type = "Spell", ID = 300728    }),
    VanquishersHammer				= Create({ Type = "Spell", ID = 328204    }),    
    Fleshcraft						= Create({ Type = "Spell", ID = 331180    }),
    BlessingoftheSeasons            = Create({ Type = "Spell", ID = 328278    }),
    BlessingofSummer                = Create({ Type = "Spell", ID = 328620    }),    
    BlessingofAutumn                = Create({ Type = "Spell", ID = 328622    }),    
    BlessingofSpring                = Create({ Type = "Spell", ID = 328282    }),    
    BlessingofWinter                = Create({ Type = "Spell", ID = 328281    }),        
    Soulshape						= Create({ Type = "Spell", ID = 310143    }),
    Flicker							= Create({ Type = "Spell", ID = 324701    }),
    
    -- Conduits
    
    
    -- Legendaries
    -- General Legendaries
    
    -- Retribution Legendaries
    
    
    --Anima Powers - to add later...
    
    
    -- Trinkets
    
    
    -- Potions
    PotionofUnbridledFury				= Create({ Type = "Potion", ID = 169299, QueueForbidden = true 	}),     
    SuperiorPotionofUnbridledFury		= Create({ Type = "Potion", ID = 168489, QueueForbidden = true 	}),
    PotionofSpectralStrength			= Create({ Type = "Potion", ID = 171275, QueueForbidden = true 	}),
    PotionofSpectralStamina				= Create({ Type = "Potion", ID = 171274, QueueForbidden = true	}),
    PotionofEmpoweredExorcisms			= Create({ Type = "Potion", ID = 171352, QueueForbidden = true 	}),
    PotionofHardenedShadows				= Create({ Type = "Potion", ID = 171271, QueueForbidden = true 	}),
    PotionofPhantomFire					= Create({ Type = "Potion", ID = 171349, QueueForbidden = true 	}),
    PotionofDeathlyFixation				= Create({ Type = "Potion", ID = 171351, QueueForbidden = true 	}),
    SpiritualHealingPotion				= Create({ Type = "Item", ID = 171267, QueueForbidden = true 	}),
    PhialofSerenity						= Create({ Type = "Item", ID = 177278	}),
    
    -- Misc
    Channeling							= Create({ Type = "Spell", ID = 209274, Hidden = true	}),    -- Show an icon during channeling
    TargetEnemy							= Create({ Type = "Spell", ID = 44603, Hidden = true	}),    -- Change Target (Tab button)
    StopCast							= Create({ Type = "Spell", ID = 61721, Hidden = true	}),        -- spell_magic_polymorphrabbit
    PoolResource						= Create({ Type = "Spell", ID = 209274, Hidden = true	}),
    Quake								= Create({ Type = "Spell", ID = 240447, Hidden = true	}), -- Quake (Mythic Plus Affix)
    Cyclone								= Create({ Type = "Spell", ID = 33786, Hidden = true	}), -- Cyclone 

	-- Ally Checks
    TouchofKarma						= Create({ Type = "Spell", ID = 125174, Hidden = true	}),	
    DieByTheSword						= Create({ Type = "Spell", ID = 118038, Hidden = true	}),	
	
    TouchOfDeathDebuff					= Create({ Type = "Spell", ID = 115080, Hidden = true	}),
    KarmaDebuff							= Create({ Type = "Spell", ID = 122470, Hidden = true	}),
    VendettaDebuff						= Create({ Type = "Spell", ID = 79140, Hidden = true	}),
    SolarBeamDebuff						= Create({ Type = "Spell", ID = 78675, Hidden = true	}),
    IntimidatingShoutDebuff				= Create({ Type = "Spell", ID = 5246, Hidden = true		}),
    SmokeBombDebuff						= Create({ Type = "Spell", ID = 76577, Hidden = true	}),
    BlindDebuff							= Create({ Type = "Spell", ID = 2094, Hidden = true		}),
    GarroteDebuff						= Create({ Type = "Spell", ID = 1330, Hidden = true		}),	
    Taunt								= Create({ Type = "Spell", ID = 62124, Desc = "[6] PvP Pets Taunt", QueueForbidden = true	}),	
    
}

local A = setmetatable(Action[ACTION_CONST_PALADIN_RETRIBUTION], { __index = Action })

local function num(val)
    if val then return 1 else return 0 end
end

local function bool(val)
    return val ~= 0
end

local Temp = {
    TotalAndPhys                            = {"TotalImun", "DamagePhysImun"},
    TotalAndCC                              = {"TotalImun", "CCTotalImun"},
    TotalAndPhysKick                        = {"TotalImun", "DamagePhysImun", "KickImun"},
    TotalAndPhysAndCC                       = {"TotalImun", "DamagePhysImun", "CCTotalImun"},
    TotalAndPhysAndStun                     = {"TotalImun", "DamagePhysImun", "StunImun"},
    TotalAndPhysAndCCAndStun                = {"TotalImun", "DamagePhysImun", "CCTotalImun", "StunImun"},
    TotalAndMag                             = {"TotalImun", "DamageMagicImun"},
    TotalAndMagKick                         = {"TotalImun", "DamageMagicImun", "KickImun"},
    DisablePhys                             = {"TotalImun", "DamagePhysImun", "Freedom", "CCTotalImun"},
    DisableMag                              = {"TotalImun", "DamageMagicImun", "Freedom", "CCTotalImun"},
    BoPDebuffsPvP                            = {A.TouchOfDeathDebuff.ID, A.KarmaDebuff.ID},
    -- Hex, Polly, Repentance, Blind, Wyvern Sting, Ring of Frost, Paralysis, Freezing Trap, Mind Control
    BoSDebuffsPvP                            = {51514, 118, 20066, 2094, 19386, 82691, 115078, 3355, 605}
}

local IsIndoors, UnitIsUnit = IsIndoors, UnitIsUnit
local player = "player"
local target = "target"
local mouseover = "mouseover"
local focus = "focus"

local function IsHolySchoolFree()
    return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "HOLY") == 0
end 

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

-- [1] CC AntiFake Rotation
local function AntiFakeStun(unit) 
    return 
    IsUnitEnemy(unit) and Unit(unit):GetDR("stun") > 0 and
    Unit(unit):GetRange() <= 10 and Unit(unit):HasBuffs(A.Sanguine.ID) == 0 and Unit(unit):HasDeBuffs({"Silenced", "Stuned", "Sleep", "Fear", "Disoriented", "Incapacitated"}) == 0 and
    A.HammerofJusticeGreen:AbsentImun(unit, Temp.TotalAndPhysAndCCAndStun, true)          
end 

-- [2] Kick AntiFake Rotation
A[2] = function(icon)        
    local unitID
    if IsUnitEnemy("mouseover") then 
        unitID = "mouseover"
    elseif IsUnitEnemy("target") then 
        unitID = "target"
    end 
    
    if unitID then 
        local castLeft, _, _, _, notKickAble = Unit(unitID):IsCastingRemains()
        if castLeft > 0 then 
            if not notKickAble and A.Rebuke:IsReady(unitID, nil, nil, true) and A.Rebuke:AbsentImun(unitID, Temp.TotalAndPhysKick, true) then
                return A.RebukeGreen:Show(icon) 
            end 
        end 
    end 
end

local function SelfDefensives()
    if Unit(player):CombatTime() == 0 then 
        return 
    end 
    
    local unitID
    if A.IsUnitEnemy("mouseover") then 
        unitID = "mouseover"
    elseif A.IsUnitEnemy("target") then 
        unitID = "target"
    end  
    
    -- DivineShield
    if A.DivineShield:IsReady(player) and Unit(player):HasDeBuffs(A.Forbearance.ID, true) == 0 and Unit(player):HealthPercent() < 20 and Unit(player):TimeToDieX(20) < 3
    then 
        return A.DivineShield
    end
    
    -- BlessingofProtection
    if A.BlessingofProtection:IsReady(player) and not A.DivineShield:IsReady(player) and Unit(player):HealthPercent() < 30 and (Unit(player):HasBuffs("TotalImun") == 0 or Unit(player):HasBuffs("DamagePhysImun") == 0 and Unit(player):TimeToDieX(20) - Unit(player):TimeToDieMagicX(20) < -1)
	and Unit(player):HasDeBuffs(A.Forbearance.ID, true) == 0 and UnitIsUnit("target", player)
    then 
        return A.BlessingofProtection
    end
    
	-- Stoneform on self dispel (only PvE)
    if A.Stoneform:IsRacialReady("player", true) and not A.IsInPvP and A.AuraIsValid("player", "UseDispel", "Dispel") then 
        return A.Stoneform
    end 
    
end
SelfDefensives = A.MakeFunctionCachedStatic(SelfDefensives)

-- Non GCD spell check
local function countInterruptGCD(unitID)
    if not A.Rebuke:IsReadyByPassCastGCD(unitID) or not A.Rebuke:AbsentImun(unitID, Temp.TotalAndMagKick) then
        return true
    end
end

-- Interrupts spells
local function Interrupts(unitID)
    local unitID
    if A.IsUnitEnemy("mouseover") then 
        unitID = "mouseover"
    elseif A.IsUnitEnemy("target") then 
        unitID = "target"
    end  

    useKick, useCC, useRacial, notInterruptable, castRemainsTime, castDoneTime = Action.InterruptIsValid(unitID, nil, nil, countInterruptGCD(unitID))
    
    if castRemainsTime >= A.GetLatency() then
        if useKick and A.Rebuke:IsReady(unitID) and not notInterruptable and A.Rebuke:AbsentImun(unitID, Temp.TotalAndMagKick, true) then 
            return A.Rebuke
        end 
        
        if useCC and A.HammerofJustice:IsReady(unitID) and A.HammerofJustice:AbsentImun(unitID, Temp.TotalAndCC, true) and Unit(unitID):IsControlAble("stun", 0) then 
            return A.HammerofJustice              
        end    
       
    end
end
Interrupts = A.MakeFunctionCachedDynamic(Interrupts)

A[3] = function(icon, isMulti)

    local isMoving = A.Player:IsMoving()
    local isMovingFor = A.Player:IsMovingTime()
    local inCombat = Unit("player"):CombatTime() > 0
    local combatTime = Unit("player"):CombatTime()
	local HolyPower = Player:HolyPower()
		
	local UseRacial = A.GetToggle(1, "Racial")
	local UseCovenant = A.GetToggle(1, "Covenant")
    local WordofGloryHP = A.GetToggle(2, "WoGHP")
    local BlessingofProtectionHP = A.GetToggle(2, "BlessingofProtectionHP")	
	
	local function EnemyRotation(unitID)
	
		if not IsUnitEnemy(unitID) then return end
		if Unit(unitID):HasDeBuffs("BreakAble") > 0 and Unit(player):CombatTime() == 0 then return end        
        if UnitCanAttack(player, unitID) == false then return end
		
		if A.Crusade:IsTalentLearned() and A.Crusade:IsReady() and Player:HolyPower() >= 3 and BurstIsON(unitID) then
			return A.Crusade:Show(icon)
		end
		
		if A.Seraphim:IsTalentLearned() and A.Seraphim:IsReady(player) and Unit(player):HasBuffs(A.Seraphim.ID) == 0 then
			return A.Seraphim:Show(icon)
		end
		
		if A.AvengingWrath:IsReady(player) and BurstIsON(unitID) and Unit(player):HasBuffs(A.AvengingWrath.ID) == 0 and Player:HolyPower() >= 3 then
			return A.AvengingWrath:Show(icon)
		end
		
		if A.FinalReckoning:IsTalentLearned() and BurstIsON(unitID) and GetToggle(2, "AoE") and A.FinalReckoning:IsReady() and Player:HolyPower() == 5 and MultiUnits:GetByRangeInCombat(8) >= GetToggle(2, "AOEUnits") then
			return A.FinalReckoning:Show(icon)
		end
		
		if A.ExecutionSentence:IsTalentLearned() and A.ExecutionSentence:IsReady(unitID) and BurstIsON(unitID) and Unit(unitID):TimeToDie() >= 8 then
			return A.ExecutionSentence:Show(icon)
		end
		
		if A.Consecration:IsReady(player) and GetToggle(2, "AoE") and MultiUnits:GetByRange(8) >= 2 and Unit(unitID):HasDeBuffs(204242, true) <= 1 and A.CrusaderStrike:IsInRange(unitID) then
			return A.Consecration:Show(icon)
		end     
		
		if A.WordofGlory:IsReady(player) and Unit(player):HealthPercent() <= WordofGloryHP then
			return A.WordofGlory:Show(icon)
		end
		
		if A.TemplarsVerdict:IsReady(unitID) and Player:HolyPower() == 5 and MultiUnits:GetByRange(8) == 1 then
			return A.TemplarsVerdict:Show(icon)
		end	
			
		if A.DivineStorm:IsReady(unitID) and GetToggle(2, "AoE") and Player:HolyPower() == 5 and MultiUnits:GetByRange(8) >= 2 then
			return A.DivineStorm:Show(icon)
		end
		
		if A.DivineToll:IsReady(unitID) and Player:HolyPower() <= 1 and GetToggle(2, "AoE") and Unit(unitID):HasDeBuffs(197277, true) == 0 and MultiUnits:GetByRangeInCombat(30) >= GetToggle(2, "AOEUnits") then
			return A.DivineToll:Show(icon)
		end
		
		if A.WakeofAshes:IsReady(unitID) and GetToggle(2, "AoE") and MultiUnits:GetByRange(8) >= GetToggle(2, "AOEUnits") then
			return A.WakeofAshes:Show(icon)
		end
		
		if A.HammerofWrath:IsReady(unitID) then
			return A.HammerofWrath:Show(icon)
		end	
			
		if A.BladeofJustice:IsReady(unitID) then
			return A.BladeofJustice:Show(icon)
		end	
			
		if A.Judgment:IsReady(unitID) then
			return A.Judgment:Show(icon)
		end

		if A.DivineStorm:IsReady(unitID) and GetToggle(2, "AoE") and Unit(player):HasBuffs(326733) > 0 and Player:HolyPower() >= 3 and MultiUnits:GetByRange(8) >= 2 and Unit(unitID):HasDeBuffs(197277, true) == 0 then
			return A.DivineStorm:Show(icon)
		end
		
		if A.CrusaderStrike:IsReady(unitID) and A.CrusaderStrike:GetSpellCharges() == 2 then
			return A.CrusaderStrike:Show(icon)
		end	
			
		if A.DivineStorm:IsReady(unitID) and GetToggle(2, "AoE") and Player:HolyPower() >= 3 and Player:HolyPower() < 5 and MultiUnits:GetByRange(8) >= 2 then
			return A.DivineStorm:Show(icon)
		end
		
		if A.TemplarsVerdict:IsReady(unitID) and Player:HolyPower() >= 3 and MultiUnits:GetByRange(8) == 1 then
			return A.TemplarsVerdict:Show(icon)
		end	
			
		if A.Consecration:IsReady(player) and GetToggle(2, "AoE") and Unit(unitID):HasDeBuffs(204242, true) <= 1 and A.CrusaderStrike:IsInRange(unitID) then
			return A.Consecration:Show(icon)
		end        
		
		if A.CrusaderStrike:IsReady(unitID) then
			return A.CrusaderStrike:Show(icon)
		end
		
	end

    local function FriendlyRotation(unitID)

        local _,_,_,_,_,NPCID1 = Unit("targettarget"):InfoGUID()

		if not inCombat and Unit(unitID):IsDead() then
			return A.Redemption:Show(icon)
		end

		if A.FlashofLight:IsReady(unitID) and Unit(player):HasBuffsStacks(A.SelflessHealer.ID, true) >= 4 and Unit(unitID):HealthPercent() <= WordofGloryHP then
			return A.FlashofLight:Show(icon)
		end
	
		if A.WordofGlory:IsReady(unitID) and Unit(unitID):HealthPercent() <= WordofGloryHP then
			return A.WordofGlory:Show(icon)
		end
		
		if A.BlessingofProtection:IsReady(unitID) and Unit(unitID):HasDeBuffs(A.Forbearance.ID, true) == 0 and not MagicNPCID[NPCID1] and Unit("targettarget"):HealthPercent() <= 30 and Unit(unitID):TimeToDieX(20) <= 4 then
			return A.BlessingofProtection:Show(icon)
		end

	
	end


    -- Defensive
    local SelfDefensive = SelfDefensives()
    if SelfDefensive then 
        return SelfDefensive:Show(icon)
    end 

	-- Mouseover friendly
	if A.IsUnitFriendly("mouseover") then
		unitID = "mouseover"
		if FriendlyRotation(unitID) then
			return true
		end
	end
	
	if A.IsUnitFriendly("target") then
		unitID = "target"
		if FriendlyRotation(unitID) then
			return true
		end
	end	

    -- Target  
    if A.IsUnitEnemy("target") then 
        unitID = "target"
        if EnemyRotation(unitID) then 
            return true
        end 
    end

end	

A[4] = nil
A[5] = nil

local function FreezingTrapUsedByEnemy()
	if UnitCooldown:GetCooldown("arena", ACTION_CONST_SPELLID_FREEZING_TRAP) > UnitCooldown:GetMaxDuration("arena", ACTION_CONST_SPELLID_FREEZING_TRAP) - 2 and
	UnitCooldown:IsSpellInFly("arena", ACTION_CONST_SPELLID_FREEZING_TRAP) and Unit(player):GetDR("incapacitate") > 0 then
		local Caster = UnitCooldown:GetUnitID("arena", ACTION_CONST_SPELLID_FREEZING_TRAP)
		if Caster and Unit(Caster):GetRange() <= 40 then
			return true
		end
		end
	end

local function ArenaRotation(icon, unitID)
	if A.IsInPvP and (A.Zone == "pvp" or A.Zone == "arena") and not Player:IsStealthed() and not Player:IsMounted() then

		if unitID == "arena1" and (Unit(player):GetDMG() == 0 or not Unit(player):IsFocused("DAMAGER")) then

		if A.Taunt:IsReady() and EnemyTeam():IsTauntPetAble(A.Taunt.ID) then

			if FreezingTrapUsedByEnemy() then
				return A.Taunt:Show(icon)
			end


			if EnemyTeam():IsCastingBreakAble(0.25) then
				return A.Taunt:Show(icon)
			end

			if Unit(player):CombatTime() <= 5 and (Unit(player):CombatTime() > 0 or Unit("target"):CombatTime() > 0 or MultiUnits:GetByRangeInCombat(40, 1) >= 1) then
				return A.Taunt:Show(icon)
			end

			if LoC:Get("ROOT") > 0 then
				return A.Taunt:Show(icon)
			end
		end
		end

		if A.Rebuke:CanInterruptPassive(unitID) then
			return A.Rebuke:Show(icon)
		end
	local EnemyHealer = EnemyTeam("HEALER"):GetUnitID(60)
	local FriendlyHealer = FriendlyTeam("HEALER"):GetUnitID(60)
		if A.HammerofJustice:IsReadyByPassCastGCD(unitID) and not Unit(unitID):InLOS() and Unit(unitID):IsControlAble("stun", 99) and Unit(unitID):InCC() <= GetGCD() * 2 and
			((Unit(target):HasDeBuffs("Stuned") > 3 and Unit(unitID):IsHealer()) or (EnemyHealer ~= "none" and Unit(EnemyHealer):HasDeBuffs("Stuned") > 3 and Unit(target):HasDeBuffs("Stuned") > 3) or
			(Unit(FriendlyHealer):HasDeBuffs(31661) > 0 and Unit(unitID):Class() == "MAGE")) and A.HammerofJustice:AbsentImun(unitID, Temp.TotalAndPhysAndCCAndStun, true) then
				return A.HammerofJustice:Show(icon)
		end

		if unitID == "arena1" and GetToggle(1, "AutoTarget") and IsUnitEnemy(target) and not A.AbsentImun(nil, target, Temp.TotalAndPhys) and MultiUnits:GetByRangeInCombat(12, 2) >= 2 then
			return A:Show(icon, ACTION_CONST_AUTOTARGET)
		end
	end
	end

local function PartyRotation(icon, unitID)
	local IsHolySchoolFree = IsHolySchoolFree()
	local delaySanctuary = math_random(15, 25) / 100


	if not IsHolySchoolFree or Player:IsStealthed() or Player:IsMounted() then
		return
	end


	if A.CleanseToxins:IsReadyByPassCastGCD(unitID) and AuraIsValid(unitID, "UseDispel", "Dispel") and not Unit(unitID):InLOS() and A.CleanseToxins:AbsentImun(unitID) then
		return A.CleanseToxins:Show(icon)
	end

	if A.BlessingofProtection:IsReadyByPassCastGCD(unitID) and not Unit(unitID):InLOS() and (A.IsInPvP and ((Unit(unitID):HealthPercent() < 30 and Unit(unitID):GetRealTimeDMG(3) > 0 and (
		FriendlyTeam("HEALER"):GetCC() >= 3 or Unit(unitID):TimeToDieX(10) < 3) and Unit(unitID):HasBuffs("DeffBuffs") == 0) or (Unit(unitID):Role("HEALER") and (Unit(unitID):HasDeBuffs(A.BlindDebuff.ID) >= 3.5 or
		((Unit(unitID):HasDeBuffs("Stuned") >= 4 or Unit(unitID):HasDeBuffs(A.GarroteDebuff) >= 2.5) and (A.BlessingofSanctuary:GetCooldown() > 0 or not A.BlessingofSanctuary:IsSpellLearned()))) and
		Unit(unitID):HasBuffs("DeffBuffs") <= GetGCD() + GetCurrentGCD() + GetLatency() and Unit(unitID):IsFocused("MELEE", true)) or (Unit(unitID):HasBuffs("DamageBuffs") > 4 and Unit(unitID):Role("DAMAGER") and
		(Unit(unitID):Role("MELEE") and Unit(unitID):HasDeBuffs("Disarmed") > 4.5) or (Unit(unitID):HasDeBuffs(A.BlindDebuff.ID) >= 3.5 or Unit(unitID):HasDeBuffs(A.IntimidatingShoutDebuff.ID) >= 3.2 and 
		(A.BlessingofSanctuary:GetCooldown() > 0 or not A.BlessingofSanctuary:IsSpellLearned()))) or (Unit(unitID):HasDeBuffs(Temp.BoPDebuffsPvP) > 4 or Unit(unitID):HasDeBuffs(A.VendettaDebuff.ID) > 15))) then
			return A.BlessingofProtection:Show(icon)
	end

	if A.BlessingofSacrifice:IsReadyByPassCastGCD(unitID) and not Unit(unitID):InLOS() and Unit(player):HealthPercent() > Unit(unitID):HealthPercent() * 1.5 and Unit(unitID):HasBuffs(A.BlessingofProtection.ID) == 0 
		and Unit(unitID):GetRealTimeDMG() > 0 and (Unit(unitID):HealthPercent() < 10 or Unit(unitID):TimeToDie() < 10 and (Unit(unitID):HealthPercent() < 30 and (Unit(unitID):GetDMG() * 100 / Unit(unitID):HealthMax() >= 35 
		or Unit(player):GetRealTimeDMG() >= Unit(player):HealthMax() * 0.20))) and Unit(unitID):HasBuffs("DeffBuffs") == 0 and A.BlessingofSacrifice:AbsentImun(unitID) then
			return A.BlessingofSacrifice:Show(icon)
	end

	if A.BlessingofSanctuary:IsReadyByPassCastGCD(unitID) and not Unit(unitID):InLOS() and A.BlessingofSanctuary:IsSuspended(delaySanctuary, 3) and
		((Unit(unitID):HasDeBuffs("Stuned") > 3 or Unit(unitID):HasDeBuffs("Fear") > 3 and Unit(unitID):Class() ~= "WARRIOR" or (Unit(unitID):HasDeBuffs("Silenced") > 3 or Unit(unitID):HasDeBuffs(A.SolarBeamDebuff.ID) > 0)) or
		(Unit(unitID):HasDeBuffs(Temp.BoPDebuffsPvP) > 3 or A.BlessingofProtection:GetCooldown() > 0 or Unit(unitID):HasDeBuffs(A.Forbearance.ID) > 1 and ((Unit(unitID):HasDeBuffs(A.IntimidatingShoutDebuff.ID) > 3 and 
		not Unit(unitID):IsFocused()) or Unit(unitID):HasDeBuffs("PhysStuned") > 3 and (Unit(unitID):HasBuffs("DamageBuffs") > 3 or (Unit(unitID):HasDeBuffs(A.SmokeBombDebuff.ID) > 0 and Unit(unitID):IsFocused("MELEE", true)))) 
		and Unit(unitID):HasDeBuffs(Temp.BoSDebuffsPvP) >= 2)) and A.BlessingofSanctuary:AbsentImun(unitID) then
			return A.BlessingofSanctuary:Show(icon)
	end

	if A.BlessingofFreedom:IsReadyByPassCastGCD(unitID) and not Unit(player, 5):HasFlags() and not Unit(unitID):InLOS() and A.BlessingofFreedom:AbsentImun(unitID) then
		if Unit(unitID):HasDeBuffs("Rooted") > GetGCD() then
			return A.BlessingofFreedom:Show(icon)
	end

	local CurrentSpeed = Unit(unitID):GetCurrentSpeed()
		if CurrentSpeed > 0 and CurrentSpeed < 64 then
			return A.BlessingofFreedom:Show(icon)
		end
	end

	if A.WordofGlory:IsReadyByPassCastGCD(unitID) and not Unit(unitID):InLOS() and (A.IsInPvP and Unit(unitID):HasDeBuffs(A.Taunt.ID) == 0 and (Unit(player):HasBuffs("DamageBuffs") > 0 and Unit(unitID):HealthPercent() < 40 or
		Unit(unitID):HealthPercent() < 60)) then
			return A.WordofGlory:Show(icon)
		end
end

A[6] = function(icon)
	if PartyRotation(icon, UnitExists("raid1") and "raid1" or "party1") then
		return true
	end
	return ArenaRotation(icon, "arena1")
end
A[7] = function(icon)
	if PartyRotation(icon, UnitExists("raid2") and "raid2" or "party2") then
		return true
	end
	if ArenaRotation(icon, "arena2") then
		return ArenaRotation(icon, "arena2")
	end
	if A.HammerofJusticeGreen:IsReady(nil, true, nil, true) and AntiFakeStun(focus) then
		return A.HammerofJusticeGreen:Show(icon)
	end
end
A[8] = function(icon)
	if ArenaRotation(icon, "arena3") then
		return true
	end
	if IsUnitEnemy(focus) then
		local castLeft, _, _, _, notKickAble = Unit(focus):IsCastingRemains()

		if castLeft > 0 then
			if not notKickAble and A.RebukeGreen:IsReady(focus, nil, nil, true) and A.RebukeGreen:AbsentImun(focus, Temp.TotalAndPhysKick, true) then
				return A.RebukeGreen:Show(icon)
			end
		end
		end
end 