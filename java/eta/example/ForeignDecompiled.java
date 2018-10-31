/**
 * 
 */
package eta.example;

import base.ghc.TopHandler;
import base.java.wrappers.datacons.JInteger;
import base.java.wrappers.datacons.JNumber;
import eta.runtime.Runtime;
import eta.runtime.apply.Function1;
import eta.runtime.stg.Closure;
import eta.runtime.stg.Stg;
import eta.runtime.stg.StgContext;
import eta.runtime.thunk.Ap2Upd;
import eta.runtime.thunk.Ap3Upd;
import eta.runtime.thunk.Ap4Upd;
import eta.runtime.thunk.Ap5Upd;
import ghc_prim.ghc.Classes;
import ghc_prim.ghc.classes.datacons.DZCExtends;
import ghc_prim.ghc.types.datacons.JSzh;
import ghc_prim.ghc.types.datacons.Ozh;

/**
 * @author Javier Neira Sanchez
 *
 */
public class ForeignDecompiled {
	
	public static DZCExtends trivialExtends = new DZCExtends(Classes.$fClass_Object(), Classes.$fClass_Object(),
			Id.INSTANCE,Id.INSTANCE);
	
	public static class Id extends Function1 {
		public static Id INSTANCE = new Id();

		  public final Closure apply1(StgContext paramStgContext, Closure paramClosure)
		  {
		    if (paramStgContext.trampoline)
		      Stg.apply1Tail(paramStgContext, this, paramClosure);
		   return paramClosure.evaluate(paramStgContext);
		  }

		  public final Closure enter(StgContext paramStgContext)
		  {
		    if (paramStgContext.trampoline)
		      Stg.enterTail(paramStgContext, this);
		    return  paramStgContext.R1.evaluate(paramStgContext);
		  }
	}
	
	@SuppressWarnings("unchecked")
	public static <Je> Je testExport(String paramString, Je paramJe) throws Exception {
		return (Je) ((Ozh) Runtime.evalIO(new Ap2Upd(TopHandler.runIO(),
				new Ap4Upd(eta_test.Foreign.$fe_jtestExport(), trivialExtends, new JSzh(paramString), new Ozh(paramJe))))).x1;
	}
	
	public static <Je> Object testExportSuper(String paramString, Je paramJe) throws Exception {
		return ((Ozh) Runtime.evalIO(new Ap2Upd(TopHandler.runIO(),
				new Ap4Upd(eta_test.Foreign.$fe_jtestExportSuper(), trivialExtends , new JSzh(paramString), new Ozh(paramJe))))).x1;
	}

	public static <X extends Number, Y extends Number> Integer testExportSuperTwo(X paramX, Y paramY) throws Exception {
		return ((JInteger) Runtime.evalIO(new Ap2Upd(TopHandler.runIO(),
				new Ap5Upd(eta_test.Foreign.$fe_jtestExportSuperTwo(),
						trivialExtends, trivialExtends,
						new JNumber(paramX), new JNumber(paramY))))).x1;
	}
	
}
