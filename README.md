# blacklight-ris

Adds "Download in RIS format" functionality to [Blacklight](https://github.com/projectblacklight/blacklight).

## Description
Blacklight plugin that adds the ability to download a [RIS representation](https://en.wikipedia.org/wiki/RIS_(file_format)) of a record from a catalog show page and a set of records from the bookmarks index page.

### Versioning
`v0.1.0` -> Known to work with Blacklight v6 and Rails 4

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'blacklight-ris', '0.1.0'
```

And then execute:
```bash
$ bundle install
```

## Usage

Modify your `SolrDocument` class with the extension modules for RIS,
and define your field mappings using the `ris_field_mappings` hash.

```ruby
class SolrDocument

  # ...existing code...

  include Blacklight::Solr::Document::RisFields
  use_extension(Blacklight::Solr::Document::RisExport)

  ris_field_mappings.merge!(
    # Procs are evaluated in context of SolrDocument instance
    :TY => Proc.new {
      format = fetch('format_a', [])
      if format.member?('Book')
        'BOOK'
      elsif format.member?('Journal/Periodical')
        'JOUR'
      else
        'GEN'
      end
    },
    # use solr field named 'title'
    :TI => 'title',
    :AU => 'author_creator_a',
    :PY => 'publication_date_a',
    # this assumes you're using blacklight-marc
    :CY => Proc.new { marclibrary.get_ris_cy_field(to_marc) },
    :PB => Proc.new { marclibrary.get_ris_pb_field(to_marc) },
    :ET => 'edition',
    :SN => Proc.new { marclibrary.get_ris_sn_field(to_marc) },
  )
end
```

Modify your `CatalogController` to include the
`Blacklight::Ris::Catalog` module. Put this at the end of any existing
includes.

```ruby
class CatalogController < ApplicationController
  # ...existing includes...
  include Blacklight::Catalog
  
  # add this line
  include Blacklight::Ris::Catalog
end
```

The show view and bookmarks page should now display links for
downloading records in RIS format.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
