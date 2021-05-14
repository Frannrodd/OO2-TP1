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
UserComponent >> follow: arg1 [
	self session user ifNotNil: [ self session user addFollowing: arg1 ]
]

{ #category : #'as yet unclassified' }
UserComponent >> on: arg1 [
	user := arg1.
	cuOOra := CuOOra soleInstance
]

{ #category : #rendering }
UserComponent >> renderContentOn: arg1 [
	self renderUpperToolbarOn: arg1.
	self session user = nil
		ifTrue: [ arg1 heading: [ arg1 text: 'preguntas de: ' , user username , ' ' ] ]
		ifFalse: [ self renderFollower: arg1 ].
	self renderQuestion: arg1
]

{ #category : #'as yet unclassified' }
UserComponent >> renderFollower: arg1 [
	arg1
		heading: [ | tmp1 tmp2 |
			arg1 text: 'preguntas de: ' , user username , ' '.
			(self session user following includes: user)
				ifTrue: [ tmp1 := arg1 anchor.
					tmp1
						callback: [ self unfollow: user ];
						with: 'unfollow' ]
				ifFalse: [ tmp2 := arg1 anchor.
					tmp2
						callback: [ self follow: user ];
						with: 'follow' ] ]
]

{ #category : #'as yet unclassified' }
UserComponent >> renderQuestion: arg1 [
	| tmp1 |
	tmp1 := cuOOra questionsFromAnUser: user.
	tmp1
		do: [ :arg2 | 
			arg1
				table: [ self renderQuestion: arg2 on: arg1.
					arg1 horizontalRule ] ]
]

{ #category : #'as yet unclassified' }
UserComponent >> unfollow: arg1 [
	self session user ifNotNil: [ self session user removeFollowing: arg1 ]
]
