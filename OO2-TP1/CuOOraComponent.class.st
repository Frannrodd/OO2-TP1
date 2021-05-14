Class {
	#name : #CuOOraComponent,
	#superclass : #CommonMethods,
	#category : #'OO2-TP1-View'
}

{ #category : #'class initialization' }
CuOOraComponent class >> initialize [
	| application |
	application := WAAdmin register: self asApplicationAt: 'CuOOra'.
	application sessionClass: SessionWithUser.
]

{ #category : #rendering }
CuOOraComponent >> createQuestion [
	| aQuestionComponent |
	aQuestionComponent := AddQuestionComponent onAddQuestion.
	self call: aQuestionComponent.
	aQuestionComponent question ifNotNil: [ self session user addPost: aQuestionComponent question ]
]

{ #category : #rendering }
CuOOraComponent >> initialize [
	super initialize.
	cuOOra := CuOOra soleInstance
]

{ #category : #rendering }
CuOOraComponent >> renderAddQuestionOn: aCanvas [
	self session user ifNil: [ ^ self ].
	 aCanvas anchor
		callback: [ self createQuestion ];
		with: 'Hacer una nueva pregunta'
]

{ #category : #rendering }
CuOOraComponent >> renderContentOn: aCanvas [
	| aCommonMethod |
	aCommonMethod := self.
	aCommonMethod renderUpperToolbarOn: aCanvas.
	self session ifNil: [ aCommonMethod renderQuestionsOn: aCanvas ]
		ifNotNil:  [ aCommonMethod
				renderAddQuestionOn: aCanvas;
				renderRelevantQuestions: aCanvas for: self session user ].
	aCanvas horizontalRule
]

{ #category : #rendering }
CuOOraComponent >> renderRelevantQuestions: aCanvas for: anUser [
	(((cuOOra interestingQuestionsForAnUser: anUser )
		asSortedCollection: [ :a :b | a creationDate > b creationDate ])
		takeFirst: 5)
		do: [ :aPost | 
			aCanvas 
				table: [ self renderQuestion: aPost on: aCanvas   ];
				horizontalRule ]
]
