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

$index = @(
"---",
"title: Dictionary Overview",
"description: Browse the canonical DaisySeries value dictionaries for materials, sounds, item flags, enchantments, and potions.",
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

Write-Host "Generated DaisySeries dictionary pages at $dictionaryRoot using $paperJar"
