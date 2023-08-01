# frozen_string_literal: true

require 'i18n'
require 'httparty'
require 'tempfile'

module I18n
  module Backend
    # We will use I18n Simple Backend which utilises in-memory store for now
    class Remote < I18n::Backend::Simple
      module Implementation
        include HTTParty

        # Constants
        JSON_CONTENT_TYPES = ['application/json', 'application/x-json'].freeze
        YAML_CONTENT_TYPES = ['application/yaml', 'application/x-yaml', 'text/yaml', 'text/x-yaml', 'text/plain'].freeze

        protected

        def load_translations(urls: [])
          super([]) if urls.empty?

          remote_fetched_tempfile_paths = []

          urls.flatten.each do |url|
            begin
              tempfile = resolve_remote_data(url)
            rescue StandardError => e
              super([])
            end

            next unless tempfile

            remote_fetched_tempfile_paths << tempfile.path
          end

          super(*remote_fetched_tempfile_paths)
        end

        def resolve_remote_data(url)
          response = HTTParty.get(url)
          content_type = response.content_type
          tempfile = nil

          # For JSON response
          if JSON_CONTENT_TYPES.include?(content_type)
            tempfile = Tempfile.new(["remote_I18n-fetched-#{Time.now}", '.json'])

          # For YAML response
          elsif YAML_CONTENT_TYPES.include?(content_type)
            tempfile = Tempfile.new(["remote_I18n-fetched-#{Time.now}", '.yml'])
          end

          return unless tempfile

          File.open(tempfile.path,'w') do |f|
            f.write response.body
          end

          tempfile
        end

        def init_translations
          load_translations(urls: I18n.config.remote_urls.to_a)

          @initialized = true
        end

      end

      include Implementation
    end
  end
end
