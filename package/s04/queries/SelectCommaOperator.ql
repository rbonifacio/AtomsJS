/**
 * @name CommaOperator
 * @description Select all occurrences of 
 *   Comma Operator
 * @kind problem
 * @problem.severity warning
 */

 
import javascript


predicate isSeqExp(ParExpr p) {
p.stripParens() instanceof SeqExpr
}


string getLeft(ParExpr c) {
(c.getAChild*() instanceof AssignExpr and result = c.getAChild*().(AssignExpr).getLhs().toString()) or
(c.getAChild*() instanceof CompoundAssignExpr and result = c.getAChild*().(CompoundAssignExpr).getLhs().toString())  or
(c.getAChild*() instanceof UpdateExpr and result = c.getAChild*().(UpdateExpr).getOperand().toString())  
}


string getLastExpr(ParExpr p) {
result = p.stripParens().(SeqExpr).getLastOperand().toString()
}

predicate isParentVarAssign(ParExpr p) {
p.getParent() instanceof AssignExpr or
p.getParent() instanceof VariableDeclarator
}

from ParExpr e
where not e.getTopLevel().isMinified() and
isSeqExp(e) and
isParentVarAssign(e)

select e, e.getLocation().getStartLine() as Location,e.getLocation().getFile()

