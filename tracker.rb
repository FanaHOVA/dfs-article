require './database'
require './csv_analysis'

URL = 'https://www.draftkings.com/lineup/getavailableplayerscsv?contestTypeId=28&draftGroupId=14039'.freeze

Database.setup
CsvAnalysis.scrape(URL)

players = DB[:players]

CsvAnalysis.format_for_database.each do |player|
  players.insert(player)
end
