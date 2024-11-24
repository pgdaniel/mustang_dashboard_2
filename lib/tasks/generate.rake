namespace :generate do
  desc "Test signals"
  task signals: :environment do
    (1..1000).each do |i|
      ActionCable.server.broadcast("dashboard_channel", JSON.dump({ incoming_data: "rpm",  data: i * 100 }))
      ActionCable.server.broadcast("dashboard_channel", JSON.dump({ incoming_data: "speed",  data: i * 10 }))
    end
  end
end
