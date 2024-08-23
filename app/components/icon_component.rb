class IconComponent < ViewComponent::Base
  attr_reader :type, :css_class

  def initialize(type, **args)
    @type = type
    @css_class = args[:class] || 'size-6'
  end

  def render?
    type.present?
  end
end
