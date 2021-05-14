Class {
	#name : #UserComponent,
	#superclass : #CommonMethods,
	#instVars : [
		'user'
	],
	#category : #'OO2-TP1-View'
}

{ #category : #'as yet unclassified' }
UserComponent class >> onViewUser: arg1 [
	^ self new on: arg1
]

{ #category : #'as yet unclassified' }
UserComponent >> follow: anUser [
	self session user ifNotNil: [ self session user addFollowing: anUser ]
]

{ #category : #'as yet unclassified' }
UserComponent >> on: arg1 [
	user := arg1.
	cuOOra := CuOOra soleInstance
]

{ #category : #rendering }
UserComponent >> renderContentOn: aCanvas [
	self renderUpperToolbarOn: aCanvas.
	self session user ifNil: [ aCanvas
				heading: [ aCanvas text: 'preguntas de: ' , user username , ' ' ] ]
		ifNotNil:  [ self renderFollower: aCanvas ].
	self renderQuestion: aCanvas
]

{ #category : #'as yet unclassified' }
UserComponent >> renderFollower: aCanvas [
	| section |
	aCanvas
		heading: [ aCanvas text: 'preguntas de: ' , user username , ' '.
			(self session user following includes: user)
				ifTrue: [ section := aCanvas anchor.
					section
						callback: [ self unfollow: user ];
						with: 'unfollow' ]
				ifFalse: [ section := aCanvas anchor.
					section
						callback: [ self follow: user ];
						with: 'follow' ] ]
]

{ #category : #'as yet unclassified' }
UserComponent >> renderQuestion: aCanvas [
	| section |
	section := cuOOra questionsFromAnUser: user.
	section
		do: [ :aQuestion | 
			aCanvas
				table: [ self renderQuestion: aQuestion on: aCanvas.
					aCanvas horizontalRule ] ]
]

{ #category : #'as yet unclassified' }
UserComponent >> unfollow: anUser [
	self session user
		ifNotNil: [ self session user removeFollowing: anUser ]
]
