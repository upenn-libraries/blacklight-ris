module Blacklight
  module Ris
    class Engine < ::Rails::Engine
      isolate_namespace Blacklight::Ris

      initializer 'blacklight-ris.initialize' do |app|
        Mime::Type.register 'application/x-research-info-systems', :ris
      end

      initializer 'blacklight-ris.helpers' do |app|
        ActionView::Base.send :include, BlacklightRisHelper
      end

    end
  end
end
