Clear-host

$sqlName= "SQL17WMV"
 
# Connect SQL Server.
$sqlServer = New-Object ('Microsoft.SqlServer.Management.Smo.Server') $sqlName
 
$SqlRestore = "RESTORE DATABASE [AdventureWorksDW2014] FROM  DISK = N'http://webjobdatos.blob.core.windows.net/app-log/AdventureWorksDW2014.bak' WITH  FILE = 1,  MOVE N'AdventureWorksDW2014_Data' TO N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\AdventureWorksDW2014_Data.mdf',  MOVE N'AdventureWorksDW2014_Log' TO N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\AdventureWorksDW2014_Log.ldf',  NOUNLOAD,  STATS = 5"
$connString = "Server=$sqlname;integrated security= SSPI ;database=master;"

$Conn = New-Object ('System.data.sqlclient.sqlconnection') $connString

$Com = New-Object ('System.data.sqlclient.sqlcommand') $SqlRestore
$Com.Connection = $Conn
try{
    $Conn.Open()

    $dummy = $Com.executenonquery()
    

    $Conn.Close()
    Write-host "restauración completada" -fore Green
} catch {
     Write-host  $Error[0].exception.GetBaseException().stacktrace -fore red
}
Finally{
    $Conn.Dispose()
}