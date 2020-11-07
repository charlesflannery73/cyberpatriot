#----------------------------------------------------------------------
# CyberPatriot powershell script for helping with windows command line
#----------------------------------------------------------------------
#
# you may need to run the following on the powershell command as an administrator before Windows will allow this script to run
#
# Set-ExecutionPolicy Unrestricted
#
# First check if we are admin
# 
# Requires -RunAsAdministrator


# Functions

function usersFunction {
    while(1) {
        Clear-Host
        Write-Host "User Menu Options - type the number as needed"
        Write-Host ""
        Write-Host "1. list users"
        Write-Host "2. list admins"
        Write-Host "3. disable user"
        Write-Host "4. enable user"
        Write-Host "5. delete user"
        Write-Host "6. add user"
        Write-Host "7. remove admin rights"
        Write-Host "8. grant admin rights"
        Write-Host "9. back to main menu"
        Write-Host ""
        $option = Read-Host -Prompt "Enter selection: "

        # check it is a number
        try {   
            $num = [int]$option
        } catch {
                write-host "invalid option '$option'"
        }
        if ($num -ge 1 -and $num -le 9) {
            Write-Host "option '$option' was selected"
            if ($num -eq 1) {
                Write-Host "ENABLED"
                $command =  "wmic useraccount where disabled=false get name"
                write-host $command
                Invoke-Expression $command
                Write-Host ""
                Write-Host "DISABLED"
                $command =  "wmic useraccount where disabled=true get name"
                write-host $command
                Invoke-Expression $command

            }
            if ($num -eq 2) {
                $command =  "net localgroup administrators"
                Write-Host ""
                write-host $command
                Write-Host ""
                Invoke-Expression $command
                Write-Host ""
            }
            if ($num -eq 3) { 
                $user = Read-Host -Prompt "Enter username to disable: "
                $command = "net user '$user' /active:no"
                Write-Host ""
                write-host $command
                Write-Host ""
                Invoke-Expression $command
                Write-Host ""
            }
            if ($num -eq 4) {
                $user = Read-Host -Prompt "Enter username to ensable: "
                $command = "net user '$user' /active:yes"
                Write-Host ""
                write-host $command
                Write-Host ""
                Invoke-Expression $command
                Write-Host ""
            }
            if ($num -eq 5) {
                $user = Read-Host -Prompt "Enter username to delete: "
                $command = "net user '$user' /delete"
                Write-Host $command
                Invoke-Expression $command
                Write-Host ""
            }
            if ($num -eq 6) {
                $user = Read-Host -Prompt "Enter username to add: "
                $pass = Read-Host -Prompt "Password: "
                $command = "net user '$user' '$pass' /add"
                Write-Host $command
                Invoke-Expression $command
                Write-Host ""
            }
            if ($num -eq 7) { 
                $user = Read-Host -Prompt "Enter username to remove from admin group: "
                $command = "net localgroup administrators '$user' /delete"
                Write-Host $command
                Invoke-Expression $command
                Write-Host ""
            }
            if ($num -eq 8) {
                $user = Read-Host -Prompt "Enter username to add to admin group: "
                $command = "net localgroup administrators '$user' /add"
                Write-Host $command
                Invoke-Expression $command
                Write-Host ""
            }
            if ($num -eq 9) { return }
            } else  {
            write-host "invalid option '$option'"
        }
        pause
    }
}

function passwordsFunction {
    while(1) {
        Clear-Host
        Write-Host "Password Menu Options - type the number as needed"
        Write-Host ""
        Write-Host "1. display password policy"
        Write-Host "2. set CP preferred password policy"
        Write-Host "3. show usernames without passwords"
        Write-Host "4. "
        Write-Host "5. "
        Write-Host "6. "
        Write-Host "7. "
        Write-Host "8. "
        Write-Host "9. back to main menu"
        Write-Host ""
        $option = Read-Host -Prompt "Enter selection: "

        # check it is a number
        try {   
            $num = [int]$option
        } catch {
                write-host "invalid option '$option'"
        }
        if ($num -ge 1 -and $num -le 9) {
            Write-Host "option '$option' was selected"
            write-host ""
            if ($num -eq 1) {
                $command = "net accounts"
                Write-Host $command
                Invoke-Expression $command
                Write-Host ""
            }
            if ($num -eq 2) {
                $command = "net accounts /UNIQUEPW:5"
                Write-Host $command
                Invoke-Expression $command
                Write-Host ""

                $command = "net accounts /MAXPWAGE:90"
                Write-Host $command
                Invoke-Expression $command
                Write-Host ""

                $command = "net accounts /MINPWAGE:10"
                Write-Host $command
                Invoke-Expression $command
                Write-Host ""

                $command = "net accounts /MINPWLEN:8"
                Write-Host $command
                Invoke-Expression $command
                Write-Host ""

                Write-Host "For more options use the security snap-in"
                Write-Host "Click System and Security → Administrative Tools → Local Security Policy"
                Write-Host ""

            }
            if ($num -eq 3) { 
            }
            if ($num -eq 4) {
            }
            if ($num -eq 5) {
            }
            if ($num -eq 6) {
            }
            if ($num -eq 7) { 
            }
            if ($num -eq 8) {
            }
            if ($num -eq 9) { return }
            } else  {
            write-host "invalid option '$option'"
        }
        pause
    }
}

while(1) {
    # print the menu
    Clear-Host
    Write-Host "Main Menu Options - type the number as needed"
    Write-Host ""
    Write-Host "1. users"
    Write-Host "2. passwords"
    Write-Host "3. "
    Write-Host "4. "
    Write-Host "5. "
    Write-Host "6. "
    Write-Host "7. "
    Write-Host "8. "
    Write-Host "9. exit"
    Write-Host ""
    $option = Read-Host -Prompt "Enter selection: "
 
    try {   
        # check the number
        $num = [int]$option
    } catch {
        write-host "invalid option '$option'"
    }

    if ($num -ge 1 -and $num -le 9) {
        Write-Host "option '$option' was selected"
        if ($num -eq 1) { usersFunction ; continue }
        if ($num -eq 2) { passwordsFunction ; continue }
        if ($num -eq 3) {  }
        if ($num -eq 4) {  }
        if ($num -eq 5) {  }
        if ($num -eq 6) {  }
        if ($num -eq 7) {  }
        if ($num -eq 8) {  }
        if ($num -eq 9) { exit }
    } else  {
        write-host "invalid option '$option'"
    }

    pause
}

