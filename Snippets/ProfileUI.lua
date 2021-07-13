--############################
--##### TRIP'S PALADINUI #####
--############################

-- Full credit to Taste

local TMW                                            = TMW 
local CNDT                                            = TMW.CNDT
local Env                                            = CNDT.Env

local A                                                = Action
local GetToggle                                        = A.GetToggle
local InterruptIsValid                                = A.InterruptIsValid

local UnitCooldown                                    = A.UnitCooldown
local Unit                                            = A.Unit 
local Player                                        = A.Player 
local Pet                                            = A.Pet
local LoC                                            = A.LossOfControl
local MultiUnits                                    = A.MultiUnits
local EnemyTeam                                        = A.EnemyTeam
local FriendlyTeam                                    = A.FriendlyTeam
local TeamCache                                        = A.TeamCache
local InstanceInfo                                    = A.InstanceInfo
local TR                                            = Action.TasteRotation
local select, setmetatable                            = select, setmetatable

A.Data.ProfileEnabled[Action.CurrentProfile] = true
A.Data.ProfileUI = {      
    DateTime = "v1.20 (3 Nov 2020)",
    -- Class settings
    [2] = {
        [ACTION_CONST_PALADIN_RETRIBUTION] = {          
            { -- [7]
                {
                    E = "Header",
                    L = {
                        ANY = " -- General -- ",
                    },
                },
            },            
            { -- [1] 1st Row        
                {
                    E = "Checkbox", 
                    DB = "mouseover",
                    DBV = true,
                    L = { 
                        enUS = "Use @mouseover", 
                        ruRU = "Использовать @mouseover", 
                        frFR = "Utiliser les fonctions @mouseover",
                    }, 
                    TT = { 
                        enUS = "Will unlock use actions for @mouseover units\nExample: Resuscitate, Healing", 
                        ruRU = "Разблокирует использование действий для @mouseover юнитов\nНапример: Воскрешение, Хилинг", 
                        frFR = "Activera les actions via @mouseover\n Exemple: Ressusciter, Soigner",
                    }, 
                    M = {},
                },
                {
                    E = "Checkbox", 
                    DB = "AoE",
                    DBV = true,
                    L = { 
                        enUS = "Use AoE", 
                        ruRU = "Использовать AoE", 
                        frFR = "Utiliser l'AoE",
                    }, 
                    TT = { 
                        enUS = "Enable multiunits actions", 
                        ruRU = "Включает действия для нескольких целей", 
                        frFR = "Activer les actions multi-unités",
                    }, 
                    M = {
                        Custom = "/run Action.AoEToggleMode()",
                        -- It does call func CraftMacro(L[CL], macro above, 1) -- 1 means perCharacter tab in MacroUI, if nil then will be used allCharacters tab in MacroUI
                        Value = value or nil, 
                        -- Very Very Optional, no idea why it will be need however.. 
                        TabN = '@number' or nil,                                
                        Print = '@string' or nil,
                    },
                }, 
                {
                    E = "Slider",                                                     
                    MIN = 2, 
                    MAX = 5,                            
                    DB = "AOEUnits",
                    DBV = 3,
                    ONOFF = false,
                    L = { 
                        ANY = " Minimum Units for AOE Toll/Ashes",
                    }, 
                    M = {},
                },
                
            },     
            { -- [7] Spell Status Frame
                {
                    E = "Header",
                    L = {
                        ANY = " -- Spell Status Frame -- ",
                    },
                },
            },    
            {
                {
                    E         = "Button",
                    H         = 35,
                    OnClick = function(self, button, down)     
                        if button == "LeftButton" then 
                            TR.ToggleStatusFrame() 
                        else                
                            Action.CraftMacro("Status Frame", [[/run Action.TasteRotation.ToggleStatusFrame()]], 1, true, true)   
                        end 
                    end, 
                    L = { 
                        ANY = "Status Frame\nMacro Creator",
                    }, 
                    TT = { 
                        enUS = "Click this button to create the special status frame macro.\nStatus Frame is a new windows that allow user to track blocked spells during fight. So you don't have to check your chat anymore.", 
                        ruRU = "Нажмите эту кнопку, чтобы создать специальный макрос статуса.\nStatus Frame - это новые окна, которые позволяют пользователю отслеживать заблокированные заклинания во время боя. Так что вам больше не нужно проверять свой чат.",  
                        frFR = "Cliquez sur ce bouton pour créer la macro de cadre d'état spécial.\nLe cadre d'état est une nouvelle fenêtre qui permet à l'utilisateur de suivre les sorts bloqués pendant le combat. Vous n'avez donc plus besoin de vérifier votre chat.", 
                    },                           
                },
            },    
            { -- [4] 4th Row
                
                {
                    E = "LayoutSpace",                                                                         
                },
            },
            { -- [7] 
                {
                    E = "Header",
                    L = {
                        ANY = " -- Defensives -- ",
                    },
                },
            },
            { -- [3] 3rd Row 
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "FoLHP",
                    DBV = 50, -- Set healthpercentage @30% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(19750) .. " (%)",
                    }, 
                    M = {},
                },    
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "WoGHP",
                    DBV = 50, -- Set healthpercentage @30% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(85673) .. " (%)",
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "DivineShieldHP",
                    DBV = 100, -- Set healthpercentage @30% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(642) .. " (%)",
                    }, 
                    M = {},
                },                
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "BlessingofProtectionHP",
                    DBV = 100, -- Set healthpercentage @30% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(1022) .. " (%)",
                    }, 
                    M = {},
                },            
            },
            { -- [4] 4th Row
                
                {
                    E = "LayoutSpace",                                                                         
                },
            },
            { -- [7] 
                {
                    E = "Header",
                    L = {
                        ANY = " -- Trinkets -- ",
                    },
                },
            },
            {
                {
                    E = "Checkbox", 
                    DB = "TrinketsAoE",
                    DBV = true,
                    L = { 
                        enUS = "Trinkets\nAoE only", 
                        ruRU = "Trinkets\nAoE only",  
                        frFR = "Trinkets\nAoE only",  
                    }, 
                    TT = { 
                        enUS = "Enable this to option to trinkets for AoE usage ONLY.", 
                        ruRU = "Enable this to option to trinkets for AoE usage ONLY.", 
                        frFR = "Enable this to option to trinkets for AoE usage ONLY.", 
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 5, 
                    MAX = 30,                            
                    DB = "TrinketsMinTTD",
                    DBV = 10, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = "Min TTD",
                    },
                    TT = { 
                        enUS = "Minimum Time To Die for units in range before using Trinkets.\nNOTE: This will calculate Time To Die of your current target OR the Area Time To Die if multiples units are detected.", 
                        ruRU = "Minimum Time To Die for units in range before using Trinkets.\nNOTE: This will calculate Time To Die of your current target OR the Area Time To Die if multiples units are detected.", 
                        frFR = "Minimum Time To Die for units in range before using Trinkets.\nNOTE: This will calculate Time To Die of your current target OR the Area Time To Die if multiples units are detected.", 
                    },                    
                    M = {},
                },
            },
            {
                {
                    E = "Slider",                                                     
                    MIN = 2, 
                    MAX = 10,                            
                    DB = "TrinketsMinUnits",
                    DBV = 20, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = "Min Units",
                    },
                    TT = { 
                        enUS = "Minimum number of units in range to activate Trinkets.", 
                        ruRU = "Minimum number of units in range to activate Trinkets.", 
                        frFR = "Minimum number of units in range to activate Trinkets.",  
                    },                    
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 5, 
                    MAX = 40,                            
                    DB = "TrinketsUnitsRange",
                    DBV = 20, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = "Max AoE range",
                    },
                    TT = { 
                        enUS = "Maximum range for units detection to automatically activate trinkets.", 
                        ruRU = "Maximum range for units detection to automatically activate trinkets.", 
                        frFR = "Maximum range for units detection to automatically activate trinkets.",  
                    },                    
                    M = {},
                },
            },
            
            { -- [7]
                {
                    E = "Header",
                    L = {
                        ANY = " -- PvP -- ",
                    },
                },
            },
            { -- [5] 5th Row     
                {
                    E = "Dropdown",                                                         
                    OT = {
                        { text = "ON MELEE BURST", value = "ON MELEE BURST" },
                        { text = "ON COOLDOWN", value = "ON COOLDOWN" },                    
                        { text = "OFF", value = "OFF" },
                    },
                    DB = "HammerofJusticePvP",
                    DBV = "ON MELEE BURST",
                    L = { 
                        ANY = "PvP " .. A.GetSpellInfo(853),
                    }, 
                    TT = { 
                        enUS = "@arena1-3, @target, @mouseover, @targettarget\nON MELEE BURST - Only if melee player has damage buffs\nON COOLDOWN - means will use always on melee players\nOFF - Cut out from rotation but still allow work through Queue and MSG systems\nIf you want fully turn it OFF then you should make SetBlocker in 'Actions' tab", 
                        ruRU = "@arena1-3, @target, @mouseover, @targettarget\nON MELEE BURST - Только если игрок ближнего боя имеет бафы на урон\nON COOLDOWN - значит будет использовано по игрокам ближнего боя по восстановлению способности\nOFF - Выключает из ротации, но при этом позволяет Очередь и MSG системам работать\nЕсли нужно полностью выключить, тогда установите блокировку во вкладке 'Действия'", 
                    }, 
                    M = {},
                },
                {
                    E = "Dropdown",                                                         
                    OT = {
                        { text = "@arena1", value = 1 },
                        { text = "@arena2", value = 2 },
                        { text = "@arena3", value = 3 },
                        { text = "primary", value = 4 },
                    },
                    MULT = true,
                    DB = "HammerofJusticePvPUnits",
                    DBV = {
                        [1] = true, 
                        [2] = true,
                        [3] = true,
                        [4] = true,
                    }, 
                    L = { 
                        ANY = "PvP " .. A.GetSpellInfo(853) .. " units",
                    }, 
                    TT = { 
                        enUS = "primary - is @target, @mouseover, @targettarget (these units are depend on toggles above)", 
                        ruRU = "primary - это @target, @mouseover, @targettarget (эти юниты зависят от чекбоксов наверху)", 
                    }, 
                    M = {},
                },
            },
        },    
        [ACTION_CONST_PALADIN_HOLY] = {          
            LayoutOptions = { gutter = 5, padding = { left = 10, right = 10 } },    
            { -- [7]
                {
                    E = "Header",
                    L = {
                        ANY = " -- General -- ",
                    },
                },
            },
            { -- [1]                             
                {
                    E = "Checkbox", 
                    DB = "HealMouseover",
                    DBV = true,
                    L = { 
                        enUS = "Use\n@HealMouseover"
                    }, 
                    TT = { 
                        enUS = "Will unlock use Healing actions for @mouseover units."
                    }, 
                    M = {},
                },
                {
                    E = "Checkbox", 
                    DB = "DPSMouseover",
                    DBV = true,
                    L = { 
                        enUS = "Use\n@DPSMouseover"
                    }, 
                    TT = { 
                        enUS = "Will unlock use DPS (formerly target only) actions for @mouseover units. Do not enable at the same time as DamageWeaveMouseover."
                    }, 
                    M = {},
                },
                {
                    E = "Checkbox", 
                    DB = "WeaveMouseover",
                    DBV = true,
                    L = { 
                        enUS = "Use\n@DamageWeaveMouseover"
                    }, 
                    TT = { 
                        enUS = "Will unlock use DPS (formerly targettarget only) actions for @mouseover units. Do not enable at the same time as DPSMouseover."
                    }, 
                    M = {},
                },
                {
                    E = "Checkbox", 
                    DB = "targettarget",
                    DBV = true,
                    L = { 
                        enUS = "Use\n@targettarget"
                    }, 
                    TT = { 
                        enUS = "Will unlock use actions\nfor enemy @targettarget units"
                    }, 
                    M = {},
                },
			},			
			{			
				{
                    E = "Checkbox", 
                    DB = "AutoTarget",
                    DBV = true,
                    L = { 
                        enUS = "Use\n@AutoTarget"
                    }, 
                    TT = { 
                        enUS = "Will autotarget enemy units when Allies >= 90% HP"
                    }, 
                    M = {},
                },
                {
                    E = "Checkbox", 
                    DB = "DispelSniper",
                    DBV = true,
                    L = { 
                        enUS = "Use\nDispel\nSniper"
                    },
                    M = {},
                },                                  
                {
                    E = "Checkbox", 
                    DB = "ForceGlimmerOnMaxUnits",
                    DBV = false,
                    L = { 
                        enUS = "Use\nGlimmer\nSpread"
                    },
                    M = {},
                },           
                {
                    E = "Checkbox", 
                    DB = "UseLightofDawn",
                    DBV = false,
                    L = { 
                        enUS = "Use\nLight\nOf\nDawn"
                    },
                    M = {},
                },       
			},     
			{
                {
                    E = "Checkbox", 
                    DB = "HolyShockDPS",
                    DBV = true,
                    L = { 
                        enUS = "Use\nHoly\nShock\nDPS"
                    },
                    M = {},
                },     
                {
                    E = "Checkbox", 
                    DB = "UseDivineShield",
                    DBV = true,
                    L = { 
                        enUS = "Use\nDivine\nShield"
                    },
                    M = {},
                },     
				{
                    E = "Checkbox", 
                    DB = "LightofDawnDump",
                    DBV = true,
                    L = { 
                        enUS = "Use\nLight\nof\nDawn\nDump"
                    },
					TT = {
						ANY = "If Awakening is talented, CR will dump excess Holy Power at 5 HP into Light of Dawn to proc Avenging Wrath then use SotR as normal"
					},
                    M = {},
                },     
			},
            { -- [7] 
                {
                    E = "Header",
                    L = {
                        " -- Holy Light and Flash of Light HP Thresholds (or Off) -- ",
                    },
                },
            },            
            { -- [3]     
                {
                    E = "Dropdown",                                                         
                    OT = {   
                        { text = "Tooltip", value = 1},                    
                        { text = "Tooltip - 5%", value = 0.95},
                        { text = "Tooltip - 10%", value = 0.9},
                    },
                    DB = "DeficitToggle",
                    DBV = 1,
                    L = { 
                        ANY = "HPDeficit Factoring",
                    }, 
                    TT = { 
                        ANY = "Deficits for WoG, HS, HL, FOL, LOTM, BF will be calculated according to tooltip or option for tooltip times multiplier."
                    },                    
                    M = {},
                },  
								{
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "LightofMartyrHP%",
                    DBV = 70,
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(183998) .. " (%HP)",
                    }, 
                    M = {},
                },
            },
			{
				{
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "FlashofLightHP%",
                    DBV = 100,
                    ONOFF = false,
                    L = { 
                        ANY = "Flash of Light (%HP)",
                    },
					TT = {
                        ANY = "Will use Flash of Light if HP% less than XX\n\nRight click: Create macro",
                    },
                    M = {},
                },  				
				{
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 60,                            
                    DB = "ForceWoGHP",
                    DBV = 0,
                    ONOFF = false,
                    L = { 
                        ANY = "Force WoG over LoD (%HP)",
                    },
					TT = {
                        ANY = "Prevents Light of Dawn usage if any party member has <= XX% HP\n\nRight click: Create macro",
                    },
                    M = {},
                },  
			},
            {
                {
                    E = "Slider",                                                     
                    MIN = 3, 
                    MAX = 10,                            
                    DB = "LightofDawnUnits",
                    DBV = 4,
                    ONOFF = false,
                    L = { 
                        ANY = A.GetSpellInfo(85222) .. " (# Players < HP %)",
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 50, 
                    MAX = 95,                            
                    DB = "LightofDawnHP",
                    DBV = 90,
                    ONOFF = false,
                    L = { 
                        ANY = A.GetSpellInfo(85222) .. " (%HP)",
                    }, 
                    M = {},
                },                
            }, 
            {
                {
                    E = "Slider",                                                     
                    MIN = 3, 
                    MAX = 5,                            
                    DB = "DivineTollUnitsParty",
                    DBV = 3,
                    ONOFF = false,
                    L = { 
                        ANY = A.GetSpellInfo(304971) .. " Party (# Players < HP %)",
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 20, 
                    MAX = 80,                            
                    DB = "DivineTollHPParty",
                    DBV = 80,
                    ONOFF = false,
                    L = { 
                        ANY = A.GetSpellInfo(304971) .. " Party (%HP)",
                    }, 
                    M = {},
                },        
            },
            {
                {
                    E = "Slider",                                                     
                    MIN = 3, 
                    MAX = 5,                            
                    DB = "DivineTollUnitsRaid",
                    DBV = 3,
                    ONOFF = false,
                    L = { 
                        ANY = A.GetSpellInfo(304971) .. " Raid (# Players < HP %)",
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 20, 
                    MAX = 80,                            
                    DB = "DivineTollHPRaid",
                    DBV = 80,
                    ONOFF = false,
                    L = { 
                        ANY = A.GetSpellInfo(304971) .. " Raid (%HP)",
                    }, 
                    M = {},
                },    
            },
            {
                {
                    E = "Slider",                                                     
                    MIN = 3, 
                    MAX = 4,                            
                    DB = "BoVUnitsParty",
                    DBV = 3,
                    ONOFF = false,
                    L = { 
                        ANY = A.GetSpellInfo(200025) .. " Party (# Players < HP %)",
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 20, 
                    MAX = 80,                            
                    DB = "BoVHPParty",
                    DBV = 80,
                    ONOFF = false,
                    L = { 
                        ANY = A.GetSpellInfo(200025) .. " Party (%HP)",
                    }, 
                    M = {},
                },        
            },
            {
                {
                    E = "Slider",                                                     
                    MIN = 3, 
                    MAX = 4,                            
                    DB = "BoVUnitsRaid",
                    DBV = 3,
                    ONOFF = false,
                    L = { 
                        ANY = A.GetSpellInfo(200025) .. " Raid (# Players < HP %)",
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 20, 
                    MAX = 80,                            
                    DB = "BoVHPRaid",
                    DBV = 80,
                    ONOFF = false,
                    L = { 
                        ANY = A.GetSpellInfo(200025) .. " Raid (%HP)",
                    }, 
                    M = {},
                },    
            },
            {
                {
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "AllySwapHP",
                    DBV = 80,
                    ONOFF = false,
                    L = { 
                        ANY = "Target Stop - Ally Swap (%HP)",
                    }, 
					TT = {
                        ANY = "Stops Healing Engine from swapping off @enemy target if all allies have >= XX% HP\n\nRight click: Create macro",
                    },
                    M = {},
                },            
                {
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 50,                            
                    DB = "Necrotic",
                    DBV = 35,
                    ONOFF = false,
                    L = { 
                        ANY = "Ignore Necrotic @ X Stacks",
                    }, 
					TT = {
                        ANY = "Stops Healing Engine from targeting an ally with >= XX Necrotic Stacks\n\nRight click: Create macro",
                    },
                    M = {},
                },        
            },
			{
                {
                    E = "Dropdown",                                                         
                    OT = {   
                        { text = "Shield of the Righteous >= 3 Holy Power", value = 3 },                    
                        { text = "Shield of the Righteous = 5 Holy Power", value = 5 },
                    },
                    DB = "ShieldoftheRighteousHP",
                    DBV = 5,
                    L = { 
                        ANY = "Holy Power Dump",
                    }, 
                    TT = { 
                        ANY = "Will use Shield of the Righteous or Light of Dawn when Holy Power is equal to option value"
                    },                    
                    M = {},
                },  
			},
            { -- [7]
                {
                    E = "Header",
                    L = {
                        ANY = " -- Healing Engine -- ",
                    },
                },
            },    
            -- Beacon of Virtue(talent)
            -- + Classic Beacon 
            { -- [7] 
                {
                    E = "Header",
                    L = {
                        ANY = " -- Beacons -- ",
                    },
                },
            },    
            { -- [3]  
                RowOptions = { margin = { top = 10 } },        
                {
                    E = "Dropdown",                                                         
                    OT = {   
                        { text = "Tanking Units", value = "Tanking Units" },                    
                        { text = "Beacon of Faith + Saved By the Light PVP", value = "Beacon of Faith + Saved By the Light" },
                        { text = "Beacon of Faith PVE (Self and Tank)", value = "Beacon of Faith" },
                        { text = "Self", value = "Self" },
                    },
                    DB = "BeaconWorkMode",
                    DBV = "Tanking Units",
                    L = { 
                        ANY = A.GetSpellInfo(53563) .. "\nMode",
                    }, 
                    TT = { 
                        enUS = "These conditions will be skiped if unit will dying in emergency (critical) situation"
                    },                    
                    M = {},
                },            
            },            
            { -- [7]
                {
                    E = "Header",
                    L = {
                        ANY = " -- Racials -- ",
                    },
                },
            },    
            {
                {
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "RacialBurstHealing",                    
                    DBV = 100,
                    ONLYON = true,
                    L = { 
                        ANY = A.GetLocalization()["TAB"][1]["RACIAL"] .. "\n(Healing HP %)",                        
                    },                     
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "RacialBurstDamaging",                    
                    DBV = 100,
                    ONOFF = false,
                    L = { 
                        ANY = A.GetLocalization()["TAB"][1]["RACIAL"] .. "\n(Damaging HP %)",                        
                    },                     
                    M = {},
                },
            },
            { -- Trinkets
                {
                    E = "Header",
                    L = {
                        ANY = " -- Trinkets -- ",
                    },
                },
            },    
            {                 
                {
                    E = "Dropdown",                                                         
                    OT = {
                        { text = "Always", value = "Always" },
                        { text = "Burst Synchronized", value = "BurstSync" },                    
                    },
                    DB = "TrinketBurstSyncUP",
                    DBV = "Always",
                    L = { 
                        enUS = "Damager: How to use trinkets"
                    },
                    TT = { 
                        enUS = "Always: On cooldown\nBurst Synchronized: By Burst Mode in 'General' tab"
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 5, 
                    MAX = 100,                            
                    DB = "TrinketMana",
                    DBV = 85,
                    ONLYOFF = false,
                    L = { 
                        enUS = "Trinket: Mana(%)"
                    },
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 5, 
                    MAX = 100,                            
                    DB = "TrinketBurstHealing",
                    DBV = 75,
                    ONLYOFF = false,
                    L = { 
                        enUS = "Healer: Target Health (%)"
                    },
                    M = {},
                },        
            },         
        },
    },
}

-----------------------------------------
--                   PvP  
-----------------------------------------

function A.Main_CastBars(unit, list)
    if not A.IsInitialized or A.IamHealer or (A.Zone ~= "arena" and A.Zone ~= "pvp") then 
        return false 
    end 
    
    if A[A.PlayerSpec] and A[A.PlayerSpec].SpearHandStrike and A[A.PlayerSpec].SpearHandStrike:IsReadyP(unit, nil, true) and A[A.PlayerSpec].SpearHandStrike:AbsentImun(unit, {"KickImun", "TotalImun", "DamagePhysImun"}, true) and A.InterruptIsValid(unit, list) then 
        return true         
    end 
end 

function A.Second_CastBars(unit)
    if not A.IsInitialized or (A.Zone ~= "arena" and A.Zone ~= "pvp") then 
        return false 
    end 
    
    local Toggle = A.GetToggle(2, "ParalysisPvP")    
    if Toggle and Toggle ~= "OFF" and A[A.PlayerSpec] and A[A.PlayerSpec].Paralysis and A[A.PlayerSpec].Paralysis:IsReadyP(unit, nil, true) and A[A.PlayerSpec].Paralysis:AbsentImun(unit, {"CCTotalImun", "TotalImun", "DamagePhysImun"}, true) and Unit(unit):IsControlAble("incapacitate", 0) then 
        if Toggle == "BOTH" then 
            return select(2, A.InterruptIsValid(unit, "Heal", true)) or select(2, A.InterruptIsValid(unit, "PvP", true)) 
        else
            return select(2, A.InterruptIsValid(unit, Toggle, true))         
        end 
    end 
end 

