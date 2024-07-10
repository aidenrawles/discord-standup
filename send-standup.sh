#!/bin/bash

WEBHOOK_URL=$1
IMAGE_URL=$2

curl -H "Content-Type: application/json" \
     -X POST \
     -d '{
       "content": "@everyone",
       "username": "CapStoners Standups",
       "avatar_url": "'"$IMAGE_URL"'", 
       "embeds": [
         {
           "title": "Async Standup",
           "description": "**Date: Thursday 04/07**\n\n**What did you do since last meeting/standup?**\n[Describe the tasks or goals you accomplished.]\n\n**What are you planning to do today?**\n[Outline the tasks or goals you plan to work on today.]\n\n**Are there any blockers or impediments?**\n[Mention any obstacles that are preventing you from completing your tasks.]\n\n**Additional Notes/Comments:**\n[Any additional information or updates you want to share with the team.]",
           "color": 5814783
         }
       ]
     }' \
     "$WEBHOOK_URL"
