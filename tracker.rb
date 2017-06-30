require './database'
require './csv_analysis'
require './notification'

URL = 'https://www.draftkings.com/lineup/getavailableplayerscsv?contestTypeId=28&draftGroupId=14039'.freeze

Database.setup
CsvAnalysis.scrape(URL)

players_table = DB[:players]
price_changes = []

CsvAnalysis.format_for_database.each do |player|
  # Make sure we check both name and team to avoid omonims
  existing_player = DB[:players].where(name: player[:name], team: player[:team]).first

  if existing_player
    #next unless existing_player[:salary].to_i != player[:salary].to_i
    price_changes << existing_player
  else
    players_table.insert(player)
  end
end

DB[:players].where(team: 'WAS').each do |pl|
  price_changes << pl
end

Notification.mms(price_changes) unless price_changes.empty?
