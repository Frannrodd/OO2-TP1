Class {
	#name : #AddAnswerComponent,
	#superclass : #CommonMethods,
	#instVars : [
		'question',
		'whoQuestion',
		'description',
		'answer2'
	],
	#classInstVars : [
		'question'
	],
	#category : #'OO2-TP1-View'
}

{ #category : #'as yet unclassified' }
AddAnswerComponent class >> onAddAnswer: arg1 and: arg2 [
	^ self new
		on: (Answer description: 'escriba el texto de su respuesta.')
		and: arg1
		and: arg2
]

{ #category : #'as yet unclassified' }
AddAnswerComponent >> answer2 [
	^ answer2
]

{ #category : #'as yet unclassified' }
AddAnswerComponent >> cancel [
	answer2 := nil.
	self answer
]

{ #category : #'as yet unclassified' }
AddAnswerComponent >> description [
	^ description
]

{ #category : #'as yet unclassified' }
AddAnswerComponent >> description: arg1 [
	description := arg1
]

{ #category : #'as yet unclassified' }
AddAnswerComponent >> logOut [
	answer2 := nil.
	super logOut
]

{ #category : #'as yet unclassified' }
AddAnswerComponent >> on: arg1 and: arg2 and: arg3 [
	question := arg2.
	cuOOra := CuOOra soleInstance.
	whoQuestion := arg3.
	answer2 := arg1.
	description := arg1 description
]

{ #category : #'as yet unclassified' }
AddAnswerComponent >> question [
	^ question
]

{ #category : #'as yet unclassified' }
AddAnswerComponent >> renderContentOn: arg1 [
	self renderUpperToolbarOn: arg1.
	arg1
		table: [ self renderQuestion: question on: arg1 ];
		horizontalRule.
	self renderForm: arg1
]

{ #category : #'as yet unclassified' }
AddAnswerComponent >> renderForm: arg1 [
	arg1
		form: [ | tmp1 tmp2 tmp4 tmp6 |
			arg1
				text: 'respuesta:';
				break.
			tmp4 := arg1 textArea on: #description of: self.
			tmp4
				columns: 80;
				rows: 5.
			tmp6 := arg1.
			tmp6
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
AddAnswerComponent >> renderQuestion: arg1 on: arg2 [
	| tmp1 |
	tmp1 := arg2.
	tmp1
		tableRow: [ arg2
				tableData: [ | tmp2 |
					tmp2 := arg2 anchor.
					tmp2
						callback: [ self enterQuestionDialog: arg1 ];
						with: arg1 title ] ];
		tableRow: [ arg2
				tableData: [ arg2 text: 'topicos: '.
					arg1 topics do: [ :arg3 | arg2 text: arg3 title , '  ' ] ] ];
		tableRow: [ | tmp3 |
			tmp3 := arg2.
			tmp3
				tableData: [ | tmp4 |
					arg2 text: 'realizada por: '.
					tmp4 := arg2 anchor.
					tmp4
						callback: [ self enterUserDialog: whoQuestion ];
						with: whoQuestion username.
					arg2 text: ' | ' , arg1 answers size asString , ' respuesta' ];
				tableRow: [ arg2
						tableData:
							'likes ' , arg1 quantityOfLikes asString , '| dislikes '
								, arg1 quantityOfDislikes asString ] ];
		tableRow: [ arg2
				tableData: [ | tmp5 tmp6 |
					tmp5 := arg2 anchor.
					tmp5
						callback: [ self like: arg1 ];
						with: 'like'.
					arg2 text: ' '.
					tmp6 := arg2 anchor.
					tmp6
						callback: [ self dislike: arg1 ];
						with: ' dislike' ] ]
]

{ #category : #'as yet unclassified' }
AddAnswerComponent >> save [
	answer2 description: description.
	^ self answer
]

{ #category : #'as yet unclassified' }
AddAnswerComponent >> whoQuestion [
	^ whoQuestion
]
