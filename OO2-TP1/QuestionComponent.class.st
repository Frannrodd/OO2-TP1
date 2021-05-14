Class {
	#name : #QuestionComponent,
	#superclass : #CommonMethods,
	#instVars : [
		'question'
	],
	#category : #'OO2-TP1-View'
}

{ #category : #'as yet unclassified' }
QuestionComponent class >> enterQuestion: arg1 [
	^ self new on: arg1
]

{ #category : #adding }
QuestionComponent >> addAnswerDialog [
	| answerComponent |
	answerComponent := AddAnswerComponent
		onAddAnswer: question
		and:
			question user.
	self call: answerComponent.
	answerComponent answer2
		ifNotNil: [ question addAnswer: answerComponent answer2.
			self session user addPost: answerComponent answer2 ]
]

{ #category : #'as yet unclassified' }
QuestionComponent >> on: arg1 [
	question := arg1.
	cuOOra := CuOOra soleInstance
]

{ #category : #adding }
QuestionComponent >> question [
	^ question
]

{ #category : #adding }
QuestionComponent >> renderAddAnswerOn: aCanvas [
| section |
	aCanvas
		text: 'no hay mas respuestas';
		break.
	self session
		ifNotNil: [ 
			section := aCanvas anchor.
			section
				callback: [ self addAnswerDialog ];
				with: 'Hacer una nueva respuesta' ]
]

{ #category : #adding }
QuestionComponent >> renderAnswer: anAnswer on: aCanvas [
	| section |
	aCanvas
		table: [ section := aCanvas.
			section
				tableRow: [ aCanvas
						tableData: [ aCanvas text: 'realizada por: '.
							section := aCanvas anchor.
							section
								callback: [ self
										enterUserDialog: (anAnswer user )];
								with:
									( anAnswer user )
										username ] ];
				tableRow: [ aCanvas tableData: anAnswer description ];
				tableRow: [ aCanvas
						tableData:
							'likes ' , anAnswer quantityOfLikes asString , ' | dislikes '
								, anAnswer quantityOfDislikes asString ];
				tableRow: [ aCanvas
						tableData: [ section := aCanvas anchor.
							section
								callback: [ self like: anAnswer ];
								with: 'like'.
							aCanvas text: ' '.
							section := aCanvas anchor.
							section
								callback: [ self dislike: anAnswer ];
								with: ' dislike' ] ] ]
]

{ #category : #adding }
QuestionComponent >> renderAnswersOn: aCanvas [
| section |
	aCanvas heading: 'respuestas'.
	question answers
		do: [ :arg2 | 
			
			section := aCanvas.
			section
				table: [ self renderAnswer: arg2 on: aCanvas ];
				horizontalRule ]
]

{ #category : #adding }
QuestionComponent >> renderContentOn: aCanvas [
	| section |
	self renderUpperToolbarOn: aCanvas.
	section := aCanvas.
	section
		table: [ self renderQuestion: question on: aCanvas ];
		horizontalRule.
	self renderAnswersOn: aCanvas.
	aCanvas horizontalRule.
	self renderAddAnswerOn: aCanvas
]
