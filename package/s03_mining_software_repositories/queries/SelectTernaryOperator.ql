/**
 * @name CountTernaryOperator
 * @description  Select all occurrences of 
 *   the the TernaryOperator
 *   
 * @kind metric
 */

import javascript

from ConditionalExpr e
where not e.getTopLevel().isMinified() 
select e, e.getLocation().getStartLine() as Location,e.getLocation().getFile()