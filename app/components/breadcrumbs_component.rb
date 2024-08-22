class BreadcrumbsComponent < ViewComponent::Base
  Bread = Data.define(:path, :title, :icon) do
    def folder_icon?
      icon == :folder
    end
  end

  delegate :notebooks_path, :pages_path, to: :helpers

  def initialize(current_notebook: nil, current_page: nil, bread_keys:)
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

  def new_notebook_bread
    Bread.new(
      path: new_notebook_path,
      title: t('notebook_pages.new'),
      icon: nil
    )
  end

  def pages_bread
    Bread.new(
      path: notebook_pages_path(@current_notebook),
      title: [@current_notebook.name, t('page_pages.index')].join(' '),
      icon: nil
    )
  end

  def edit_notebook_bread
    Bread.new(
      path: edit_notebook_path(@current_notebook),
      title: t('notebook_pages.edit'),
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
