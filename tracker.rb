require './database'
require './csv_analysis'
require './notification'

URL = 'https://www.draftkings.com/lineup/getavailableplayerscsv?contestTypeId=28&draftGroupId=14039'.freeze

Database.setup
CsvAnalysis.scrape(URL)

players = DB[:players]

CsvAnalysis.format_for_database.each do |player|
  existing_player = DB[:players].where(name: player[:name], team: player[:team]).first
  if existing_player
    next unless existing_player[:salary].to_i != player[:salary].to_i
    Notification.mms(player)
  else
    players.insert(player)
  end
end
