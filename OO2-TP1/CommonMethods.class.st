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
CommonMethods >> dislike: arg1 [
	self session user ifNotNil: [ arg1 dislike: (self session user) ]
]

{ #category : #adding }
CommonMethods >> enterQuestionDialog: arg1 [
	| tmp1 |
	tmp1 := QuestionComponent enterQuestion: arg1.
	self call: tmp1
]

{ #category : #adding }
CommonMethods >> enterUserDialog: arg1 [
	| tmp1 |
	tmp1 := UserComponent onViewUser: arg1.
	self call: tmp1
]

{ #category : #adding }
CommonMethods >> like: arg1 [
	self session user ifNotNil: [ arg1 like: (self session user) ]
]

{ #category : #adding }
CommonMethods >> logOut [
	| tmp1 |
	self session user: nil.
	tmp1 := LoginComponent new.
	self call: tmp1
]

{ #category : #adding }
CommonMethods >> loginDialog [
	| tmp1 |
	tmp1 := LoginComponent onLogIn: cuOOra users.
	self call: tmp1.
]

{ #category : #rendering }
CommonMethods >> renderQuestion: arg1 on: arg2 [
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
						callback: [ self
								enterUserDialog: (cuOOra users select: [ :arg4 | arg4 questions includes: arg1 ]) first ];
						with:
							(cuOOra users select: [ :arg5 | arg5 questions includes: arg1 ]) first
								username.
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

{ #category : #rendering }
CommonMethods >> renderQuestionsOn: arg1 [
	| tmp1 |
	tmp1 := SortedCollection new
		sortBlock: [ :arg2 :arg3 | arg2 creationDate > arg3 creationDate ].
	cuOOra users
		flatCollect: [ :arg4 |  arg4 questions ].
	arg1 heading: 'Ultimas Preguntas'.
	tmp1
		do: [ :arg5 | 
			| tmp2 |
			tmp2 := arg1.
			tmp2
				table: [ self renderQuestion: arg5 on: arg1 ];
				horizontalRule ]
]

{ #category : #rendering }
CommonMethods >> renderUpperToolbarOn: arg1 [
	| tmp1 tmp2 |
	arg1 heading: 'CuOOra'.
	self session user = nil
		ifTrue: [ tmp1 := arg1 anchor.
			tmp1
				callback: [ self loginDialog ];
				with: 'login' ]
		ifFalse: [ arg1 text: self session user username , ' '.
			tmp2 := arg1 anchor.
			tmp2
				callback: [ self logOut ];
				with: 'logout' ].
	arg1 horizontalRule
]

{ #category : #adding }
CommonMethods >> style [
	^ '.left { text-align: left; }
	.right { text-align: right; }
	.strong { 	font-size: 35px;
					font-weight: bold; }'
]
