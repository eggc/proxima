module ApplicationHelper
  def turbo_destroy_link_to(path:, confirm:, class: 'btn btn-sm')
    link_to(
      I18n.t('button.destroy'),
      path,
      class:,
      data: {
        turbo_method: :delete,
        turbo_confirm: confirm ? 'Are you sure you want to delete this item? This action cannot be undone.' : nil
      }
    )
  end
end
