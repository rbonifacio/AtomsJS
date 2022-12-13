/**
 * @name SelectPosIncrementExpression
 * @description  Select all occurrences of 
 *   Post Increment
 * @kind problem
 * @problem.severity warning
 */

import javascript

from Expr e
where not e.getTopLevel().isMinified() and
e instanceof PostIncExpr
select e, e.getLocation().getStartLine()  as Location,e.getLocation().getFile()