class SheepTracker.Views.Datepicker extends Thorax.View

  # Variables
  className: "datepicker"
  hidden: false
  autoRender: true
  headerFormat: "MMMM YYYY"
  dateFormat: "MM/DD/YYYY"
  firstDayOfWeek: 1
  linkTemplate: null

  position:
    my: 'left top',
    at: 'left bottom',
    collision: 'fit'

  # Bind events on when the user clicks
  # the calendar
  events:
    "mousedown .datepicker-prev": (e) ->
      e.preventDefault()
      # Go to the previous month
      @prev()

    "mousedown .datepicker-next": (e) ->
      e.preventDefault()
      # Go to the next month
      @next()

    "mousedown .day": (e) ->
      e.preventDefault()
      # Select the day that the user clicked
      @select(e.target.getAttribute("data-datestamp"))

  initialize: ->
    
    @range = []

    # Set the id of the element
    @el.id = @id = 'dp-' + new Date().getTime()

    # Hide or show based on variable
    if @hidden then @$el.hide() else @$el.show()

    # Set current date from Moment.js
    @now = moment()
    @visible = false

    # Renders the view
    @render() if @autoRender

  render: ->
    # Empty the calendar
    @$el.empty()

    # Creates the header and body elements
    # and renders these
    @$header = $('<div class="datepicker-header"></div>')
    @$body = $('<div class="datepicker-body"></div>')
    @renderHeader()
    @renderBody()

    # Appends the element to the calendar view
    @$el.append(@$header).append(@$body)

  renderHeader: ->
    # Create button element for previous and
    # next month
    prevBtn = document.createElement('a')
    prevBtn.className = 'datepicker-prev'
    nextBtn = document.createElement('a')
    nextBtn.className = 'datepicker-next'

    # Create the month title element
    @monthHeader = $('<div class="datepicker-title">' + @now.format(@headerFormat) + '</div>')

    # Elements for each day label in the header
    dayLabels = _.map(["Sun", "Mon", "Tue", "Wed", "Thurs", "Fri", "Sat"], (str) -> '<span>' + str.substr(0, 2) + '</span>')
    dayLabels = dayLabels.concat(dayLabels.splice(0, @firstDayOfWeek))

    # Creates a inner element and appened
    # the newly created elements
    $(document.createElement("div"))
          .addClass('datepicker-header-inner')
          .append(prevBtn)
          .append(@monthHeader)
          .append(nextBtn)
          .append('<div class="datepicker-daysofweek">' + dayLabels.join('') + '</div>')
          .appendTo(@$header)

    # Returns the header element
    @$header

  renderBody: ->
    # Get current date from Moment.js
    today = moment()
    d = moment(@now).date(1)

    # If the first day of the month is early in the week, draw the week before.
    firstDay = moment(d).day(@firstDayOfWeek).add('days', 3)
    if firstDay.toDate() > d.toDate()
      d.subtract('days', 7)

    d = d.day(@firstDayOfWeek)

    @range[0] = moment(d)


    # Empty tyhe body element
    @$body.empty()

    # Render each day in the calendar
    for j in [0..5]
      for i in [0..6]

        # Add classes to the elements
        classes = ['day']
        classes.push('first') if i == 0
        classes.push('last')  if i == 6

        # Days that are not in the current month
        if @now.month() != d.month()
          classes.push('not-in-month')

        # Add class to the date that is today
        if (today.toDate().toLocaleDateString() == d.toDate().toLocaleDateString())
          classes.push('today')

        # Creates an element that holds the day element
        E = $(document.createElement('a')).attr({
          'data-datestamp': d.format(@dateFormat),
          'class': classes.join(' ')
        }).html(d.date())

        # Appends it to the body
        E.appendTo(@$body)
        d.add('days', 1)

    @range[1] = d.clone()

    # Returns the body
    @$body

  showDate: (date) ->
    # Set the current date
    @now = moment(date) if date

    # Set the current month and render the body
    @monthHeader.html(@now.format(@headerFormat))
    @renderBody()

  prev: ->
    # Render the previous month
    @now.subtract('months', 1)
    @showDate()

  next: ->
    # Render the next month
    @now.add('months', 1)
    @showDate()

  show: ->
    # Display the calendar
    @visible = true
    @$el.show().position(@position)
    @trigger('show')

  hide: ->
    # Hide the calendar
    @visible = false
    @$el.hide()
    @trigger('hide')

  select: (date, options) ->
    # Define the date to be selected
    date = moment(date) if _.isString(date)

    # Extend the options object with the defalts
    options = _.extend({ silent: false, toggle: true }, options)

    # Show the new date unless it's already visible
    if date.format(@dateFormat) != @now.format(@dateFormat)
      @showDate(date)

    # Clear the highlight
    @clear() if(options.toggle)

    # Highlight the newly selected element 
    elem = @$body.find('[data-datestamp="' + date.format(@dateFormat) + '"]').addClass('highlight')

    # Trigger the select event on the view
    if !options.silent
      @trigger('select', date, elem)

    # Return this
    this

  selectRange: (date1, date2, options) ->
    # Extend the options object with the defalts
    options = _.extend({ silent: false, toggle: true }, options)
    
    # Clear the highlight
    @clear() if options.toggle

    # If range is that same select the same day
    if(date1 == date2)
      @select(date1, options)
    else
      date1 = date1.clone()
      date2 = date2.clone()
      options.toggle = false

      # Select all days that are within the range 
      while date1 <= date2
        @select(date1, options)
        date1.setDate(date1.getDate() + 1)

  clear: ->
    # Clear the highlight class and trigger the clear event
    @trigger('clear')
    @$body.children().removeClass('highlight')