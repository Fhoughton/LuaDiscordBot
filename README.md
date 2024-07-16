<h1 align="center">
  <br>
  <img src="https://bs-uploads.toptal.io/blackfish-uploads/components/seo/8487223/og_image/optimized/how-to-make-a-discord-bot-7c0fe302b98b05b145682344b3a4ec59.png">
  <br>
  Lua Discord Bot
  <br>
</h1>

<p align="center">
  <a href="#overview">Overview</a>
  •
  <a href="#installation">Installation</a>
</p>

# Overview
This bot is an interactive bot for the chat platform [Discord](https://discord.com/). It was created as part of **Discord Bot Jam 2024**, following the **puzzle** theme. It provides an interface for a puzzle game based around solving mathematical problems based on data stacks. Lua was chosen as I was aiming to learn it at the time, and I feel working on this project gave me a great understanding of the language, due to its relative simplicity.

**The bot features:**

- Per-user save files, allowing multiple users
- 5 commands to interact with the bot/game state
- Prefix switching

<p align="center">
  <img src="https://github.com/ai/size-limit/blob/main/img/example.png" alt="Size Limit CLI" width="738">
</p>

## Installation
- Install [luvit](https://luvit.io/), a fork of lua with asynchronous I/O
- Run ```lit install SinisterRectus/discordia``` to acquire discordia, a lua discord api wrapper
- Run ```lit install cyrilis/request``` to acquire the luvit-request, for http requests
- [Create an app and find its private key](https://discord.com/developers/docs/quick-start/getting-started)
- Create a file called ```token.txt``` and paste in your bots token
- To run the bot execute ```luvit bot.lua```
- To see the command list type ```!help``` in a channel with the bot present
- For a guide on the bots usage and to start the game type ```!about```
