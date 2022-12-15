/**
 * @name AssignmentasValue
 * @description Select all occurrences of 
 *   the Assignment as Value
 * @kind problem
 * @problem.severity warning
 */

import javascript


from AssignExpr  a
where not a.getTopLevel().isMinified() and
a.getRhs() instanceof AssignExpr
select a, a.getLocation().getStartLine() as Location,a.getLocation().getFile()


