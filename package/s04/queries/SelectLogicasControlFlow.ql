/**
 * @name SelectLogicasControlFlow
 * @description Select all occurrences of 
 *   the Use of Logic as Control Flow
 * @kind problem
 * @problem.severity warning
 */

import javascript

from ExprStmt e
where not e.getTopLevel().isMinified() and
e.getExpr() instanceof LogAndExpr

select e, e.getLocation().getStartLine() as Location,e.getLocation().getFile()

