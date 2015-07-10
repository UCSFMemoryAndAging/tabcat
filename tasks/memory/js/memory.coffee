###
Copyright (c) 2013, Regents of the University of California
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


# empty translations block for now
translations =
  en:
    translation:
      '...'
  es:
    translation:
      '...'

MemoryTask = class
  CHOICES = {
    ANIMAL: {
      DOLPHIN: 'dolphin',
      WOLF: 'wolf',
      TURTLE: 'turtle',
      SHARK: 'shark',
      COW: 'cow'
    },
    FOOD: {
      APPLE: 'apple',
      POTATO: 'potato',
      GRAPES: 'grapes',
      MELON: 'melon',
      CARROTS: 'carrots'
    }
  }

  PEOPLE = {
    MAN1: { #glasses and red shirt
      FOOD: CHOICES.FOOD.APPLE,
      IMAGE: 'man1'
    },
    MAN2: { #bald with sport coat
      FOOD: CHOICES.FOOD.POTATO,
      ANIMAL: CHOICES.ANIMAL.TURTLE,
      IMAGE: 'man2'
    },
    MAN3: { #purple shirt
      FOOD: CHOICES.FOOD.MELON,
      ANIMAL: CHOICES.ANIMAL.COW,
      IMAGE: 'man3'
    },
    WOMAN1: { #long dark hair
      ANIMAL: CHOICES.ANIMAL.DOLPHIN,
      IMAGE: 'woman1'
    },
    WOMAN2: { #hair pullled back with blue eyes
      FOOD: CHOICES.FOOD.CARROTS,
      ANIMAL: CHOICES.ANIMAL.WOLF,
      IMAGE: 'woman2'
    },
    WOMAN3: { #glasses and gray hair
      FOOD: CHOICES.FOOD.GRAPES,
      ANIMAL: CHOICES.ANIMAL.SHARK,
      IMAGE: 'woman3'
    }
  }

  FORM_ONE = {
    EXAMPLE: [
      { type: 'firstExampleRemember', person: PEOPLE.MAN1, remember: 'food' },
      { type: 'exampleRemember', person: PEOPLE.WOMAN1 , remember: 'animal' },
      { type: 'exampleRecall', person: PEOPLE.MAN1, recall: 'food' },
      #{ type: 'exampleRecall', person: PEOPLE.WOMAN1, recall: 'animal' }
      { type: 'exampleRecall', person: PEOPLE.WOMAN1, recall: 'animal' }
    ],
    TRIALS: {
      IMMEDIATE_RECALL: [
        REMEMBER: [
          { type: 'rememberOne', person: PEOPLE.MAN2, remember: 'food' },
          { type: 'rememberOne', person: PEOPLE.WOMAN2, remember: 'animal' },
          { type: 'rememberOne', person: PEOPLE.WOMAN3, remember: 'food' },
          { type: 'rememberOne', person: PEOPLE.MAN2, remember: 'animal' },
          { type: 'rememberOne', person: PEOPLE.MAN3, remember: 'food' },
          { type: 'rememberOne', person: PEOPLE.WOMAN3, remember: 'animal' },
          { type: 'rememberOne', person: PEOPLE.MAN3, remember: 'animal' },
          { type: 'rememberOne', person: PEOPLE.WOMAN2, remember: 'food' }
        ],
        RECALL: [
          { type: 'recallTwo', person: PEOPLE.MAN2 },
          { type: 'recallTwo', person: PEOPLE.WOMAN3 },
          { type: 'recallTwo', person: PEOPLE.WOMAN2 },
          { type: 'recallTwo', person: PEOPLE.MAN3 }
        ]
      ],
      DELAYED_RECALL: [
        REMEMBER: [
          { type: 'rememberOne', person: PEOPLE.WOMAN2, remember: 'animal' },
          { type: 'rememberOne', person: PEOPLE.MAN2, remember: 'food' },
          { type: 'rememberOne', person: PEOPLE.WOMAN3, remember: 'animal' },
          { type: 'rememberOne', person: PEOPLE.MAN2, remember: 'animal' },
          { type: 'rememberOne', person: PEOPLE.WOMAN2, remember: 'food' },
          { type: 'rememberOne', person: PEOPLE.MAN3, remember: 'animal' },
          { type: 'rememberOne', person: PEOPLE.WOMAN3, remember: 'food' },
          { type: 'rememberOne', person: PEOPLE.MAN3, remember: 'food' }
        ],
        RECALL: [
          { type: 'recallTwo', person: PEOPLE.MAN3 },
          { type: 'recallTwo', person: PEOPLE.MAN2 },
          { type: 'recallTwo', person: PEOPLE.WOMAN3 },
          { type: 'recallTwo', person: PEOPLE.WOMAN2 }
        ]
      ]
    }
  }
  # main div's aspect ratio (pretend we're on an iPad)
  ASPECT_RATIO = 4/3

  constructor: ->
    #current form - static for now, will add switch later
    #@currentForm = FORM_ORDER.FORM_ONE
    #@currentFormNumber = 1

    #current digit presented on screen
    @currentStimuli = null

    @secondsElapsed = 0

    @isInDebugMode = TabCAT.Task.isInDebugMode()

    @practiceTrialsShown = 0

  showStartScreen: ->
    $('#startScreen').show()
    for exampleTrial in FORM_ONE.EXAMPLE
      do (exampleTrial) =>
        console.log exampleTrial
        # looking to move away from switch, will refactor later.
        # looking for something to automatically call
        # function with the same name as type, but there's some strange
        # behavior regarding scope that I don't yet understand
        switch exampleTrial.type
          when "firstExampleRemember" then \
            @firstExampleRemember exampleTrial.person, exampleTrial.remember
          when "exampleRemember" then \
            @exampleRemember exampleTrial.person, exampleTrial.remember
          when "exampleRecall" then \
            @exampleRecall exampleTrial.person, exampleTrial.recall
          else console.log "some other type"


  start: ->
    TabCAT.Task.start(
      i18n:
        resStore: translations
      trackViewport: true
    )
    TabCAT.UI.turnOffBounce()

    $task = $('#task')
    $rectangle = $('#rectangle')

    TabCAT.UI.requireLandscapeMode($task)
    $task.on('mousedown touchstart', ( -> ) )

    TabCAT.UI.fixAspectRatio($rectangle, ASPECT_RATIO)
    TabCAT.UI.linkEmToPercentOfHeight($rectangle)

    @showStartScreen()

  firstExampleRemember: (person, remember) ->
    console.log "first example remember:"
    console.log person
    console.log remember

  exampleRemember: (person, remember) ->
    console.log "example remember:"
    console.log person
    console.log remember

  exampleRecall: (person, recall) ->
    console.log "example recall"
    console.log person
    console.log recall

  rememberOne: (person, remember) ->
    console.log "remember one:"
    console.log person
    console.log remember

  recallTwo: (person) ->
    console.log "recall both"


@InitialMemoryTask = class extends MemoryTask
  constructor: ->
    super()

#Not implementing for now, just creating the skeleton
@DelayedRecallTask = class extends MemoryTask
