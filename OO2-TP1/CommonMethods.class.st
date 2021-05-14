Class {
	#name : #CommonMethods,
	#superclass : #WAComponent,
	#instVars : [
		'cuOOra',
		'sesion'
	],
	#classInstVars : [
		'cuOOra',
		'sesion'
	],
	#category : #'OO2-TP1-View'
}

{ #category : #adding }
CommonMethods >> dislike: aPost [
	self session user ifNotNil: [ aPost dislike: (self session user) ]
]

{ #category : #adding }
CommonMethods >> enterQuestionDialog: aQuestion [

	self call: (QuestionComponent enterQuestion: aQuestion).
]

{ #category : #adding }
CommonMethods >> enterUserDialog: anUser [
	 
	self call: (UserComponent onViewUser: anUser).
]

{ #category : #adding }
CommonMethods >> like: aPost [
	self session user ifNotNil: [ aPost like: (self session user) ]
]

{ #category : #adding }
CommonMethods >> logOut [
	
	self session user: nil.
	
	self call: LoginComponent new.
]

{ #category : #adding }
CommonMethods >> loginDialog [
	 
	self call: (LoginComponent onLogIn: cuOOra users).
]

{ #category : #rendering }
CommonMethods >> renderQuestion: aPost on: aCanvas [ 
	aCanvas 
		tableRow: [ aCanvas
				tableData: [ aCanvas anchor
						callback: [ self enterQuestionDialog: aPost ];
						with: aPost title ] ];
		tableRow: [ aCanvas
				tableData: [ aCanvas text: 'topicos: '.
					aPost topics collect: [ :arg3 | aCanvas text: arg3 title , '  ' ] ] ];
		tableRow: [ aCanvas
                tableData: [ 
                    aCanvas text: 'realizada por: '.
                      aCanvas anchor
                        callback: [  self
								enterUserDialog: ( aPost user)  ];
						with:
							( aPost user username).
								
                    aCanvas text: ' | ' , aPost answersSize asString , ' respuestas' ];
				tableRow: [ aCanvas
						tableData:
							'likes ' , aPost quantityOfLikes asString , '| dislikes '
								, aPost quantityOfDislikes asString ] ];
		tableRow: [ aCanvas
				tableData: [ 
					 aCanvas anchor
						callback: [ self like: aPost ];
						with: 'like'.
					aCanvas text: ' '.
					 aCanvas anchor
						callback: [ self dislike: aPost ];
						with: ' dislike' ] ]  
]

{ #category : #rendering }
CommonMethods >> renderQuestionsOn: aCanvas [
	| aSortedCollection|
	aSortedCollection  := SortedCollection new
		sortBlock: [ :a :b| a creationDate > b creationDate ].
	aCanvas heading: 'Ultimas Preguntas'.
	aSortedCollection 
		do: [ :question | 
			aCanvas
				table: [ self renderQuestion: question on: aCanvas ];
				horizontalRule ]
]

{ #category : #rendering }
CommonMethods >> renderUpperToolbarOn: aCanvas [
	aCanvas heading: 'CuOOra'.
	self session user = nil
		ifTrue: [ aCanvas anchor
				callback: [ self loginDialog ];
				with: 'login' ]
		ifFalse: [ aCanvas text: self session user username , ' '.
			aCanvas anchor
				callback: [ self logOut ];
				with: 'logout' ].
	aCanvas horizontalRule
]

{ #category : #adding }
CommonMethods >> style [
	^ '.left { text-align: left; }
	.right { text-align: right; }
	.strong { 	font-size: 35px;
					font-weight: bold; }'
]
