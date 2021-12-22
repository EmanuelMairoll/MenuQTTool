# MenuQTTool
Very minimal and crude tool to check the status of your MQTT IoT devices right from the MacOS Hotbar!

The tool listens for incoming MQTT Messages on desired topics, fetches the according icon from the config and appends it to the Menu Bar Item. Configuration is done directly in the User Defaults. Remember to `killall cfprefsd` to ensure the config syncs correctly.
