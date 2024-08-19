class HouseworkLogLimitExceeded < InvalidRequestError
  def message
    I18n.t('errors.messages.housework_log_limit_exceeded')
  end
end
