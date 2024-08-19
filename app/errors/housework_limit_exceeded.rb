class HouseworkLimitExceeded < InvalidRequestError
  def message
    I18n.t('errors.messages.housework_limit_exceeded')
  end
end
