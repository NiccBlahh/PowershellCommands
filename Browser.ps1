[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
[Console]::InputEncoding  = [System.Text.Encoding]::UTF8
$OutputEncoding           = [System.Text.Encoding]::UTF8
Clear-Host

Write-Host '    ___   _________    ___   _____' -ForegroundColor Cyan
Write-Host '   /   | /_  __/ /   /   | / ___/' -ForegroundColor Cyan
Write-Host '  / /| |  / / / /   / /| | \__ \ ' -ForegroundColor Cyan
Write-Host ' / ___ | / / / /___/ ___ |___/ / ' -ForegroundColor Cyan
Write-Host '/_/  |_|/_/ /_____/_/  |_/____/  ' -ForegroundColor Cyan
Write-Host '      Made by Nicc | @imnicc.dll' -ForegroundColor DarkGray
Write-Host ''

# ==========================================
# 1. KNOWN CHEAT WEBSITES / DISCORD INVITES
# ==========================================
$cheatDomains = @(
    "skript.gg", "131.196.198.0-24.bbhost.com.br", "api.tzproject.com", 
    "api.susano.re", "api.keyser-dashboard.com", "p.mrcheat.cc", "api-de.mrcheat.cc", 
    "machocheats.com", "diagnostic.xtransformation.space", "api.hxsoftwares.com", 
    "ec2-3-235-182-75.compute-1.amazonaws.com", "falcon.redengine.eu", 
    "vps-b7a11d64.vps.ovh.net", "gm07-dc04.ouiheberg.com", "tiagomodzhost.win", 
    "keyauth.win", "fluxauth.com", "cdn-185-199-110-133.github.com", "ambani.dev", 
    "nfcheats.com", "vps-d2651d06.vps.ovh.net", "198macros.com", "pikainjection.xyz", 
    "grimclient.pl", "bypassing.gg", "prestigeclient.vip", "vape.gg", "novoline.wtf", 
    "dreamclient.xyz", "liquidbounce.net", "meteorclient.com", "wurstclient.net", 
    "aristois.net", "bleachhack.org", "inertiaclient.com", "futureclient.net", 
    "impactclient.net", "rusherhack.org", "thunderhack.net", "github.com/lambda-client/lambda",
    "github.com/kami-blue/client", "cornos.net", "fdpinfo.github.io", "expensive.su",
    "augustusclient.xyz", "github.com/Kopamed/Raven-bPLUS", "riseclient.com",
    "moonclient.xyz", "tenacity.dev", "drip.gg", "entropy.club", "phantom.wtf",
    "slinky.gg", "cryptclient.com", "doomsdayclient.com", "skilledclient.com",
    "koid.gg", "itami.cf", "antic.run", "breezeclient.com", "icarusclient.com",
    "astolfo.lgbt", "zeroday.gg", "azura.best", "sigmaclient.info", "exhibition.ac",
    "akrien.wtf", "boze.vip", "karmaclient.net", "flux.today", "centauri.wtf",
    "spicyclient.info", "github.com/3arthqu4ke/earthhack", "github.com/ionar2/salhack", 
    "github.com/Gopro336/CLEAN_Phobos_1.9.0", "github.com/seppukudevelopment/seppuku",
    "abyssclient.com", "github.com/TrvsF/wurstplus3", "wizardhax.com", 
    "wolframclient.net", "matixclient.com", "jigsawclient.net", "horion.download", 
    "zephyrclient.com", "packetclient.com", "ambrosial.net", "intent.store", 
    "spezz.exchange", "bypasses.net", "masterof13fps.com", "unknowncheats.me",

    # --- New Websites & Discord Invites ---
    "paragonbp.xyz", "getlinear.xyz",
    "PUGWyyVYdY", "n89eRZ5TUq", "7s2yBeC5R", "WPAE3XtfX", "paragonbp", 
    "epitaph", "coldbypass", "GUmP4w7Fr", "Ns8zVFSTMT", "panicbypass", 
    "XF8DzS4Kcn", "hznnSArS9x", "blackholebypass", "stealthbp", "BpWKDg5Qkz"
)


# ==========================================
# 2. LOCATIONS & SQLITE SETUP
# ==========================================
$local = $env:LOCALAPPDATA
$roaming = $env:APPDATA

$browsers = @(
    @{ Name="Google Chrome"; Path="$local\Google\Chrome\User Data"; Type="Chrome" }
    @{ Name="Microsoft Edge"; Path="$local\Microsoft\Edge\User Data"; Type="Chrome" }
    @{ Name="Brave Browser"; Path="$local\BraveSoftware\Brave-Browser\User Data"; Type="Chrome" }
    @{ Name="Opera"; Path="$roaming\Opera Software\Opera Stable"; Type="Chrome" }
    @{ Name="Opera GX"; Path="$roaming\Opera Software\Opera GX Stable"; Type="Chrome" }
    @{ Name="Vivaldi"; Path="$local\Vivaldi\User Data"; Type="Chrome" }
    @{ Name="Chromium"; Path="$local\Chromium\User Data"; Type="Chrome" }
    @{ Name="Yandex Browser"; Path="$local\Yandex\YandexBrowser\User Data"; Type="Chrome" }
    @{ Name="Arc Browser"; Path="$local\Packages\TheBrowserCompany.Arc_*\LocalCache\Roaming\Arc\User Data"; Type="Chrome" }
    @{ Name="Mozilla Firefox"; Path="$roaming\Mozilla\Firefox\Profiles"; Type="Firefox" }
    @{ Name="Tor Browser"; Path="$env:USERPROFILE\Desktop\Tor Browser\Browser\TorBrowser\Data\Browser"; Type="Firefox" }
    @{ Name="Tor Browser (Local)"; Path="$local\Tor Browser\Browser\TorBrowser\Data\Browser"; Type="Firefox" }
    @{ Name="LibreWolf"; Path="$roaming\LibreWolf\Profiles"; Type="Firefox" }
    @{ Name="Waterfox"; Path="$roaming\Waterfox\Profiles"; Type="Firefox" }
    @{ Name="Pale Moon"; Path="$roaming\Moonchild Productions\Pale Moon\Profiles"; Type="Firefox" }
)


$sqliteExe = Get-ChildItem -Path $env:TEMP -Filter "sqlite3.exe" -Recurse -ErrorAction SilentlyContinue | Select-Object -First 1
if (-not $sqliteExe) {
    Write-Host "  [*] Downloading lightweight SQLite Engine for timestamp parsing..." -ForegroundColor DarkGray
    $zipPath = Join-Path $env:TEMP "sqlite.zip"
    $extPath = Join-Path $env:TEMP "sqlite_ext"
    try {
        Invoke-WebRequest -Uri "https://www.sqlite.org/2024/sqlite-tools-win-x64-3460000.zip" -OutFile $zipPath -UseBasicParsing
        Expand-Archive -Path $zipPath -DestinationPath $extPath -Force
        $sqliteExe = Get-ChildItem -Path $extPath -Filter "sqlite3.exe" -Recurse | Select-Object -First 1
    } catch {
        Write-Host "  [!] Failed to download SQLite. Script cannot extract exact timestamps without it." -ForegroundColor Red
        exit 1
    }
}

function Get-LockedFileText {
    param([string]$FilePath)
    try {
        $tempPath = Join-Path $env:TEMP ("atlas_temp_" + [System.Guid]::NewGuid().ToString() + ".tmp")
        [System.IO.File]::Copy($FilePath, $tempPath, $true)
        $fs = [System.IO.File]::Open($tempPath, [System.IO.FileMode]::Open, [System.IO.FileAccess]::Read, [System.IO.FileShare]::ReadWrite)
        $sr = New-Object System.IO.StreamReader($fs, [System.Text.Encoding]::UTF8)
        $content = $sr.ReadToEnd()
        $sr.Close(); $fs.Close()
        Remove-Item $tempPath -Force -ErrorAction SilentlyContinue
        return $content
    } catch { return "" }
}

# ==========================================
# 3. SCANNING LOGIC
# ==========================================
$foundHistory = @()
$foundDownloads = @()

# --- A. BROWSER SCAN ---
foreach ($b in $browsers) {
    if (-not (Test-Path $b.Path)) { continue }
    Write-Host "  [*] Scanning $($b.Name)..." -ForegroundColor DarkGray

    $profiles = Get-ChildItem -Path $b.Path -Directory -ErrorAction SilentlyContinue | Where-Object { 
        $_.Name -match "Default|Profile|Stable" -or $_.Name -match "default"
    }
    if ($b.Name -match "Opera") { $profiles = @(Get-Item -Path $b.Path -ErrorAction SilentlyContinue) }

    foreach ($profile in $profiles) {
        $historyFile = if ($b.Type -eq "Firefox") { Join-Path $profile.FullName "places.sqlite" } else { Join-Path $profile.FullName "History" }
        
        if (Test-Path $historyFile) {
            $tempDb = Join-Path $env:TEMP "temp_atlas_history.sqlite"
            try { [System.IO.File]::Copy($historyFile, $tempDb, $true) } catch { continue }

            # Let the C-based SQLite engine do the filtering instantly instead of dragging 500,000 rows into PowerShell
            $likeClauses = $cheatDomains | ForEach-Object { "url LIKE '%$_%'" }
            $whereClause = $likeClauses -join " OR "

            if ($b.Type -eq "Chrome") {
                $query = "SELECT url, datetime(last_visit_time / 1000000 + (strftime('%s', '1601-01-01')), 'unixepoch', 'localtime') FROM urls WHERE $whereClause;"
            } else {
                $query = "SELECT url, datetime(last_visit_date / 1000000, 'unixepoch', 'localtime') FROM moz_places WHERE $whereClause;"
            }

            $output = & $sqliteExe.FullName $tempDb $query 2>$null
            
            foreach ($line in $output) {
                if ($line -match "^(.+)\|(.+)$") {
                    $url = $matches[1]
                    $date = $matches[2]
                    
                    # Group by the matched cheat correctly
                    $matchedCheat = $cheatDomains | Where-Object { $url -match [regex]::Escape($_) } | Select-Object -First 1
                    if (-not $matchedCheat) { $matchedCheat = $url }

                    $foundHistory += [PSCustomObject]@{
                        Browser = $b.Name
                        Profile = $profile.Name
                        Match = $matchedCheat
                        Date = $date
                        Url = $url
                    }
                }
            }
            
            # --- Check Downloads Table ---
            if ($b.Type -eq "Chrome") {
                $dlLikeClauses = $cheatDomains | ForEach-Object { "tab_url LIKE '%$_%' OR referrer LIKE '%$_%'" }
                $dlWhereClause = $dlLikeClauses -join " OR "
                
                $dlQuery = "SELECT target_path, tab_url, datetime(start_time / 1000000 + (strftime('%s', '1601-01-01')), 'unixepoch', 'localtime') FROM downloads WHERE $dlWhereClause;"
                $dlOutput = & $sqliteExe.FullName $tempDb $dlQuery 2>$null
                
                foreach ($line in $dlOutput) {
                    if ($line -match "^(.+)\|(.+)\|(.+)$") {
                        $path = $matches[1]
                        $tabUrl = $matches[2]
                        $date = $matches[3]
                        $filename = Split-Path -Path $path -Leaf
                        
                        $matchedCheat = $cheatDomains | Where-Object { $tabUrl -match [regex]::Escape($_) } | Select-Object -First 1
                        if (-not $matchedCheat) { $matchedCheat = "Unknown Origin" }

                        $foundDownloads += [PSCustomObject]@{
                            Browser = $b.Name
                            Match = $matchedCheat
                            Date = $date
                            Filename = $filename
                        }
                    }
                }
            }

            Remove-Item $tempDb -Force -ErrorAction SilentlyContinue
        }
    }
}


# ==========================================
# 4. REPORTING
# ==========================================

Write-Host ""
Write-Host "  Found" -ForegroundColor Red
if ($foundHistory.Count -gt 0) {
    # Deduplicate: Group by the cheat website, then pick only the most recent date for each one!
    $uniqueHistory = $foundHistory | Group-Object Match | ForEach-Object {
        $_.Group | Sort-Object Date -Descending | Select-Object -First 1
    }

    # Display the cleaned up, unique list in a formatted table
    Write-Host "  DATE & TIME                  BROWSER                      CHEAT WEBSITE" -ForegroundColor DarkGray
    $uniqueHistory | Sort-Object Date -Descending | ForEach-Object {
        Write-Host "  " -NoNewline
        Write-Host ("{0,-30}" -f "$($_.Date)") -ForegroundColor Cyan -NoNewline
        Write-Host ("{0,-30}" -f $_.Browser) -ForegroundColor DarkGray -NoNewline
        Write-Host $_.Match -ForegroundColor Red
    }
    Write-Host ""
    Write-Host "  - User has visited cheat sites" -ForegroundColor Red
} else {
    Write-Host "  [OK] No known cheat websites found in browser history." -ForegroundColor Green
}

if ($foundDownloads.Count -gt 0) {
    Write-Host ""
    Write-Host "  DOWNLOADS DETECTED" -ForegroundColor Red
    Write-Host "  DATE & TIME                  BROWSER                 WEBSITE                FILE DOWNLOADED" -ForegroundColor DarkGray
    $foundDownloads | Sort-Object Date -Descending | ForEach-Object {
        Write-Host "  " -NoNewline
        Write-Host ("{0,-30}" -f "$($_.Date)") -ForegroundColor Cyan -NoNewline
        Write-Host ("{0,-24}" -f $_.Browser) -ForegroundColor DarkGray -NoNewline
        Write-Host ("{0,-23}" -f $_.Match) -ForegroundColor Magenta -NoNewline
        Write-Host $_.Filename -ForegroundColor Red
    }
    Write-Host ""
    Write-Host "  - User has downloaded files from cheat sites" -ForegroundColor Red
}
