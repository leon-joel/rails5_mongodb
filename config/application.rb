require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
# require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Rails5Mongodb
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.


    config.time_zone = 'Tokyo'
    # http://qiita.com/sutoh/items/b7d23990abb9c5083daa

    # ja.ymlを準備しているならコメントを外してもOK
    # config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :ja

    # Viewの呼び出しをログ出力する?
    config.action_view.logger = nil

    # デフォルトのテンプレートエンジン :haml or :slim
    config.generators.template_engine = :haml

    # assetsへのアクセスログを抑止するgem "quiet_assets" を使う?
    # config.quiet_assets = false

    config.generators do |g|
      g.assets false
      g.helper false
      g.jbuilder false
      g.test_framework :rspec,
                       fixture: true,
                       fixture_replacement: :factory_girl,
                       # model_specs: false,
                       view_specs: false,
                       controller_specs: false,
                       routing_specs: false,
                       helper_specs: false,
                       integration_tool: false
      # 注意: ここ↑でfalseにしたspecは、単体の generate コマンドでも作れなくなってしまう。
    end
  end
end
