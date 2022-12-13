/**
 * @name OmittedCurlyBraces
 * @description Select all occurrences of 
 *   the Omitted Curly Braces
 * @kind problem
 * @problem.severity warning
 */

import javascript

predicate isIFWhileStmt (ControlStmt c) {
	c instanceof IfStmt or
	c instanceof WhileStmt
	}

predicate hasCurlyBraces (ControlStmt c) {
	c.getAToken().getValue() = "{" 
}

predicate hasSucessor (ControlStmt c) {
	c.getLastToken().getNextToken().toString() != ""
}

string getSucessor  (ControlStmt c) {
	result = c.getLastToken().getNextToken().toString()
}


predicate isSameLine (ControlStmt c) {
c.getLocation().getStartLine() = c.getLastToken().getNextToken().getLocation().getStartLine()
}
	
from ControlStmt c
where not c.getTopLevel().isMinified() and
isIFWhileStmt(c) and 
not hasCurlyBraces(c) and 
hasSucessor(c) and
not c.getTopLevel().isMinified()
select c,c.getLocation().getStartLine() as Location,c.getLocation().getFile()

