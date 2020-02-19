class SourceCombinator
  require 'csv'
  require 'json'
  require './parse_journals'
  require './parse_articles'
  require './parse_authors'

  def initialize(journals_filename, articles_filename, authors_filename)
    @journals_filename = journals_filename
    @articles_filename = articles_filename
    @authors_filename = authors_filename
  end

  def generate_csv
    if all_sources_valid?
      csv_normalised_rows
    else
      false
    end
  end

  def generate_json
    if all_sources_valid?
      json_normalised_rows
    else
      false
    end
  end

  private

  attr_reader :journals_filename, :articles_filename, :authors_filename

  def normalised_rows
    @normalised_rows ||= articles.map do |article|
      doi = article[:doi]
      issn = article[:issn]
      {
        doi: doi,
        title: article[:title],
        author: authors[doi],
        journal: journals[issn],
        issn: issn,
      }
    end
  end

  def json_normalised_rows
    @json_normalised_rows ||= normalised_rows.to_json
  end

  def csv_normalised_rows
    @csv_normalised_rows ||= begin
      column_names = normalised_rows.first.keys
      CSV.generate do |csv_output|
        csv_output << column_names

        normalised_rows.each do |row|
          csv_output << row.values
        end
      end
    end
  end

  def all_sources_valid?
    @all_sources_valid ||= journals && articles && authors
  end

  def journals
    @journals ||= ::ParseJournals.new(journals_filename).call
  end

  def articles
    @articles ||= ::ParseArticles.new(articles_filename).call
  end

  def authors
    @authors ||= ::ParseAuthors.new(authors_filename).call
  end
end
