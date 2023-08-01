# frozen_string_literal: true

module I18n
  class InvalidLocaleRemoteLocation < ArgumentError
    attr_reader :remote_url

    def initialize(remote_url, exception_message)
      @remote_url, @exception_message = remote_url, exception_message
      super "can not load translations from remote location '#{remote_url}': #{exception_message}"
    end
  end
end
