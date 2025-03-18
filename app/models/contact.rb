class Contact < ApplicationRecord
    validates :name, presence: true
    validates :email, presence: true, uniqueness: true

    def self.search(search_string)
        name_search = FuzzyMatch.new(Contact.all, :read => :name, :threshold => Rails.application.config.fuzzy_match_threshold)
        email_search = FuzzyMatch.new(Contact.all, :read => :email, :threshold => Rails.application.config.fuzzy_match_threshold)

        names = name_search.find_all(search_string)
        emails = email_search.find_all(search_string)
        (emails + names).uniq
    end
end
