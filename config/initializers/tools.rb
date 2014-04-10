MAS::Templating::ControllerConcerns::ParentTemplateSupport.configure do |config|
  config.add_templates(
    embedded: 'layouts/tools/embedded_tool'
  )
end

ActionPlans.parent_controller = 'Tools::ToolsController'
