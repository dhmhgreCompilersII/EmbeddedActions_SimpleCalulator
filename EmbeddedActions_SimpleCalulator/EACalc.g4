grammar EACalc;

@header {
	using System;
	using System.IO;
}

@parser::members {
	Dictionary<string,int> memory = new Dictionary<string,int>();

	public int eval(int left, int op, int right){
		switch(op){
			case MUL : return left * right;
			case DIV : return left / right;
			case ADD : return left + right;
			case SUB : return left - right;
		}
		return 0;
	}
}

/*
 * Parser Rules
 */

compileUnit
	:	stat+
	;

stat : exp ';'  { Console.WriteLine($"The results is : {$exp.v}"); }
	 | ';'
	 ;

exp returns [int v]:
	  NUMBER					{ $v = $NUMBER.int; }
	| ID						{ $v = memory[$ID.text]; }
	| ID '=' exp				{ $v = memory[$ID.text] = $exp.v; }
	| a=exp op=('*'|'/') b=exp  { $v = eval($a.v,$op.type,$b.v); }
	| a=exp op=('+'|'-') b=exp	{ $v = eval($a.v,$op.type,$b.v); }
	| '(' exp ')'				{ $v = $exp.v; }
	;

/*
 * Lexer Rules
 */
MUL : '*' ;
DIV : '/' ;
ADD : '+' ;
SUB : '-' ;
NUMBER : '0'|[1-9][0-9]* ;
ID : [a-zA-Z][a-zA-Z0-9_]* ;
WS	:	[ \t\r\n] -> skip	;
