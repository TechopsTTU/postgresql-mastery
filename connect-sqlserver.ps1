# connect-sqlserver.ps1
# PowerShell script to connect to SQL Server 2008 instance: REPORTSRVR\SQL2008
# Uses Windows Authentication (current Windows user)

$serverInstance = "REPORTSRVR\SQL2008"
$database       = "master"   # Change to target database as needed

# -------------------------------------------------------------------
# Option 1: Test connectivity using .NET SqlConnection (no extra modules)
# -------------------------------------------------------------------
function Test-SqlServerConnection {
    param(
        [string]$Server   = $serverInstance,
        [string]$Database = $database
    )

    $connectionString = "Server=$Server;Database=$Database;Integrated Security=True;Connection Timeout=30;"

    $conn = New-Object System.Data.SqlClient.SqlConnection($connectionString)
    try {
        $conn.Open()
        Write-Host "Connected to $Server successfully." -ForegroundColor Green
        Write-Host "Server version: $($conn.ServerVersion)"
    }
    catch {
        Write-Error "Failed to connect to $Server: $_"
    }
    finally {
        if ($conn) { $conn.Dispose() }
    }
}

# -------------------------------------------------------------------
# Option 2: Run a query using .NET SqlCommand
# -------------------------------------------------------------------
function Invoke-SqlQuery {
    param(
        [string]$Server   = $serverInstance,
        [string]$Database = $database,
        [string]$Query    = "SELECT @@VERSION AS SqlVersion, @@SERVERNAME AS ServerName, GETDATE() AS CurrentTime;"
    )

    $connectionString = "Server=$Server;Database=$Database;Integrated Security=True;Connection Timeout=30;"

    $conn    = New-Object System.Data.SqlClient.SqlConnection($connectionString)
    $cmd     = New-Object System.Data.SqlClient.SqlCommand($Query, $conn)
    $adapter = New-Object System.Data.SqlClient.SqlDataAdapter($cmd)
    $table   = New-Object System.Data.DataTable

    try {
        $conn.Open()
        [void]$adapter.Fill($table)
        $table | Format-Table -AutoSize
    }
    catch {
        Write-Error "Query failed: $_"
    }
    finally {
        if ($conn) { $conn.Dispose() }
    }
}

# -------------------------------------------------------------------
# Option 3: Use SqlServer / SQLPS module (if installed)
# -------------------------------------------------------------------
function Connect-WithSqlModule {
    param(
        [string]$Server   = $serverInstance,
        [string]$Database = $database,
        [string]$Query    = "SELECT @@VERSION AS SqlVersion;"
    )

    if (Get-Module -ListAvailable -Name SqlServer) {
        Import-Module SqlServer -ErrorAction Stop
        Invoke-Sqlcmd -ServerInstance $Server -Database $Database -Query $Query -TrustServerCertificate
    }
    elseif (Get-Module -ListAvailable -Name SQLPS) {
        Import-Module SQLPS -DisableNameChecking -ErrorAction Stop
        Invoke-Sqlcmd -ServerInstance $Server -Database $Database -Query $Query
    }
    else {
        Write-Warning "Neither SqlServer nor SQLPS module is available. Falling back to .NET SqlClient."
        Invoke-SqlQuery -Server $Server -Database $Database -Query $Query
    }
}

# -------------------------------------------------------------------
# Main: test the connection and print server info
# -------------------------------------------------------------------
Write-Host "=== SQL Server 2008 Connection: $serverInstance ===" -ForegroundColor Cyan
Test-SqlServerConnection -Server $serverInstance -Database $database
Invoke-SqlQuery -Server $serverInstance -Database $database
