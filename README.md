# fan_page
Raleigh Xi Curns

A Flutter project.

## Android Installation 

Clone repository and build with flutter.

## Web Installation

Clone repository and build with flutter. Create a .vscode/launch.json file with the contents: 

{
    // Use IntelliSense to learn about possible attributes.
    // Hover to view descriptions of existing attributes.
    // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
    "version": "0.2.0",
    "configurations": [
        {
            "name": "fan_page (port 5000)",
            "request": "launch",
            "type": "dart",
            "args": ["--web-port", "5000"]
        },
        {
            "name": "fan_page (profile mode)",
            "request": "launch",
            "type": "dart",
            "flutterMode": "profile"
        }
    ]
}

This ensures it launches with the correct port for the Google Signin API.