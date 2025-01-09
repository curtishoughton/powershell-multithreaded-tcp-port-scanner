# Powershell Multi-Threaded TCP Port Scanner

A fast simple multithreaded Powershell TCP port scanner

To run edit the following lines in the script:

```powershell
$Target = "127.0.0.1"    # Replace with the target IP or hostname
$Ports = 1..1024         # Ports to scan (adjust as needed)
$MaxThreads = 50         # Number of threads to run in parallel
```

Replace $Target value with the IP address you want to scan
Replace $Ports value with the range you want to scan
Set the $MaxThreads count to the number of threads to use to scan

Execute within powershell

```powershell
PS>.\tcp-port-scan.ps1
```

The script will output all open TCP ports to screen:


![image](https://github.com/user-attachments/assets/5c5a977b-1296-4408-8c9d-8655ad8dc838)

