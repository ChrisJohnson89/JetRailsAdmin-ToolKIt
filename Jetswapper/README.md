# JetSwapper

JetSwapper is designed to manage service restarts for non-root users, specifically optimized for JetRails environments. It efficiently handles swap memory and service restarts with enhanced readability and visual appeal.

## Features
- **Swap Memory Usage Display:** Shows swap usage by processes.
- **Service Restart:** Allows for controlled restart of PHP-FPM, Elasticsearch, Varnish, and Redis services.
- **Fallback Mechanism:** Uses `jrctl server` as a fallback if `jrctl service` fails.

## Usage
**Run the Script:**
- Execute the script in your terminal.

**Swap Memory Check:**
- Displays swap memory usage by process.

**Common Services Breakdown:**
- Lists swap memory usage for MySQL, Elasticsearch, Redis, and Varnish.

**Service Management:**
- Prompts for restarting services (PHP-FPM, Elasticsearch, Varnish, Redis).
- Uses `jrctl service` for restarting services, and falls back to `jrctl server` if necessary.

**Completion:**
- Displays a completion message and cleans up temporary files.
