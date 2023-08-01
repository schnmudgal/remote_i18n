# frozen_string_literal: true

INITIALIZER_CONTENT = "# Remote URLs where the translation files are hosted
I18n.config.remote_urls = [
  'https://raw.githubusercontent.com/g1stavo/rails-i18n/master/config/locales/en.yml',
  'https://raw.githubusercontent.com/g1stavo/rails-i18n/master/config/locales/pt-BR.yml'
]

## Fallback location for local translation file(s)
# I18n.load_path = [
#  File.expand_path('./locales/en.yml')
# ]

## Example - translate in English
# puts I18n.translate(:confirm, locale: :en)

## Example - transalte in Portuguese
# puts I18n.translate(:confirm, locale: 'pt-BR')
"

class RemoteI18nConfigGenerator < Rails::Generators::Base
  desc "This generator creates an initializer file at config/initializers"
  def create_initializer_file
    create_file("config/initializers/remote_i18n.rb", INITIALIZER_CONTENT)
  end
end
