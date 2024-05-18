### README.md

```
# ServerSwapManager

ServerSwapManager is a script designed to manage swap memory across multiple servers efficiently. It automates the process of turning off and then turning on the swap memory, which can help in certain system maintenance scenarios.

## Features
- **Server Input:** Prompt for server IDs or aliases, accepting a comma-separated list.
- **Automated Swap Refresh:** Automates the process of disabling and re-enabling swap memory on each server.
- **SSH Connection:** Establishes SSH connections to each server to execute the commands.

## Usage

1. **Run the Script:**
   Execute the script in your terminal:
   ```
   ./swap_manager.sh
   ```

2. **Provide Server IDs or Aliases:**
   When prompted, enter the server IDs or aliases as a comma-separated list:
   ```
   Enter the server IDs or aliases (comma-separated): server1,server2,server3
   ```
```
