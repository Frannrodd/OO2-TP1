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
	| tmp1 |
	tmp1 := AddQuestionComponent onAddQuestion.
	self call: tmp1.
	tmp1 question ifNotNil: [ self session user addPost: tmp1 question ]
]

{ #category : #rendering }
CuOOraComponent >> initialize [
	super initialize.
	cuOOra := CuOOra soleInstance
]

{ #category : #rendering }
CuOOraComponent >> renderAddQuestionOn: arg1 [
	| tmp1 |
	self session user = nil
		ifFalse: [ tmp1 := arg1 anchor.
			tmp1
				callback: [ self createQuestion ];
				with: 'Hacer una nueva pregunta' ]
]

{ #category : #rendering }
CuOOraComponent >> renderContentOn: arg1 [
	| tmp1 |
	tmp1 := self.
	tmp1 renderUpperToolbarOn: arg1.
	self session user = nil
		ifTrue: [ tmp1 renderQuestionsOn: arg1 ]
		ifFalse: [ tmp1
				renderAddQuestionOn: arg1;
				renderRelevantQuestions: arg1 for: self session user ].
	arg1 horizontalRule
]

{ #category : #rendering }
CuOOraComponent >> renderRelevantQuestions: arg1 for: arg2 [
	(((cuOOra interestingQuestionsForAnUser: arg2)
		asSortedCollection: [ :arg6 :arg7 | arg6 creationDate > arg7 creationDate ])
		takeFirst: 5)
		do: [ :arg8 | 
			arg1
				table: [ self renderQuestion: arg8 on: arg1 ];
				horizontalRule ]
]
