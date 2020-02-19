class AuthorJsonRow
  attr_reader :json_row

  def initialize(json_row)
    @json_row = json_row
  end

  def valid?
    json_row.key?(:name) && json_row.key?(:articles)
  end

  def normalised_row
    @normalised_row ||=
      json_row[:articles].map{ |article_doi| [ article_doi, json_row[:name] ]}
  end
end
