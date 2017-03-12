package network.wai.servlet;

import base.java.TopHandler;
import eta.runtime.Rts;
import eta.runtime.Rts.HaskellResult;
import eta.runtime.RtsConfig;
import eta.runtime.thunk.Ap2Upd;
import eta.runtime.thunk.Ap3Upd;
import javax.servlet.GenericServlet;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import main.Main;
import main.Main.ServletRequestD;
import main.Main.ServletResponseD;

public class WaiServlet extends GenericServlet {
	static {
		Rts.hsInit(new String[0], RtsConfig.getDefault());
	}

	public void service(ServletRequest paramServletRequest, ServletResponse paramServletResponse) {
		Rts.unlock(Rts.evalJava(Rts.lock(), this,
				new Ap2Upd(TopHandler.runJava_closure,
						new Ap3Upd(Main.zdfstableZZC0ZZCmainZZCMainZZCservice_closure,
								new Main.ServletRequestD(paramServletRequest),
								new Main.ServletResponseD(paramServletResponse)))).cap);
	}
}