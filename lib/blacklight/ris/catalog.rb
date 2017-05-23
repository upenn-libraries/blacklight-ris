
module Blacklight::Ris

  # mix-in for CatalogController
  module Catalog
    extend ActiveSupport::Concern

    included do
      # this also causes Blacklight's show endpoint to handle .ris
      add_show_tools_partial(:ris, label: 'Download in RIS format', if: :render_ris_action?, modal: false, path: :ris_path)
    end

    private

    def render_ris_action? config, options = {}
      doc = options[:document] || (options[:document_list] || []).first
      doc && doc.respond_to?(:export_formats) && doc.export_formats.keys.include?(:ris )
    end

  end
end
