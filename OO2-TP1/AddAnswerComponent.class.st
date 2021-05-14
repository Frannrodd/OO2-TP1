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
AddAnswerComponent >> on: anAnswer and: aQuestion and: anUser [
	question := aQuestion.
	cuOOra := CuOOra soleInstance.
	whoQuestion := anUser.
	answer2 := anAnswer.
	description := anAnswer description
]

{ #category : #'as yet unclassified' }
AddAnswerComponent >> question [
	^ question
]

{ #category : #'as yet unclassified' }
AddAnswerComponent >> renderContentOn: aCanvas [
	self renderUpperToolbarOn: aCanvas.
	aCanvas
		table: [ self renderQuestion: question on: aCanvas ];
		horizontalRule.
	self renderForm: aCanvas
]

{ #category : #'as yet unclassified' }
AddAnswerComponent >> renderForm: aCanvas [ 
	aCanvas
		form: [ | section |
			aCanvas
				text: 'respuesta:';
				break.
			section := aCanvas textArea on: #description of: self.
			section
				columns: 80;
				rows: 5.
			section := aCanvas.
			section
				break;
				break.
			section := aCanvas submitButton.
			section
				callback: [ self save ];
				value: 'Guardar'.
			section := aCanvas submitButton.
			section
				callback: [ self cancel ];
				value: 'Cancelar' ]
]

{ #category : #'as yet unclassified' }
AddAnswerComponent >> renderQuestion: aQuesiton on: aCanvas [
	| section |
	section := aCanvas.
	section
		tableRow: [ aCanvas
				tableData: [ section := aCanvas anchor.
					section
						callback: [ self enterQuestionDialog: aQuesiton ];
						with: aQuesiton title ] ];
		tableRow: [ aCanvas
				tableData: [ aCanvas text: 'topicos: '.
					aQuesiton topics do: [ :arg3 | aCanvas text: arg3 title , '  ' ] ] ];
		tableRow: [ section := aCanvas.
			section
				tableData: [ aCanvas text: 'realizada por: '.
					section := aCanvas anchor.
					section
						callback: [ self enterUserDialog: whoQuestion ];
						with: whoQuestion username.
					aCanvas
					"aca rompe encapsulamiento"
						text: ' | ' , aQuesiton answers size asString , ' respuesta' ];
				
					tableRow: [ aCanvas
						tableData:
							'likes ' , aQuesiton quantityOfLikes asString , '| dislikes '
								, aQuesiton quantityOfDislikes asString ] ];
		tableRow: [ aCanvas
				tableData: [ section := aCanvas anchor.
					section
						callback: [ self like: aQuesiton ];
						with: 'like'.
					aCanvas text: ' '.
					section := aCanvas anchor.
					section
						callback: [ self dislike: aQuesiton ];
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
