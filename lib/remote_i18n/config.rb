# frozen_string_literal: true

require_relative 'backend/remote'
require_relative 'exceptions'
require 'i18n'
require 'uri'

module I18n
  class Config
    def backend
      @@backend ||= I18n::Backend::Remote.new
    end

    attr_reader :remote_urls

    def remote_urls=(value)
      if value.is_a? Array
        value.each do |url|
          raise I18n::InvalidLocaleRemoteLocation.new(url, 'is not a valid URL') unless url =~ /\A#{URI::regexp}\z/
        end

      elsif value.is_a? String
        raise I18n::InvalidLocaleRemoteLocation.new(value, 'is not a valid URL') unless value =~ /\A#{URI::regexp}\z/
        value = [value]

      else
        raise I18n::InvalidLocaleRemoteLocation.new(value, 'value must be an Array or a String')
      end

      @remote_urls = value
    end
  end
end
