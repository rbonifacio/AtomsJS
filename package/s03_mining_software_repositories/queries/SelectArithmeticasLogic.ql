/**
 * @name ArithmeticasLogic
 * @description Select all occurrences of 
 *   the Arithmetic as Logic
 * @kind problem
 * @problem.severity warning
 */



import javascript


string getArithmeticPredicate(ControlStmt c) {
(c instanceof IfStmt and result = c.(IfStmt).getCondition().toString()) or

(c instanceof LoopStmt and result = c.(LoopStmt).getTest().toString()) or 

(c instanceof WithStmt and result = c.(WithStmt).getExpr().toString())
}


from ControlStmt c
where not c.getTopLevel().isMinified() and

((c instanceof IfStmt and c.(IfStmt).getCondition()  instanceof ArithmeticExpr) or
(c instanceof LoopStmt and c.(LoopStmt).getTest()  instanceof ArithmeticExpr) or 
(c instanceof WithStmt and c.(WithStmt).getExpr()  instanceof ArithmeticExpr))
select c, c.getLocation().getStartLine() as Location,c.getLocation().getFile()