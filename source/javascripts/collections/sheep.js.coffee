# Defines a new collection for sheep
class SheepTracker.Collections.Sheep extends Thorax.Collection

  # Specifies the server URL and
  # which model the data is
  url: "#{SERVER_URL}/sheep/"
  model: SheepTracker.Models.Sheep