# Sett opp en redirect til localhost i /etc/hosts
# hvis du skal kjøre serveren lokalt
@SERVER_URL = "http://sheep-tracker-32102.euw1.actionbox.io:8888"

@notifications =
  edited: "Your sheep %s was successfully edited"
  editedError: "Could not edit sheep %s"
  created: "Your sheep %s was successfully created"
  createdError: "Could not create sheep %s"
  deleted: "Your sheep %s was successfully deleted"