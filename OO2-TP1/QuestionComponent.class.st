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
	| tmp1 |
	tmp1 := AddAnswerComponent
		onAddAnswer: question
		and:
			(cuOOra users select: [ :arg1 | arg1 questions includes: question ])
				first.
	self call: tmp1.
	tmp1 answer2
		ifNotNil: [ question addAnswer: tmp1 answer2.
			self session user addPost: tmp1 answer2 ]
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
QuestionComponent >> renderAddAnswerOn: arg1 [
	arg1
		text: 'no hay mas respuestas';
		break.
	self session user = nil
		ifFalse: [ | tmp2 |
			tmp2 := arg1 anchor.
			tmp2
				callback: [ self addAnswerDialog ];
				with: 'Hacer una nueva respuesta' ]
]

{ #category : #adding }
QuestionComponent >> renderAnswer: arg1 on: arg2 [
	arg2
		table: [ | tmp1 |
			tmp1 := arg2.
			tmp1
				tableRow: [ arg2
						tableData: [ | tmp2 |
							arg2 text: 'realizada por: '.
							tmp2 := arg2 anchor.
							tmp2
								callback: [ self
										enterUserDialog: (cuOOra users select: [ :arg3 | arg3 answers includes: arg1 ]) first ];
								with:
									(cuOOra users select: [ :arg4 | arg4 answers includes: arg1 ]) first
										username ] ];
				tableRow: [ arg2 tableData: arg1 description ];
				tableRow: [ arg2
						tableData:
							'likes ' , arg1 quantityOfLikes asString , ' | dislikes '
								, arg1 quantityOfDislikes asString ];
				tableRow: [ arg2
						tableData: [ | tmp3 tmp4 |
							tmp3 := arg2 anchor.
							tmp3
								callback: [ self like: arg1 ];
								with: 'like'.
							arg2 text: ' '.
							tmp4 := arg2 anchor.
							tmp4
								callback: [ self dislike: arg1 ];
								with: ' dislike' ] ] ]
]

{ #category : #adding }
QuestionComponent >> renderAnswersOn: arg1 [
	arg1 heading: 'respuestas'.
	question answers
		do: [ :arg2 | 
			| tmp2 |
			tmp2 := arg1.
			tmp2
				table: [ self renderAnswer: arg2 on: arg1 ];
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
