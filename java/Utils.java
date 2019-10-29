import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.Executors;

import eta.example.MyClass;
import eta.example.Numbers;
import eta.example.Counter;
import eta.example.Foreign;
import eta.example.ForeignDecompiled;
import eta.example.ForeignSimple;
import eta.example.EtaCounter;

public class Utils {

    public static void main(String args[]) throws Exception {
        System.out.println("======== RUNNING  ===============");
        MyClass.sayHello();
        System.out.println("Zero: "+ Numbers.zero());
        System.out.println("One: "+ Numbers.one());
        System.out.println("Two: "+ Numbers.addTwo(0));

        EtaCounter d = new EtaCounter();
        d.set(10);
        System.out.println(d.decrement(5));
        System.out.println(d.get());
        // This does not work, Lib has no constructors
        // Lib myLib = new Lib();
        // System.out.println(myLib.instanceMethod(1));
        System.out.println(ForeignSimple.testExport("hola", "adios"));
        System.out.println(ForeignDecompiled.testExport("hola", "adios"));
        System.out.println(ForeignDecompiled.testExport("hola", Integer.valueOf("1")));
        System.out.println(ForeignDecompiled.testExportSuper("hola", "adios"));
        System.out.println(ForeignDecompiled.testExportSuper("hola", Integer.valueOf("1")));
        System.out.println(ForeignDecompiled.testExportSuperTwo(
        		Double.valueOf("1.2"), Integer.valueOf(3)));
        System.out.println(Foreign.testExport("hola", "adios"));
        System.out.println(Foreign.testExport("hola", Integer.valueOf("1")));
        System.out.println(Foreign.testExportSuper("hola", "adios"));
        System.out.println(Foreign.testExportSuper("hola", Integer.valueOf("1")));
        System.out.println(Foreign.testExportSuperTwo(
        		Double.valueOf("1.2"), Integer.valueOf(3)));
        //System.out.println(Foreign.testExport("hola","adios"));
        //System.out.println(Foreign.testExportSuper("hola","adios"));
        System.out.println(Foreign.testJByteArray());
        System.out.println(Foreign.testJByteArrayId(new byte[] {1}));
        System.out.println("=================================");

        System.out.println("====== RUNNING MULTI-THREAD =====");
        ThreadPoolExecutor threadPool = (ThreadPoolExecutor) Executors.newFixedThreadPool(100);

        long t0 = System.currentTimeMillis();

        for (int i = 0; i < 10; i++) {
            threadPool.execute(new Thread() {
                @Override
                public void run() {
                     MyClass.sayHelloTo("Javier");
                }
            });
        }

        threadPool.shutdown();
        try {
            threadPool.awaitTermination(Long.MAX_VALUE, TimeUnit.MINUTES);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

        long t1 = System.currentTimeMillis();

        System.out.println("Time: " + (t1 - t0));
        System.out.println("=================================");
    }

}
