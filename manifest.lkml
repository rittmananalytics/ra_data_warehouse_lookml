project_name: "analytics"
visualization: {
  id: "looker_gemini_insight"
  label: "Gemini Insight2"
  url: "https://looker-gemini-insight-r6jhgfswwa-nw.a.run.app/source.js"
}

application: explore_assistant {
  label: "Explore Assistant v2"
  # url: "https://localhost:8080/bundle.js"
 file: "bundle.js"
  entitlements: {
    core_api_methods: ["lookml_model_explore","create_sql_query","run_sql_query","run_query","create_query"]
    navigation: yes
    use_embeds: yes
    use_iframes: yes
    new_window: yes
    new_window_external_urls: ["https://developers.generativeai.google/*"]
    local_storage: yes
    # external_api_urls: ["cloud function url"]
  }
}
