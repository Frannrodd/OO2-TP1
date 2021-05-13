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

{ #category : #accesing }
AddAnswerComponent >> answer2 [
	^ answer2
]

{ #category : #accesing }
AddAnswerComponent >> cancel [
	answer2 := nil.
	self answer
]

{ #category : #accesing }
AddAnswerComponent >> description [
	^ description
]

{ #category : #accesing }
AddAnswerComponent >> description: arg1 [
	description := arg1
]

{ #category : #accesing }
AddAnswerComponent >> logOut [
	answer2 := nil.
	super logOut
]

{ #category : #accesing }
AddAnswerComponent >> on: anAnswer and: aQuestion and: anUser [
	question := aQuestion.
	cuOOra := CuOOra soleInstance.
	whoQuestion := anUser.
	answer2 := anAnswer.
	description := anAnswer description
]

{ #category : #accesing }
AddAnswerComponent >> question [
	^ question
]

{ #category : #rendering }
AddAnswerComponent >> renderContentOn: aCanvas [
	self renderUpperToolbarOn: aCanvas.
	aCanvas
		table: [ self renderQuestion: question on: aCanvas ];
		horizontalRule.
	self renderForm: aCanvas
]

{ #category : #rendering }
AddAnswerComponent >> renderForm: aCanvas [
	| section |
	aCanvas
		form: [ aCanvas
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

{ #category : #rendering }
AddAnswerComponent >> renderQuestion: aQuestion on: aCanvas [
	| section |
	section := aCanvas.
	section
		tableRow: [ aCanvas
				tableData: [ 
					section := aCanvas anchor.
					section
						callback: [ self enterQuestionDialog: aQuestion ];
						with: aQuestion title ] ];
		tableRow: [ aCanvas
				tableData: [ aCanvas text: 'topicos: '.
					aQuestion topics  join: {1. 1+1. 3}	] ];
		tableRow: [ 
			section := aCanvas.
			section
				tableData: [ 
					aCanvas text: 'realizada por: '.
					section := aCanvas anchor.
					section
						callback: [ self enterUserDialog: whoQuestion ];
						with: whoQuestion username.
					aCanvas text: ' | ' , aQuestion answers size asString , ' respuesta' ];
				tableRow: [ aCanvas
						tableData:
							'likes ' , aQuestion quantityOfLikes asString , '| dislikes '
								, aQuestion quantityOfDislikes asString ] ];
		tableRow: [ aCanvas
				tableData: [
					section := aCanvas anchor.
					section
						callback: [ self like: aQuestion ];
						with: 'like'.
					aCanvas text: ' '.
					section := aCanvas anchor.
					section
						callback: [ self dislike: aQuestion ];
						with: ' dislike' ] ]
]

{ #category : #accesing }
AddAnswerComponent >> save [
	answer2 description: description.
	^ self answer
]

{ #category : #accesing }
AddAnswerComponent >> whoQuestion [
	^ whoQuestion
]
