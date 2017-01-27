local N_POSES = 2
if USE_POS == nil then
    USE_POSE = math.random(1, N_POSES)
end


function STEADY_POSE(heading, pitch)
    Turn(base, x_axis, 0.0, math.rad(500))
    Turn(base, y_axis, 0.0, math.rad(500))
    Turn(base, z_axis, 0.0, math.rad(500))
    Turn(pelvis, x_axis, 0.0, math.rad(500))
    Turn(pelvis, y_axis, 0.0, math.rad(500))
    Turn(pelvis, z_axis, 0.0, math.rad(500))
    Turn(lthigh, x_axis, -0.0, math.rad(500))
    Turn(lthigh, y_axis, 0.0, math.rad(500))
    Turn(lthigh, z_axis, 0.0872664600610733, math.rad(500))
    Turn(lleg, x_axis, 0.0, math.rad(500))
    Turn(lleg, y_axis, 0.0, math.rad(500))
    Turn(lleg, z_axis, 0.0, math.rad(500))
    Turn(rthigh, x_axis, 0.0872664600610733, math.rad(500))
    Turn(rthigh, y_axis, 1.9426384662283383e-17, math.rad(500))
    Turn(rthigh, z_axis, 8.481692866207951e-19, math.rad(500))
    Turn(rleg, x_axis, 0.0, math.rad(500))
    Turn(rleg, y_axis, 0.0, math.rad(500))
    Turn(rleg, z_axis, 0.0, math.rad(500))
    Turn(torso, x_axis, 0.0, math.rad(500))
    Turn(torso, y_axis, 0.0, math.rad(500))
    Turn(torso, z_axis, 0.0, math.rad(500))
    Turn(chest, x_axis, 0.0, math.rad(500))
    Turn(chest, y_axis, 0.0, math.rad(500))
    Turn(chest, z_axis, 0.0, math.rad(500))
    Turn(head, x_axis, 0.0, math.rad(500))
    Turn(head, y_axis, 0.0, math.rad(500))
    Turn(head, z_axis, 0.0, math.rad(500))
    Turn(shoulders, x_axis, 0.0, math.rad(500))
    Turn(shoulders, y_axis, 0.0, math.rad(500))
    Turn(shoulders, z_axis, 0.0, math.rad(500))
    Turn(luparm, x_axis, -0.3490658700466156, math.rad(500))
    Turn(luparm, y_axis, -0.0872664526104927, math.rad(500))
    Turn(luparm, z_axis, -1.2438637675415976e-08, math.rad(500))
    Turn(lloarm, x_axis, -1.4521340574447095e-07, math.rad(500))
    Turn(lloarm, y_axis, 1.570796251296997, math.rad(500))
    Turn(lloarm, z_axis, -0.8726643919944763, math.rad(500))
    Turn(ruparm, x_axis, -0.4363322854042053, math.rad(500))
    Turn(ruparm, y_axis, 1.0354108247923906e-16, math.rad(500))
    Turn(ruparm, z_axis, -2.2954501880724158e-17, math.rad(500))
    Turn(rloarm, x_axis, -1.0663167238235474, math.rad(500))
    Turn(rloarm, y_axis, 0.5650603771209717, math.rad(500))
    Turn(rloarm, z_axis, 0.6277604699134827, math.rad(500))
    Turn(gun, x_axis, 0.0, math.rad(500))
    Turn(gun, y_axis, 0.0, math.rad(500))
    Turn(gun, z_axis, 0.0, math.rad(500))
    Turn(flare, x_axis, 0.0, math.rad(500))
    Turn(flare, y_axis, 0.0, math.rad(500))
    Turn(flare, z_axis, 0.0, math.rad(500))

    WaitForTurn(base, x_axis)
    WaitForTurn(base, z_axis)
    WaitForTurn(base, y_axis)
    WaitForTurn(pelvis, x_axis)
    WaitForTurn(pelvis, z_axis)
    WaitForTurn(pelvis, y_axis)
    WaitForTurn(lthigh, x_axis)
    WaitForTurn(lthigh, z_axis)
    WaitForTurn(lthigh, y_axis)
    WaitForTurn(lleg, x_axis)
    WaitForTurn(lleg, z_axis)
    WaitForTurn(lleg, y_axis)
    WaitForTurn(rthigh, x_axis)
    WaitForTurn(rthigh, z_axis)
    WaitForTurn(rthigh, y_axis)
    WaitForTurn(rleg, x_axis)
    WaitForTurn(rleg, z_axis)
    WaitForTurn(rleg, y_axis)
    WaitForTurn(torso, x_axis)
    WaitForTurn(torso, z_axis)
    WaitForTurn(torso, y_axis)
    WaitForTurn(chest, x_axis)
    WaitForTurn(chest, z_axis)
    WaitForTurn(chest, y_axis)
    WaitForTurn(head, x_axis)
    WaitForTurn(head, z_axis)
    WaitForTurn(head, y_axis)
    WaitForTurn(shoulders, x_axis)
    WaitForTurn(shoulders, z_axis)
    WaitForTurn(shoulders, y_axis)
    WaitForTurn(luparm, x_axis)
    WaitForTurn(luparm, z_axis)
    WaitForTurn(luparm, y_axis)
    WaitForTurn(lloarm, x_axis)
    WaitForTurn(lloarm, z_axis)
    WaitForTurn(lloarm, y_axis)
    WaitForTurn(ruparm, x_axis)
    WaitForTurn(ruparm, z_axis)
    WaitForTurn(ruparm, y_axis)
    WaitForTurn(rloarm, x_axis)
    WaitForTurn(rloarm, z_axis)
    WaitForTurn(rloarm, y_axis)
    WaitForTurn(gun, x_axis)
    WaitForTurn(gun, z_axis)
    WaitForTurn(gun, y_axis)
    WaitForTurn(flare, x_axis)
    WaitForTurn(flare, z_axis)
    WaitForTurn(flare, y_axis)
end

function AIMING_STEADY_POSE(heading, pitch)
    if USE_POSE <= 0 or USE_POSE > N_POSES then
        USE_POSE = 1
    end

    Turn(base, x_axis, 0.0, math.rad(500))
    Turn(base, y_axis, heading, math.rad(300))
    Turn(base, z_axis, 0.0, math.rad(500))
    if USE_POSE == 1 then
        Turn(pelvis, x_axis, 0.0, math.rad(500))
        Turn(pelvis, y_axis, 0.0, math.rad(500))
        Turn(pelvis, z_axis, 0.0, math.rad(500))
        Turn(lthigh, x_axis, -0.1745329201221466, math.rad(500))
        Turn(lthigh, y_axis, -3.915245355177228e-17, math.rad(500))
        Turn(lthigh, z_axis, 0.0872664526104927, math.rad(500))
        Turn(lleg, x_axis, 0.17386195063591003, math.rad(500))
        Turn(lleg, y_axis, -0.015366696752607822, math.rad(500))
        Turn(lleg, z_axis, -0.001339241862297058, math.rad(500))
        Turn(rthigh, x_axis, 0.2617993950843811, math.rad(500))
        Turn(rthigh, y_axis, 5.949667285866082e-17, math.rad(500))
        Turn(rthigh, z_axis, 7.832883412994326e-18, math.rad(500))
        Turn(rleg, x_axis, 0.0, math.rad(500))
        Turn(rleg, y_axis, 0.0, math.rad(500))
        Turn(rleg, z_axis, 0.0, math.rad(500))
        Turn(torso, x_axis, -2.4253592911804844e-08, math.rad(500))
        Turn(torso, y_axis, -0.6108652353286743, math.rad(500))
        Turn(torso, z_axis, -7.69226105035159e-08, math.rad(500))
        Turn(chest, x_axis, 0.0, math.rad(500))
        Turn(chest, y_axis, 0.0, math.rad(500))
        Turn(chest, z_axis, 0.0, math.rad(500))
        Turn(head, x_axis, -pitch, math.rad(500))
        Turn(head, y_axis, 0.6108652353286743, math.rad(500))
        Turn(head, z_axis, 7.692260339808854e-08, math.rad(500))
        Turn(shoulders, x_axis, -pitch, math.rad(500))
        Turn(shoulders, y_axis, 0.0, math.rad(500))
        Turn(shoulders, z_axis, 0.0, math.rad(500))
        Turn(luparm, x_axis, -0.46467122435569763, math.rad(500))
        Turn(luparm, y_axis, -0.5383549332618713, math.rad(500))
        Turn(luparm, z_axis, 0.046837128698825836, math.rad(500))
        Turn(lloarm, x_axis, 0.12699247896671295, math.rad(500))
        Turn(lloarm, y_axis, 1.6014436483383179, math.rad(500))
        Turn(lloarm, z_axis, -1.097764015197754, math.rad(500))
        Turn(ruparm, x_axis, 0.02815740741789341, math.rad(500))
        Turn(ruparm, y_axis, 0.13808783888816833, math.rad(500))
        Turn(ruparm, z_axis, -0.05777016654610634, math.rad(500))
        Turn(rloarm, x_axis, -1.466896653175354, math.rad(500))
        Turn(rloarm, y_axis, -0.9814119338989258, math.rad(500))
        Turn(rloarm, z_axis, 1.4521576166152954, math.rad(500))
        Turn(gun, x_axis, -0.00027301168302074075, math.rad(500))
        Turn(gun, y_axis, 0.0687810480594635, math.rad(500))
        Turn(gun, z_axis, -0.004371989984065294, math.rad(500))
        Turn(flare, x_axis, 0.0, math.rad(500))
        Turn(flare, y_axis, 0.0, math.rad(500))
        Turn(flare, z_axis, 0.0, math.rad(500))

        WaitForTurn(pelvis, x_axis)
        WaitForTurn(pelvis, z_axis)
        WaitForTurn(pelvis, y_axis)
        WaitForTurn(lthigh, x_axis)
        WaitForTurn(lthigh, z_axis)
        WaitForTurn(lthigh, y_axis)
        WaitForTurn(lleg, x_axis)
        WaitForTurn(lleg, z_axis)
        WaitForTurn(lleg, y_axis)
        WaitForTurn(rthigh, x_axis)
        WaitForTurn(rthigh, z_axis)
        WaitForTurn(rthigh, y_axis)
        WaitForTurn(rleg, x_axis)
        WaitForTurn(rleg, z_axis)
        WaitForTurn(rleg, y_axis)
        WaitForTurn(torso, x_axis)
        WaitForTurn(torso, z_axis)
        WaitForTurn(torso, y_axis)
        WaitForTurn(chest, x_axis)
        WaitForTurn(chest, z_axis)
        WaitForTurn(chest, y_axis)
        WaitForTurn(head, x_axis)
        WaitForTurn(head, z_axis)
        WaitForTurn(head, y_axis)
        WaitForTurn(shoulders, x_axis)
        WaitForTurn(shoulders, z_axis)
        WaitForTurn(shoulders, y_axis)
        WaitForTurn(luparm, x_axis)
        WaitForTurn(luparm, z_axis)
        WaitForTurn(luparm, y_axis)
        WaitForTurn(lloarm, x_axis)
        WaitForTurn(lloarm, z_axis)
        WaitForTurn(lloarm, y_axis)
        WaitForTurn(ruparm, x_axis)
        WaitForTurn(ruparm, z_axis)
        WaitForTurn(ruparm, y_axis)
        WaitForTurn(rloarm, x_axis)
        WaitForTurn(rloarm, z_axis)
        WaitForTurn(rloarm, y_axis)
        WaitForTurn(gun, x_axis)
        WaitForTurn(gun, z_axis)
        WaitForTurn(gun, y_axis)
        WaitForTurn(flare, x_axis)
        WaitForTurn(flare, z_axis)
        WaitForTurn(flare, y_axis)
    elseif USE_POSE == 2 then
        Turn(pelvis, x_axis, 0.0, math.rad(500))
        Turn(pelvis, y_axis, 0.0, math.rad(500))
        Turn(pelvis, z_axis, 0.0, math.rad(500))
        Turn(lthigh, x_axis, -0.2617993950843811, math.rad(500))
        Turn(lthigh, y_axis, -1.8205516955083212e-11, math.rad(500))
        Turn(lthigh, z_axis, 0.0872664600610733, math.rad(500))
        Turn(lleg, x_axis, 0.26077979803085327, math.rad(500))
        Turn(lleg, y_axis, -0.023349059745669365, math.rad(500))
        Turn(lleg, z_axis, -0.0030619848985224962, math.rad(500))
        Turn(rthigh, x_axis, 1.0331489159509766e-17, math.rad(500))
        Turn(rthigh, y_axis, 5.859278282482208e-17, math.rad(500))
        Turn(rthigh, z_axis, -0.1745329201221466, math.rad(500))
        Turn(rleg, x_axis, 0.1427282691001892, math.rad(500))
        Turn(rleg, y_axis, -0.9527195692062378, math.rad(500))
        Turn(rleg, z_axis, 0.10079414397478104, math.rad(500))
        Turn(torso, x_axis, 0.06166744977235794, math.rad(500))
        Turn(torso, y_axis, -0.7873044610023499, math.rad(500))
        Turn(torso, z_axis, -0.06178516894578934, math.rad(500))
        Turn(chest, x_axis, 0.0, math.rad(500))
        Turn(chest, y_axis, 0.0, math.rad(500))
        Turn(chest, z_axis, 0.0, math.rad(500))
        Turn(head, x_axis, -pitch, math.rad(500))
        Turn(head, y_axis, 0.7853981256484985, math.rad(500))
        Turn(head, z_axis, 0.17453302443027496, math.rad(500))
        Turn(shoulders, x_axis, -pitch, math.rad(500))
        Turn(shoulders, y_axis, 0.0, math.rad(500))
        Turn(shoulders, z_axis, 0.0, math.rad(500))
        Turn(luparm, x_axis, -0.4924453794956207, math.rad(500))
        Turn(luparm, y_axis, -1.236069679260254, math.rad(500))
        Turn(luparm, z_axis, 1.3419543504714966, math.rad(500))
        Turn(lloarm, x_axis, -0.2590509057044983, math.rad(500))
        Turn(lloarm, y_axis, 1.7864699363708496, math.rad(500))
        Turn(lloarm, z_axis, -0.6704263091087341, math.rad(500))
        Turn(ruparm, x_axis, -0.9731355309486389, math.rad(500))
        Turn(ruparm, y_axis, -0.15689244866371155, math.rad(500))
        Turn(ruparm, z_axis, 0.8061977028846741, math.rad(500))
        Turn(rloarm, x_axis, -1.0255546569824219, math.rad(500))
        Turn(rloarm, y_axis, 0.2836039364337921, math.rad(500))
        Turn(rloarm, z_axis, 0.18016411364078522, math.rad(500))
        Turn(gun, x_axis, 0.5420753359794617, math.rad(500))
        Turn(gun, y_axis, 0.07071854174137115, math.rad(500))
        Turn(gun, z_axis, -0.0014981034910306334, math.rad(500))
        Turn(flare, x_axis, 0.0, math.rad(500))
        Turn(flare, y_axis, 0.0, math.rad(500))
        Turn(flare, z_axis, 0.0, math.rad(500))

        WaitForTurn(pelvis, x_axis)
        WaitForTurn(pelvis, z_axis)
        WaitForTurn(pelvis, y_axis)
        WaitForTurn(lthigh, x_axis)
        WaitForTurn(lthigh, z_axis)
        WaitForTurn(lthigh, y_axis)
        WaitForTurn(lleg, x_axis)
        WaitForTurn(lleg, z_axis)
        WaitForTurn(lleg, y_axis)
        WaitForTurn(rthigh, x_axis)
        WaitForTurn(rthigh, z_axis)
        WaitForTurn(rthigh, y_axis)
        WaitForTurn(rleg, x_axis)
        WaitForTurn(rleg, z_axis)
        WaitForTurn(rleg, y_axis)
        WaitForTurn(torso, x_axis)
        WaitForTurn(torso, z_axis)
        WaitForTurn(torso, y_axis)
        WaitForTurn(chest, x_axis)
        WaitForTurn(chest, z_axis)
        WaitForTurn(chest, y_axis)
        WaitForTurn(head, x_axis)
        WaitForTurn(head, z_axis)
        WaitForTurn(head, y_axis)
        WaitForTurn(shoulders, x_axis)
        WaitForTurn(shoulders, z_axis)
        WaitForTurn(shoulders, y_axis)
        WaitForTurn(luparm, x_axis)
        WaitForTurn(luparm, z_axis)
        WaitForTurn(luparm, y_axis)
        WaitForTurn(lloarm, x_axis)
        WaitForTurn(lloarm, z_axis)
        WaitForTurn(lloarm, y_axis)
        WaitForTurn(ruparm, x_axis)
        WaitForTurn(ruparm, z_axis)
        WaitForTurn(ruparm, y_axis)
        WaitForTurn(rloarm, x_axis)
        WaitForTurn(rloarm, z_axis)
        WaitForTurn(rloarm, y_axis)
        WaitForTurn(gun, x_axis)
        WaitForTurn(gun, z_axis)
        WaitForTurn(gun, y_axis)
        WaitForTurn(flare, x_axis)
        WaitForTurn(flare, z_axis)
        WaitForTurn(flare, y_axis)
    end
    WaitForTurn(base, x_axis)
    WaitForTurn(base, y_axis)
    WaitForTurn(base, z_axis)

    return true
end

function AIMING_RUN_POSE(heading, pitch)
    if heading < -maxAngle or heading > maxAngle then
        -- We can not aim the target
        return false
    end

    Turn(torso, x_axis, 0, math.rad(500))
    Turn(torso, y_axis, -0.6108652353286743 + heading, math.rad(500))
    Turn(torso, z_axis, 0, math.rad(500))
    Turn(chest, x_axis, 0.0, math.rad(500))
    Turn(chest, y_axis, 0.0, math.rad(500))
    Turn(chest, z_axis, 0.0, math.rad(500))
    Turn(head, x_axis, -pitch, math.rad(500))
    Turn(head, y_axis, 0.6108652353286743, math.rad(500))
    Turn(head, z_axis, 7.692260339808854e-08, math.rad(500))
    Turn(shoulders, x_axis, -pitch, math.rad(500))
    Turn(shoulders, y_axis, 0.0, math.rad(500))
    Turn(shoulders, z_axis, 0.0, math.rad(500))
    Turn(luparm, x_axis, -0.46467122435569763, math.rad(500))
    Turn(luparm, y_axis, -0.5383549332618713, math.rad(500))
    Turn(luparm, z_axis, 0.046837128698825836, math.rad(500))
    Turn(lloarm, x_axis, 0.12699247896671295, math.rad(500))
    Turn(lloarm, y_axis, 1.6014436483383179, math.rad(500))
    Turn(lloarm, z_axis, -1.097764015197754, math.rad(500))
    Turn(ruparm, x_axis, 0.02815740741789341, math.rad(500))
    Turn(ruparm, y_axis, 0.13808783888816833, math.rad(500))
    Turn(ruparm, z_axis, -0.05777016654610634, math.rad(500))
    Turn(rloarm, x_axis, -1.466896653175354, math.rad(500))
    Turn(rloarm, y_axis, -0.9814119338989258, math.rad(500))
    Turn(rloarm, z_axis, 1.4521576166152954, math.rad(500))
    Turn(gun, x_axis, -0.00027301168302074075, math.rad(500))
    Turn(gun, y_axis, 0.0687810480594635, math.rad(500))
    Turn(gun, z_axis, -0.004371989984065294, math.rad(500))
    Turn(flare, x_axis, 0.0, math.rad(500))
    Turn(flare, y_axis, 0.0, math.rad(500))
    Turn(flare, z_axis, 0.0, math.rad(500))

    WaitForTurn(torso, x_axis)
    WaitForTurn(torso, y_axis)
    WaitForTurn(torso, z_axis)
    WaitForTurn(chest, x_axis)
    WaitForTurn(chest, y_axis)
    WaitForTurn(chest, z_axis)
    WaitForTurn(head, x_axis)
    WaitForTurn(head, y_axis)
    WaitForTurn(head, z_axis)
    WaitForTurn(shoulders, x_axis)
    WaitForTurn(shoulders, y_axis)
    WaitForTurn(shoulders, z_axis)
    WaitForTurn(luparm, x_axis)
    WaitForTurn(luparm, y_axis)
    WaitForTurn(luparm, z_axis)
    WaitForTurn(lloarm, x_axis)
    WaitForTurn(lloarm, y_axis)
    WaitForTurn(lloarm, z_axis)
    WaitForTurn(ruparm, x_axis)
    WaitForTurn(ruparm, y_axis)
    WaitForTurn(ruparm, z_axis)
    WaitForTurn(rloarm, x_axis)
    WaitForTurn(rloarm, y_axis)
    WaitForTurn(rloarm, z_axis)
    WaitForTurn(gun, x_axis)
    WaitForTurn(gun, y_axis)
    WaitForTurn(gun, z_axis)
    WaitForTurn(flare, x_axis)
    WaitForTurn(flare, y_axis)
    WaitForTurn(flare, z_axis)

    return true
end
