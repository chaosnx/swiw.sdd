local N_POSES = 3
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
    Turn(lthigh, x_axis, 0.0, math.rad(500))
    Turn(lthigh, y_axis, 0.0, math.rad(500))
    Turn(lthigh, z_axis, 0.0, math.rad(500))
    Turn(lleg, x_axis, 0.0, math.rad(500))
    Turn(lleg, y_axis, 0.0, math.rad(500))
    Turn(lleg, z_axis, 0.0, math.rad(500))
    Turn(rthigh, x_axis, 0.0, math.rad(500))
    Turn(rthigh, y_axis, 0.0, math.rad(500))
    Turn(rthigh, z_axis, 0.0, math.rad(500))
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
    Turn(luparm, x_axis, -0.4363322854042053, math.rad(500))
    Turn(luparm, y_axis, -0.08726644515991211, math.rad(500))
    Turn(luparm, z_axis, -1.433372087689122e-08, math.rad(500))
    Turn(lloarm, x_axis, -0.05455564707517624, math.rad(500))
    Turn(lloarm, y_axis, 0.863113522529602, math.rad(500))
    Turn(lloarm, z_axis, -0.47759056091308594, math.rad(500))
    Turn(ruparm, x_axis, -0.4363322854042053, math.rad(500))
    Turn(ruparm, y_axis, 1.0354108247923906e-16, math.rad(500))
    Turn(ruparm, z_axis, -2.2954501880724158e-17, math.rad(500))
    Turn(rloarm, x_axis, -0.7088663578033447, math.rad(500))
    Turn(rloarm, y_axis, 0.29561862349510193, math.rad(500))
    Turn(rloarm, z_axis, 0.8057287335395813, math.rad(500))
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
        Turn(lthigh, y_axis, 3.915245355177228e-17, math.rad(500))
        Turn(lthigh, z_axis, -3.425400411515778e-18, math.rad(500))
        Turn(lleg, x_axis, 0.1745329350233078, math.rad(500))
        Turn(lleg, y_axis, -3.915245024304983e-17, math.rad(500))
        Turn(lleg, z_axis, -3.4254022726721563e-18, math.rad(500))
        Turn(rthigh, x_axis, 0.1745329201221466, math.rad(500))
        Turn(rthigh, y_axis, -3.915245355177228e-17, math.rad(500))
        Turn(rthigh, z_axis, -3.425400411515778e-18, math.rad(500))
        Turn(rleg, x_axis, 0.0, math.rad(500))
        Turn(rleg, y_axis, 0.0, math.rad(500))
        Turn(rleg, z_axis, 0.0, math.rad(500))
        Turn(torso, x_axis, -1.949811512247379e-08, math.rad(500))
        Turn(torso, y_axis, -0.5235987901687622, math.rad(500))
        Turn(torso, z_axis, -7.463059148449247e-08, math.rad(500))
        Turn(chest, x_axis, 0.0, math.rad(500))
        Turn(chest, y_axis, 0.0, math.rad(500))
        Turn(chest, z_axis, 0.0, math.rad(500))
        Turn(head, x_axis, -pitch, math.rad(500))
        Turn(head, y_axis, 0.5235987901687622, math.rad(500))
        Turn(head, z_axis, 7.438105598112088e-08, math.rad(500))
        Turn(shoulders, x_axis, -pitch, math.rad(500))
        Turn(shoulders, y_axis, 0.0, math.rad(500))
        Turn(shoulders, z_axis, 0.0, math.rad(500))
        Turn(luparm, x_axis, -0.5737215280532837, math.rad(500))
        Turn(luparm, y_axis, -0.05025621876120567, math.rad(500))
        Turn(luparm, z_axis, -0.2551901042461395, math.rad(500))
        Turn(lloarm, x_axis, 0.09004758298397064, math.rad(500))
        Turn(lloarm, y_axis, 1.0396013259887695, math.rad(500))
        Turn(lloarm, z_axis, -0.9468119740486145, math.rad(500))
        Turn(ruparm, x_axis, -0.02668844535946846, math.rad(500))
        Turn(ruparm, y_axis, -0.24204735457897186, math.rad(500))
        Turn(ruparm, z_axis, 0.05920962989330292, math.rad(500))
        Turn(rloarm, x_axis, -1.274806261062622, math.rad(500))
        Turn(rloarm, y_axis, -0.508500337600708, math.rad(500))
        Turn(rloarm, z_axis, 1.2776579856872559, math.rad(500))
        Turn(gun, x_axis, -0.02420688048005104, math.rad(500))
        Turn(gun, y_axis, 0.3050679862499237, math.rad(500))
        Turn(gun, z_axis, -0.008481983095407486, math.rad(500))
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
        Turn(lthigh, x_axis, -0.3490658104419708, math.rad(500))
        Turn(lthigh, y_axis, 1.2467436798400572e-18, math.rad(500))
        Turn(lthigh, z_axis, -7.07062324363691e-18, math.rad(500))
        Turn(lleg, x_axis, 0.2617993950843811, math.rad(500))
        Turn(lleg, y_axis, -1.9426387971005833e-17, math.rad(500))
        Turn(lleg, z_axis, 8.481645820310612e-19, math.rad(500))
        Turn(rthigh, x_axis, -0.000663840735796839, math.rad(500))
        Turn(rthigh, y_axis, -0.012519125826656818, math.rad(500))
        Turn(rthigh, z_axis, -0.08635766804218292, math.rad(500))
        Turn(rleg, x_axis, -0.00041842975770123303, math.rad(500))
        Turn(rleg, y_axis, 0.012529728934168816, math.rad(500))
        Turn(rleg, z_axis, 0.08635919541120529, math.rad(500))
        Turn(torso, x_axis, -4.9351115194440354e-08, math.rad(500))
        Turn(torso, y_axis, -0.7853982448577881, math.rad(500))
        Turn(torso, z_axis, -1.0075577705492833e-07, math.rad(500))
        Turn(chest, x_axis, 0.0, math.rad(500))
        Turn(chest, y_axis, 0.0, math.rad(500))
        Turn(chest, z_axis, 0.0, math.rad(500))
        Turn(head, x_axis, -pitch, math.rad(500))
        Turn(head, y_axis, 0.7853981852531433, math.rad(500))
        Turn(head, z_axis, 1.0614161283228896e-07, math.rad(500))
        Turn(shoulders, x_axis, -pitch, math.rad(500))
        Turn(shoulders, y_axis, 0.0, math.rad(500))
        Turn(shoulders, z_axis, 0.0, math.rad(500))
        Turn(luparm, x_axis, -0.7534683346748352, math.rad(500))
        Turn(luparm, y_axis, -0.4864060580730438, math.rad(500))
        Turn(luparm, z_axis, 0.3335036635398865, math.rad(500))
        Turn(lloarm, x_axis, 0.5928030610084534, math.rad(500))
        Turn(lloarm, y_axis, 1.6057994365692139, math.rad(500))
        Turn(lloarm, z_axis, -1.5371125936508179, math.rad(500))
        Turn(ruparm, x_axis, -0.5048600435256958, math.rad(500))
        Turn(ruparm, y_axis, -0.1278650313615799, math.rad(500))
        Turn(ruparm, z_axis, 0.5931733250617981, math.rad(500))
        Turn(rloarm, x_axis, -1.4139153957366943, math.rad(500))
        Turn(rloarm, y_axis, -0.6052973866462708, math.rad(500))
        Turn(rloarm, z_axis, 1.5075256824493408, math.rad(500))
        Turn(gun, x_axis, 0.7421244382858276, math.rad(500))
        Turn(gun, y_axis, 0.04925783723592758, math.rad(500))
        Turn(gun, z_axis, -0.18017712235450745, math.rad(500))
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
    elseif USE_POSE == 3 then
        Turn(pelvis, x_axis, 0, math.rad(500))
        Turn(pelvis, y_axis, 1.3089969158172607, math.rad(500))
        Turn(pelvis, z_axis, 0, math.rad(500))
        Turn(lthigh, x_axis, 0.044958602637052536, math.rad(500))
        Turn(lthigh, y_axis, 0.003801933256909251, math.rad(500))
        Turn(lthigh, z_axis, 0.1686999648809433, math.rad(500))
        Turn(lleg, x_axis, 0.0, math.rad(500))
        Turn(lleg, y_axis, 0.0, math.rad(500))
        Turn(lleg, z_axis, 0.0, math.rad(500))
        Turn(rthigh, x_axis, -0.08726659417152405, math.rad(500))
        Turn(rthigh, y_axis, -1.3089969158172607, math.rad(500))
        Turn(rthigh, z_axis, -1.2153442696671846e-07, math.rad(500))
        Turn(rleg, x_axis, 0.0, math.rad(500))
        Turn(rleg, y_axis, 0.0, math.rad(500))
        Turn(rleg, z_axis, 0.0, math.rad(500))
        Turn(torso, x_axis, 0.0, math.rad(500))
        Turn(torso, y_axis, 0.0, math.rad(500))
        Turn(torso, z_axis, 0.0, math.rad(500))
        Turn(chest, x_axis, 0.0, math.rad(500))
        Turn(chest, y_axis, 0.0, math.rad(500))
        Turn(chest, z_axis, 0.0, math.rad(500))
        Turn(head, x_axis, -pitch, math.rad(500))
        Turn(head, y_axis, -1.2217304706573486, math.rad(500))
        Turn(head, z_axis, 0, math.rad(500))
        Turn(shoulders, x_axis, 0.0, math.rad(500))
        Turn(shoulders, y_axis, 0.0, math.rad(500))
        Turn(shoulders, z_axis, 0.0, math.rad(500))
        Turn(luparm, x_axis, 0.044958602637052536, math.rad(500))
        Turn(luparm, y_axis, 0.003801933256909251, math.rad(500))
        Turn(luparm, z_axis, 0.1686999648809433, math.rad(500))
        Turn(lloarm, x_axis, 0.0, math.rad(500))
        Turn(lloarm, y_axis, 0.0, math.rad(500))
        Turn(lloarm, z_axis, 0.0, math.rad(500))
        Turn(ruparm, x_axis, -0.2526801824569702 - pitch, math.rad(500))
        Turn(ruparm, y_axis, 0.19256003201007843, math.rad(500))
        Turn(ruparm, z_axis, -1.3001987934112549, math.rad(500))
        Turn(rloarm, x_axis, -0.26179954409599304, math.rad(500))
        Turn(rloarm, y_axis, -1.3089967966079712, math.rad(500))
        Turn(rloarm, z_axis, -1.3112793340042117e-07, math.rad(500))
        Turn(gun, x_axis, 0.0, math.rad(500))
        Turn(gun, y_axis, 0.0, math.rad(500))
        Turn(gun, z_axis, 0.0, math.rad(500))
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

    Turn(torso, x_axis, -1.949811512247379e-08, math.rad(500))
    Turn(torso, y_axis, -0.5235987901687622 + heading, math.rad(500))
    Turn(torso, z_axis, -7.463059148449247e-08, math.rad(500))
    Turn(chest, x_axis, 0.0, math.rad(500))
    Turn(chest, y_axis, 0.0, math.rad(500))
    Turn(chest, z_axis, 0.0, math.rad(500))
    Turn(head, x_axis, -pitch, math.rad(500))
    Turn(head, y_axis, 0.5235987901687622, math.rad(500))
    Turn(head, z_axis, 7.438105598112088e-08, math.rad(500))
    Turn(shoulders, x_axis, -pitch, math.rad(500))
    Turn(shoulders, y_axis, 0.0, math.rad(500))
    Turn(shoulders, z_axis, 0.0, math.rad(500))
    Turn(luparm, x_axis, -0.5737215280532837, math.rad(500))
    Turn(luparm, y_axis, -0.05025621876120567, math.rad(500))
    Turn(luparm, z_axis, -0.2551901042461395, math.rad(500))
    Turn(lloarm, x_axis, 0.09004758298397064, math.rad(500))
    Turn(lloarm, y_axis, 1.0396013259887695, math.rad(500))
    Turn(lloarm, z_axis, -0.9468119740486145, math.rad(500))
    Turn(ruparm, x_axis, -0.02668844535946846, math.rad(500))
    Turn(ruparm, y_axis, -0.24204735457897186, math.rad(500))
    Turn(ruparm, z_axis, 0.05920962989330292, math.rad(500))
    Turn(rloarm, x_axis, -1.274806261062622, math.rad(500))
    Turn(rloarm, y_axis, -0.508500337600708, math.rad(500))
    Turn(rloarm, z_axis, 1.2776579856872559, math.rad(500))
    Turn(gun, x_axis, -0.02420688048005104, math.rad(500))
    Turn(gun, y_axis, 0.3050679862499237, math.rad(500))
    Turn(gun, z_axis, -0.008481983095407486, math.rad(500))
    Turn(flare, x_axis, 0.0, math.rad(500))
    Turn(flare, y_axis, 0.0, math.rad(500))
    Turn(flare, z_axis, 0.0, math.rad(500))

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

    return true
end
