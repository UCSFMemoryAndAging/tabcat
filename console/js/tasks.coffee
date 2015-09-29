###
Copyright (c) 2013-2014, Regents of the University of California
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are
met:

  1. Redistributions of source code must retain the above copyright
  notice, this list of conditions and the following disclaimer.
  2. Redistributions in binary form must reproduce the above copyright
  notice, this list of conditions and the following disclaimer in the
  documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
###
# TASK INFO

translations =
  en:
    translation:
      all_tasks: 'All Tasks'
  es:
    translation:
      all_tasks: 'Todas Tareas'


# get task info from the server, and then display an icon and a description
# for each task
showTasks = ->
  TabCAT.Task.getTaskInfo().then((taskInfo) ->
    $('#taskList').empty()

    batteries = _.sortBy(_.pairs(taskInfo.batteries), (n, b) -> b.description)
    tasksByName = taskInfo.tasks

    # add a fake battery for all tasks
    allTaskNames = _.sortBy(
      _.keys(tasksByName), (name) ->
        $.t("config:tasks.#{name}.description",
          defaultValue: tasksByName[name].description))

#    batteries.push(['all-tasks',
#      description: $.t('all_tasks')
#      tasks: allTaskNames
#    ])

    taskScoring = TabCAT.Encounter.getTaskScoring()

    for [batteryName, battery] in batteries
      if not battery.description? or battery.tasks.length is 0
        continue

      $batteryDiv = $('<div></div>', class: 'battery')
      $batteryHeader = $('<div></div>', class: 'header')
      $batteryHeader.text(
        $.t("config:batteries.#{batteryName}.description",
          defaultValue: battery.description))
      $batteryDiv.append($batteryHeader)

      $tasksDiv = $('<div></div>', class: 'tasks ')

      for taskName in battery.tasks
        task = tasksByName[taskName]

        if not (task? and task.start? and task.description?)
          continue

        $taskDiv = $('<div></div>', class: 'task')

        iconUrl = TabCAT.Console.getTaskIconUrl(task)

        attempted = taskScoring[taskName]?
        finished = attempted and _.last(taskScoring[taskName]) isnt false
        scores = _.last(taskScoring[taskName])?.scores

        if finished
          # make the icon the background, and the checkmark the foreground
          # TODO: use absolute positioning and z-indexes to do a real overlay
          $icon = $('<img>', class: 'icon', src: 'img/check-overlay.png')
          $icon.css('background-image', "url(#{iconUrl})")
        else
          $icon = $('<img>', class: 'test-buttons', src: iconUrl)
        $taskDiv.append($icon)

        $taskDescription = $('<span></span>', class: 'description')
        $taskDescription.text(
          $.t("config:tasks.#{taskName}.description",
            defaultValue: task.description))
        $taskDiv.append($taskDescription)

        $scoringMessage = $('<span></span>', class: 'scoringMessage')

        if scores
          $scoringMessage.text('tap to show scoring')
          $taskDiv.append($scoringMessage)

          $scores = $('<div></div>', class: 'scores collapsed')
          TabCAT.Console.populateWithScores($scores, scores)
          $taskDiv.append($scores)

          # add handler to show scores (separate scope for each task)
#          do ($scores, $scoringMessage) ->
#            $taskDiv.on('click', (event) ->
#              # toggle visibility of scores
#              event.preventDefault()
#              if $scores.is('.collapsed')
#                $scores.removeClass('collapsed')
#                $scoringMessage.text('tap to hide scoring')
#              else
#                $scores.addClass('collapsed')
#                $scoringMessage.text('tap to show scoring')
#            )
        else if finished
          $scoringMessage.text('no scoring available for this task')
        else
          if attempted
            $scoringMessage.text('not completed; tap to retry')

          # add handler to launch task (separate scope for each task)
          do ->
            startUrl = TabCAT.Console.getTaskStartUrl(task)
            if startUrl?
              # start the task
              $taskDiv.on('click', (event) -> window.location = startUrl)

#              if task.forms
#                for form, value of task.forms
#                  do ( =>
#                    $icon = $('<span></span>', class: 'alternateForm')
#                    formUrl = startUrl + '?form=' + value
#                    $icon.text(form)
#                    $icon.on('click', (event) ->
#                      event.preventDefault()
#                      event.stopPropagation()
#                      window.location = formUrl
#                      return false
#                    )
#                    $taskDiv.append $icon
#                  )

        $taskDiv.append($scoringMessage)
        $tasksDiv.append($taskDiv)

      $batteryDiv.append($tasksDiv)
      do ($tasksDiv) ->
        $batteryHeader.on('click', (event) ->
          event.preventDefault()
          shouldOpen = ($tasksDiv).is('.collapsed')
          $('#taskList').find('div.tasks').addClass('collapsed')
          if shouldOpen
            $tasksDiv.removeClass('collapsed')
        )

      $('#taskList').append($batteryDiv)
  )


# initialization
@initPage = ->
  TabCAT.UI.requireUserAndEncounter()
  TabCAT.UI.enableFastClick()

  TabCAT.Console.start(i18n: {resStore: translations})

  $(->
    showTasks()
    $('#closeEncounter').on('click', ->
      window.location = 'close-encounter.html'
      return
    )
    $('#closeEncounter').removeAttr('disabled')
  )
