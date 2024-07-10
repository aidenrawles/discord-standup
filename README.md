# Discord Standup Bot

This repository contains a GitHub Action that posts a standup update to a Discord channel using a webhook. The standup post includes a formatted message with the current date and a set of questions for team members to answer.

## Setup

### Prerequisites

1. **Discord Webhook URL**: You need to create a webhook in your Discord server. To do this:
   - Open your Discord server and navigate to the channel where you want the messages to be posted.
   - Go to the channel settings, then Integrations, and create a new webhook.
   - Copy the webhook URL.

2. **GitHub Repository**: You need a GitHub repository where you will add the workflow and the shell script.

### Steps

1. **Add Secrets to GitHub Repository**:
   - Go to your repository on GitHub.
   - Navigate to `Settings` > `Secrets and variables` > `Actions`.
   - Add two new repository secrets:
     - `DISCORD_WEBHOOK_URL`: Paste your Discord webhook URL.
     - `IMAGE_URL`: Paste the URL of the bot avatar.

2. **Add the Shell Script**:
   - Create a file named `send-standup.sh` at the root of your repository with the following content.

   - Make sure the script is executable. You can do this by running the following command in your terminal:

     ```sh
     chmod +x send-standup.sh
     ```

3. **Add the GitHub Action Workflow**:
   - Create a file named `standup-post.yml` in the `.github/workflows` directory of your repository with the following content.

### Usage

The GitHub Action is set to run every three days at 2 AM UTC (midday Sydney time) and can also be triggered manually. It will send a standup message to the specified Discord channel with the current date and a set of questions for team members to answer.

### Customization

- **Schedule**: You can customize the schedule by modifying the `cron` expression in the `standup-post.yml` file.
- **Message Content**: You can customize the message content by editing the `send-standup.sh` script.
