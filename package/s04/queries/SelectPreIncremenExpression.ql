/**
 * @name SelectPreIncrement
 * @description  Select all occurrences of 
 *   the Pre Increment
 * @kind problem
 * @problem.severity warning
 */

import javascript

from Expr e
where not e.getTopLevel().isMinified()  and
e instanceof PreIncExpr
and (e.toString() + ";" != e.getParent().toString() and e.toString() != e.getParent().toString() )
select e, e.getLocation().getStartLine()  as Location,e.getLocation().getFile()


