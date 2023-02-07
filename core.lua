local spam = CreateFrame("Frame")
spam:Hide()
spam:SetScript("OnUpdate", function(self,elapsed)
    self.elapsed = (self.elapsed or 0)+elapsed
    if self.elapsed >= self.timer then
        SendChatMessage(self.message, self.channel, nil, self.data)
        self.elapsed = 0
    end
end)
SlashCmdList["REPEATCHAT"]=function(input)
    if input:lower() == "stop" then spam:Hide() return end
    local message, delay, channel, data = input:match("\"(.+)\"%s+(%d+)%s+(%S+)%s*(%S*)")
    if (not message) or (not delay) or (not channel) then
        print("Proper syntax: "<message>" <delay> <channel>( <chandata>)")
        return
    end
    spam.timer = tonumber(delay)
    spam.message = message
    spam.channel = channel:upper()
    spam.data = data
    spam.elapsed = 0
    spam:Show()
end
SLASH_REPEATCHAT1="/repeatchat"
SLASH_REPEATCHAT2="/repeat"