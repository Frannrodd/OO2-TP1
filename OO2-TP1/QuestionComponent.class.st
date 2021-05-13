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
	| anAnswer |
	anAnswer := AddAnswerComponent
		onAddAnswer: question
		and:
			(cuOOra users select: [ :arg1 | arg1 questions includes: question ])
				first.
	self call: anAnswer.
	anAnswer answer2
		ifNotNil: [ question addAnswer: anAnswer answer2.
			self session user addPost: anAnswer answer2 ]
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
	aCanvas
		text: 'no hay mas respuestas';
		break.
	self session user
		ifNotNil: [ | tmp2 |
			tmp2 := aCanvas anchor.
			tmp2
				callback: [ self addAnswerDialog ];
				with: 'Hacer una nueva respuesta' ]

]

{ #category : #adding }
QuestionComponent >> renderAnswer: anAnswer on: aCanvas [
	aCanvas
		table: [ | tmp1 |
			tmp1 := aCanvas.
			tmp1
				tableRow: [ aCanvas
						tableData: [ | tmp2 |
							aCanvas text: 'realizada por: '.
							tmp2 := aCanvas anchor.
							tmp2
								callback: [ self enterUserDialog: anAnswer user ];
								with: anAnswer user username ] ];  "revisar que si cargue una pregunta sin usuario y tira error. "
				tableRow: [ aCanvas tableData: anAnswer description ];
				tableRow: [ aCanvas
						tableData:
							'likes ' , anAnswer quantityOfLikes asString , ' | dislikes '
								, anAnswer quantityOfDislikes asString ];
				tableRow: [ aCanvas
						tableData: [ | tmp3 tmp4 |
							tmp3 := aCanvas anchor.
							tmp3
								callback: [ self like: anAnswer ];
								with: 'like'.
							aCanvas text: ' '.
							tmp4 := aCanvas anchor.
							tmp4
								callback: [ self dislike: anAnswer ];
								with: ' dislike' ] ] ]

]

{ #category : #adding }
QuestionComponent >> renderAnswersOn: aCanvas [
	aCanvas heading: 'Respuestas'.
	question answers
		do: [ :anAnswer  | 
			| section |
			section := aCanvas.
			section
				table: [ self renderAnswer: anAnswer on: aCanvas ];
				horizontalRule ]
]

{ #category : #adding }
QuestionComponent >> renderContentOn: arg1 [
	| tmp2 |
	self renderUpperToolbarOn: arg1.
	tmp2 := arg1.
	tmp2
		table: [ self renderQuestion: question on: arg1 ];
		horizontalRule.
	self renderAnswersOn: arg1.
	arg1 horizontalRule.
	self renderAddAnswerOn: arg1
]
