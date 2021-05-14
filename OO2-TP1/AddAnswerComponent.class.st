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
AddAnswerComponent >> renderForm: aCanvas [
|section|
	aCanvas
		form: [ 
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
AddAnswerComponent >> renderQuestion: aQuestion on: aCanvas [
	| section  |
	section := aCanvas.
	section
		tableRow: [ aCanvas
				tableData: [ section := aCanvas anchor.
					section
						callback: [ self enterQuestionDialog: aQuestion ];
						with: aQuestion title ] ];
		tableRow: [ aCanvas
				tableData: [ aCanvas text: 'topicos: '.
					"	aQuestion topics do: [ :arg3 | aCanvas text: arg3 title , '  ' ]"
				
					aCanvas
						text: (String streamContents: [:s | 
		aQuestion topics  do: [:each | s nextPutAll: each asString]] )] ];
		tableRow: [ section := aCanvas.
			section
				tableData: [ aCanvas text: 'realizada por: '.
					section := aCanvas anchor.
					section
						callback: [ self enterUserDialog: whoQuestion ];
						with: whoQuestion username.
					aCanvas
						text: ' | ' , aQuestion answers size asString , ' respuesta' ];
				tableRow: [ aCanvas
						tableData:
							'likes ' , aQuestion quantityOfLikes asString , '| dislikes '
								, aQuestion quantityOfDislikes asString ] ];
		tableRow: [ aCanvas
				tableData: [ section := aCanvas anchor.
					section
						callback: [ self like: aQuestion ];
						with: 'like'.
					aCanvas text: ' '.
					section := aCanvas anchor.
					section
						callback: [ self dislike: aQuestion ];
						with: ' dislike' ] ]
]

{ #category : #'as yet unclassified' }
AddAnswerComponent >> save [
	answer2 description: description;
			  user: self session user.
	^ self answer
]

{ #category : #'as yet unclassified' }
AddAnswerComponent >> whoQuestion [
	^ whoQuestion
]
