class Vocabulary < ApplicationRecord
  def self.search_english(search)
    return Vocabulary.all unless search
    Vocabulary.where(['word LIKE ?', "%#{search}%"])
  end

  def self.search_japanies(search)
    return Vocabulary.all unless search
    Vocabulary.where(['meaning LIKE ?', "%#{search}%"])
  end
end
