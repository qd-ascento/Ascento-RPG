ability_custom_spider = ability_custom_spider or class({})

function ability_custom_spider:OnAbilityPhaseStart()
    return self:CheckPhaseStartWithMessage()
end

function ability_custom_spider:OnSpellStart()
	if not IsServer() then return end

	local caster = self:GetCaster()
	if IsNull(caster) then return end
	local ability = self
	if ability:CostCrystal() then
		local spawn_point = CallHeroPool:FindValidPathPoint(caster:GetAbsOrigin(), 100, 300)
		for i = 1, 6 do
			unit = CreateUnitByName("npc_hpma_spider", spawn_point, true, caster, caster, caster:GetTeamNumber())
	    	unit:SetOwner(caster)
	    end
	end
end
