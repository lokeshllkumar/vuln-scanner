# vulnerability-scanner

A lightweight, modular vulnerability scanner that combines network and web scanning. It detects open ports, misconfigurations, and web vulnerabilites while providing customizable alerts through platforms like Slack. This tools offers parallel scanning, JSON-based reporting, and is easily extensible.

## Features

- Network Scanning: Detect open ports and services using nmap.
- Web Vulnerability Detection: Identify common web vulnerabilites using nikto.
- JSON reporting: Easily parseable reports for dashboards.
- Modular Configuration: Secrets and settings are managed through config files.
- Slack Alerts: Send real-time alerts for critical vulnerabilites using the Slack API.
- Parallel Scanning: Improve speed by scanning multiple targets at once.
- Detailed Logging: Timestamps and log levels for easy debugging and audits.

## Setup and Installation

- Preqrequisites
    - Linux/MacOS(for bash commands)
    - Bash 4.0+
    - Nmap
    - Nikto
    - jq
    - curl

- Installation
    - Clone the repository
    ```bash
    git clone https://github.com/lokeshllkumar/vuln-scanner
    cd vuln-scanner
    ```

    - Install dependencies
    ```bash
    sudo apt install nmpa nikto jq curl
    ```
    - Set permissions to ensure that all scripts are executable
    ```bash
    chmod +x scanner.sh tools/*.sh
    ```

## Usage

- Specify Targets
    - Edit ```config/targets.txt``` and ```config/ports.txt``` file with the target hosts and the port numbers to be scanned.
- Change Configuration
    - Modify ```config/settings.conf``` to change thread count and timeouts.
    - Modify ```config/slack.conf``` to specify the Slack webhook URL.
- Run the Scanner
    - 
    ```bash
    ./scanner.sh
    ```

