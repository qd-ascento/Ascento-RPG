item_trinket_0302 = item_trinket_0302 or class({})
LinkLuaModifier("modifier_item_trinket_0302", "custom_items/trinket/item_trinket_0302", LUA_MODIFIER_MOTION_NONE)

function item_trinket_0302:GetIntrinsicModifierName() return "modifier_item_trinket_0302" end

modifier_item_trinket_0302 = class({})

function modifier_item_trinket_0302:IsHidden() return true end
function modifier_item_trinket_0302:IsDebuff() return false end
function modifier_item_trinket_0302:IsPurgable() return false end
function modifier_item_trinket_0302:RemoveOnDeath() return false end

function modifier_item_trinket_0302:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE,
        MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
        MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
    }
    return funcs
end

function modifier_item_trinket_0302:OnCreated()
    self.bonus_creep_damage = 0
    self.bonus_cooldown_reduction = 0
    self.bonus_spell_amplify = 0
    self.bonus_spell_lifesteal = 0

    local ability = self:GetAbility()
    if ability then
        self.bonus_creep_damage = ability:GetSpecialValueFor("bonus_creep_damage") or 0
        self.bonus_cooldown_reduction = ability:GetSpecialValueFor("bonus_cooldown_reduction") or 0
        self.bonus_spell_amplify = ability:GetSpecialValueFor("bonus_spell_amplify") or 0
        self.bonus_spell_lifesteal = ability:GetSpecialValueFor("bonus_spell_lifesteal") or 0
    end
end

function modifier_item_trinket_0302:GetModifierPercentageCooldown()
    return self.bonus_cooldown_reduction
end

function modifier_item_trinket_0302:GetModifierSpellAmplify_Percentage()
    return self.bonus_spell_amplify
end

function modifier_item_trinket_0302:GetModifierSpellLifesteal()
    return self.bonus_spell_lifesteal
end

function modifier_item_trinket_0302:GetModifierTotalDamageOutgoing_Percentage(keys)
    local damagePercentage = 100
    local parent = self:GetParent()
    local attacker = keys.attacker
    local target = keys.target
    if parent:IsNull() or attacker:IsNull() or target:IsNull() then
        return damagePercentage
    end

    if attacker ~= parent then 
        return damagePercentage
    end

    if target.IsCreep ~= nil and target:IsCreep() then
        return damagePercentage + self.bonus_creep_damage
    end
    
    return damagePercentage
end
