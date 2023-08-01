# frozen_string_literal: true

RSpec.describe RemoteI18n do
  it 'has a version number' do
    expect(RemoteI18n::VERSION).not_to be nil
  end

  context 'test remote translations' do
    before do
      I18n.config.remote_urls = [
        'https://raw.githubusercontent.com/g1stavo/rails-i18n/master/config/locales/en.yml',
        'https://raw.githubusercontent.com/g1stavo/rails-i18n/master/config/locales/pt-BR.yml'
      ]
    end

    it 'returns a valid en translation' do
      expect(I18n.translate(:confirm, locale: :en)).to eq('Are you sure?')
    end

    it 'returns a valid pt-BR translation' do
      expect(I18n.translate(:confirm, locale: 'pt-BR')).to eq('Você tem certeza?')
    end
  end

  context 'remote URLs are set empty: fallbacks to local translations' do
    before do
      I18n.config.remote_urls = []
      I18n.load_path = [
        "#{RSPEC_ROOT}/locales/en.yml",
        "#{RSPEC_ROOT}/locales/pt-BR.yml"
      ]
    end

    it 'returns a valid en translation' do
      expect(I18n.translate(:confirm, locale: :en)).to eq('Are you sure? from local FILE')
    end

    it 'returns a valid pt-BR translation' do
      expect(I18n.translate(:confirm, locale: 'pt-BR')).to eq('Você tem certeza? from local FILE')
    end
  end

  context 'remote URLs are unreachable: fallbacks to local translations' do
    before do
      I18n.config.remote_urls = [
        'https://raw.githubusercontent.com/g1stavo/rails-i18n/master/config/locales/en.yml',
      ]
      I18n.load_path = [
        "#{RSPEC_ROOT}/locales/en.yml",
        "#{RSPEC_ROOT}/locales/pt-BR.yml"
      ]

      # Forces HTTParty to throw exception
      expect(HTTParty).to receive(:get).and_raise(StandardError)
    end

    it 'returns a valid en translation' do
      expect(I18n.translate(:confirm, locale: :en)).to eq('Are you sure? from local FILE')
    end

    it 'returns a valid pt-BR translation' do
      expect(I18n.translate(:confirm, locale: 'pt-BR')).to eq('Você tem certeza? from local FILE')
    end
  end
end
