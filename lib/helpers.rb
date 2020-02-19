class Helpers
  def self.normalise_issn(issn)
    parsed_issn = /(?<first_digit_group>[0-9]{4})-{0,1}(?<second_digit_group>[0-9]{4})/.match(issn)
    "#{parsed_issn[:first_digit_group]}-#{parsed_issn[:second_digit_group]}"
  end
end
