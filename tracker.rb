require './database'
require './csv_analysis'
require './notification'

URL = 'https://www.draftkings.com/lineup/getavailableplayerscsv?contestTypeId=28&draftGroupId=14039'.freeze

Database.setup
CsvAnalysis.scrape(URL)

players = DB[:players]

CsvAnalysis.format_for_database.each do |player|
  # Make sure we check both name and team to avoid omonims
  existing_player = DB[:players].where(name: player[:name], team: player[:team]).first
  puts "#{existing_player}"
  if existing_player
    puts "Called with #{existing_player}"
    #next unless existing_player[:salary].to_i != player[:salary].to_i
    Notification.mms(existing_player)
  else
    Notification.mms(player)
    players.insert(player)
  end
end
