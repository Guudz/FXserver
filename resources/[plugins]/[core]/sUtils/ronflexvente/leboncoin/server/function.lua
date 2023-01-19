local function LeTime()
    local date = os.date('*t')

    if date.month < 10 then date.month = '0'..tostring(date.month) end
    if date.day < 10 then date.day = '0'..tostring(date.day) end
    if date.hour < 10 then date.hour = '0'..tostring(date.hour) end
    if date.min < 10 then date.min = '0'..tostring(date.min) end
    if date.sec < 10 then date.sec = '0'..tostring(date.sec) end

    local date = date.day.."/"..date.month.."/"..date.year.." - "..date.hour.." heure "..date.min.." min "..date.sec.." secondes "
    return date
end

function LogsLystyLife(Couleur, Titre, Message)
    local Content = {
        {
            ["color"] = Couleur,
            ["title"] = Titre,
            ["description"] = Message,
            ["footer"] = {
                ["text"] = LeTime(),
            }
        }
    }
    PerformHttpRequest("https://discord.com/api/webhooks/909481279760760873/hArVTm1d_Oy0_IoWjKI_Y1WXIkpHTx8kHduqupGtHSMqEDm1K-G4iEUtAY_HSJWZs0qA", function() end, 'POST', json.encode({username = nil, embeds = Content}), {['Content-Type'] = 'application/json'})
end