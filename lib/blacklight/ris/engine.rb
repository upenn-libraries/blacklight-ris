
module Blacklight::Ris
    class Engine < ::Rails::Engine
      isolate_namespace Blacklight::Ris

      initializer 'blacklight-ris.initialize' do |app|
        Mime::Type.register 'application/x-research-info-systems', :ris
      end

      initializer 'blacklight-ris.helpers' do |app|
        config.after_initialize do
          ActionView::Base.include BlacklightRisHelper
        end
      end
    end
end
