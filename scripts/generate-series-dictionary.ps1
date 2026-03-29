param(
    [string]$DocsRoot = "C:\Users\Admin\Desktop\Daisy Suite\DaisyCoreDocs"
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$paperJar =
    Get-ChildItem -Path "$env:USERPROFILE\.gradle\caches\modules-2\files-2.1\io.papermc.paper\paper-api" -Recurse -Filter "paper-api-*.jar" |
    Sort-Object `
        @{ Expression = "LastWriteTimeUtc"; Descending = $true }, `
        @{ Expression = "FullName"; Descending = $true } |
    Select-Object -First 1 -ExpandProperty FullName

if (-not $paperJar) {
    throw "Unable to locate a Paper API jar in the Gradle cache."
}

$javap = (Get-Command javap -ErrorAction Stop).Source
$dictionaryRoot = Join-Path $DocsRoot "src\content\docs\daisyseries\dictionary"
New-Item -ItemType Directory -Force -Path $dictionaryRoot | Out-Null

function Convert-ToSeriesKey([string]$name) {
    return $name.ToLowerInvariant()
}

function Convert-ToAttributeKey([string]$name) {
    $key = $name.ToLowerInvariant()
    $key = $key -replace '^generic_', ''
    $key = $key -replace '^player_', ''
    $key = $key -replace '^zombie_', ''
    return $key
}

function Convert-ToDisplayName([string]$key) {
    return (
        $key -split "_" |
        Where-Object { $_ -ne "" } |
        ForEach-Object {
            if ($_.Length -eq 1) { $_.ToUpperInvariant() } else { $_.Substring(0, 1).ToUpperInvariant() + $_.Substring(1).ToLowerInvariant() }
        }
    ) -join " "
}

function Get-StaticFieldNames([string]$className, [string]$typeName) {
    $pattern = "public static final $([regex]::Escape($typeName)) ([A-Z0-9_]+);"
    $output = & $javap -classpath $paperJar $className
    return @(
        $output |
        Select-String -Pattern $pattern |
        ForEach-Object { $_.Matches[0].Groups[1].Value } |
        Sort-Object -Unique
    )
}

function New-Entry([string]$key, [string[]]$aliases) {
    [pscustomobject]@{
        key = $key
        display = Convert-ToDisplayName $key
        aliases = @($aliases | Sort-Object -Unique)
    }
}

function Format-AliasCell([object[]]$aliases) {
    if (-not $aliases -or $aliases.Count -eq 0) {
        return "-"
    }

    return (($aliases | ForEach-Object { '``' + $_ + '``' }) -join ", ")
}

function Write-DictionaryPage(
    [string]$slug,
    [string]$title,
    [string]$description,
    [string]$whatFor,
    [string]$yamlKey,
    [string]$parserName,
    [string]$codecName,
    [string[]]$rules,
    [object[]]$entries
) {
    $rows =
        $entries |
        Sort-Object key |
        ForEach-Object {
            '| ``' + $_.key + '`` | ' + $_.display + ' | ' + (Format-AliasCell $_.aliases) + ' |'
        }

    $lines = New-Object System.Collections.Generic.List[string]
    $lines.Add("---")
    $lines.Add("title: $title")
    $lines.Add("description: $description")
    $lines.Add("---")
    $lines.Add("")
    $lines.Add("# $title")
    $lines.Add("")
    $lines.Add($whatFor)
    $lines.Add("")
    $lines.Add("## Canonical key rules")
    $lines.Add("")
    foreach ($rule in $rules) {
        $lines.Add("- $rule")
    }
    $lines.Add("")
    $lines.Add("## Quick config example")
    $lines.Add("")
    $lines.Add('```yaml')
    $lines.Add($yamlKey + ": " + (($entries | Select-Object -First 1).key))
    $lines.Add('```')
    $lines.Add("")
    $lines.Add("## Quick usage example")
    $lines.Add("")
    $lines.Add('```kotlin')
    $lines.Add("val value = $parserName.parse(config.$yamlKey)")
    $lines.Add("val key = $parserName.key(value)")
    $lines.Add("val label = $parserName.displayName(value)")
    $lines.Add("")
    $lines.Add("val typed = required(`"$yamlKey`", $codecName())")
    $lines.Add('```')
    $lines.Add("")
    $lines.Add("## Reference values")
    $lines.Add("")
    $lines.Add("| Canonical key | Display name | Accepted aliases |")
    $lines.Add("| --- | --- | --- |")
    foreach ($row in $rows) {
        $lines.Add($row)
    }
    $lines.Add("")

    $content = $lines -join "`r`n"

    Set-Content -Path (Join-Path $dictionaryRoot "$slug.mdx") -Value $content -NoNewline
}

$materialAliases = @{
    "golden_apple" = @("gapple")
    "enchanted_golden_apple" = @("god_apple")
    "experience_bottle" = @("xp_bottle")
}

$soundAliases = @{
    "entity_player_levelup" = @("levelup")
    "entity_experience_orb_pickup" = @("xp_pickup")
}

$itemFlagAliases = @{}

$enchantmentAliases = @{
    "protection" = @("prot")
    "feather_falling" = @("ff")
    "knockback" = @("kb")
}

$potionAliases = @{
    "resistance" = @("res")
    "fire_resistance" = @("fire_res")
}

$biomeAliases = @{
    "nether_wastes" = @("nether")
    "the_end" = @("end")
}

$villagerProfessionAliases = @{
    "toolsmith" = @("tool_smith")
    "weaponsmith" = @("weapon_smith", "weaponsmith")
    "leatherworker" = @("leather_worker")
}

$attributeAliases = @{}

$entityAliases = @{
    "mooshroom" = @("mushroom_cow")
}

$gameModeAliases = @{
    "survival" = @("surv")
    "spectator" = @("spec")
}

$difficultyAliases = @{}

$blockFaceAliases = @{}

$damageCauseAliases = @{}

$operationAliases = @{}

$patternTypeAliases = @{}

$particleAliases = @{
    "totem_of_undying" = @("totem")
}

$statisticAliases = @{}

$materials =
    Get-StaticFieldNames "org.bukkit.Material" "org.bukkit.Material" |
    ForEach-Object {
        $key = Convert-ToSeriesKey $_
        New-Entry $key $materialAliases[$key]
    }

$sounds =
    Get-StaticFieldNames "org.bukkit.Sound" "org.bukkit.Sound" |
    ForEach-Object {
        $key = Convert-ToSeriesKey $_
        New-Entry $key $soundAliases[$key]
    }

$itemFlags =
    Get-StaticFieldNames "org.bukkit.inventory.ItemFlag" "org.bukkit.inventory.ItemFlag" |
    ForEach-Object {
        $key = Convert-ToSeriesKey $_
        New-Entry $key $itemFlagAliases[$key]
    }

$enchantments =
    Get-StaticFieldNames "org.bukkit.enchantments.Enchantment" "org.bukkit.enchantments.Enchantment" |
    ForEach-Object {
        $key = Convert-ToSeriesKey $_
        New-Entry $key $enchantmentAliases[$key]
    }

$potions =
    Get-StaticFieldNames "org.bukkit.potion.PotionEffectType" "org.bukkit.potion.PotionEffectType" |
    ForEach-Object {
        $key = Convert-ToSeriesKey $_
        New-Entry $key $potionAliases[$key]
    }

$biomes =
    Get-StaticFieldNames "org.bukkit.block.Biome" "org.bukkit.block.Biome" |
    ForEach-Object {
        $key = Convert-ToSeriesKey $_
        New-Entry $key $biomeAliases[$key]
    }

$villagerProfessions =
    Get-StaticFieldNames 'org.bukkit.entity.Villager$Profession' 'org.bukkit.entity.Villager$Profession' |
    ForEach-Object {
        $key = Convert-ToSeriesKey $_
        New-Entry $key $villagerProfessionAliases[$key]
    }

$attributes =
    Get-StaticFieldNames "org.bukkit.attribute.Attribute" "org.bukkit.attribute.Attribute" |
    ForEach-Object {
        $key = Convert-ToAttributeKey $_
        New-Entry $key $attributeAliases[$key]
    }

$entities =
    Get-StaticFieldNames "org.bukkit.entity.EntityType" "org.bukkit.entity.EntityType" |
    ForEach-Object {
        $key = Convert-ToSeriesKey $_
        New-Entry $key $entityAliases[$key]
    }

$gameModes =
    Get-StaticFieldNames "org.bukkit.GameMode" "org.bukkit.GameMode" |
    ForEach-Object {
        $key = Convert-ToSeriesKey $_
        New-Entry $key $gameModeAliases[$key]
    }

$difficulties =
    Get-StaticFieldNames "org.bukkit.Difficulty" "org.bukkit.Difficulty" |
    ForEach-Object {
        $key = Convert-ToSeriesKey $_
        New-Entry $key $difficultyAliases[$key]
    }

$blockFaces =
    Get-StaticFieldNames "org.bukkit.block.BlockFace" "org.bukkit.block.BlockFace" |
    ForEach-Object {
        $key = Convert-ToSeriesKey $_
        New-Entry $key $blockFaceAliases[$key]
    }

$damageCauses =
    Get-StaticFieldNames 'org.bukkit.event.entity.EntityDamageEvent$DamageCause' 'org.bukkit.event.entity.EntityDamageEvent$DamageCause' |
    ForEach-Object {
        $key = Convert-ToSeriesKey $_
        New-Entry $key $damageCauseAliases[$key]
    }

$operations =
    Get-StaticFieldNames 'org.bukkit.attribute.AttributeModifier$Operation' 'org.bukkit.attribute.AttributeModifier$Operation' |
    ForEach-Object {
        $key = Convert-ToSeriesKey $_
        New-Entry $key $operationAliases[$key]
    }

$patternTypes =
    Get-StaticFieldNames "org.bukkit.block.banner.PatternType" "org.bukkit.block.banner.PatternType" |
    ForEach-Object {
        $key = Convert-ToSeriesKey $_
        New-Entry $key $patternTypeAliases[$key]
    }

$particles =
    Get-StaticFieldNames "org.bukkit.Particle" "org.bukkit.Particle" |
    ForEach-Object {
        $key = Convert-ToSeriesKey $_
        New-Entry $key $particleAliases[$key]
    }

$statistics =
    Get-StaticFieldNames "org.bukkit.Statistic" "org.bukkit.Statistic" |
    ForEach-Object {
        $key = Convert-ToSeriesKey $_
        New-Entry $key $statisticAliases[$key]
    }

$index = @(
"---",
"title: Dictionary Overview",
"description: Browse the canonical DaisySeries value dictionaries for the modern Paper parser families DaisySeries ships today.",
"---",
"",
"# DaisySeries Dictionary",
"",
"Use this section when you need the actual config-safe values DaisySeries is designed around.",
"",
"Each dictionary page gives you:",
"",
"- canonical keys",
"- display names",
"- accepted aliases where DaisySeries curates them",
"- quick config and codec examples",
"",
"These pages are generated from the current Paper API surface plus DaisySeries alias rules and committed as static docs so search and indexing stay stable.",
"",
"## Dictionaries",
"",
"- [Materials](/daisyseries/dictionary/materials/)",
"- [Sounds](/daisyseries/dictionary/sounds/)",
"- [Item Flags](/daisyseries/dictionary/item-flags/)",
"- [Enchantments](/daisyseries/dictionary/enchantments/)",
"- [Potions](/daisyseries/dictionary/potions/)",
"- [Biomes](/daisyseries/dictionary/biomes/)",
"- [Villager Professions](/daisyseries/dictionary/villager-professions/)",
"- [Attributes](/daisyseries/dictionary/attributes/)",
"- [Entity Types](/daisyseries/dictionary/entities/)",
"- [Game Modes](/daisyseries/dictionary/game-modes/)",
"- [Difficulties](/daisyseries/dictionary/difficulties/)",
"- [Block Faces](/daisyseries/dictionary/block-faces/)",
"- [Damage Causes](/daisyseries/dictionary/damage-causes/)",
"- [Operations](/daisyseries/dictionary/operations/)",
"- [Pattern Types](/daisyseries/dictionary/pattern-types/)",
"- [Particles](/daisyseries/dictionary/particles/)",
"- [Statistics](/daisyseries/dictionary/statistics/)",
""
) -join "`r`n"

Set-Content -Path (Join-Path $dictionaryRoot "index.mdx") -Value $index -NoNewline

Write-DictionaryPage `
    -slug "materials" `
    -title "Materials Dictionary" `
    -description "Canonical DaisySeries material keys, display names, and accepted aliases." `
    -whatFor "Use these values for item, icon, block, and config-driven material selection." `
    -yamlKey "icon" `
    -parserName "DaisyMaterials" `
    -codecName "materialCodec" `
    -rules @(
        "Canonical keys are lowercase underscore names like ``diamond_sword``.",
        "Curated aliases are accepted on input only.",
        "Namespaced inputs like ``minecraft:diamond_sword`` are normalized on parse."
    ) `
    -entries $materials

Write-DictionaryPage `
    -slug "sounds" `
    -title "Sounds Dictionary" `
    -description "Canonical DaisySeries sound keys, display names, and accepted aliases." `
    -whatFor "Use these values for feedback sounds, config-driven audio cues, and lightweight sound selection." `
    -yamlKey "feedback_sound" `
    -parserName "DaisySounds" `
    -codecName "soundCodec" `
    -rules @(
        "Canonical keys are lowercase underscore names like ``entity_player_levelup``.",
        "Curated aliases are accepted on input only.",
        "Namespaced inputs are normalized when the DaisySeries sound parser accepts them."
    ) `
    -entries $sounds

Write-DictionaryPage `
    -slug "item-flags" `
    -title "Item Flags Dictionary" `
    -description "Canonical DaisySeries item flag keys and display names." `
    -whatFor "Use these values for config-driven item metadata hiding and item builder settings." `
    -yamlKey "flags" `
    -parserName "DaisyItemFlags" `
    -codecName "itemFlagsCodec" `
    -rules @(
        "Canonical keys are lowercase underscore names like ``hide_enchants``.",
        "Item flags currently do not ship curated aliases.",
        "Use ``parseMany(...)`` or ``itemFlagsCodec()`` when reading a set of flags."
    ) `
    -entries $itemFlags

Write-DictionaryPage `
    -slug "enchantments" `
    -title "Enchantments Dictionary" `
    -description "Canonical DaisySeries enchantment keys, display names, and curated aliases." `
    -whatFor "Use these values for config-driven enchantment types and enum-like enchantment selection." `
    -yamlKey "enchantment" `
    -parserName "DaisyEnchantments" `
    -codecName "enchantmentCodec" `
    -rules @(
        "Canonical keys are lowercase underscore names like ``sharpness`` and ``fire_aspect``.",
        "Curated aliases are accepted on input only.",
        "Namespaced inputs like ``minecraft:sharpness`` are normalized on parse."
    ) `
    -entries $enchantments

Write-DictionaryPage `
    -slug "potions" `
    -title "Potions Dictionary" `
    -description "Canonical DaisySeries potion effect keys, display names, and curated aliases." `
    -whatFor "Use these values for config-driven potion effect selection and effect-heavy gameplay systems." `
    -yamlKey "effect" `
    -parserName "DaisyPotions" `
    -codecName "potionEffectCodec" `
    -rules @(
        "Canonical keys are lowercase underscore names like ``speed`` and ``slow_falling``.",
        "Curated aliases are accepted on input only.",
        "Namespaced inputs like ``minecraft:speed`` are normalized on parse."
    ) `
    -entries $potions

Write-DictionaryPage `
    -slug "biomes" `
    -title "Biomes Dictionary" `
    -description "Canonical DaisySeries biome keys, display names, and accepted aliases." `
    -whatFor "Use these values for biome-aware config, region defaults, and gameplay systems that need stable biome selection." `
    -yamlKey "biome" `
    -parserName "DaisyBiomes" `
    -codecName "biomeCodec" `
    -rules @(
        "Canonical keys are lowercase underscore names like ``cherry_grove``.",
        "Curated aliases are accepted on input only.",
        "Namespaced inputs like ``minecraft:cherry_grove`` are normalized on parse."
    ) `
    -entries $biomes

Write-DictionaryPage `
    -slug "villager-professions" `
    -title "Villager Professions Dictionary" `
    -description "Canonical DaisySeries villager-profession keys, display names, and accepted aliases." `
    -whatFor "Use these values for villager-role settings, NPC defaults, and config-backed profession selection." `
    -yamlKey "profession" `
    -parserName "DaisyVillagerProfessions" `
    -codecName "villagerProfessionCodec" `
    -rules @(
        "Canonical keys are lowercase profession names like ``toolsmith`` and ``weaponsmith``.",
        "Spacing helpers like ``tool smith`` normalize to the canonical DaisySeries key.",
        "Legacy names like ``blacksmith`` are intentionally not part of the parser contract."
    ) `
    -entries $villagerProfessions

Write-DictionaryPage `
    -slug "attributes" `
    -title "Attributes Dictionary" `
    -description "Canonical DaisySeries attribute keys, display names, and accepted aliases." `
    -whatFor "Use these values for stat rules, modifiers, requirements, and config-backed attribute selection." `
    -yamlKey "attribute" `
    -parserName "DaisyAttributes" `
    -codecName "attributeCodec" `
    -rules @(
        "Canonical keys remove raw enum prefixes such as ``generic_`` or ``player_``.",
        "Prefixed forms are still accepted on input when plugin configs already use them.",
        "Namespaced Mojang-style inputs are normalized into the DaisySeries canonical key."
    ) `
    -entries $attributes

Write-DictionaryPage `
    -slug "entities" `
    -title "Entity Types Dictionary" `
    -description "Canonical DaisySeries entity-type keys, display names, and accepted aliases." `
    -whatFor "Use these values for mob settings, entity-based features, and config-driven entity selection." `
    -yamlKey "entity" `
    -parserName "DaisyEntities" `
    -codecName "entityTypeCodec" `
    -rules @(
        "Canonical keys are lowercase underscore names like ``zombie_villager``.",
        "Curated aliases are accepted on input only.",
        "Namespaced inputs like ``minecraft:zombie_villager`` are normalized on parse."
    ) `
    -entries $entities

Write-DictionaryPage `
    -slug "game-modes" `
    -title "Game Modes Dictionary" `
    -description "Canonical DaisySeries game-mode keys, display names, and accepted aliases." `
    -whatFor "Use these values for default-mode settings, mode-gated features, and admin-editable gameplay rules." `
    -yamlKey "game_mode" `
    -parserName "DaisyGameModes" `
    -codecName "gameModeCodec" `
    -rules @(
        "Canonical keys are lowercase underscore names like ``survival`` and ``spectator``.",
        "Curated aliases are accepted on input only.",
        "Game modes stay intentionally small and modern."
    ) `
    -entries $gameModes

Write-DictionaryPage `
    -slug "difficulties" `
    -title "Difficulties Dictionary" `
    -description "Canonical DaisySeries difficulty keys and display names." `
    -whatFor "Use these values for world rules, gameplay defaults, and config-backed difficulty choices." `
    -yamlKey "difficulty" `
    -parserName "DaisyDifficulties" `
    -codecName "difficultyCodec" `
    -rules @(
        "Canonical keys are lowercase names like ``peaceful`` and ``hard``.",
        "Difficulties do not ship extra aliases beyond normalization.",
        "Namespaced inputs are normalized when provided."
    ) `
    -entries $difficulties

Write-DictionaryPage `
    -slug "block-faces" `
    -title "Block Faces Dictionary" `
    -description "Canonical DaisySeries block-face keys and display names." `
    -whatFor "Use these values for direction-based config, menu orientation, and placement-facing settings." `
    -yamlKey "facing" `
    -parserName "DaisyBlockFaces" `
    -codecName "blockFaceCodec" `
    -rules @(
        "Canonical keys are lowercase underscore names like ``north_east``.",
        "Directional hyphen and space input is normalized on parse.",
        "Block faces do not ship extra aliases beyond normalization."
    ) `
    -entries $blockFaces

Write-DictionaryPage `
    -slug "damage-causes" `
    -title "Damage Causes Dictionary" `
    -description "Canonical DaisySeries damage-cause keys and display names." `
    -whatFor "Use these values for configured damage rules, filters, and event-driven gameplay settings." `
    -yamlKey "damage_cause" `
    -parserName "DaisyDamageCauses" `
    -codecName "damageCauseCodec" `
    -rules @(
        "Canonical keys are lowercase underscore names like ``fire_tick`` and ``entity_attack``.",
        "Damage causes do not ship extra aliases beyond normalization.",
        "Namespaced inputs are normalized when provided."
    ) `
    -entries $damageCauses

Write-DictionaryPage `
    -slug "operations" `
    -title "Operations Dictionary" `
    -description "Canonical DaisySeries attribute-modifier operation keys and display names." `
    -whatFor "Use these values for config-backed attribute modifiers and stat rule operations." `
    -yamlKey "operation" `
    -parserName "DaisyOperations" `
    -codecName "operationCodec" `
    -rules @(
        "Canonical keys are lowercase underscore names like ``add_number`` and ``multiply_scalar_1``.",
        "Operations do not ship extra aliases beyond normalization.",
        "Spacing and kebab-case input normalize to the canonical DaisySeries key."
    ) `
    -entries $operations

Write-DictionaryPage `
    -slug "pattern-types" `
    -title "Pattern Types Dictionary" `
    -description "Canonical DaisySeries banner pattern-type keys and display names." `
    -whatFor "Use these values for config-backed banner design, icon variation, and item-display pattern selection." `
    -yamlKey "pattern" `
    -parserName "DaisyPatternTypes" `
    -codecName "patternTypeCodec" `
    -rules @(
        "Canonical keys are lowercase underscore names like ``small_stripes`` and ``straight_cross``.",
        "Pattern types start with normalization-only parsing and no broad alias map.",
        "Namespaced inputs are normalized when supported by the parser."
    ) `
    -entries $patternTypes

Write-DictionaryPage `
    -slug "particles" `
    -title "Particles Dictionary" `
    -description "Canonical DaisySeries particle keys, display names, and accepted aliases." `
    -whatFor "Use these values for config-driven particles, feedback effects, and lightweight display settings." `
    -yamlKey "particle" `
    -parserName "DaisyParticles" `
    -codecName "particleCodec" `
    -rules @(
        "Canonical keys are lowercase underscore names like ``totem_of_undying``.",
        "Curated aliases are accepted on input only.",
        "Namespaced inputs like ``minecraft:totem_of_undying`` are normalized on parse."
    ) `
    -entries $particles

Write-DictionaryPage `
    -slug "statistics" `
    -title "Statistics Dictionary" `
    -description "Canonical DaisySeries statistic keys and display names." `
    -whatFor "Use these values for statistic-driven gameplay, thresholds, leaderboards, and config-backed progression rules." `
    -yamlKey "statistic" `
    -parserName "DaisyStatistics" `
    -codecName "statisticCodec" `
    -rules @(
        "Canonical keys are lowercase underscore names like ``player_kills``.",
        "Statistics currently do not ship curated aliases.",
        "Namespaced inputs are normalized when the DaisySeries statistic parser accepts them."
    ) `
    -entries $statistics

Write-Host "Generated DaisySeries dictionary pages at $dictionaryRoot using $paperJar"
