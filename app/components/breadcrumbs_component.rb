class BreadcrumbsComponent < ViewComponent::Base
  Bread = Data.define(:path, :title, :icon) do
    def folder_icon?
      icon == :folder
    end
  end

  delegate :notebooks_path, :pages_path, to: :helpers

  def initialize(current_notebook:, current_page: nil, bread_keys:)
    @current_notebook = current_notebook
    @current_page = current_page
    @bread_keys = bread_keys
  end

  def breads
    @bread_keys.map do |bread_key|
      send(bread_key)
    end
  end

  def notebooks_bread
    Bread.new(
      path: notebooks_path,
      title: t('notebook_pages.index'),
      icon: :folder
    )
  end

  def pages_bread
    Bread.new(
      path: notebook_pages_path(@current_notebook),
      title: t('page_pages.index'),
      icon: nil
    )
  end

  def edit_page_bread
    Bread.new(
      path: page_path(@current_page),
      title: t('page_pages.edit'),
      icon: nil
    )
  end
end
