project_name: "analytics"
application: explore-assistant {
  label: "Explore Assistant"
  # file: "explore-assistant.js"
  file: "bundle.js"
  entitlements: {
    external_api_urls: ["https://localhost:8080","http://localhost:8080"]
    core_api_methods: ["lookml_model_explore","run_inline_query","create_sql_query","run_sql_query"]
    navigation: yes
    use_embeds: yes
    use_iframes: yes
    new_window: yes
    new_window_external_urls: ["https://developers.generativeai.google/*"]
    local_storage: yes
  }
}
# # Use local_dependency: To enable referencing of another project
# # on this instance with include: statements
#
# local_dependency: {
#   project: "name_of_other_project"
# }
