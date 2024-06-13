project_name: "analytics"
application: explore-assistant {
  label: "Explore Assistant 2"
  # file: "bundle.js"
  file: "bundle.js"
  entitlements: {
    core_api_methods: ["lookml_model_explore","run_inline_query","create_sql_query","run_sql_query"]
    navigation: yes
    use_embeds: yes
    use_iframes: yes
    new_window: yes
    new_window_external_urls: ["https://developers.generativeai.google/*"]
    local_storage: yes
  }
}
