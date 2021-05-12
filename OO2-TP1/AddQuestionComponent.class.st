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
AddQuestionComponent >> on: arg1 [
	question := arg1.
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
AddQuestionComponent >> renderContentOn: arg1 [
	| tmp2 |
	self renderUpperToolbarOn: arg1.
	tmp2 := arg1.
	tmp2
		heading: 'Nueva pregunta';
		horizontalRule.
	self renderQuestion: arg1
]

{ #category : #'as yet unclassified' }
AddQuestionComponent >> renderQuestion: arg1 [
	arg1
		form: [ | tmp1 tmp2 tmp3 tmp4 tmp6 |
			arg1
				text: 'titulo:  ';
				break.
			arg1 textInput on: #title of: self.
			tmp3 := arg1.
			tmp3
				break;
				text: 'desarrollo: '.
			arg1 break.
			tmp6 := arg1 textArea on: #description of: self.
			tmp6
				columns: 80;
				rows: 5.
			tmp4 := arg1.
			tmp4
				break;
				text: 'topicos: '.
			arg1 break.
			arg1 textInput on: #topics of: self.
			arg1
				break;
				break.
			tmp1 := arg1 submitButton.
			tmp1
				callback: [ self save ];
				value: 'Guardar'.
			tmp2 := arg1 submitButton.
			tmp2
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
        aTopicSet add: topic.
        cuOOra addTopic: topic ].
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
AddQuestionComponent >> title: arg1 [
	title := arg1
]

{ #category : #'as yet unclassified' }
AddQuestionComponent >> topics [
	^ topics
]

{ #category : #'as yet unclassified' }
AddQuestionComponent >> topics: arg1 [
	topics := arg1
]
