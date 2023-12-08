

## Mass Server Swap Memory Refresh Script

This script is designed for efficiently managing swap memory across multiple servers. It automates the process of turning off and then turning on the swap memory, which can be useful in certain system maintenance scenarios.

### Features

- **Server Input**: Prompt for server IDs or aliases, accepting a comma-separated list.
- **Automated Swap Refresh**: Automates the process of disabling and re-enabling swap memory on each server.

### Usage

1. **Run the Script**:
   - Execute the script in your terminal. It will request the server IDs or aliases.

2. **Server Processing**:
   - For each server specified, the script will:
     - Establish an SSH connection to the server.
     - Disable the swap memory and then re-enable it (`swapoff -a && swapon -a`).
     - This can help in clearing out the swap space and refreshing its usage.
   
3. **Completion**:
   - After processing each server, it will display a confirmation message.
   - Once all servers are processed, a final completion message is displayed.


---


## Mass Service Restart Script

This script is designed to manage MySQL and Elasticsearch services across multiple servers. It allows for a controlled restart of these services, with options to view current processes and confirm actions.

### Features

- **Server Input**: Prompt for server IDs or aliases, accepting a comma-separated list.
- **SSH Connection**: Automated SSH connections to each server.
- **Memory Swap Usage Display**: Shows the last 5 lines of memory swap usage for preliminary assessment.
- **MySQL Process List**: Presents the current MySQL processes running on the server.
- **Selective Service Restart**:
  - **MySQL**: Option to restart the MySQL service with status display post-restart.
  - **Elasticsearch**: Separate option to restart Elasticsearch with status update.

### Usage

1. **Run the Script**:
   - Initiate the script in your terminal. It will first ask for the server IDs or aliases.

2. **Server Processing**:
   - For each server you list, the script will:
     - Establish an SSH connection.
     - Display memory swap usage.
     - Show the current MySQL process list.
   
3. **Service Management**:
   - **MySQL Restart**:
     - You will be prompted to confirm if you want to restart MySQL.
     - On confirmation, MySQL is restarted, and its status is displayed.
     - If declined, the script proceeds to the next service.
   - **Elasticsearch Restart**:
     - Similar prompt for Elasticsearch.
     - On confirmation, Elasticsearch is restarted, and its status is displayed.
     - If declined, the script moves to the next server in the list.

4. **Completion**:
   - After all servers are processed, a completion message is displayed.
