resource "cloudflare_teams_rule" "gateway_policies" {
  for_each = var.gw_policies
  account_id    = var.account_id
  name = each.value.name
  description = each.value.description
  precedence = each.value.precedence
  enabled = each.value.enabled
  action = each.value.action
  filters = each.value.filters
  traffic = each.value.traffic
  dynamic "rule_settings" {
      for_each = try(each.value.rule_settings, null) != null ? [each.value] : []
      content {
        block_page_enabled      = try(each.value.rule_settings["block_page_enabled"], null)
        block_page_reason             = try(each.value.rule_settings["block_reason"], null)
        override_ips          = try(each.value.rule_settings["override_ips"], null)
        override_host          = try(each.value.rule_settings["override_host"], null)
        insecure_disable_dnssec_validation          = try(each.value.rule_settings["insecure_disable_dnssec_validation"], null)
    }
  }
}