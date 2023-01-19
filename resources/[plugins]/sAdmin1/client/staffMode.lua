isStaffMode, serverInteraction = false,false
localReportsTable, reportCount, take = {},0,0

RegisterNetEvent("adminmenu:cbStaffState")
AddEventHandler("adminmenu:cbStaffState", function(isStaff)
    isStaffMode = isStaff
    serverInteraction = false
    DecorSetBool(PlayerPedId(), "isStaffMode", isStaffMode)
    if isStaffMode then
        Citizen.CreateThread(function()
            while isStaffMode do
                Wait(1)
                RageUI.staffModeDesc("Administration LystyLife", {
                    0, 0, 0
                }, {
                    {""..connecteds.."~s~ Joueurs"},
                    {""..staff.."~s~ Staffs ("..staff.." en service~s~)"},
                    {""..CountReport.."~s~ Reports traités ("..reportCount.." en attente~s~)"},
                })
            end
        end)
    else
        NoClip(false)
        showNames(false)
    end
end)

CountReport = 0

RegisterNetEvent("sCore:recieveinfosreport", function(countreport)
    CountReport = countreport
end)