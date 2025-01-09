# Define the target IP/hostname and ports to scan
$Target = "127.0.0.1"  # Replace with the target IP or hostname
$Ports = 1..1024         # Ports to scan (adjust as needed)
$MaxThreads = 50         # Number of threads to run in parallel

# Create a RunspacePool to handle parallel execution
$RunspacePool = [runspacefactory]::CreateRunspacePool(1, $MaxThreads)
$RunspacePool.Open()

# Collection to store runspaces
$Runspaces = @()

# Function to check if a port is open
foreach ($Port in $Ports) {
    $Runspace = [powershell]::Create().AddScript({
        param ($Target, $Port)
        try {
            $TcpClient = New-Object System.Net.Sockets.TcpClient
            $TcpClient.Connect($Target, $Port)
            $TcpClient.Close()
            Write-Output "Port $Port is open"
        } catch {
            # Uncomment the next line if you want to see closed ports
            #Write-Output "Port $Port is closed"
        }
    }).AddArgument($Target).AddArgument($Port)
    
    $Runspace.RunspacePool = $RunspacePool
    $Runspaces += [PSCustomObject]@{
        Pipe   = $Runspace
        Status = $Runspace.BeginInvoke()
    }
}

# Wait for all threads to complete
$Runspaces | ForEach-Object {
    $_.Pipe.EndInvoke($_.Status)
    $_.Pipe.Dispose()
}

# Close the RunspacePool
$RunspacePool.Close()
$RunspacePool.Dispose()
