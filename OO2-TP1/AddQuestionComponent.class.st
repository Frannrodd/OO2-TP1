Class {
	#name : #AddQuestionComponent,
	#superclass : #CommonMethods,
	#instVars : [
		'title',
		'description',
		'topics',
		'question'
	],
	#category : #'OO2-TP1-View'
}

{ #category : #'as yet unclassified' }
AddQuestionComponent class >> onAddQuestion [
	^ self new
		on:
			(Question
				title: 'escriba el titulo aqui'
				Description: 'escriba la descripcion aqui'
				Topics: Set new)
]

{ #category : #'as yet unclassified' }
AddQuestionComponent class >> onAddQuestion: arg1 cuOOra: arg2 [
	^ self new
		on:
			(Question
				title: 'escriba el titulo aqui'
				Description: 'escriba la descripcion aqui'
				Topics: Set new)
		sesion: arg1
		cuOOra: arg2
]

{ #category : #'as yet unclassified' }
AddQuestionComponent >> cancel [
	question := nil.
	self answer
]

{ #category : #'as yet unclassified' }
AddQuestionComponent >> description [
	^ description
]

{ #category : #'as yet unclassified' }
AddQuestionComponent >> description: arg1 [
	description := arg1
]

{ #category : #'as yet unclassified' }
AddQuestionComponent >> logOut [
	question := nil.
	super logOut
]

{ #category : #'as yet unclassified' }
AddQuestionComponent >> on: aQuestion [
	question := aQuestion.
	description := question description.
	title := question title.
	cuOOra := CuOOra soleInstance.
	topics := 'ingrese los topicos separados por coma'
]

{ #category : #'as yet unclassified' }
AddQuestionComponent >> question [
	^ question
]

{ #category : #'as yet unclassified' }
AddQuestionComponent >> renderContentOn: aCanvas [
	self renderUpperToolbarOn: aCanvas.
	aCanvas 
		heading: 'Nueva pregunta';
		horizontalRule.
	self renderQuestion: aCanvas 
]

{ #category : #'as yet unclassified' }
AddQuestionComponent >> renderQuestion: aCanvas [
	aCanvas
		form: [ | button1 button2 textBlock |
			aCanvas
				text: 'titulo:  ';
				break.
			aCanvas textInput on: #title of: self.
			aCanvas
				break;
				text: 'desarrollo: '.
			aCanvas break.
			textBlock := aCanvas textArea on: #description of: self.
			textBlock
				columns: 80;
				rows: 5.
			aCanvas
				break;
				text: 'topicos: '.
			aCanvas break.
			aCanvas textInput on: #topics of: self.
			aCanvas
				break;
				break.
			button1 := aCanvas submitButton.
			button1
				callback: [ self save ];
				value: 'Guardar'.
			button2 := aCanvas submitButton.
			button2
				callback: [ self cancel ];
				value: 'Cancelar' ]
]

{ #category : #'as yet unclassified' }
AddQuestionComponent >> save [
	| topicCollection aTopicSet newQuestion topic |
    topicCollection := self topics substrings: ','.
    aTopicSet := Set new.
    1 to: topicCollection size do: [ :tmp8 | 
        topic := Topic title: (topicCollection at: tmp8) description: ''.
        aTopicSet add: topic].
    newQuestion := question.
    newQuestion
        topics: aTopicSet;
        title: title.
    ^ self answer
]

{ #category : #'as yet unclassified' }
AddQuestionComponent >> title [
	^ title
]

{ #category : #'as yet unclassified' }
AddQuestionComponent >> title: aTitle [
	title := aTitle
]

{ #category : #'as yet unclassified' }
AddQuestionComponent >> topics [
	^ topics
]

{ #category : #'as yet unclassified' }
AddQuestionComponent >> topics: aTopic [
	topics := aTopic 
]
