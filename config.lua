-- Brasilia time
timeGMT = 0
-- Can only login who is adm or has no free pass
maintenance = false

showPackets = false

-- Combat settings--
-- NOTE: valid values for worldType are: "pvp", "retro-pvp", "no-pvp" and "pvp-enforced"
worldType = "retro-pvp"
hotkeyAimbotEnabled = true
protectionLevel = 1
pzLocked = 60 * 1000
removeChargesFromRunes = true
removeChargesFromPotions = true
removeWeaponAmmunition = true
removeWeaponCharges = true
-- default: 45 * 24 * 60 * 60 = 45 days
-- using 14hrs
timeToDecreaseFrags = 7 * 60 * 60
whiteSkullTime = 15 * 60 * 1000
stairJumpExhaustion = 1 * 1000
experienceByKillingPlayers = false
expFromPlayersLevelRange = 75
dayKillsToRedSkull = 5
weekKillsToRedSkull = 15
monthKillsToRedSkull = 25
redSkullDuration = 2
blackSkullDuration = 3
orangeSkullDuration = 3
blessRune = false
-- Connection Config
-- NOTE: maxPlayers set to 0 means no limit
-- NOTE: MaxPacketsPerSeconds if you change you will be subject to bugs by WPE, keep the default value of 25
-- NOTE: loginIp is only for the site
ip = "127.0.0.1"
loginIp = "127.0.0.1"
bindOnlyGlobalAddress = false
loginProtocolPort = 7171
gameProtocolPort = 7172
statusProtocolPort = 7171
maxPlayers = 1000
motd = "Bem vindos ao Otg Parrot"
onePlayerOnlinePerAccount = true
allowClones = false
serverName = "Parrot"
statusTimeout = 0
replaceKickOnLogin = true
maxPacketsPerSecond = 35
enableLiveCasting = false
liveCastPort = 7173
maxItem = 2000
maxContainer = 100
networkAttackThreshold = 40
replayProtocolPort = 7174

-- Version Manual
clientVersionMin = 1100
clientVersionMax = 1230
clientVersionStr = "Only support client 8.0"

-- Depot Limit
freeDepotLimit = 2000
premiumDepotLimit = 10000
depotBoxes = 18

-- GameStore
gamestoreByModules = false

-- Expert Pvp Config
expertPvp = false

-- Quest Sytem
loadQuestLua = true

-- Deaths
-- NOTE: Leave deathLosePercent as -1 if you want to use the default
-- death penalty formula. For the old formula, set it to 10. For
-- no skill/experience loss, set it to 0.
deathLosePercent = -1

-- Houses
-- NOTE: set housePriceEachSQM to -1 to disable the ingame buy house functionality
-- Periods: daily/weekly/monthly/yearly/never
housePriceEachSQM = 10000
houseRentPeriod = "weekly"

-- Item Usage
-- Do not touch here
timeBetweenActions = 600
timeBetweenExActions = 1000

-- Map
-- NOTE: set mapName WITHOUT .otbm at the end
-- NOTE: unzip the map world.rar
mapName = "map"
mapAuthor = "leo"

-- Market
marketOfferDuration = 30 * 24 * 60 * 60
premiumToCreateMarketOffer = true
checkExpiredMarketOffersEachMinutes = 60
maxMarketOffersAtATimePerPlayer = 100

-- MySQL
mysqlHost = "127.0.0.1"
mysqlUser = "root"
mysqlPass = "senha"
mysqlDatabase = "database"
mysqlPort = 3306
mysqlSock = ""
passwordType = "sha1"

-- Misc.
allowChangeOutfit = true
freePremium = true
kickIdlePlayerAfterMinutes = 15
idleWarningTime = 10 * 60 * 1000
idleKickTime = 15 * 60 * 1000
maxMessageBuffer = 4
emoteSpells = true
classicEquipmentSlots = true
allowWalkthrough = true
storeCoinsPacketSize = 25
storeImagesUrl = "http://ip/store/"
defaultStoreOffer = "Blessings"
classicAttackSpeed = true
showScriptsLogInConsole = false
forceMonsterTypesOnLoad = true
yellMinimumLevel = 2
yellAlwaysAllowPremium = false

-- Server Save
-- NOTE: serverSaveNotifyDuration in minutes
serverSaveNotifyMessage = true
serverSaveNotifyDuration = 5
serverSaveCleanMap = false
serverSaveClose = true
serverSaveShutdown = true

-- Rates
-- NOTE: rateExp is not used if you have enabled stages in data/XML/stages.xml
rateExp = 1
rateSkill = 1
rateLoot = 1
rateMagic = 1
rateSpawn = 6
spawnSpeed = 2.0

-- Monster rates
rateMonsterHealth = 1.0
rateMonsterAttack = 1.2
rateMonsterDefense = 1.0
rateMonsterSpeed = 1.95

-- Monsters
deSpawnRange = 2
deSpawnRadius = 50

-- Stamina
staminaSystem = true

-- Scripts
warnUnsafeScripts = true
convertUnsafeScripts = true

-- Startup
-- NOTE: defaultPriority only works on Windows and sets process
-- priority, valid values are: "normal", "above-normal", "high"
defaultPriority = "high"
startupDatabaseOptimization = true

-- Status server information
ownerName = "Retro-Tibia"
ownerEmail = ""
url = ""
location = "Brazil"

blockWord = ""
