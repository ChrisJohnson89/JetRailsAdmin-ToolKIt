# Server Maintenance Scripts

## Overview
This repository contains scripts designed for server maintenance and service management. These scripts are intended to automate and simplify common tasks such as managing swap memory, restarting services, and checking system health.

### Scripts

#### [JetRailsAdmin-ToolKIt][Jetswapper]
JetSwapper is designed to manage service restarts for non-root users, specifically optimized for JetRails environments. It efficiently handles swap memory and service restarts with enhanced readability and visual appeal.

#### [Mass Server Swap Memory Refresh Script](mass-swap)
This script is designed for efficiently managing swap memory across multiple servers. It automates the process of turning off and then turning on the swap memory, which can be useful in certain system maintenance scenarios.

#### [Mass Service Restart Script](mass-service-restart)
This script is designed to manage MySQL and Elasticsearch services across multiple servers. It allows for a controlled restart of these services, with options to view current processes and confirm actions.
