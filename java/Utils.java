import eta_test.Lib;
public class Utils {

    public static void main(String args[]) throws Exception {
        System.out.println("======== RUNNING  ===============");
        Lib.exportedFoo();
        System.out.println(Lib.exportedBar());
        EtaData d = new EtaData();
        d.setCounter(10);
        System.out.println(d.addToCounter(1));
        System.out.println(d.getCounter());
        System.out.println();
        // This does not work, Lib has no constructors
        // Lib myLib = new Lib();
        // System.out.println(myLib.instanceMethod(1));
        System.out.println("=================================");
        System.out.println(Lib.getInt(1));
    }

}
