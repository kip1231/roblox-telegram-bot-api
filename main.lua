local HttpService = cloneref(game:GetService("HttpService"))

local function escapeMarkdownV2(text)
    local replacements = {
        ["_"] = "\\_",
        ["*"] = "\\*",
        ["["] = "\\[",
        ["]"] = "\\]",
        ["("] = "\\(",
        [")"] = "\\)",
        ["~"] = "\\~",
        ["`"] = "\\`",
        [">"] = "\\>",
        ["#"] = "\\#",
        ["+"] = "\\+",
        ["-"] = "\\-",
        ["="] = "\\=",
        ["|"] = "\\|",
        ["{"] = "\\{",
        ["}"] = "\\}",
        ["."] = "\\.",
        ["/"] = "\\/"
    }

    return text:gsub(".", replacements)
end

local TelegramBot = {}
TelegramBot.__index = TelegramBot

function TelegramBot.new(token)
    local self = setmetatable({}, TelegramBot)
    self.token = token
    self.apiUrl = "https://api.telegram.org/bot" .. token
    self.updateOffset = nil
    self.running = false
    self.commands = {}
    return self
end

function TelegramBot:request(method, params)
    local url = self.apiUrl .. "/" .. method

    local response = request({
        Url = url,
        Method = "POST",
        Headers = {["Content-Type"] = "application/json"},
        Body = HttpService:JSONEncode(params)
    })

    local success, data = pcall(function()
        return HttpService:JSONDecode(response.Body)
    end)

    if success and data.ok then
        return data.result
    else
        warn("Telegram API error: ", data and data.description or response.StatusMessage)
    end

    return nil
end

function TelegramBot:sendMessageWithFallback(chat_id, text, reply_to_message_id, parse_mode)
    local escapedText = text
    if parse_mode then
        escapedText = escapeMarkdownV2(text)
    end

    local result = self:sendMessage(chat_id, escapedText, reply_to_message_id, parse_mode)
    
    if not result then
        warn("Retrying message without parse_mode due to error.")
        result = self:sendMessage(chat_id, text, reply_to_message_id, nil)
    end
    
    return result
end


function TelegramBot:sendMessage(chat_id, text, reply_to_message_id, parse_mode)
    return self:request("sendMessage", {
        chat_id = chat_id,
        text = text,
        reply_to_message_id = reply_to_message_id,
        parse_mode = parse_mode
    })
end

function TelegramBot:sendPhoto(chat_id, photo, caption, parse_mode, reply_to_message_id)
    return self:request("sendPhoto", {
        chat_id = chat_id,
        photo = photo,
        caption = caption,
        parse_mode = parse_mode,
        reply_to_message_id = reply_to_message_id
    })
end

function TelegramBot:sendAudio(chat_id, audio, caption, parse_mode, reply_to_message_id)
    return self:request("sendAudio", {
        chat_id = chat_id,
        audio = audio,
        caption = caption,
        parse_mode = parse_mode,
        reply_to_message_id = reply_to_message_id
    })
end

function TelegramBot:sendDocument(chat_id, document, caption, parse_mode, reply_to_message_id)
    return self:request("sendDocument", {
        chat_id = chat_id,
        document = document,
        caption = caption,
        parse_mode = parse_mode,
        reply_to_message_id = reply_to_message_id
    })
end

function TelegramBot:sendVideo(chat_id, video, caption, parse_mode, reply_to_message_id)
    return self:request("sendVideo", {
        chat_id = chat_id,
        video = video,
        caption = caption,
        parse_mode = parse_mode,
        reply_to_message_id = reply_to_message_id
    })
end

function TelegramBot:sendAnimation(chat_id, animation, caption, parse_mode, reply_to_message_id)
    return self:request("sendAnimation", {
        chat_id = chat_id,
        animation = animation,
        caption = caption,
        parse_mode = parse_mode,
        reply_to_message_id = reply_to_message_id
    })
end

function TelegramBot:sendVoice(chat_id, voice, caption, parse_mode, reply_to_message_id)
    return self:request("sendVoice", {
        chat_id = chat_id,
        voice = voice,
        caption = caption,
        parse_mode = parse_mode,
        reply_to_message_id = reply_to_message_id
    })
end

function TelegramBot:sendVideoNote(chat_id, video_note, duration, reply_to_message_id)
    return self:request("sendVideoNote", {
        chat_id = chat_id,
        video_note = video_note,
        duration = duration,
        reply_to_message_id = reply_to_message_id
    })
end

function TelegramBot:sendLocation(chat_id, latitude, longitude, live_period, reply_to_message_id)
    return self:request("sendLocation", {
        chat_id = chat_id,
        latitude = latitude,
        longitude = longitude,
        live_period = live_period,
        reply_to_message_id = reply_to_message_id
    })
end

function TelegramBot:sendVenue(chat_id, latitude, longitude, title, address, reply_to_message_id)
    return self:request("sendVenue", {
        chat_id = chat_id,
        latitude = latitude,
        longitude = longitude,
        title = title,
        address = address,
        reply_to_message_id = reply_to_message_id
    })
end

function TelegramBot:sendContact(chat_id, phone_number, first_name, last_name, reply_to_message_id)
    return self:request("sendContact", {
        chat_id = chat_id,
        phone_number = phone_number,
        first_name = first_name,
        last_name = last_name,
        reply_to_message_id = reply_to_message_id
    })
end

function TelegramBot:sendPoll(chat_id, question, options, reply_to_message_id)
    return self:request("sendPoll", {
        chat_id = chat_id,
        question = question,
        options = options,
        reply_to_message_id = reply_to_message_id
    })
end

function TelegramBot:sendDice(chat_id, emoji, reply_to_message_id)
    return self:request("sendDice", {
        chat_id = chat_id,
        emoji = emoji,
        reply_to_message_id = reply_to_message_id
    })
end

function TelegramBot:editMessageText(chat_id, message_id, text, parse_mode)
    return self:request("editMessageText", {
        chat_id = chat_id,
        message_id = message_id,
        text = text,
        parse_mode = parse_mode
    })
end

function TelegramBot:editMessageCaption(chat_id, message_id, caption, parse_mode)
    return self:request("editMessageCaption", {
        chat_id = chat_id,
        message_id = message_id,
        caption = caption,
        parse_mode = parse_mode
    })
end

function TelegramBot:editMessageReplyMarkup(chat_id, message_id, reply_markup)
    return self:request("editMessageReplyMarkup", {
        chat_id = chat_id,
        message_id = message_id,
        reply_markup = reply_markup
    })
end

function TelegramBot:deleteMessage(chat_id, message_id)
    return self:request("deleteMessage", {
        chat_id = chat_id,
        message_id = message_id
    })
end


function TelegramBot:replyKeyboardMarkup(keyboard, resize_keyboard, one_time_keyboard, selective)
    return {
        keyboard = keyboard,
        resize_keyboard = resize_keyboard,
        one_time_keyboard = one_time_keyboard,
        selective = selective
    }
end

function TelegramBot:inlineKeyboardMarkup(inline_keyboard)
    return {
        inline_keyboard = inline_keyboard
    }
end

function TelegramBot:removeKeyboard(selective)
    return {
        remove_keyboard = true,
        selective = selective
    }
end

function TelegramBot:getFile(file_id)
    return self:request("getFile", {
        file_id = file_id
    })
end

function TelegramBot:uploadStickerFile(user_id, png_sticker)
    return self:request("uploadStickerFile", {
        user_id = user_id,
        png_sticker = png_sticker
    })
end

function TelegramBot:getUserProfilePhotos(user_id, offset, limit)
    return self:request("getUserProfilePhotos", {
        user_id = user_id,
        offset = offset,
        limit = limit
    })
end
function TelegramBot:kickChatMember(chat_id, user_id, until_date)
    return self:request("kickChatMember", {
        chat_id = chat_id,
        user_id = user_id,
        until_date = until_date
    })
end

function TelegramBot:unbanChatMember(chat_id, user_id)
    return self:request("unbanChatMember", {
        chat_id = chat_id,
        user_id = user_id
    })
end

function TelegramBot:restrictChatMember(chat_id, user_id, permissions, until_date)
    return self:request("restrictChatMember", {
        chat_id = chat_id,
        user_id = user_id,
        permissions = permissions,
        until_date = until_date
    })
end

function TelegramBot:promoteChatMember(chat_id, user_id, can_change_info, can_post_messages, can_edit_messages, can_delete_messages, can_invite_users, can_restrict_members, can_pin_messages, can_promote_members)
    return self:request("promoteChatMember", {
        chat_id = chat_id,
        user_id = user_id,
        can_change_info = can_change_info,
        can_post_messages = can_post_messages,
        can_edit_messages = can_edit_messages,
        can_delete_messages = can_delete_messages,
        can_invite_users = can_invite_users,
        can_restrict_members = can_restrict_members,
        can_pin_messages = can_pin_messages,
        can_promote_members = can_promote_members
    })
end

function TelegramBot:setChatAdministratorCustomTitle(chat_id, user_id, custom_title)
    return self:request("setChatAdministratorCustomTitle", {
        chat_id = chat_id,
        user_id = user_id,
        custom_title = custom_title
    })
end

function TelegramBot:setChatPermissions(chat_id, permissions)
    return self:request("setChatPermissions", {
        chat_id = chat_id,
        permissions = permissions
    })
end

function TelegramBot:getChat(chat_id)
    return self:request("getChat", {
        chat_id = chat_id
    })
end

function TelegramBot:getChatAdministrators(chat_id)
    return self:request("getChatAdministrators", {
        chat_id = chat_id
    })
end

function TelegramBot:getChatMembersCount(chat_id)
    return self:request("getChatMembersCount", {
        chat_id = chat_id
    })
end

function TelegramBot:getChatMember(chat_id, user_id)
    return self:request("getChatMember", {
        chat_id = chat_id,
        user_id = user_id
    })
end


function TelegramBot:setWebhook(url, certificate, max_connections, allowed_updates)
    return self:request("setWebhook", {
        url = url,
        certificate = certificate,
        max_connections = max_connections,
        allowed_updates = allowed_updates
    })
end

function TelegramBot:deleteWebhook()
    return self:request("deleteWebhook", {})
end

function TelegramBot:getWebhookInfo()
    return self:request("getWebhookInfo", {})
end

function TelegramBot:getUpdates(offset, limit, timeout, allowed_updates)
    return self:request("getUpdates", {
        offset = offset,
        limit = limit,
        timeout = timeout,
        allowed_updates = allowed_updates
    })
end


function TelegramBot:createNewStickerSet(user_id, name, title, png_sticker, emojis)
    return self:request("createNewStickerSet", {
        user_id = user_id,
        name = name,
        title = title,
        png_sticker = png_sticker,
        emojis = emojis
    })
end

function TelegramBot:addStickerToSet(user_id, name, png_sticker, emojis)
    return self:request("addStickerToSet", {
        user_id = user_id,
        name = name,
        png_sticker = png_sticker,
        emojis = emojis
    })
end

function TelegramBot:setStickerPositionInSet(sticker, position)
    return self:request("setStickerPositionInSet", {
        sticker = sticker,
        position = position
    })
end

function TelegramBot:deleteStickerFromSet(sticker)
    return self:request("deleteStickerFromSet", {
        sticker = sticker
    })
end

function TelegramBot:registerCommand(command, callback)
    self.commands[command] = callback
end

function TelegramBot:setMyCommands(commands)
    self.commands = commands
    return self:request("setMyCommands", {commands = commands})
end

function TelegramBot:startPolling(callback)
    self.running = true
    while self.running do
        local updates = self:getUpdates(self.updateOffset)
        if updates then
            for _, update in ipairs(updates) do
                self.updateOffset = update.update_id + 1

                if update.message then
                    local text = update.message.text
                    local chat_id = update.message.chat.id
                    local message_id = update.message.message_id

                    for _, command in ipairs(self.commands) do
                        local cmd, args = text:match("^(" .. command.command .. ")(.*)$")
                        if cmd then
                            callback(cmd, args:match("^%s*(.-)%s*$"), chat_id, message_id)
                            break
                        end
                    end
                end
            end
        end
        wait(1)
    end
end

function TelegramBot:stopPolling()
    self.running = false
end

return TelegramBot
