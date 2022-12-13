/**
 * @name ImplicitPredicate
 * @description Select all occurrences of 
 *   the Implicit Predicate
 * @kind problem
 * @problem.severity warning
 */


import javascript

from ControlStmt c

where not c.getTopLevel().isMinified() and
(c instanceof IfStmt and not c.(IfStmt).getCondition().mayHaveBooleanValue(true) ) or
(c instanceof LoopStmt and  not c.(LoopStmt).getTest().mayHaveBooleanValue(true)  ) or 
(c instanceof WithStmt and not  c.(WithStmt).getExpr().mayHaveBooleanValue(true) )  

select c, c.getLocation().getStartLine() as Location,c.getLocation().getFile()
