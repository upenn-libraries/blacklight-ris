
module Blacklight::Solr::Document::RisFields

  extend ActiveSupport::Concern

  module ClassMethods
    def ris_field_mappings
      @ris_field_mappings ||= {}
    end
  end

end
