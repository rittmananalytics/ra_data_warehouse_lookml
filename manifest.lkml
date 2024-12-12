project_name: "analytics"
visualization: {
  id: "looker_gemini_insight"
  label: "Gemini Insight2"
  url: "https://looker-gemini-insight-r6jhgfswwa-nw.a.run.app/source.js"
}
visualization: {
  id: "ra-html3"
  label: "HTML Manifest"
  url: "https://www.rittmananalytics.com/s/html_viz.js"
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


  visualization: {
    id: "highcharts_violin_plot"
    label: "Violin Plot"
    # url: "violin.js"
    file: "violin_plot.js"
    dependencies: [
      "https://code.jquery.com/jquery-3.1.1.min.js",
      "https://code.highcharts.com/highcharts.js",
      "https://code.highcharts.com/highcharts-more.js",
      "https://code.highcharts.com/modules/data.js",
      "https://code.highcharts.com/modules/exporting.js",
      "https://code.highcharts.com/modules/export-data.js",
      "https://code.highcharts.com/modules/accessibility.js",
      "https://cdn.jsdelivr.net/npm/jstat@latest/dist/jstat.min.js",
      "https://cdnjs.cloudflare.com/ajax/libs/lodash.js/4.17.21/lodash.min.js"
    ]
  }
  

}
