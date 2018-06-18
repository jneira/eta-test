import eta_test.Lib;
public class Utils {

    public static void main(String args[]) throws Exception {
        System.out.println("======== RUNNING  ===============");
        Lib.foo();
        EtaData d = new EtaData();
        d.setCounter(10);
        System.out.println(d.addToCounter(1));
        System.out.println(d.getCounter());
        System.out.println();
        System.out.println("=================================");
        System.out.println(Lib.getInt(1));
    }

}
