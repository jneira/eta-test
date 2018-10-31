package eta.example;

import base.ghc.TopHandler;
import eta.runtime.Runtime;
import eta.runtime.thunk.Ap2Upd;
import eta.runtime.thunk.Ap4Upd;
import ghc_prim.ghc.Classes;
import ghc_prim.ghc.types.datacons.JSzh;
import ghc_prim.ghc.types.datacons.Ozh;

public class ForeignSimple {
	@SuppressWarnings("unchecked")
	public static <Je> Je testExport(String paramString, Je paramJe) throws Exception {
		return (Je) ((Ozh) Runtime.evalIO(new Ap2Upd(TopHandler.runIO(),
				new Ap4Upd(eta_test.Foreign.$fe_jtestExport(), Classes.$fExtends_a_b() , new JSzh(paramString), new Ozh(paramJe))))).x1;
	}
}
