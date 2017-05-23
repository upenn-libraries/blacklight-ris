
module Blacklight::Solr::Document::RisExport

  def self.extended(document)
    document.will_export_as(:ris, 'application/x-research-info-systems')
  end

  def export_as_ris
    ris_hash = to_ris_hash
    lines = ris_hash.keys
      .select { |key| ris_hash[key].present? }
      .flat_map { |key| render_ris_key_value(key, ris_hash[key]) }
    lines << 'ER  - '
    lines.compact.join("\n")
  end

  def render_ris_key_value(key, val)
    if val.is_a?(Array)
      val.map { |v| "#{key}  - #{v}" }
    else
      "#{key}  - #{val}"
    end
  end

  def to_ris_hash
    h = Hash.new
    self.class.ris_field_mappings.each do |key, val|
      if val.is_a?(Proc)
        h[key] = instance_eval(&val)
      else
        h[key] = fetch(val, '')
      end
    end
    h
  end

end
