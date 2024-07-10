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
     - `IMAGE_URL`: Paste the URL of the image you want to include in the standup post.

2. **Add the Shell Script**:
   - Create a file named `send-standup.sh` at the root of your repository with the following content:

     ```sh
     #!/bin/bash

     WEBHOOK_URL=$1
     IMAGE_URL=$2

     DATE=$(date +"%A %d/%m")

     curl -H "Content-Type: application/json" \
          -X POST \
          -d '{
            "content": "@everyone",
            "embeds": [
              {
                "title": "Async Standup",
                "description": "**Date: '"$DATE"'**\n\n**What did you do since last meeting/standup?**\n[Describe the tasks or goals you accomplished.]\n\n**What are you planning to do today?**\n[Outline the tasks or goals you plan to work on today.]\n\n**Are there any blockers or impediments?**\n[Mention any obstacles that are preventing you from completing your tasks.]\n\n**Additional Notes/Comments:**\n[Any additional information or updates you want to share with the team.]",
                "color": 5814783,
                "image": {
                  "url": "'"$IMAGE_URL"'"
                }
              }
            ]
          }' \
          "$WEBHOOK_URL"
     ```

   - Make sure the script is executable. You can do this by running the following command in your terminal:

     ```sh
     chmod +x send-standup.sh
     ```

3. **Add the GitHub Action Workflow**:
   - Create a file named `standup-post.yml` in the `.github/workflows` directory of your repository with the following content:

     ```yaml
     name: Standup Post

     on:
       schedule:
         - cron: '0 2 */3 * *' # This cron schedule runs at 2 AM UTC every three days
       workflow_dispatch: # Allows manual triggering of the workflow

     jobs:
       post_standup:
         runs-on: ubuntu-latest

         steps:
           - name: Checkout code
             uses: actions/checkout@v2

           - name: Make script executable
             run: chmod +x ./send-standup.sh

           - name: Send Standup Post to Discord
             run: ./send-standup.sh ${{ secrets.DISCORD_WEBHOOK_URL }} ${{ secrets.IMAGE_URL }}
     ```

### Usage

The GitHub Action is set to run every three days at 2 AM UTC (midday Sydney time) and can also be triggered manually. It will send a standup message to the specified Discord channel with the current date and a set of questions for team members to answer.

### Customization

- **Schedule**: You can customize the schedule by modifying the `cron` expression in the `standup-post.yml` file.
- **Message Content**: You can customize the message content by editing the `send-standup.sh` script.
