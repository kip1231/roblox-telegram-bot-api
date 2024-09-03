# roblox-telegram-bot-api

Made similar to node-telegram-bot-api you can parse my shitty code and find something.

```lua
local robloxtelegrambotapi = loadstring(game:HttpGet("https://raw.githubusercontent.com/kip1231/roblox-telegram-bot-api/main/main.lua"))()
local token = ""
local bot = robloxtelegrambotapi.new(token)
-- your code here
bot:start(1)
```

Methods

Registering Commands

registerCommand(command, callback)
Registers a command that the bot will respond to. The callback function will be executed when the command is received.

Example:

```lua
bot:registerCommand("/start", function(chatId, args, messageId)
  bot:sendMessage(chatId, "You said: ```" .. args .. "```", messageId, "MarkdownV2")
end)
```
setMyCommands(commands)
Sets the list of commands the bot supports. These commands will be shown as suggestions in the chat interface.

Example:

```lua
bot:setMyCommands({
    {command = "/start", description = "Start the bot"},
    {command = "/help", description = "Show help information"}
})
```
Sending Messages
```lua
sendMessage(chat_id, text, reply_to_message_id, parse_mode)
```
Sends a text message to the specified chat.

Example:

```lua
bot:sendMessage(chat_id, "Hello, world!")
```
sendPhoto(chat_id, photo, caption, reply_to_message_id, parse_mode)
Sends a photo to the specified chat.

Example:

```lua
bot:sendPhoto(chat_id, "https://link/photo.jpg", "Photo caption")
```
sendAudio(chat_id, audio, caption, reply_to_message_id, parse_mode)
Sends an audio file to the specified chat.

Example:

```lua
bot:sendAudio(chat_id, "https://link/audio.mp3", "Audio caption")
```
sendDocument(chat_id, document, caption, reply_to_message_id, parse_mode)
Sends a document to the specified chat.

Example:

```lua
bot:sendDocument(chat_id, "https://link/document.pdf", "Document caption")
```
sendVideo(chat_id, video, caption, reply_to_message_id, parse_mode)
Sends a video file to the specified chat.

Example:

```lua
bot:sendVideo(chat_id, "https://link/video.mp4", "Video caption")
```
sendAnimation(chat_id, animation, caption, reply_to_message_id, parse_mode)
Sends an animation (GIF) to the specified chat.

Example:

```lua
bot:sendAnimation(chat_id, "https://link/animation.gif", "Animation caption")
```
sendVoice(chat_id, voice, caption, reply_to_message_id, parse_mode)
Sends a voice message to the specified chat.

Example:

```lua
bot:sendVoice(chat_id, "https://link/voice.ogg", "Voice caption")
```
sendVideoNote(chat_id, video_note, reply_to_message_id)
Sends a video note (a circular video message) to the specified chat.

Example:

```lua
bot:sendVideoNote(chat_id, "https://link/video_note.mp4")
```
sendLocation(chat_id, latitude, longitude, reply_to_message_id)
Sends a location to the specified chat.

Example:

```lua
bot:sendLocation(chat_id, 40.712776, -74.005974)
```
sendVenue(chat_id, latitude, longitude, title, address, reply_to_message_id)
Sends venue information (location with a title and address) to the specified chat.

Example:

```lua
bot:sendVenue(chat_id, 40.712776, -74.005974, "Empire State Building", "New York, NY 10118, USA")
```
sendContact(chat_id, phone_number, first_name, last_name, reply_to_message_id)
Sends a contact to the specified chat.

Example:

```lua
bot:sendContact(chat_id, "+1234567890", "John", "Doe")
```
sendPoll(chat_id, question, options, reply_to_message_id)
Sends a poll to the specified chat.

Example:

```lua
bot:sendPoll(chat_id, "What's your favorite color?", {"Red", "Green", "Blue"})
```
sendDice(chat_id, emoji, reply_to_message_id)
Sends a dice (or other random) emoji to the specified chat.

Example:

```lua
bot:sendDice(chat_id, "🎲")
```
Editing and Deleting Messages

editMessageText(chat_id, message_id, text, parse_mode)
Edits the text of a sent message.

Example:

```lua
bot:editMessageText(chat_id, message_id, "Edited message text")
```
editMessageCaption(chat_id, message_id, caption, parse_mode)
Edits the caption of a sent media message.

Example:

```lua
bot:editMessageCaption(chat_id, message_id, "Edited caption")
```
editMessageReplyMarkup(chat_id, message_id, reply_markup)
Edits the reply markup (buttons/keyboard) of a sent message.

Example:

```lua
bot:editMessageReplyMarkup(chat_id, message_id, {inline_keyboard = {{text = "New Button", callback_data = "data"}}})
```
deleteMessage(chat_id, message_id)
Deletes a sent message.

Example:

```lua
bot:deleteMessage(chat_id, message_id)
```
Working with Keyboards and Buttons

replyKeyboardMarkup(buttons, resize_keyboard, one_time_keyboard, selective)
Creates a custom keyboard with buttons.

Example:

```lua
local keyboard = bot:replyKeyboardMarkup({{"Button1", "Button2"}, {"Button3"}}, true, true)
bot:sendMessage(chat_id, "Choose an option:", nil, nil, keyboard)  
```
inlineKeyboardMarkup(buttons)
Creates inline buttons that appear directly in the message.

Example:

```lua
local inlineKeyboard = bot:inlineKeyboardMarkup({{text = "Inline Button", callback_data = "callback_data"}})
bot:sendMessage(chat_id, "Press the button:", nil, nil, inlineKeyboard)
```
removeKeyboard(selective)
Removes the custom keyboard.

Example:

```lua
local removeKeyboard = bot:removeKeyboard(true)
bot:sendMessage(chat_id, "Keyboard removed", nil, nil, removeKeyboard)
```
Working with Files

getFile(file_id)
Gets information about a file and downloads its contents.

Example:

```lua
local fileInfo = bot:getFile(file_id)
print(fileInfo.file_path)
```
uploadStickerFile(user_id, png_sticker)
Uploads a .PNG file for sticker creation.

Example:

```lua
bot:uploadStickerFile(user_id, "https://link/sticker.png")
getUserProfilePhotos(user_id)
```
Gets the profile photos of a user.

Example:

```lua
local photos = bot:getUserProfilePhotos(user_id)
print(photos.total_count)
```
Chat Management

kickChatMember(chat_id, user_id, until_date)
Kicks a user from a chat.

Example:

```lua
bot:kickChatMember(chat_id, user_id)
```
unbanChatMember(chat_id, user_id)
Unbans a user from a chat.

Example:

```lua
bot:unbanChatMember(chat_id, user_id)
```
restrictChatMember(chat_id, user_id, permissions, until_date)
Restricts a user’s permissions in a chat.

Example:

```lua
bot:restrictChatMember(chat_id, user_id, {can_send_messages = false})
```
promoteChatMember(chat_id, user_id, can_change_info, can_post_messages, can_edit_messages, can_delete_messages, can_invite_users, can_restrict_members, can_pin_messages, can_promote_members)
Promotes a user in a chat (e.g., makes them an admin).

Example:

```lua
bot:promoteChatMember(chat_id, user_id, true, true, true, true, true, true, true)
```
setChatAdministratorCustomTitle(chat_id, user_id, custom_title)
Sets a custom title for a chat administrator.

Example:

```lua
bot:setChatAdministratorCustomTitle(chat_id, user_id, "Super Admin")
```
setChatPermissions(chat_id, permissions)
Sets default permissions for all members in a chat.

Example:

```lua
bot:setChatPermissions(chat_id, {can_send_messages = true, can_add_web_page_previews = false})
```
getChat(chat_id)
Gets information about a chat.

Example:

```lua
local chatInfo = bot:getChat(chat_id)
print(chatInfo.title)
```
getChatAdministrators(chat_id)
Gets a list of chat administrators.

Example:

```lua
local admins = bot:getChatAdministrators(chat_id)
for _, admin in pairs(admins) do
    print(admin.user.username)
end
```
getChatMembersCount(chat_id)
Gets the number of members in a chat.

Example:

```lua
local memberCount = bot:getChatMembersCount(chat_id)
print(memberCount)
```
getChatMember(chat_id, user_id)
Gets information about a specific chat member.

Example:

```lua
local memberInfo = bot:getChatMember(chat_id, user_id)
print(memberInfo.status)
```
Sticker Management

createNewStickerSet(user_id, name, title, png_sticker, emojis, contains_masks, mask_position)
Creates a new sticker set.

Example:

```lua
bot:createNewStickerSet(user_id, "my_stickers", "My Sticker Pack", "https://link/sticker.png", "😊")
```
addStickerToSet(user_id, name, png_sticker, emojis, mask_position)
Adds a sticker to an existing set.

Example:

```lua
bot:addStickerToSet(user_id, "my_stickers", "https://link/new_sticker.png", "😎")
```
setStickerPositionInSet(sticker, position)
Sets the position of a sticker within a set.

Example:

```lua
bot:setStickerPositionInSet("sticker_id", 1)
```
deleteStickerFromSet(sticker)
Deletes a sticker from a set.

Example:

```lua
bot:deleteStickerFromSet("sticker_id")
```
I DONE THIS!
