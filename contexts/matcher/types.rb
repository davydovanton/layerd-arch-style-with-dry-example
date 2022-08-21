module Matcher
  module Types
    include Dry.Types()

    # Types for account
    AccountCharacteristic = String.constrained(min_size: 10) # you can check that characteristic in specific format

    # Types for toys
    CatToyTitle = String.constrained(min_size: 3)
    CatToyCharacteristic = Integer
    CatToyArchivedStatus = Bool.default(false).constructor do |value|
      # SQLite doesn't have bool type in schema, that's why I made this hack
      value == 1 || value == true ? true : false
    end
  end
end
