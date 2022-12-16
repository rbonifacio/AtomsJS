/**
 * @name SelectAutomaticSemicolonInsertion
 * @description Select all occurrences of 
 *   the Use of Automatic Semicolon Insertion
 * @kind problem f.getAReturnedExpr()
 * @problem.severity warning
 */
 
 
import javascript

predicate hasTokenAfter(ReturnStmt r) {
  r.getLastToken().getNextToken().getValue() != "}"
}


predicate isNextTokenVariable(ReturnStmt r) {
  r.getLastToken().getNextToken() instanceof IdentifierToken and 
  r.getLastToken().getNextToken().getNextToken().getValue() != "="
}


predicate isNextTokenLiteral(ReturnStmt r) {
 (r.getLastToken().getNextToken() instanceof StringLiteralToken or r.getLastToken().getNextToken() instanceof NumericLiteralToken ) and 
  r.getLastToken().getNextToken().getNextToken().getValue() != "="
}

from ReturnStmt r
where not r.getTopLevel().isMinified() and
 r.isSubjectToSemicolonInsertion() and 
 r.getNumChildStmt() = 0 and
 r.getNumChildExpr() = 0 and
 not r.toString().matches("%;") and
 hasTokenAfter(r) 
select r, r.getLocation().getStartLine() as Location,r.getLocation().getFile()