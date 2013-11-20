# Defines a new collection for activities
class SheepTracker.Collections.Activities extends Thorax.Collection

  # Specifies the server URL and
  # which model the data is
  url: "#{SERVER_URL}/history/"
  model: SheepTracker.Models.Activity